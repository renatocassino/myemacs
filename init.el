;;;(setq make-backup-files nil)

(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/elpa/neotree")
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "C-x q") 'neotree-toggle)

(global-linum-mode t)
(if (equal (shell-command-to-string "uname") "Darwin\n")
  (load-theme 'tango-dark)
  (load-theme 'tsdh-dark)
)

;; Find file
(global-set-key (kbd "C-x f") 'fiplr-find-file)
;;;;; Ignore files
(setq fiplr-ignored-globs
      '((directories
         ;; Version control
         (".git"
          "node_modules"
          "__pycache__"))
        (files
         ;; Emacs
         (".#*"
          "*~"
          "*.so"
          "*.o"
          "*.obj"
          "*.jpg"
          "*.png"
          "*.gif"
          "*.pdf"
          ;; Archives
          "*.gz"
          "*.zip"))))

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
 '(ansi-color-names-vector
   ["#ffffff" "#183691" "#969896" "#a71d5d" "#969896" "#969896" "#795da3" "#969896"])
 '(custom-safe-themes
   (quote
    ("96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "907bacbe973888e44b057b32439bd51795d38034dceb71876958ffccc808a010" "1a6753b8c816dcc7ebf7fb7d893343a381b4920e9f883a222d77d207009a4dd6" "759fd5856e85b6dca95615ffc0e214036d738639246a11dc224b7084d2a98117" "d606ac41cdd7054841941455c0151c54f8bff7e4e050255dbd4ae4d60ab640c1" "9e6ac467fa1e5eb09e2ac477f61c56b2e172815b4a6a43cf48def62f9d3e5bf9" default)))
 '(fci-rule-color "#969896")
 '(js-indent-level 2)
 '(linum-format " %7i ")
 '(nrepl-message-colors
   (quote
    ("#183691" "#969896" "#a71d5d" "#969896" "#0086b3" "#795da3" "#a71d5d" "#969896")))
 '(pdf-view-midnight-colors (quote ("#969896" . "#f8eec7")))
 '(vc-annotate-background "#b0cde7")
 '(vc-annotate-color-map
   (quote
    ((20 . "#969896")
     (40 . "#183691")
     (60 . "#969896")
     (80 . "#969896")
     (100 . "#969896")
     (120 . "#a71d5d")
     (140 . "#969896")
     (160 . "#969896")
     (180 . "#969896")
     (200 . "#969896")
     (220 . "#63a35c")
     (240 . "#0086b3")
     (260 . "#795da3")
     (280 . "#969896")
     (300 . "#0086b3")
     (320 . "#969896")
     (340 . "#a71d5d")
     (360 . "#969896"))))
 '(vc-annotate-very-old-color "#969896"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; For ruby env
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . html-mode))


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

;;;;; Clipboard Mac OS X
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))
(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

;;;;; Ubuntu clipboard
(setq *is-a-mac* (eq system-type 'darwin))
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(defun copy-to-x-clipboard-all-os (text &optional push)
  (interactive)
  (if (region-active-p)
      (progn
        (cond
         ((and (display-graphic-p) x-select-enable-clipboard)
          (x-set-selection 'CLIPBOARD (buffer-substring (region-beginning) (region-end))))
         (t (shell-command-on-region (region-beginning) (region-end)
                                     (cond
                                      (*cygwin* "putclip")
                                      (*is-a-mac* "pbcopy")
                                      (*linux* "xsel -ib")))
            ))
        (message "Yanked region to clipboard!")
        (deactivate-mark))
        (message "No region active; can't yank to clipboard!")))

(defun paste-from-x-clipboard-all-os()
  (interactive)
  (cond
   ((and (display-graphic-p) x-select-enable-clipboard)
    (insert (x-selection 'CLIPBOARD)))
   (t (shell-command
       (cond
        (*cygwin* "getclip")
        (*is-a-mac* "pbpaste")
        (t "xsel -ob"))
       1))
   ))

   ;;;;;;;;;;; Check if mac os and ubuntu
   (if (equal (shell-command-to-string "uname") "Darwin\n")
     (progn
       ;;;;; Clipboard Mac OS X
       (setq interprogram-cut-function 'paste-to-osx)
       (setq interprogram-paste-function 'copy-from-osx))
     (progn
       ;;;;; Clipboard UBUNTU
       (setq interprogram-cut-function 'copy-to-x-clipboard-all-os)
       (setq interprogram-paste-function 'paste-from-x-clipboard-all-os)))

;;;;;;;;;;;; MAC
(if (equal (shell-command-to-string "uname") "Darwin\n")
  (progn
    ;;;;; Clipboard Mac OS X
    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx))
  (progn
    ;;;;; Clipboard UBUNTU
    (setq interprogram-cut-function 'copy-from-ubuntu)
    (setq interprogram-paste-function 'paste-to-ubuntu)))


;;;;;; C-n to next buffer (equals C-<right>)
(global-set-key (kbd "C-x C-n") 'next-buffer)
(global-set-key (kbd "C-x C-m") 'previous-buffer) ;; Change b to m because i use tmux :/

;;;;;;;;;;;;;;;; CHANGE INDENT SIZE
 (setq css-indent-offset 2)

;;;; JSX
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

;; ---------------------------------------
;; load elscreen
;; ---------------------------------------
(load "elscreen" "ElScreen" t)

;; F9 creates a new elscreen, shift-F9 kills it
(global-set-key (kbd "C-x t n") 'elscreen-create)
(global-set-key (kbd "C-x t k") 'elscreen-kill)

;; Windowskey+PgUP/PgDown switches between elscreens
(global-set-key (kbd "C-M-_") 'elscreen-previous)
(global-set-key (kbd "C-M-+") 'elscreen-next)

