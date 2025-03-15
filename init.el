;; (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
;; (package-initialize)
(org-babel-load-file "~/.config/emacs/config.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/.config/emacs/config.org"))
 '(package-selected-packages
   '(all-the-icons centered-cursor-mode command-log-mode company
				   company-box company-mode counsel darkroom
				   doom-modeline doom-themes evil flycheck ivy
				   ivy-rich js-mode lsp-pyright lua-mode
				   page-break-lines sublimity sublimity-attractive
				   sublimity-map sublimity-scroll toc-org tree-sitter
				   tree-sitter-langs use-package which-key zen-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
