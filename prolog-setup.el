;;;;;;;;;;;;;;;
;;;;prologの設定
;;;;;;;;;;;;;;;

(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
				("\\.p$" . prolog-mode)
                                ("\\.m$" . mercury-mode))
			      auto-mode-alist))
(setq prolog-program-name "~/.emacs.d/setup-elisp/bin/swipl")
(setq prolog-consult-string "[user].\n")

(add-hook 'prolog-mode-hook 'auto-complete-mode)

(defun line-to-other-buffer ()
  (let ((prl-buffer (get-buffer-create "*prolog*"))
	(current-line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
    (set-buffer (buffer-name prl-buffer))
    (insert (format "%s" current-line))
    (comint-send-input)))

(add-hook 'prolog-mode-hook
	  '(lambda ()
	     (define-key prolog-mode-map (kbd "\C-c\C-v")
	       (lambda ()
		 (interactive)
		 (line-to-other-buffer)))))

(provide 'prolog-setup)
