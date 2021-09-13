;;; eslint-auto-fix-mode.el --- Run eslint --fix automatically.  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  A.I.

;; Author: A.I. <merrick@luois.me>
;; Keywords: language tools
;; Version: 0.2
;; Package-Requires: ((emacs "26.1"))
;; Keywords: eslint javascript
;; URL: https://github.com/merrickluo/eslint-auto-fix-mode

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Run eslint --fix automatically after saving files.

;;; Code:
(defvar-local eslint-auto-fix-executable (executable-find "eslint"))

(defun eslint-auto-fix-mode--run ()
  "Run eslint --fix on current buffer."
  (interactive)
  (when eslint-auto-fix-mode
    (when-let ((eslint-executable (or eslint-auto-fix-executable
                                      (executable-find "eslint"))))
      (setq-local eslint-auto-fix-executable eslint-executable)
      (let ((args (list "--fix" (buffer-file-name))))
        (apply #'process-file eslint-executable nil nil nil args)
        (revert-buffer t t t)))))

;;;###autoload
(define-minor-mode eslint-auto-fix-mode
  "Runs eslint --fix on buffer when enabled."
  nil nil nil
  (add-hook 'after-save-hook #'eslint-auto-fix-mode--run))

(provide 'eslint-auto-fix-mode)
