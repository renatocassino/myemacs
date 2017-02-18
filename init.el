;;;(setq make-backup-files nil)

(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/elpa/neotree")
(add-to-list 'load-path "~/.emacs.d/custom")

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(global-linum-mode t)
(load-theme 'wombat)

;; Find file
(global-set-key (kbd "C-x f") 'fiplr-find-file)

;; Cursor
(setq-default cursor-type 'bar)

;; No tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 2) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; Space between line
(setq linum-format "%4d \u2502 ")

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; For ruby env
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)

;; RVM
(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;; Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

; JSX and ECMA
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;(load "00common-setup.el")
;(load "01ruby.el")
;(load "02org.el")


(defun prompt-macro-query (arg)
        "Prompt for input using minibuffer during kbd macro execution.
    With prefix argument, allows you to select what prompt string to use.
    If the input is non-empty, it is inserted at point."
        (interactive "P")
        (let* ((query (lambda () (kbd-macro-query t)))
               (prompt (if arg (read-from-minibuffer "PROMPT: ") "Input: "))
               (input (unwind-protect
                          (progn
                            (add-hook 'minibuffer-setup-hook query)
                            (read-from-minibuffer prompt))
                        (remove-hook 'minibuffer-setup-hook query))))
          (unless (string= "" input) (insert input))))
(global-set-key "\C-xQ" 'prompt-macro-query)

; Macros
; C-x ( # Begin
; C-x ) # End
; C-x C-k n # Save name
; C-u <n> C-x e # Run many times
; C-x C-k SPC # Control macro
; C-x C-k e # Edit current macro
; C-x C-k b # Set macro command
; C-x C-k <0..9> # Set command to number
; M-x insert-kbd-macro # Convert named macro to LISP command

(fset 'changelog-add
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("<## Q (Q) - Q" 0 "%d")) arg)))

;; SET COMMANDS
(global-set-key (kbd "C-c t") 'emmet-expand-line)

;; Remote automatic # coding utf-8 for ruby-mode
(setq ruby-insert-encoding-magic-comment nil)

;;;; Clipboard for ubuntu
(defun copy-from-ubuntu (text &optional push)
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
    )

(defun paste-to-ubuntu ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string "xsel -o -b"))
    )
  )

;;;;; Clipboard Mac OS X
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))
(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(if (equal (shell-command-to-string "uname") "Darwin\n")
  (progn
    ;;;;; Clipboard Mac OS X
    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx))
  (progn
    ;;;;; Clipboard UBUNTU
    (setq interprogram-cut-function 'copy-from-ubuntu)
    (setq interprogram-paste-function 'paste-to-ubuntu)))

