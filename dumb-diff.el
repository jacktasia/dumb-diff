
;; TODO: audit inline TODOS
;; TODO: add license
;; TODO: package-ify
;; TODO: submit to MELPA

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
  (dumb-diff--refresh))

(defun dumb-diff-select-f1 ()
  (interactive)
  (switch-to-buffer dumb-diff-f1))

(defun dumb-diff-select-f2 ()
  (interactive)
  (switch-to-buffer dumb-diff-f2))

(defun dumb-diff-select-result ()
  (interactive)
  (switch-to-buffer dumb-diff-f-result))

(defun dumb-diff-get-buffer-contents (b)
  (with-current-buffer b
    (buffer-string)))

(defun dumb-diff-write-to-file (f c)
  (with-temp-file f
    (insert
     (dumb-diff-get-buffer-contents c))))

(defun dumb-diff--refresh ()
  (let* ((dd-f1 (make-temp-file "dumb-diff-f1"))
         (dd-f2 (make-temp-file "dumb-diff-f2")))

    (dumb-diff-write-to-file dd-f1 dumb-diff-f1)
    (dumb-diff-write-to-file dd-f2 dumb-diff-f2)

    (with-current-buffer dumb-diff-f1
      (funcall 'dumb-diff-mode))

    (with-current-buffer dumb-diff-f2
      (funcall 'dumb-diff-mode))

    (let* ((cmd (format "diff -u %s %s" dd-f1 dd-f2))
           (raw-result (shell-command-to-string cmd))
           (result (if (> (length raw-result) 0) raw-result "(no difference)")))
      (with-current-buffer dumb-diff-f-result
        (funcall 'diff-mode)
        (erase-buffer)
        (insert result)))))


(defvar dumb-diff-mode-map (make-sparse-keymap)
  "Keymap for `dumb-diff-mode'.")

(defun dumb-diff-mode-keymap ()
  "Define keymap for `dumb-diff-mode'."
  (define-key dumb-diff-mode-map (kbd "C-c 1") 'dumb-diff-select-f1) ;; TODO: find better key bindings
  (define-key dumb-diff-mode-map (kbd "C-c 2") 'dumb-diff-select-f2)
  (define-key dumb-diff-mode-map (kbd "C-c 3") 'dumb-diff-select-result)
  (define-key dumb-diff-mode-map (kbd "C-c C-c") 'dumb-diff-go))


(define-derived-mode dumb-diff-mode
  fundamental-mode
  "Dumb Diff"
  (dumb-diff-mode-keymap))


;;END
