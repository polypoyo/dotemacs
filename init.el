;; MELPA
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/") 
						 ("org" . "https://orgmode.org/elpa/") 
						 ("gnu" . "https://elpa.gnu.org/packages/") 
						 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
;; Setup quelpa-use-package
(unless (package-installed-p 'quelpa) 
  (with-temp-buffer (url-insert-file-contents
					 "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el") 
					(eval-buffer) 
					(quelpa-self-upgrade)))
(quelpa '(quelpa-use-package :fetcher git 
							 :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)
;;(unless (package-installed-p 'use-package)
;;  (package-install 'use-package))
;;(require 'use-package)
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
(use-package 
  nix-mode)
(use-package 
  lua-mode)
(use-package 
  rust-mode)
;; COMplete ANYthing
(use-package 
  company 
  :init (add-hook 'after-init-hook 'global-company-mode))
(use-package 
  eshell-vterm 
  :quelpa (eshell-vterm :fetcher github 
						:reop "https://github.com/iostapyshyn/eshell-vterm.git") 
  :demand t 
  :after eshell 
  :config (eshell-vterm-mode))

;; BEGIN Org mode configuration
(use-package 
  visual-fill-column 
  :ensure t 
  :init (setq visual-fill-column-width 80 visual-fill-column-center-text t))
(use-package 
  org
  ;; Settings when not presenting
  (defun my/org-present-end () 
	(interactive) 
	(text-scale-set 1) 
	(visual-fill-column-mode -1) 
	(toggle-truncate-lines -1) 
	(toggle-word-wrap 1) 
	(visual-line-mode 0) 
	(display-line-numbers-mode 1) 
	(org-display-inline-images -1) 
	(display-line-numbers--turn-on) 
	(read-only-mode -1))
  ;; Settings when presenting
  (defun my/org-present () 
	(interactive) 
	(text-scale-set 3) 
	(visual-fill-column-mode 1) 
	(visual-line-mode 1) 
	(display-line-numbers-mode 0) 
	(org-display-inline-images 1) 
	(read-only-mode 1)) 
  :hook ((org-mode . my/org-present-end)
		 (org-mode . org-indent-mode))
  :custom
  (org-ellipsis " ▼" "Replace the \"...\" in org-mode with a downwards triangle because it looks better")
  (org-hide-emphasis-markers t)
  ;; Show hidden emphasis markers
  (use-package 
	org-appear 
	:hook (org-mode . org-appear-mode)) 
  (use-package 
	org-tree-slide 
	:ensure t 
	:after org 
	:bind (:map org-mode-map 
				("<f8>" . org-tree-slide-mode) 
				:map org-tree-slide-mode-map
				("<prior>" . org-tree-slide-move-previous-tree) 
				("<next>" . org-tree-slide-move-next-tree) 
				("ESC" . org-tree-slide-mode)) 
	:hook (org-tree-slide-play . my/org-present) 
	:hook (org-tree-slide-stop . my/org-present-end) 
	:custom (org-tree-slide-slide-in-effect nil) 
	(org-tree-slide-breadcrums " // ")) 
  (use-package 
	org-superstar 
	:hook (org-mode . org-superstar-mode)))
;; END Org mode configuration
(use-package 
  lsp-mode 
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l") 
  :hook ((c-mode . lsp) 
		 (rust-mode . lsp) 
		 (python-mode . lsp)
         ;; if you want which-key integration
         ;;(lsp-mode . lsp-enable-which-key-integration)
		 ) 
  :commands lsp)
;; -------------------------- ;;
(use-package 
  drag-stuff 
  :config (drag-stuff-define-keys) 
  (drag-stuff-global-mode))
(use-package 
  prettier)
;; Less mouse, more keyboard
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 1)
(setq use-dialog-box nil)
(use-package 
  web-mode)
;; Basic code editor stuff
(global-display-line-numbers-mode 1)	; show line numbers
(add-hook 'vterm-mode-hook (lambda () 
							 (display-line-numbers-mode -1))) ; ...except in the terminal.
(global-hl-line-mode 1)					; highlight current line
(global-auto-revert-mode 1) ; auto-refresh files when changed (great for logs!)
(setq global-auto-revert-non-file-buffers t) ; same, but for dired (and more)
(electric-pair-mode 1)						 ; Bracket pairing

(recentf-mode 1)
(save-place-mode 1)

;; Save minibuffer history
(setq history-length 25)
(savehist-mode 1)

;;; Theming
(load (locate-user-emacs-file "theming.el"))
(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

;; Close tags in html
(setq sgml-quick-keys 'close)

;;; Other Variables
(setq inhibit-startup-message t visible-bell t)
(setq-default tab-width 4)
(setq-default cursor-type 'bar)

(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))

;;; Move `customize's junk into a separate file
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
