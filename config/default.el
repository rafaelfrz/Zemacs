(add-to-list 'default-frame-alist '(fullscreen))
(setq inhibit-start-message t)
(setq visible-bell nil)
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font Mono-12"))

(menu-bar-mode -1)        ;Disable menubar
(tool-bar-mode -1)        ;Disable toolbar
(tooltip-mode -1)         ;Disable tooltip
(scroll-bar-mode -1)      ;Disable toolbar
(visual-line-mode t)
(recentf-mode 1)
(electric-pair-mode t)
(setq nerd-icons-scale-factor 1.2)

(set-fringe-mode 8)
(setq-default tab-width 2)

(defun line-numbers ()
  (when (derived-mode-p '(prog-mode elisp-mode))
		(display-line-numbers-mode t)))

(add-hook 'after-change-major-mode-hook #'line-numbers)
