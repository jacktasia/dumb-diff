
(defun dumb-diff-go ()
  (interactive)
  (delete-other-windows)

  (split-window-below)
  (split-window-right)
  ;;

  (find-file (make-temp-file "DUMB_DIFF_1_"))
  (other-window 1)
  (find-file (make-temp-file "DUMB_DIFF_2_"))
  (other-window 1)
  (find-file (make-temp-file "DUMB_DIFF_RESULT_"))

  ;; https://emacs.stackexchange.com/questions/12459/save-buffer-at-each-modification

  (diff-mode)
  (insert "+123\n-456\n"))
