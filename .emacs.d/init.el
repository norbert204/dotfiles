;; Clean this file from automatic customization garbage
(setq custom-file
      (if (boundp 'server-socket-dir)
          (expand-file-name "custom.el" server-socket-dir)
        (expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)))
(load custom-file t)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Initialize use-package
(require 'use-package)
(setq use-package-always-ensure t)

;;; Very basic packages

;; Diminish modes from showing up in the modeline
(use-package diminish) 

;;;
;;; Basic settings
;;;

;; Use UTF-8
(set-language-environment "UTF-8")

;; Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)

;; Use 4 space tabs by default
(setq-default tab-width 4)

;; Please use spaces instead of tab character
(setq indent-line-function 'insert-tab)

;; A bit more friendly shortcut to insert a literal tab
(global-set-key (kbd "C-<tab>") 'tab-to-tab-stop)

;; Use ESC to quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Disable backup files
(setq make-backup-files nil)

;; Disable line wrapping
(setq-default truncate-lines t)

;; Somewhat smooth scrolling when using keyboard
;; It's beyond me why achieving some sort of smooth scrolling in Emacs is so difficult and hacky.
(setq redisplay-dont-pause t
  scroll-margin 7
  scroll-step 1
  scroll-conservatively 10
  scroll-preserve-screen-position 1)

;;;
;;; UI
;;;

;; Disable start screen
; (setq inhibit-startup-message t)

;; Disable some UI elements
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
;(menu-bar-mode -1)

;; Set font
(set-face-attribute 'default nil :font "mononoki Nerd Font Mono" :height 140)

;; Highlight current line
(global-hl-line-mode 1)

;; Tabline
(global-tab-line-mode t)
(setq tab-line-new-button-show nil)    ; do not show add-new button
(setq tab-line-close-button-show nil)  ; do not show close button

;; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
                eshell-mode-hook
                org-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

;; Theme
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))
  (load-theme 'doom-one t)

;; All the icons
(use-package all-the-icons
  :if (display-graphic-p))

;; Let dired have some icons
(use-package all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

;; Doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 40)))

;; Ivy trio (for better command completition)
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ;("C-x b" . counsel-ibuffer)
         ("C-x f" . counsel-find-file))
  :custom ((ivy-initial-inputs-alist nil)))  ; Don't start ivy searches with ^ (mostly significant for M-x)

(use-package swiper
  :bind ("C-s" . swiper))
  
(use-package ivy
  :init (ivy-mode 1)
  :diminish ivy-mode
  :bind (:map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-k" . ivy-previous-line)
         ("C-j" . ivy-next-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-switch-buffer-kill)
         ("TAB" . ivy-done)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill)))

;; Richer and more friendly interface for Ivy
(use-package ivy-rich
  :init (ivy-rich-mode 1))

;; Which Key
(use-package which-key
  :init (which-key-mode t)
  :custom ((which-key-idle-delay 0.5)))

;; A fancier dashboard
(use-package dashboard
  :config (dashboard-setup-startup-hook)
  :custom ((initial-buffer-choice (lambda() (get-buffer-create "*dashboard*"))) ; For Emacsclient windows
           (dashboard-startup-banner 'logo)
           (dashboard-center-content t)
           (dashboard-items '((recents . 5)
                              (projects . 5)
                              (bookmarks . 5)
                              (agenda . 5)))))

;;;
;;; Org mode
;;;

;; The package
(use-package org
  :hook (org-mode . (lambda()
                      (org-indent-mode)
                      (visual-line-mode 1)))
  :custom ((org-directory "~/pCloudDrive/OrgNotes/")
           (org-agenda-files (list org-directory))))

;; Have variable size headings
(dolist (face '((org-level-1 . 1.5)
                (org-level-2 . 1.4)
                (org-level-3 . 1.3)
                (org-level-4 . 1.2)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :height (cdr face)))

(use-package org-bullets
  :after (org)
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("▸")))

;;;
;;; Plugins for development
;;;

;; Projectile
(use-package projectile
  :diminish projectile-mode
  :init (projectile-mode)
  :custom ((projectilel-completion-system 'ivy))
  :bind-keymap ("C-c p" . projectile-command-map))

;; Magit
(use-package magit)

;; LSP mode
(use-package lsp-mode
  :custom (lsp-keymap-prefix "C-l")
  :hook ((c-mode . lsp-deferred)
         (csharp-mode . lsp-deferred))
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :commands (lsp-ui-mode))

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

(use-package company
  :bind (:map company-active-map
         ("<tab>" . company-complete-common-or-cycle)
         ;("<backtab>" . company-complete-common-or-cycle-1)
         ("<backtab>" . company-select-previous))
  :custom ((company-idle-delay 0.0)
           (company-minimum-prefix-length 1)))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs)
(use-package tree-sitter-indent)

;; Language specific LSP plugins

; Python
(use-package lsp-pyright
  :hook (python-mode . (lambda() (require 'lsp-pyright)
                          (lsp-deferred))))
