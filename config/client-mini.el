;; emacsclient filename usage
(server-start)

;; 这个方法首先要有一个启动好了的 Emacs ，并且要已经启动了 server 模式， 你可以用 M-x server-start 来启动 server 模式，或者在自己的 ~/.emacs 里 面加入 (server-start) 来自动启动 server 。

;; 然后，你就可以通过 emacsclient filename 来快速使用 Emacs 打开文件了！ 事实上，文件是在作为 server 的那个 Emacs 里面打开的，而 emacsclient 将 等待 server 编辑文件。这个时候你可以转到 server 那里去编辑文件，编辑好 之后用 C-x # 来关闭文件并通知 emacsclient 文件已经编辑完成。现在，你就 可以把自己的 EDITOR 变量设置成 emacsclient 而不用怕启动速度慢了：

;; EDITOR="emacsclient +%d %s"
;; 不过如果没有事先启动了一个 emacs server 的话，这个命令就会失败，他提供 的一个解决办法就是 --alternate-editor 参数，表示连接失败的时候调用的命 令，你可以把他设置成 vi 或者是其他小巧的编辑器，或者，你也可以在这儿直 接设置成 emacs ，不过这也许并不如想象中的那么美妙，也许你认为如果没有 启动 emacs ，那么在这儿就启动它，然后后面就可以顺利地调用 emacsclient 了！但是如果这儿是其他程序比如 mutt 或者 svn 之类的使用 EDITOR 环境变 量来调用的编辑器，他会等待编辑器退出来表示编辑完成，这个时候看着刚刚启 动的 emacs 马上又要关闭了，实在是不忍心呀！:) 1 不过这个也有个不爽的 地方就是打开文件都是在 server 里面打开的，还不能自动跳转到 server 那里 去，比较麻烦。