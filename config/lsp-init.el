(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((lsp-mode . lsp-enable-which-key-integration)
				 (typescript-ts-mode . lsp)
				 (tsx-ts-mode . lsp)
				 (js-ts-mode . lsp)
				 (js-mode . lsp))
  :commands lsp
  :config (setq lsp-headerline-breadcrumb-enable t
								lsp-enable-snippet t
								lsp-enable-symbol-highlighting t
								lsp-idle-delay 0.500))

(use-package minimap
	:init
	(setq minimap-width-fraction 0.10
				minimap-minimum-width 10
				minimap-window-location 'right
				minimap-hide-fringes t
				minimap-major-modes '(prog-mode elisp-mode))
	:hook
	(after-init . minimap-mode))
