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
  "t" '(:ignore t :wk "Treemacs")
  "t t" '(treemacs :wk "Open Treemacs")
  "t f" '(treemacs-find-file :wk "Find file in Treemacs"))

(leader-key
  "m" '(:ignore t :wk "Magit")
  "m s" '(magit-status :wk "Magit status"))

(leader-key
  "C-m" '(minimap-mode :wk "Opens minimap"))

(leader-key
  "z" '(darkroom-mode :wk "Distraction free editing"))

(leader-key
	"p" '(projectile-command-map :wk "Projectile"))
