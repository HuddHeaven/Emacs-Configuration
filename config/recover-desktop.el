(require 'session)
(add-hook 'after-init-hook
		   'session-initialize)

(load "desktop")
(setq desktop-load-locked-desktop t)
(desktop-save-mode 1)
;remove from here

;(add-hook 'after-init-hook 'session-initialize)
;(require  'wcy-desktop)
;(wcy-desktop-init)

;; 可以用 M-x desktop-save 来手动保存
;; 每当 Emacs 启动的时候，它在当前目录查找一个已经保存的桌面，所以你可以在不同的目录保存不同的桌面，启动的时候的``当前目录''就是 Emacs 加载桌面文件的目录。也可以用 M-x desktop-change-dir 保存当前桌面，然后加载另外一个目录下的桌面文件。 M-x desktop-revert 可以推回到先前加载的那个桌面。

;; 可以在 Emacs 启动的时候使用 --no-desktop 选项禁止加载桌面。

;; 默认情况下，所有的 buffers 都被一次加载起来。当有很多文件要加载的时候可能会非常慢，不过你可以指定 desktop-restore-eager 变量来规定立即加载的文件的最大数目，而剩下的文件会在 Emacs 空闲的时候慢慢加载。

;; 如果你觉得当前桌面里面的东西太多了，可以用 M-x desktop-clear 来把桌面清空一下。如果你想保留某些 buffer ，可以设定你 desktop-clear-preserve-buffers-regexp 变量来控制保留哪些 buffer ，这是一个正则表达式，如果 buffer 的名字匹配了这个正则表达式，那么他将会被保留下来。不过一个更好的办法是使用 ibuffer 来把不想要的 buffer 关掉再保存桌面。
