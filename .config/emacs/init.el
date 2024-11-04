;; Make UI look better
(setq inhibit-startup-message t) ; Don't show the splash screen

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(set-face-attribute 'default nil :height 120) ; Increase font size

(add-to-list 'default-frame-alist '(fullscreen . maximized)) ; Start maximized pls

(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color"))) ; Have some colors eshell

(global-hl-line-mode 1)

;; Behavior

;; 'setq-default' will set the value to be global default, not just fot the local buffer
(setq-default make-backup-files nil ; I don't want backup files, thanks
              tab-width 4           ; Reasonable tab size
              indent-tabs-mode nil  ; Spaces instead of tabs please
              truncate-lines t)     ; Disable word wrapping by default

(setq backup-directory-alist `(("." . "/tmp"))) ; Please don't bloat my system with #..# files

(electric-pair-mode 1) ; Auto-pair my brackets please

(global-auto-revert-mode 1) ; Make Emacs refresh a buffer when the underlying file is modified

(setq use-dialog-box nil) ; Don't give me popup windows

;; MELPA
(require 'package) ; We need 'package' first
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package (cannot forgo this it seems)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

;; Themes
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm))

;; Better modeline
(use-package doom-modeline
  :custom
  (doom-modeline-height 35)
  :hook
  (after-init . doom-modeline-mode))

;; Evil mode (couldn't bear the default bindings, sorry)
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :custom
  ((evil-want-C-u-scroll t)
   (evil-split-window-below t)
   (evil-split-window-right t)
   (evil-undo-system 'undo-redo))
  :config
  (evil-mode 1)
  (evil-global-set-key 'visual (kbd "C-c /") 'comment-or-uncomment-region))

(use-package evil-collection ; For parts that don't integrate well by default
  :after evil
  :config
  (evil-collection-init))

;; I love my 'jk' escape
(use-package evil-escape
  :config
  (setq-default evil-escape-key-sequence "jk")
  (evil-escape-mode 1))

;; Programming modes
(use-package rust-mode
  :config
  (setq rust-mode-treesitter-derive t)) ; Has to be under ':config' because it needs to run after package loading

;; Eglot (LSP)
(use-package eglot ; It's actually built-in. I use 'use-package' for simplicity
  :bind
  (:map eglot-mode-map
        ("C-c h" . eldoc)
        ("C-c f" . eglot-format-buffer)
        ("C-<return>" . eglot-code-actions)
        ("C-c c" . compile)
        ("C-c r" . eglot-rename))
  :hook
  ((rust-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (mhtml-mode . eglot-ensure)
   (css-mode . eglot-ensure))
  :config  ; I really hope there are some better ways to do this.
  (evil-define-key 'normal eglot-mode-map (kbd "gd") 'xref-find-definitions)
  (evil-define-key 'normal eglot-mode-map (kbd "gr") 'xref-find-references))

(use-package eldoc
  :custom
  (eldoc-echo-area-use-multiline-p 4)    ; Limit the documentation size eldoc shows
  (eldoc-echo-area-prefer-doc-buffer t)) ; Don't show info twice

;; Git
(use-package magit
  :bind
  ("C-c g" . magit-status)
  :custom
  (magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1))

;; Better terminal emulator
(use-package vterm
  :custom
  (vterm-shell "/usr/bin/fish"))

;; Some auto completion
(use-package company
  :custom
  ((company-idle-delay 0)
   (company-minimum-prefix-length 1)
   (company-selection-wrap-around t))
  :config
  (company-tng-mode 1)
  (global-company-mode 1))

;; Sadly this is buggy atm.
;; (use-package corfu
;;   :custom
;;   ((corfu-cycle t)
;;    (corfu-auto t)
;;    (corfu-preselect 'prompt)
;;    (corfu-auto-prefix 2)
;;    (corfu-auto-delay 0.1))
;;   :bind
;;   (:map corfu-map
;;         ("TAB" . corfu-next)
;;         ("<backtab>" . corfu-previous))
;;   :init
;;   (global-corfu-mode 1))

;; Ivy + Counsel
(use-package ivy
  :bind
  (:map ivy-minibuffer-map
        ("TAB" . ivy-alt-done)
        ("C-j" . ivy-next-line)
        ("C-k" . ivy-previous-line)
        :map ivy-switch-buffer-map
        ("C-k" . ivy-previous-line)
        ("C-d" . ivy-switch-buffer-kill))
  :custom
  ((ivy-use-virtual-buffers nil)    ; Don't want closed buffers to show on buffer switcher
   (enable-recursive-minibuffers t)
   (ivy-initial-inputs-alist nil))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind
  (("C-x b" . counsel-switch-buffer)
   ("C-x C-b" . counsel-switch-buffer))
  :config
  (counsel-mode 1))

(use-package swiper
  :bind
  ("C-s" . swiper))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1))

;; Which key
(use-package which-key
  :config
  (which-key-mode 1))

;; Org shenanigans
(use-package org
  :custom
  ((org-src-tab-acts-natively t)) ; Proper indentations in source code blocks
  :hook
  (org-mode . org-indent-mode))

(use-package org-superstar
  :custom
  ((org-superstar-headline-bullets-list '("•"))
   (org-superstar-leading-bullet " "))
  :hook
  (org-mode . org-superstar-mode))

;; Keybinds
(keymap-global-set "C-x C-k" 'kill-this-buffer)

;; Keep the junk out of this file please
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file t)
