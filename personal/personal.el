(server-start)

(global-linum-mode t)

;; -----
;; Theme
;; -----
(disable-theme 'zenburn)
(load-theme 'solarized-light t)

;; -----------
;; Ident style
;; -----------
(setq-default inhibit-startup-message t
              font-lock-maximum-decoration t
              visible-bell t
              require-final-newline t
              resize-minibuffer-frame t
              column-number-mode t
              display-battery-mode t
              transient-mark-mode t
              next-line-add-newlines nil
              blink-matching-paren t
              quack-pretty-lambda-p t
              blink-matching-delay .25
              vc-follow-symlinks t
              indent-tabs-mode t
              tab-width 8
              c-basic-offset 8
	      js-indent-level 8
              edebug-trace t
              fill-adapt-mode t
              winner-mode t
              uniquify-buffer-name-style 'forward
	      indent-tabs-mode t)

;; Autoindent on newline
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Don't use preludes half beginning of line stuff
(global-set-key [remap move-beginning-of-line]
                'move-beginning-of-line)


;; ----
;; html
;; ----
(add-hook 'html-mode-hook
	  (lambda()
	    (setq sgml-basic-offset 8)
	    (setq indent-tabs-mode t)))

;; ---
;; xml
;; ---
(defun my-xml-hook ()
  (setq c-tab-always-indent nil
	tab-width 4
	indent-tabs-mode nil))
(add-hook 'nxml-mode-hook 'my-xml-hook)

;; ----
;; java
;; ----
(load "~/.emacs.d/personal/custom-java-style.el")
(add-hook 'java-mode-hook 'custom-set-java-style)

;; ------
;; python
;; ------

(add-hook 'python-mode-hook
	  (lambda()
	    (setq tab-width 2)
	    (setq indent-tabs-mode nil)))

;; ----
;; perl
;; ----
(setq-default cperl-indent-level 8
	      cperl-close-paren-offset -8
	      cperl-continued-statement-offset 8
	      cperl-indent-parens-as-block t
	      cperl-tab-always-indent t
	      tab-width 8)

;; -----
;; shell
;; -----

(add-hook 'sh-mode-hook
	  (lambda ()
	    (setq sh-basic-offset 8
		  indent-tabs-mode t)))

;; -------
;; Haskell
;; -------

(custom-set-variables
 '(haskell-mode-hook '(turn-on-haskell-indentation)))

;; ------------------------------------------
;; Got this from the kernel coding guidelines
;; ------------------------------------------
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/src/linux-trees")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))

;; ---------------
;; smart-mode-line
;; ---------------
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'automatic)

(setq system-uses-terminfo nil)

(global-set-key (kbd "M-p") 'ace-window)

;; -------
;; notmuch
;; -------
(require 'notmuch)
