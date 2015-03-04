(add-to-list 'load-path "~/.emacs.d/cscope-15.8a")
(require 'xcscope)
(setq cscope-do-not-update-database t)
(define-key global-map [(control f3)]  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
(define-key global-map [(control f5)]  'cscope-find-this-symbol);;搜索所有，相当于grep,在f5生成的buf中一次向下查找
(define-key global-map [(control f6)]  'cscope-find-global-definition);;在f5生成的buf中一次向下查找
(define-key global-map [(control f7)]  'cscope-find-global-definition-no-prompting)
(define-key global-map [(control f8)]  'cscope-pop-mark)
(define-key global-map [(control f9)]  'cscope-next-symbol);;在f5生成的buf中一次向下查找
(define-key global-map [(control f10)] 'cscope-next-file);;在f5生成的buf中一次向下查找
(define-key global-map [(control f11)] 'cscope-prev-symbol)
(define-key global-map [(control f12)] 'cscope-prev-file)
(define-key global-map [(meta f9)]     'cscope-display-buffer);;显示cscope的buf
(define-key global-map [(meta f10)]    'cscope-display-buffer-toggle);;切换cscope的buf
;;      C-c s I         Create list and index.
;;      C-c s s         Find symbol.
;;      C-c s d         Find global definition.
;;      C-c s G         Find global definition without prompting.
;;      C-c s e         Find egrep pattern.

  ;; C-c s C-h 查看所有的 cscope 相关的按键
  ;;   C-c s a 设定索引文件所在目录
  ;;   C-c s c 查找调用该函数的地方
  ;;   C-c s g 查找该符号的全局定义
  ;;   C-c s f 查找该符号对应的文件
;;      C-c s s         Find symbol.
;;      C-c s g         Find global definition (alternate binding).
;;      C-c s G         Find global definition without prompting.
;;      C-c s c         Find functions calling a function.
;;      C-c s C         Find called functions (list functions called
;;                      from a function).
;;      C-c s t         Find text string.
;;      C-c s e         Find egrep pattern.
;;      C-c s f         Find a file.
;;      C-c s i         Find files #including a file.
;;
;; These pertain to navigation through the search results:
;;
;;      C-c s b         Display *cscope* buffer.
;;      C-c s B         Auto display *cscope* buffer toggle.
;;      C-c s n         Next symbol.
;;      C-c s N         Next file.
;;      C-c s p         Previous symbol.
;;      C-c s P         Previous file.
;;      C-c s u         Pop mark.
;;
;; These pertain to setting and unsetting the variable,
;; `cscope-initial-directory', (location searched for the cscope database
;;  directory):
;;
;;      C-c s a         Set initial directory.
;;      C-c s A         Unset initial directory.
;;
;; These pertain to cscope database maintenance:
;;
;;      C-c s L         Create list of files to index.
;;      C-c s I         Create list and index.
;;      C-c s E         Edit list of files to index.
;;      C-c s W         Locate this buffer's cscope directory
;;                      ("W" --> "where").
;;      C-c s S         Locate this buffer's cscope directory.
;;                      (alternate binding: "S" --> "show").
;;      C-c s T         Locate this buffer's cscope directory.
;;                      (alternate binding: "T" --> "tell").
;;      C-c s D         Dired this buffer's directory.

;;usage
;; 1.首先，在源码根目录下，如~/kernerl/linux-2.6.29.3,利用cscope-indexer脚本生成文件列表和数据库，方法是执行
;; cscope-indexer －r
;; -r参数表示递归检索子目录，文件列表和数据库的默认文件名分别为cscope.files和cscope.out，可以使用-i,-f参数进行修改，请参考man了解脚本参数用法。
 
;; 2.激动人心的时刻到了。用emacs打开init/main.c，C-s搜索sched_init函数，将光标停在函数名上，按C-c s d或者先前设置的Ctrl+F6,回车进行查找。结果居然用了35.32秒，汗！原来，Cscope默认在每次进行查找时更新cscope.out。当工程十分庞大时，建议关闭该选项以提高查找速度。方法是在~/.emacs文件中加入
;; (setq cscope-do-not-update-database t)
;; 重复上述操作，结果仍然用了9.89秒，再汗！莫非是我的古董本太慢？
 
;; 3.百度一下，你就知道:) Cscope可以通过创建反向索引加速查找，方法是调用Cscope时，使用-q参数。真的假的，一试便知。修改cscope-indexer脚本，将
;; cscope -b -i $LIST_FILE -f $DATABASE_FILE
;; 替换为
;; cscope -q -b -i $LIST_FILE -f $DATABASE_FILE
;; 进入内核根目录，删除先前的文件列表和数据库，重新调用cscope-indexer。这回多生成了两个文件，cscope.in.out和cscope.po.out。重试刚才的查找，结果只用了0.08秒，大功告成。
 

;; cscope是个很不错的代码查看工具，配合emacs很好用。但是今天遇到了一些问题。一般来说，我们都会在被查看的项目代码下面建立cscope的索引文件，这样就可以自动的找到。但是还有些公共库如果我们想用cscope的话，就需要额外的配置，比如我装了boost 到 /usr/yylocal/include/boost，这个时候我希望每次搜索时， cscope先按照默认规则搜索当前目录中的文件，如果找不到，再搜索 boost目录，那就需要按照如下配置， 加入到你的 init.el中：

;; (setq cscope-database-regexps
;;       '(   
;; 	;; (".*" (t) ("/usr/yylocal/include/yy-c++") ("/usr/local/include/boost"))
;; 	(".*" t ("/usr/yylocal/include/yy-c++") ("/usr/local/include/boost"))
;; 	)
;;       )

;; ".*" 是正则表达式， 表示对任何目录均匹配。
;; 后面跟着的 (t) 表明，优先使用默认搜索顺序， 即在当前被搜索符号所在的目录，父目录， 祖父目录 中依次搜索。
;; 在后面的两个路径表示 libc++ 和 boost的cscope库所在目录。这样在按照默认规则搜索完后，会再搜索这些目录。

;; 这样就达到了优先搜索当前目录，随后再搜索公用目录。

;; 你也可以通过查看 cscope-database-regexps 的帮助获得更多信息，如果你想在当前目录中找到结果后就停止搜索，将 (t) 替换为 t 即可