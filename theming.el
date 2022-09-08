;; -*- mode: emacs-lisp -*-
;; Modus configuration

;; Disable modeline buffer
(setq modus-themes-mode-line '(accented borderless padded))
;; Nicer region selection
(setq modus-themes-region '(bg-only))
;; Paren matching
(setq modus-themes-paren-match '(intense bold underline))
;; completion colors
(setq modus-themes-completions (quote ((matches . (extrabold background intense)) 
				       (selection . (semibold accented intense)) 
				       (popup . (accented)))))
;; more bold
(setq modus-themes-bold-constructs t)
;; italic comments
(setq modus-themes-italic-constructs t)
;; green strings (like vscode's Dark+)
(setq modus-themes-syntax '(green-strings))
;; heading setup
(setq modus-themes-headings (quote ((0 . (variable-pitch rainbox)) 
				    (1 . (background overline variable-pitch rainbow 1.5)) 
				    (2 . (overline variable-pitch rainbow 1.3)) 
				    (3 . (overline variable-pitch rainbow 1.1)) 
				    (t . (variable-pitch rainbow)))))
;; Org mode source block background
(setq modus-themes-org-blocks 'tinted-background)
;; Actually load the theme
(load-theme 'modus-vivendi t)
