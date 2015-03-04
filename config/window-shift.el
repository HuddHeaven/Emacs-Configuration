;;窗口设置
;窗口缩放   
;; (require 'windresize)      

;; (global-set-key (kbd "C-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "C-<right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "C-<down>") 'shrink-window)
;; (global-set-key (kbd "C-<up>") 'enlarge-window)
;;窗口标号导航 http://www.emacswiki.org/emacs/NumberedWindows
;(require 'window-number)
;(window-number-mode) ;;采用C-x C-j x x为数字进行导航
;(window-number-meta-mode) ;;采用M-x x为数字进行窗口导航
(require 'window-number) ;;功能稍微好用于NumberedWindows http://nschum.de/src/emacs/window-numbering-mode/
(window-number-mode 1) ;;采用M-x进行窗口导航切换 M-0切换到激活的minibuffer
 (window-number-meta-mode)
;;usage
;; M+1/2/3 turn to the window corr

