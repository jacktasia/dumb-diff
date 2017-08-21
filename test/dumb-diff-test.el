;;; -*- lexical-binding: t -*-

;;; Code:

(ert-deftest test-dumb-diff-get-buffer-contents ()
  (let* ((buf (get-buffer-create "*Test*"))
         (contents "test-contents"))
    (with-current-buffer buf
      (insert contents))
  (should (string= contents (dumb-diff-get-buffer-contents buf)))))
