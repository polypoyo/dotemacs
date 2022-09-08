;; MELPA
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/") 
			 ("org" . "https://orgmode.org/elpa/") 
			 ("gnu" . "https://elpa.gnu.org/packages/") 
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
;; Setup use-package
(unless (package-installed-p 'use-package) 
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; -------------------------- ;;

;; Vertico search
(use-package 
  vertico 
  :init (vertico-mode)
  (setq vertico-resize t)
  (setq vertico-cycle t))
;; Elisp formatter
(use-package 
  elisp-format)
;; I use NixOS so this is very important
(use-package nix-mode)
(use-package lua-mode)
;; COMplete ANYthing
(use-package company
  :init (add-hook 'after-init-hook 'global-company-mode))
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (c-mode . lsp)
	 (python-mode . lsp)
         ;; if you want which-key integration
         ;;(lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; -------------------------- ;;

;; Less mouse, more keyboard
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 1)
(setq use-dialog-box nil)

;; Basic code editor stuff
(global-display-line-numbers-mode 1)	; show line numbers
(global-hl-line-mode 1)			; highlight current line
(global-auto-revert-mode 1) ; auto-refresh files when changed (great for logs!)
(setq global-auto-revert-non-file-buffers t) ; same, but for dired (and more)
(electric-pair-mode 1) ; Bracket pairing

(recentf-mode 1)
(save-place-mode 1)

;; Save minibuffer history
(setq history-length 25)
(savehist-mode 1)

;;; Theming
(load (locate-user-emacs-file "theming.el"))
(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

;;; Other Variables
(setq inhibit-startup-message t visible-bell t)

;;; Move `customize's junk into a separate file
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
