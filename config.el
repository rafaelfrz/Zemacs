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
  :global-prefix "M-SPC")

(general-define-key
 :keymaps 'override
 "<tab>" 'org-cycle)

(leader-key
  "."  '(find-file :wk "Find file")
  "/"  '(comment-line :wk "Comment line")
  "\\" '(indent-region :wk "Indent region")
  "s"  '(dashboard-open :wk "Opens dashboard"))

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
  "w n v" '(split-window-horizontally :wk "New horizontal window")
  "w n h" '(split-window-vertically   :wk "New vertical window"))

(leader-key
  "d"     '(:ignore t :wk "Delete")
  "d b"   '(kill-current-buffer :wk "Delete buffer")
  "d w"   '(:wk "Delete window")
  "d w q" '(delete-window :wk "Delete window")
  "d w Q" '(kill-buffer-and-window :wk "Kill buffer and window"))

(leader-key
  "h"   '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable"))

(leader-key
  "b"   '(:ignore t :wk "Buffer options")
  "b b" '(counsel-switch-buffer :wk "Change buffer")
  "b [" '(previous-buffer :wk "Go to previous buffer")
  "b ]" '(next-buffer :wk "Go to next buffer"))

(leader-key
  "t" '(treemacs :wk "Treemacs"))

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
          treemacs-indentation-string              " "
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
          treemacs-width                           30
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

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

(use-package treemacs-all-the-icons
  :after (treemacs-evil)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs)))

(setq org-agenda-files '("~/Documents/Agenda.org"))
(setq org-directory nil)
(setq org-agenda-include-diary t)

(setq org-src-preserve-identation t)

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
