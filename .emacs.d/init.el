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

;;; Basic settings

;; Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)

;; Use ESC to quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Disable backup files
(setq make-backup-files nil)

;;; UI

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
                eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

;; Theme
(use-package doom-themes
  :custom ((doom-themes-enable-bold t)
           (doom-themes-enable-italic t))
  :config
  (load-theme 'doom-one t))

;; All the icons
(use-package all-the-icons
  :if (display-graphic-p))

;; Doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 40)))

;; Ivy trio (for better command completition)
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
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

;;; Plugins for development

;; Projectile
(use-package projectile
  :diminish projectile-mode
  :init (projectile-mode)
  :custom ((projectilel-completion-system 'ivy))
  :bind-keymap ("C-c p" . projectile-command-map))

;; Magit
(use-package magit)
