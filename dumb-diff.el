
(defvar dumb-diff-f1 nil)
(defvar dumb-diff-f2 nil)
(defvar dumb-diff-f-result nil)

(defun dumb-diff-go ()
  (interactive)
  ;; (let

  (when dumb-diff-f1
    (kill-buffer (get-buffer dumb-diff-f1)))

  (when dumb-diff-f2
    (kill-buffer (get-buffer dumb-diff-f2)))

  (when dumb-diff-f-result
    (kill-buffer (get-buffer dumb-diff-f-result)))

  (setq dumb-diff-f1 "/tmp/dumb-diff-f1")
  (setq dumb-diff-f2 "/tmp/dumb-diff-f2")
  (setq dumb-diff-f-result "/tmp/dumb-diff-f-result.diff")

  (delete-other-windows)
  (split-window-below)
  (split-window-right)
  ;;

  (find-file dumb-diff-f1)
  (other-window 1)
  (find-file dumb-diff-f2)
  (other-window 1)
  (find-file dumb-diff-f-result)
  (dumb-diff-refresh))

  ;; https://emacs.stackexchange.com/questions/12459/save-buffer-at-each-modification

(defun dumb-diff-refresh ()
  (interactive)
  (with-current-buffer (find-file-noselect dumb-diff-f1)
    (funcall 'basic-save-buffer))

  (with-current-buffer (find-file-noselect dumb-diff-f2)
    (funcall 'basic-save-buffer))

  (let ((cmd (format "diff -u %s %s > %s" dumb-diff-f1 dumb-diff-f2 dumb-diff-f-result)))
        (shell-command-to-string cmd)

        (with-current-buffer dumb-diff-f-result
          (revert-buffer nil t))))


;;END
