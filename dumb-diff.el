
;; TODO: make major-mode

(defvar dumb-diff-f1 nil)
(defvar dumb-diff-f2 nil)
(defvar dumb-diff-f-result nil)

(defun dumb-diff-go ()
  (interactive)

  (setq dumb-diff-f1 (get-buffer-create "*Dumb Diff 1*"))
  (setq dumb-diff-f2 (get-buffer-create "*Dumb Diff 2*"))
  (setq dumb-diff-f-result (get-buffer-create "*Dumb Diff Result*"))

  (delete-other-windows)
  (split-window-below)
  (split-window-right)

  (switch-to-buffer dumb-diff-f1)
  (other-window 1)

  (switch-to-buffer dumb-diff-f2)
  (other-window 1)

  (switch-to-buffer dumb-diff-f-result)
  (dumb-diff-refresh))

(defun dumb-diff-get-buffer-contents (b)
  (with-current-buffer b
    (buffer-string)))

(defun dumb-diff-write-to-file (f c)
  (with-temp-file f
    (insert
     (dumb-diff-get-buffer-contents c))))

(defun dumb-diff-refresh ()
  (interactive)

  (let* ((dd-f1 (make-temp-file "dumb-diff-f1"))
         (dd-f2 (make-temp-file "dumb-diff-f2")))

    (dumb-diff-write-to-file dd-f1 dumb-diff-f1)
    (dumb-diff-write-to-file dd-f2 dumb-diff-f2)

    (let* ((cmd (format "diff -u %s %s" dd-f1 dd-f2))
           (raw-result (shell-command-to-string cmd))
           (result (if (> (length raw-result) 0) result "(no difference)")))
      (with-current-buffer dumb-diff-f-result
        (funcall 'diff-mode)
        (erase-buffer)
        (insert result)))))


;;END
