;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ecb
;;注意这个段要加在cedet配置的后面
(add-to-list 'load-path "~/.emacs.d/ecb-2.40")
(require 'ecb)
;;;; 自动启动ecb，并且不显示每日提示
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil)
;(setq ecb-auto-activate t)

(ecb-activate)
(ecb-hide-ecb-windows)

(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down) 

(define-key global-map [f5] 'ecb-show-ecb-windows)
(define-key global-map [f6] 'ecb-hide-ecb-windows)

;;;; 使某一ecb窗口最大化 use C-x 1
;; (define-key global-map "/C-c1" 'ecb-maximize-window-directories)
;; (define-key global-map "/C-c2" 'ecb-maximize-window-sources)
;; (define-key global-map "/C-c3" 'ecb-maximize-window-methods)
;; (define-key global-map "/C-c4" 'ecb-maximize-window-history)
;; ;;;; 恢复原始窗口布局
;; (define-key global-map "/C-c`" 'ecb-restore-default-window-sizes)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ecb layout
(ecb-layout-define "hyli-ecb-layout" right nil  
                   (ecb-set-directories-buffer)
                   (ecb-split-ver 0.3 t)  
                   (other-window 1)  
                   (ecb-set-sources-buffer)  
                   (ecb-split-ver 0.3 t)  
                   (other-window 1)  
                   (ecb-set-methods-buffer))  
  
(setq ecb-layout-name "hyli-ecb-layout")  
  

;; ECB代表的是“Emacs Code Browser”，顾名思义，用以浏览代码。ECB提供了四个窗口：
;; ²         Directories窗口：显示目录结构；
;; ²         Sources窗口：显示当前目录下的文件列表；
;; ²         Methods窗口：显示当前文件中的函数/类/成员列表；
;; ²         History窗口：显示最近访问过的文件。