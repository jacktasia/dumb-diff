
;; TODO: audit inline TODOS
;; TODO: add license
;; TODO: package-ify
;; TODO: submit to MELPA

(defvar dumb-diff-buf1 nil)
(defvar dumb-diff-buf2 nil)
(defvar dumb-diff-buf-result nil)

(defvar dumb-diff-msg-empty "Press `C-c C-c` to view the diff for the buffers above")
(defvar dumb-diff-msg-no-difference "(no difference)")

(defun dumb-diff-go ()
  (interactive)

  (setq dumb-diff-buf1 (get-buffer-create "*Dumb Diff 1*"))
  (setq dumb-diff-buf2 (get-buffer-create "*Dumb Diff 2*"))
  (setq dumb-diff-buf-result (get-buffer-create "*Dumb Diff Result*"))

  (delete-other-windows)
  (split-window-below)
  (split-window-right)

  (switch-to-buffer dumb-diff-buf1)
  (other-window 1)

  (switch-to-buffer dumb-diff-buf2)
  (other-window 1)

  (switch-to-buffer dumb-diff-buf-result)
  (dumb-diff--refresh))

(defun dumb-diff-select-result ()
  (interactive)
  (switch-to-buffer dumb-diff-buf-result))

(defun dumb-diff-get-buffer-contents (b)
  (with-current-buffer b
    (buffer-string)))

(defun dumb-diff-write-to-file (f c)
  (with-temp-file f
    (insert c)))


(defun dumb-diff--refresh ()
  "Run `diff` command and update result buffer."
  (let* ((dd-f1 (make-temp-file "dumb-diff-buf1"))
         (dd-f2 (make-temp-file "dumb-diff-buf2"))
         (txt-f1 (dumb-diff-get-buffer-contents dumb-diff-buf1))
         (txt-f2 (dumb-diff-get-buffer-contents dumb-diff-buf2))
         (is-blank (and (= (length txt-f1) 0)
                        (= (length txt-f2) 0))))

    ;; write buffer contents to temp file for comparison
    (dumb-diff-write-to-file dd-f1 txt-f1)
    (dumb-diff-write-to-file dd-f2 txt-f2)

    ;; ensure compare buffers have major mode enabled
    (dolist (x (list dumb-diff-buf2 dumb-diff-buf1))
      (with-current-buffer x
        (funcall 'dumb-diff-mode)))

    (let* ((cmd (format "diff -u %s %s" dd-f1 dd-f2))
           (raw-result (shell-command-to-string cmd))
           (result (if (> (length raw-result) 0)
                       raw-result
                     (if is-blank
                         dumb-diff-msg-empty
                       dumb-diff-msg-no-difference))))

      ;; TODO: replace tmp file name with the pretty buffer name
      (with-current-buffer dumb-diff-buf-result
        (funcall 'diff-mode)
        (erase-buffer)
        (insert result)))
    (dumb-diff-select-result)))


(defvar dumb-diff-mode-map (make-sparse-keymap)
  "Keymap for `dumb-diff-mode'.")

(defun dumb-diff-mode-keymap ()
  "Define keymap for `dumb-diff-mode'."
  (define-key dumb-diff-mode-map (kbd "C-c C-c") 'dumb-diff-go))


(define-derived-mode dumb-diff-mode
  fundamental-mode
  "Dumb Diff"
  (dumb-diff-mode-keymap))


;;END
