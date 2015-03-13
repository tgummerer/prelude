(server-start)

(global-linum-mode t)

;; -----
;; Theme
;; -----
(disable-theme 'zenburn)
(load-theme 'solarized-light t)

;; Ident style
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

(add-hook 'html-mode-hook
	  (lambda()
	    (setq sgml-basic-offset 8)
	    (setq indent-tabs-mode t)))

;; Autoindent on newline
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Don't use preludes half beginning of line stuff
(global-set-key [remap move-beginning-of-line]
                'move-beginning-of-line)

;; -------
;; spotify
;; -------
;; (require 'spotify)

;; -------
;; notmuch
;; -------
;;(autoload 'notmuch "notmuch" "notmuch mail" t)
(require 'notmuch)
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq mail-host-address "gmail.com")
(setq user-full-name "Thomas Gummerer")
(setq user-mail-address "t.gummerer@gmail.com")

(require 'notmuch-pick nil t)

;; ------------------------------
;; find file as root if necessary
;; ------------------------------

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
	       (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


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
