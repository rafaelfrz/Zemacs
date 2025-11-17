(use-package centaur-tabs
  :demand
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 50
        centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-icon-type 'nerd-icons
        centaur-tabs-set-bar 'over
        centaur-tabs-set-modified-marker t)
	(centaur-tabs-mode 1))

