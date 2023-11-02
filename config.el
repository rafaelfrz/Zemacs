(setq inhibit-start-message t)
(setq visible-bell nil)
(set-face-attribute 'default t :font "Fira Code-10")
(set-frame-font "Fira Code-10" nil t)

(menu-bar-mode -1)        ;Disable menubar
(tool-bar-mode -1)        ;Disable toolbar
(tooltip-mode -1)         ;Disable tooltip
(scroll-bar-mode -1)      ;Disable toolbar
(set-fringe-mode 8)
(setq-default tab-width 4)

(global-display-line-numbers-mode nil)

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

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

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
  (setq doom-themes-treemacs-theme "doom-tokyo-night")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(unless (package-installed-p 'evil)
  (package-install 'evil))

(use-package all-the-icons
  :if (display-graphic-p)
  )

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package dashboard
    :ensure t
    :config
    (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-icon-type 'all-the-icons)
(setq dashboard-display-icons t)
;;(setq dashboard-set-heading-icons t)
;;(setq dashboard-set-file-icons t)

(use-package evil)
(evil-mode 1)

(use-package general
  :config
  (general-evil-setup))

(general-create-definer leader-key
  :states '(normal insert visual emacs)
  :prefix "SPC"
  :keymaps 'override
  :global-prefix "M-SPC"
  )

(general-define-key
  :keymaps 'override
  "<tab>" 'org-cycle
)

(leader-key
  "." '(find-file :wk "Find file")
  "/" '(comment-line :wk "Comment line")
  )

(leader-key
  "e" '(:ignore t :wk "Evaluate")
  "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
  "e r" '(eval-region :wk "Evaluate elisp in region"))

(leader-key
  "w" '(:ignore t :wk "Windows")
  "w k" '(evil-window-up   :wk "Top window")
  "w j" '(evil-window-down  :wk "Bottom window")
  "w h" '(evil-window-left  :wk "Left window")
  "w l" '(evil-window-right :wk "Right window"))
  "w n" '(:wk "New")
  "w n v" '(split-window-horizontally :wk "New horizontal window")
  "w n h" '(split-window-vertically   :wk "New vertical window")

(leader-key
  "d" '(:ignore t :wk "Delete")
  "d b" '(delete-buffer :wk "Delete buffer")
  "d w" '(:wk "Delete window")
  "d w k" '(delete-window :wk "Delete window")
  "d w K" '(kill-buffer-and-window :wk "Kill buffer and window"))

(leader-key
  "h" '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable"))

(leader-key
  "b" '(ibuffer :wk "Buffer"))

(setq org-src-preserve-identation t)

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(toc-org which-key all-the-icons evil doom-themes doom-modeline counsel ivy-rich ivy command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
