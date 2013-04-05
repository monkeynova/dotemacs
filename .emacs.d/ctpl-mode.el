(defvar ctpl-mode-hook nil)

(add-to-list 'auto-mode-list '("\\.tpl$" . ctpl-mode))

(defun ctpl-mode ()
  "Major mode for editing CTeplate files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table ctpl-mode-syntax-table)
  (use-local-map ctpl-mode-map)

  (set (make-local-variable 'font-lock-defaults) '(ctpl-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'ctpl-index-line)

  (setq major-mode 'ctpl-mode)
  (setq mode-name "ctemplate")
  (run-hooks 'ctpl-mode-hook)
  )

(provide 'ctpl-mode)
