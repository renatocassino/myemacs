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