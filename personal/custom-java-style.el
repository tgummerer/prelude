;;; custom-java-style.el --- Java style

;; Keywords: java, tools

;; custom-java-style is distributed under the terms of the GNU General Public License version 3.
;;
;; This work is partly derived from google-c-style.el.

(defconst custom-java-style
  `((c-recognize-knr-p . nil) ; K&R style argument declarations are not valid
    (c-basic-offset . 2)
    (indent-tabs-mode . nil) ; tabs are evil!
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((defun-open after)
                               (defun-close before after)
                               (class-open after)
                               (class-close before after)
                               (namespace-open after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open after)
                               (block-close . c-snug-do-while)
                               (extern-lang-open after)
                               (extern-lang-close after)
                               (statement-case-open after)
                               (substatement-open after)))
    (c-hanging-colons-alist . ((case-label)
                               (label after)
                               (access-label after)
                               (member-init-intro before)
                               (inher-intro)))
    (c-hanging-semi&comma-criteria
     . (c-semi&comma-no-newlines-for-oneline-inliners
        c-semi&comma-inside-parenlist
        c-semi&comma-no-newlines-before-nonblanks))
    (c-indent-comments-syntactically-p . nil)
    (comment-column . 40)
    (c-cleanup-list . (brace-else-brace
                       brace-elseif-brace
                       brace-catch-brace
                       empty-defun-braces
                       defun-close-semi
                       list-close-comma
                       scope-operator))
    (c-offsets-alist . (;;(arglist-intro custom-java-lineup-expression-plus-4)
                        (func-decl-cont . ++)
                        (member-init-intro . ++)
                        (inher-intro . ++)
                        (comment-intro . 0)
                        (arglist-close . c-lineup-arglist)
                        (topmost-intro . 0)
                        (block-open . 0)
                        (inline-open . 0)
                        (substatement-open . 0)
                        (statement-cont
                         .
                         (,(when (fboundp 'c-no-indent-after-java-annotations)
                             'c-no-indent-after-java-annotations)
                          ,(when (fboundp 'c-lineup-assignments)
                             'c-lineup-assignments)
                          ++))
                        (label . /)
                        (case-label . +)
                        (statement-case-open . +)
                        (statement-case-intro . +) ; case w/o {
                        (access-label . /)
                        (innamespace . 0)
                        (arglist-intro . ++)
                        (arglist-cont-nonempty . ++)
                        (annotation-var-cont . 0)))
    (c-block-comment-prefix . "*"))
  "Custom Java Programming Style")

(defun custom-set-java-style ()
  "Set the current buffer's java-style to my Custom Programming Style. Meant to be added to `java-mode-hook'."
  (interactive)
  (make-local-variable 'c-tab-always-indent)
  (setq c-tab-always-indent t)
  (c-toggle-auto-newline 0)
  (c-add-style "custom-java-style" custom-java-style t))

(defun custom-make-newline-indent ()
  "Sets up preferred newline behavior. Not set by default. Meant to be added to `java-mode-hook'."
  (interactive)
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map [ret] 'newline-and-indent))

(provide 'custom-java-style)
;;; custom-java-style.el ends here
