;; gtags -vi
;; gtags -u(recommonded)global -u这个命令会自动向上找到project/GTAGS，并更新其内容。而gtags相对于cscope的优势就在这里：增量更新单个文件的速度极快，几乎是瞬间完成。

	;gtag confgi begin
(add-to-list 'load-path "~/.emacs.d/global-6.2.12")
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'gtags-mode-hook
  '(lambda ()
	(define-key gtags-mode-map "\C-o" 'scroll-up)
	(define-key gtags-mode-map "\C-p" 'scroll-down)
))
(add-hook 'gtags-select-mode-hook
  '(lambda ()
	(setq hl-line-face 'underline)
	(hl-line-mode 1)
))
	(add-hook 'c-mode-hook
	  '(lambda ()
		(gtags-mode 1)))
	(add-hook 'c++-mode-hook 
		  '(lambda () 
			 (gtags-mode 1))) 

	(add-hook 'asm-mode-hook 
		  '(lambda () 
			 (gtags-mode 1))) 


(setq gtags-suggested-key-mapping t)
;; (setq gtags-auto-update t)

	;gtag config end

;; (add-to-list 'load-path "~/.emacs.d/global-6.2.12")
;; (autoload 'gtags-mode "gtags" "" t)

;; (add-hook 'c-mode-hook 
;; 	  '(lambda () 
;; 	     (gtags-mode 1)
;; )) 

;; (add-hook 'c++-mode-hook 
;; 	  '(lambda () 
;; 	     (gtags-mode 1)
;; )) 

;; (add-hook 'asm-mode-hook 
;; 	  '(lambda () 
;; 	     (gtags-mode 1)
;; )) 



;; (defun yp-gtags-append () 
;;   (interactive) 
;;   (if gtags-mode 
;;       (progn 
;; 	(message "start to global -u") 
;; 	(start-process "gtags-name" "*gtags-var*" "global" "-u"))))

;; (gtags-mode 1) ;; 好像不在.emacs中使能gtags-mode下面的函数就找不到。 
;; (define-prefix-command 'yp-gtags-map) ;; 和下一句话合起来定义一个自己的快捷键头（C-xg）。 
;; (global-set-key "\C-xg" 'yp-gtags-map) 
;; (define-key gtags-mode-map "\C-xgv" 'gtags-visit-rootdir)  ;; 选择搜索的根目录。 
;; (define-key gtags-mode-map "\C-xgt" 'gtags-find-tag)  ;; 找函数定义 
;; (define-key gtags-mode-map "\C-xgo" 'gtags-find-tag-other-window)  ;; 打开一个新窗口找函数定义 
;; (define-key gtags-mode-map "\C-xgr" 'gtags-find-rtag)  ;; 找函数的调用 
;; (define-key gtags-mode-map "\C-xgs" 'gtags-find-symbol)  ;; 搜索符号，也就是变量的定义和调用 
;; (define-key gtags-mode-map "\C-xgp" 'gtags-find-pattern)  ;; 似乎和下面两个一样，都是在项目中进行字符串搜索，不知道有啥区别，不会使。 
;; (define-key gtags-mode-map "\C-xgg" 'gtags-find-with-grep) 
;; (define-key gtags-mode-map "\C-xgi" 'gtags-find-with-idutils) 
;; (define-key gtags-mode-map "\C-xgf" 'gtags-find-file)  ;; 在项目中搜索文件。 
;; (define-key gtags-mode-map "\C-xga" 'gtags-parse-file)  ;; 分析指定文件（基本就是找到所有能找到的定义），列在emacs中。 
;; (define-key gtags-mode-map "\C-xgb" 'yp-gtags-append)  ;; 更新项目的tag文件，该函数在后面定义。 
;; (global-set-key (kbd "C-x v") 'gtags-find-symbol) 
;;(global-set-key (kbd "C-x f") 'gtags-find-rtag)
;; (global-set-key (kbd "C-x f") 'gtags-select-tag-other-window)
;; (global-set-key (kbd "<f1>") 'gtags-select-tag-other-window)

;; (global-set-key [f1] 'gtags-select-tag-other-window) 




;; (if (eq system-type 'darwin)
;;     (add-to-list 'load-path "/home_backup/hyli/.emacs.d/global-6.2.12/out/share/gtags")
;;   )

;; (require 'gtags)

;; (add-hook 'c-mode-common-hook 'gtags-mode)
;; (add-hook 'c++-mode-common-hook 'gtags-mode)
;; (add-hook 'java-mode-common-hook 'gtags-mode)
;; (add-hook 'gtags-select-mode-hook
;; 	  '(lambda ()
;; 	     (setq hl-line-face 'underline)
;; 	     (hl-line-mode 1)))

;; (defvar gtags-src-dir nil)
;; (defvar gtags-saved-tagfile-dir nil)
;; (defvar gtags-language-suffix nil)

;; (setq gtags-suggested-key-mapping t)

;; (defun gtags-update ()
;;   "Make GTAGS incremental update"
;;   (if
;;       (null gtags-src-dir)
;;       (message "no tags updated for gtags")
;;     (with-temp-buffer
;;       (shell-command
;;        (concat "cd " gtags-src-dir ";" "global " "-u")
;;        (buffer-name))
;;       )
;;     )
;;   )

;; (defun gtags-update-hook ()
;;   (gtags-update)
;;   )

;; (add-hook 'after-save-hook 'gtags-update-hook)

;; 					;gtags生成函数
;; (defun generate-gtags ()
;;   "Generate gtag tables."
;;   (interactive)
;;   (let
;;       (
;;        (language-suffix "")
;;        (src-dir "")
;;        (saved-tag-dir "")
;;        )

;;     (setq src-dir
;;           (read-from-minibuffer "source directory for gtags:")
;;           language-suffix
;;           (read-from-minibuffer "suffix:")

;;           saved-tag-dir
;;           (read-from-minibuffer "gtags saved path:")
;; 	  )
;; 					;设置全局变量保存起来
;;     (setf gtags-src-dir src-dir)
;;     (setf gtags-language-suffix language-suffix)
;;     (setf gtags-saved-tagfile-dir saved-tag-dir)


;;     (with-temp-buffer
;;       (shell-command
;;        (concat "mkdir -p" " " gtags-saved-tagfile-dir " " "2>/dev/null;" "cd " gtags-src-dir ";" "find" " " gtags-src-dir " -name \"" gtags-language-suffix "\" | gtags" " " gtags-saved-tagfile-dir)
;;        (buffer-name)))))

;; 					;加载gtags
;; (defalias 'load-gtags 'gtags-visit-rootdir)


;; 					;光return键在vim模式下不起作用，所以绑定的键是alt+回车
;; (define-key gtags-select-mode-map [(meta return)] 'gtags-select-tag)
;; (define-key gtags-select-mode-map [mouse-1] 'gtags-select-tag)

;; 					;查找变量引用：gtags-find-symbol
;; 					;查找函数引用：gtags-find-rtag
;; (global-set-key (kbd "C-x v") 'gtags-find-symbol) 
;; ;;(global-set-key (kbd "C-x f") 'gtags-find-rtag)
;; (global-set-key (kbd "C-x f") 'gtags-select-tag-other-window)

 

;; GNU global
;; (setq gtags-suggested-key-mapping t)
;; (require 'gtags)
;; (add-hook 'c-mode-common-hook 'gtags-mode)
;; (add-hook 'c++-mode-common-hook 'gtags-mode)
;; (add-hook 'java-mode-common-hook 'gtags-mode)
;; (add-hook 'gtags-select-mode-hook
;; 	  '(lambda ()
;; 	     (setq hl-line-face 'underline)
;; 	     (hl-line-mode 1)))

;; (define-key gtags-select-mode-map "RET" 'gtags-select-tag)

;; (defun gtags-root-dir ()
;;   "Returns GTAGS root directory or nil if doesn't exist."
;;   (with-temp-buffer
;;     (if (zerop (call-process "global" nil t nil "-pr"))
;;         (buffer-substring (point-min) (1- (point-max)))
;;       nil)))
;; (defun gtags-update ()
;;   "Make GTAGS incremental update"
;;   (call-process "global" nil nil nil "-u"))
;; (defun gtags-update-hook ()
;;   (when (gtags-root-dir)
;;     (gtags-update)))
;; 					;(add-hook 'after-save-hook #'gtags-update-hook)
