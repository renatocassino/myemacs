(tool-bar-mode -1)
(scroll-bar-mode -1)

;;; NEOTREE
(add-to-list 'load-path "./plugins/neotree")
(require 'neotree)
(global-set-key (kbd "C-x q") 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow)) ;; Icons

(global-linum-mode t) ; Show lines
(setq linum-format "%4d \u2502 ") ; Format line number

;; Find file with Fuzzy algorithm
(global-set-key (kbd "C-x f") 'fiplr-find-file)

;; Cursor
(setq-default cursor-type 'bar)

;;;;; Ignore files
(setq fiplr-ignored-globs
      '((directories
         ;; Version control
         (".git"
          "node_modules"))
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
          "*.gz"
          "*.zip"))))

;; Cask - package manager
(if (equal (shell-command-to-string "uname") "Darwin\n")
  (require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
  (require 'cask "~/.cask/cask.el")
)
(cask-initialize)
(require 'pallet) ;; Package manager
(pallet-mode t)

;; THEME
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

;; Flycheck
(require 'web-mode)
(require 'flycheck)

(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

;;;; Indent
(setq js-indent-level 2)
(setq js2-basic-offset 2)
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq-default indent-tabs-mode nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-js-indent-offset 8)
  (setq web-mode-script-padding 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-css-colorization t)

  (define-key prelude-mode-map (kbd "C-c C-i") nil)
  (bind-key "C-c C-i" 'web-mode-buffer-indent))

(add-hook 'web-mode-hook  'my-web-mode-hook)

(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
