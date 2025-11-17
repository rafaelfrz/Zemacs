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
