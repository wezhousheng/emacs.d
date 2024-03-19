;;;go
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(require-package 'go-guru)
(add-hook 'before-save-hook #'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") #'godef-jump)))

;;;(defun copy-from-osx ()
;;;  (shell-command-to-string "pbpaste"))
;;;(defun paste-to-osx (text &optional push)
;;;  (let ((process-connection-type nil))
;;;    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;;      (process-send-string proc text)
;;;      (process-send-eof proc))))
;;;(setq interprogram-cut-function 'paste-to-osx)
;;;(setq interprogram-paste-function 'copy-from-osx)

(require-package 'multi-term)

;;smerge-ediff
(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))

(defun copy-full-path ()
  "copy current buffer's full path"
  (interactive)
  (kill-new buffer-file-name))

;;markdown
(require-package 'pandoc)
(custom-set-variables
 '(markdown-command "/usr/local/bin/pandoc"))
(require-package 'flymd)
(defun my-flymd-browser-function (url)
  (let ((process-environment (browse-url-process-environment)))
    (apply 'start-process
           (concat "firefox " url)
           nil
           "/usr/bin/open"
           (list "-a" "firefox" url))))
(setq flymd-browser-open-function 'my-flymd-browser-function)

;;;flutter
(require-package 'dart-mode)

(require-package 'undo-tree)
(global-undo-tree-mode)

(provide 'init-local)
