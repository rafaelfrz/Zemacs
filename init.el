(setq inhibit-start-message t)
(setq visible-bell nil)
(set-face-attribute 'default t :font "Fira Code-10")
(set-frame-font "Fira Code-10" nil t)

(menu-bar-mode -1)        ;Disable menubar
(tool-bar-mode -1)        ;Disable toolbar
(tooltip-mode -1)         ;Disable tooltip
(scroll-bar-mode -1)      ;Disable toolbar
(set-fringe-mode 8)

(global-display-line-numbers-mode 1)

(load-theme 'wombat t)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t    
        doom-themes-enable-italic t) 
  (load-theme 'doom-one t)

  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-atom")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(unless (package-installed-p 'evil)
  (package-install 'evil))

(use-package evil)
(evil-mode 1)

(use-package all-the-icons)
