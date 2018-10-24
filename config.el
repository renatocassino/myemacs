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

