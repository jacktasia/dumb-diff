;;; -*- lexical-binding: t -*-

;;; Code:

(ert-deftest test-dumb-diff-get-buffer-contents ()
  (let* ((buf (get-buffer-create "*Test*"))
         (contents "test-contents"))
    (with-current-buffer buf
      (insert contents))
  (should (string= contents (dumb-diff-get-buffer-contents buf)))))


(ert-deftest test-dumb-diff-write-to-file ()
  (let* ((test-file (make-temp-file "dumb-diff-test-write"))
         (contents "some-test-contents"))
  (dumb-diff-write-to-file test-file contents)

  (should (string= contents
                   (with-temp-buffer
                     (insert-file-contents test-file)
                     (buffer-string))))))
