;; package manager settings
(require 'package)
(package-initialize)
(add-to-list 'package-archives
'("melpa" . "http://melpa.milkbox.net/packages/") t)


;; add custom load
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/")


;; editor and layout
(tool-bar-mode -1)
(global-linum-mode 1)
(load-theme 'wombat t)


;; plugin settings
(projectile-global-mode)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)


;; put auto save files into default tmp directory
(defvar user-temporary-file-directory "~/.emacs-backup")
(make-directory user-temporary-file-directory t)
(defconst emacs-tmp-dir (format "%s/%s%s/" user-temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix emacs-tmp-dir)


;; useful methods
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

