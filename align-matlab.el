;; modes the alignment rules apply to.
(defvar align-matlab-modes '(matlab-mode octave-mode))

;; regular expressions matching region separators.  code between keywords and
;; empty lines will be aligned together.
;;
;; XXX: expressions separated by an else/elseif do not behave as expected.
(defvar align-matlab-region-separators
  (concat
   "\\(^\\s-*$\\|" ;; empty line
   "^\\s-*if\\b\\|"
   "^\\s-*else\\(if\\)?\\b\\|"
   "^\\s-*for\\b\\|"
   "^\\s-*end\\b\\|"
   "^\\s-*return\\b\\|"
   "^\\s-*while\\b\\|"
   "^\\s-*break\\b\\|"
   "^\\s-*continue\\b\\|"
   "^\\s-*try\\b\\|"
   "^\\s-*catch\\b\\|"
   "^\\s-*t[io]c\\b\\|"
   "^\\s-*case\\b\\|"
   "^\\s-*switch\\b\\|"
   "^\\s-*otherwise\\b\\|"
   "^\\s-*function\\b\\)")
  "A list of region separators in MATLAB.")

;; callback to enable MATLAB alignment suitable for use with hooks.
(defun align-matlab-region-hook ()
  (make-local-variable 'align-region-separate)
  (setq align-region-separate align-matlab-region-separators))

;; updates align-rules-list to include MATLAB-specific alignment rules.
(defun align-matlab-add-rules ()
  "Add MATLAB alignment rules."

  ;; match lines of the form "variable = expression" and expand/contract the
  ;; whitespace so alignment occurs about the equal sign.
  (add-to-list 'align-rules-list
               '(matlab-assignment
                 (regexp   . "[^=\\t\\n]\\(\\s-*\\)=\\(\\s-*\\)\\([^=\\t\\n]\\|$\\)")
                 (group    . (1 2))
                 (modes    . align-matlab-modes)
                 (justify  . t))))

;; entry point into adding the alignment rules into one's environment.  adds the
;; custom alignment rules after the align package is available and ensures that
;; the alignment hook is run for the appropriate modes.
(defun align-matlab-load ()
  "Enable MATLAB alignment."
  (interactive)

  (eval-after-load 'align
    '(align-matlab-add-rules))

  (add-hook 'matlab-mode-hook 'align-matlab-region-hook)
  (add-hook 'octave-mode-hook 'align-matlab-region-hook))

(provide 'align-matlab)
