(add-to-list 'default-frame-alist '(fullscreen))
(setq inhibit-start-message t)
(setq visible-bell nil)
(setq has-battery
      (let ((battery-dir "~/sys/class/power_supply/BAT0/"))
        (when (file-exists-p battery-dir)
          (not (null (directory-files battery-dir nill ""))))))
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font Mono-12"))

(menu-bar-mode -1)        ;Disable menubar
(tool-bar-mode -1)        ;Disable toolbar
(tooltip-mode -1)         ;Disable tooltip
(scroll-bar-mode -1)      ;Disable toolbar
(visual-line-mode t)
(recentf-mode 1)
(when has-battery
  (display-battery-mode t))
(electric-pair-mode t)
(setq nerd-icons-scale-factor 1.2)

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
(unless (package-installed-p 'evil)
  (package-install 'evil))

(use-package all-the-icons
  :if (display-graphic-p)
  :ensure t)

;; Nerd Icons
(use-package nerd-icons
  :custom (nerd-icons-font-family "JetBrainsMono Nerd Font Mono"))

(use-package page-break-lines
  :ensure t
  :config (page-break-lines-mode))

;; Which-key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Dashboard
(use-package dashboard
  :after all-the-icons
  :init
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-navigation-cycle t)
  (setq dashboard-display-icons-p t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 5)
						  (agenda . 5)))
  (setq dashboard-startupify-list '(dashboard-insert-banner
                                    dashboard-insert-newline
                                    dashboard-insert-banner-title
                                    dashboard-insert-newline
                                    dashboard-insert-navigator
                                    dashboard-insert-newline
                                    dashboard-insert-init-info
                                    dashboard-insert-items
                                    dashboard-insert-newline
                                    dashboard-insert-footer))
	(setq dashboard-item-shortcuts '((recents   . "r")
									(bookmarks . "m")
									(projects  . "p")
									(agenda    . "a")
									(registers . "e")))
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-navigator-buttons
        `((
          (,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
            "Homepage"
            "Browse homepage"
            (lambda (&rest _) (browse-url "https://github.com")))
          (,(all-the-icons-faicon "code" :height 1.1 :v-adjust 0.0)
            "LeetCode"
            "Go to LeetCode"
            (lambda (&rest _) (browse-url "https://leetcode.com")))))
  )
)

;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  (when has-battery
    (setq doom-modeline-battery t))
  (setq doom-modeline-time t)
  (setq doom-modeline-icons t)
  (setq doom-modeline-lsp t)
  (setq doom-modeline-env-version t))

;; Doom Themes
(use-package doom-themes
:ensure t
:config
(setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
(load-theme 'doom-tokyo-night t)

;; (setq doom-themes-treemacs-theme "doom-tokyo-night")
(doom-themes-treemacs-config)
(doom-themes-org-config))

;; Magit - have to configure it later
(use-package magit)

;; Evil - seems fine by now, need to explore more
(use-package evil
  :init (evil-mode 1))

(use-package ivy
:diminish
:bind (("C-s" . swiper)
        :map ivy-minibuffer-map
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

(use-package general
  :config
  (general-evil-setup))

(setq general-override-auto-enable t)

(general-define-key
 :states 'motion
	 "<tab>" 'evil-search-foward)

(general-create-definer leader-key
  :states '(normal insert visual emacs)
  :prefix "SPC"
  :keymaps 'override
  :global-prefix "M-SPC")

(add-hook 'org-mode-hook
  (lambda()
    (general-define-key
     :keymaps 'org-mode-map
     "<tab>" 'org-cycle)))

(leader-key
  "."  '(counsel-find-file :wk "Find file")
  "/"  '(comment-line :wk "Comment line")
  "\\" '(indent-region :wk "Indent region")
  "s"  '(dashboard-refresh-buffer :wk "Opens dashboard"))

(leader-key
  "r"   '(:ignore t :wk "Restart Emacs")
  "r r" '(restart-emacs :wk "Restart Emacs"))

(leader-key
  "e"   '(:ignore t :wk "Evaluate")
  "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
  "e r" '(eval-region :wk "Evaluate elisp in region"))

(leader-key
  "a"   '(:ignore t :wk "Agenda")
  "a a" '(org-agenda :wk "Opens agenda")
  "a A" '(org-agenda-list :wk "Opens agenda list")
  "a t" '(org-todo-list :wk "Opens todo list"))

(leader-key
  "w"     '(:ignore t :wk "Windows")
  "w k"   '(evil-window-up   :wk "Top window")
  "w j"   '(evil-window-down  :wk "Bottom window")
  "w h"   '(evil-window-left  :wk "Left window")
  "w l"   '(evil-window-right :wk "Right window")
  "w n"   '(:wk "New")
  "w n h" '(split-window-horizontally :wk "New horizontal window")
  "w n v" '(split-window-vertically   :wk "New vertical window"))

(leader-key
  "d"     '(:ignore t :wk "Kill")
  "d b"   '(:wk "Kill buffer options")
  "d b b" '(kill-buffer :wk "Kill buffer from list")
  "d b B" '(kill-current-buffer :wk "Kill current buffer")
  "d w"   '(:wk "Kill window")
  "d w q" '(delete-window :wk "Kill window")
  "d w Q" '(kill-buffer-and-window :wk "Kill buffer and window"))

(leader-key
  "h"   '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable"))

(leader-key
  "b"   '(:ignore t :wk "Buffer options")
  "b b" '(counsel-switch-buffer :wk "Change buffer")
  "b h" '(previous-buffer :wk "Go to previous buffer")
  "b l" '(next-buffer :wk "Go to next buffer"))

(leader-key
  "o" '(:ignore t :wk "Org options")
  "o t" '(:wk "Todo options")
  "o t t" '(org-todo :wk "Cycle todo states")
  "o e" '(org-edit-special :wk "Opens a window with the Babel source block"))

(leader-key
  "C-t" '(treemacs :wk "Open Treemacs"))
  "t" '(:ignore t :wk "Treemacs")

(leader-key
  "m" '(:ignore t :wk "Magit")
  "m s" '(magit-status :wk "Magit status"))

(leader-key
  "C-m" '(minimap-mode :wk "Opens minimap"))

(leader-key
  "z" '(darkroom-mode :wk "Distraction free editing"))

;; Treemacs
;; The mesier part of all this config, need to study and configure it better
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              "|"
          treemacs-indent-guide-style              'line
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           50
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    (treemacs-resize-icons 11)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  (treemacs-indent-guide-mode t))

;;   :bind
;;   (:map global-map
;;         ("M-0"       . treemacs-select-window)
;;         ("C-x t 1"   . treemacs-delete-other-windows)
;;         ("C-x t t"   . treemacs)
;;         ("C-x t d"   . treemacs-select-directory)
;;         ("C-x t B"   . treemacs-bookmark)
;;         ("C-x t C-t" . treemacs-find-file)
;;         ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (emacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

;; (use-package treemacs-icons-dired
;;   :hook (dired-mode . treemacs-icons-dired-enable-once)
;;   :ensure t)

;;(use-package treemacs-all-the-icons
;;  :after (treemacs-evil)
;;  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

(projectile-mode t)

(use-package centered-cursor-mode
  :demand
  :config
  ;; Optional, enables centered-cursor-mode in all buffers.
  (global-centered-cursor-mode))

(use-package darkroom)

(setq org-agenda-files '("~/Documents/org/"))
;; (setq org-directory "~/Documents/org/")
(setq org-agenda-include-diary t)
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "ON HOLD" "|" "DONE")))

(setq org-src-preserve-identation t)
(setq org-return-follows-link t)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package lsp-mode
  :hook 
  ((js-mode . lsp)
   (lua-ts-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :init
  (setq lsp-headerline-breadcrumb-segments
		'(path-up-to-project file symbols))
  :commands lsp)

(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-ts-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package tree-sitter
  :ensure t
  :hook (prog-mode . tree-sitter-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

;;(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package company
  :hook
  (prog-mode . company-mode)
  (js-mode . company-mode)
  (lua-ts-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package minimap
  :init
  (setq minimap-width-fraction 0.10
		minimap-minimum-width 10
		minimap-window-location 'right
		minimap-hide-fringes t
		minimap-major-modes '(prog-mode))
  :hook
  (after-init . minimap-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
