;;; package --- Summary
;;; Commentary:
;;; Code:

;;;; defaults
(setq default-directory "~/Dev/Code")


;;;; package manager settings
(require 'package)
(package-initialize)
(add-to-list 'package-archives
'("melpa" . "http://melpa.milkbox.net/packages/") t)


;;;; add custom load
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/")


;;;; editor and layout
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(show-paren-mode 1)
(load-theme 'wombat t)
(require 'redo+)
(define-key global-map (kbd "C-.") 'undo)
(define-key global-map (kbd "C-/") 'redo)


;;;; window and folder navigation
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(require 'ido)
(ido-mode t)
(require 'direx)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
(require 'popwin)
(popwin-mode 1)
(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)


;;;; plugin settings
;; projectile
(projectile-global-mode)
;; auto-complete
(require 'auto-complete-config) ; Load the default configuration
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict") ; dicts path
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t) ; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2) ; case sensitivity is important when finding matches
(setq ac-ignore-case nil)
;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(yas-load-directory "~/.emacs.d/yasnippet/snippets")
(add-to-list 'ac-sources 'ac-source-yasnippet)
;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;; web-beautify
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))
(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))
(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;; js3-mode
;(autoload 'js3-mode "js3" nil t)
;(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))


;; put auto save files into default tmp directory
(defvar user-temporary-file-directory "~/.emacs-backup")
(make-directory user-temporary-file-directory t)
(defconst emacs-tmp-dir (format "%s/%s%s/" user-temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix emacs-tmp-dir)


;; Mac OSX platform config
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; useful methods
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file user-init-file))
(defun load-user-init-file ()
  "Load the `user-init-file'."
  (interactive)
  (load-file user-init-file))

;;; init.el ends here

