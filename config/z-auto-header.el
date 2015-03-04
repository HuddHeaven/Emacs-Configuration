;; ;;======================            auto-header            =====================
;; (add-to-list 'load-path "~/.emacs.d/plugins/")
;; (require 'auto-header)

;; ;;加载auto-header.el文件,自动添加文件头
;; (require 'auto-header)

;; ;; 设置文件头中的姓名
;; (setq header-full-name "Huddy")

;; ;; 设置邮箱
;; (setq header-email-address "hyli@ingenic.cn")

;; ;; 设置每次保存时要更新的项目
;; (setq header-update-on-save
;;       '(  filename
;; 	  modified
;; 	  counter
;; 	  copyright))
;; ;; 设置文件头的显示格式
;; (setq header-field-list
;;       '(  filename  ;文件名
;; 	  ;;    blank     ;空行，下同
;; 	  ;;copyright ;;版权
;; 	  version
;; 	  author    ;作者
;; 	  created   ;创建人
;; 	  ;;blank
;; 	  description   ;描述
;; 	  ;;blank
;; 	  ;;modified_by ;更改者
;; 	  ;; blank
;; 	  ;;status  ;状态，是否发布
;; 	  ;;更新
;; 	  ;;blank
;; 	  ))