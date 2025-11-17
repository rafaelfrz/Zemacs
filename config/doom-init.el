(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  (setq doom-modeline-time t)
  (setq doom-modeline-icons t)
  (setq doom-modeline-lsp t)
  (setq doom-modeline-env-version t))

(use-package doom-themes
:ensure t
:config
(setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
(load-theme 'doom-tokyo-night t)
(doom-themes-treemacs-config)
(doom-themes-org-config))
