(setq frame-title-format "Huddy--->Good Good Study,Day Day Up!!!@%b")
;; 用 emacs 打开 .emacs 文件，C-x C-e 光标前面的运行一条语句。立即生效。
;; 选择一个 region , M-x eval-region
;; M-x load-file ~/.emacs
;; M-x eval-buffer
;; 都是立即生效，可以马上试验一条语句的效果。




;;binding key
;; 先用 C-h k 检查要绑定键是否空闲。
;; 观察 C-h k 的输出 ，例如我查看 Control + tab 的输出是
;; <C-tab> is undefined
;; (global-set-key (kbd "<C-tab>") ...)
;; 总结，C-h k 显示的东西，就可以拷贝出来，作为字符串，利用 kbd 搞定。



;; 首先进入 M-x Customize-Group Grep 分组中，
;; 名称	数值	说明
;; Grep Window Height	14	可以调整grep结果窗口的大小
;; Grep Command	grep -rinH -e ../*	设置grep的默认命令，使其默认从上一层目录开始递归搜索
;; Grep Find Command	find ../* -iname "*.cpp" -type f -print0 | xargs -0 -e grep -nH -e	从上一层目录开始递归搜索，所有cpp文件的内容，常用于搜索代码中被引用的变量或者函数
;; 高级命令用法
;; 命令	使用简介	特色说明
;; rgrep	M-x rgrep RET后，首先输入的是需要搜索的内容，回车后，提示目标文件的类型，此时可以输入各个别名，比如ch，搜索所有的C++源码文件，随后输入的是搜索开始的目录。	递归搜索目录中的内容，支持一些预定义的别名，比如ch表示所有的c++代码文件，hh表示所有的c++头文件等等。这个估计是写程序时，最好用的grep命令。
;; lgrep	M-x lgrep RET后，提示内容与rgrep的都一样，唯一不同的是，lgrep只搜索当前指定目录中的内容，不会对子目录进行递归搜索。	lgrep中的l应该是表示本层目录的（local）。对于在很大的，有很多子目录的文件夹中，只想搜索限定目录中，限定文件类型的时候，这个命令很方便。
;; igrep	M-x igrep后，会自动根据当前所在文件的扩展名作为文件过滤条件（也可以修改），随后，会弹出UI提示选择目录（貌似在win32上，没有什么作用），一路回车，就可以搜索了。	根据输入的文件扩展名，过滤被搜索的文件，根据输入的内容，在指定类型的文件中搜索，并给出结果。这个命令会弹出对话框，使用上，个人感觉非常的不爽。：（ 如果哪位对这个命令有很好的最佳实践，一定要告诉kyle哦。


;; If we would like to set some command in emacs,we could carry out M + x, customize-group, then input grep, so we can set all the command.