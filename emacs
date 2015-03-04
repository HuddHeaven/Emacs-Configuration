;; .emacs

;;cedet config
(add-to-list 'load-path "~/.emacs.d/cedet/common")
(require 'cedet)
(require 'semantic-ia)

;;config speedbar
;; (add-to-list 'load-path "/usr/share/emacs/21.3/speedbar")
;; (autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
;; (autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
;; (global-set-key [(f4)] 'speedbar-get-focus)
  
(add-to-list 'load-path "~/.emacs.d")
(require 'sr-speedbar)  
;; (setq speedbar-show-unknown-files t)
;; (setq speedbar-use-images nil)
(setq sr-speedbar-width 30)
(setq sr-speedbar-right-side nil)  
;; (global-set-key (kbd "<f4>") (lambda()
;;                                 (interactive)
;;                                 (sr-speedbar-toggle)))
(global-set-key (kbd "<f4>") 'sr-speedbar-toggle)
 
;; Enable EDE (Project Management) features
(global-ede-mode 1)
;;(global-ede-mode t)
 
;;(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-guady-code-helpers)

(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

;;code complete
;;(semantic-ia-complete-symbol-menu)
;;(define-key c-mode-base-map (kbd "M-n") 'semantic-ia-complete-symbol-menu)
;; 能看出modeline上文件名前的横线多了一条，其实倒数第二条就是用来显示当前semantic解析状态的：未解析时显示为”!”，正在解析时显示”@”，解析完后显示”-”，如果buffer修改后未重新解析显示为”^”。
;; semantic会在空闲时自动解析，另外可以打开senator-minor-mode，按[C-c , ,]或者在senator菜单中选[Force Tag Refresh]强制它马上解析。
;;(semantic-idle-completions-mode)
(global-semantic-idle-completions-mode 1) 

;;bookmark
;; F2 在当前行设置或取消书签
;; C-F2 查找下一个书签
;; S-F2 查找上一个书签
;; C-S-F2 清空当前文件的所有书签
(enable-visual-studio-bookmarks)

;;code folding
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
(define-key semantic-tag-folding-mode-map (kbd "C-_") 'semantic-tag-folding-fold-all)
(define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-all)

;;Enable SRecode (Template management) minor-mode.
(global-srecode-minor-mode 1)
;;find include
;; (setq semanticdb-project-roots (list (expand-file-name "/")))
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public"
        "../.." "../../include" "../../inc" "../../common" "../../public"))
(defconst cedet-win32-include-dirs
  (list "C:/MinGW/include"
        "C:/MinGW/include/c++/3.4.5"
	"/home_backup/hyli/android-project/bootable/bootloader/xboot/include"
	"/home_backup/hyli/android-project/kernel/include"
	"/home_backup/hyli/android-project/kernel/arch/mips/xburst/soc-4780/include/mach"
        "C:/Program Files/Microsoft Visual Studio/VC98/MFC/Include"))
(require 'semantic-c nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (when (eq system-type 'windows-nt)
    (setq include-dirs (append include-dirs cedet-win32-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

;;code jump
(global-set-key [f12] 'semantic-ia-fast-jump)
;return
(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;; cedet还有个功能在函数和声明和实现间跳转，一般的，函数声明放在h文件中，函数的实现放在cpp文件中，光标在函数体的时候通过M-x semantic-analyze-proto-impl-toggle可以跳到函数声明去，在声明处再执行的话就会再跳回函数体，我把它绑定到M-S-F12上了：
;(define-key c-mode-base-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)
;;cedet config end

(setq ansi-color-for-comint-mode t)
(customize-group 'ansi-colors)
(kill-this-buffer)              
;;set show line number
(global-linum-mode t)
;; Don't display menu bar. Type M-x menu-bar-mode to display it
(menu-bar-mode '-1)
;; Don't display tool bar. Type M-x tool-bar-mode to display it
(if (not (equal (getenv "HOSTTYPE") "sparc"))
    (tool-bar-mode '-1))

;(load "gnuserv")
;(require 'gnuserv)
;(gnuserv-start)
;(setq gnuserv-frame (selected-frame))

;;打开ido支持.在用C-x C-f打开文件时缓冲区会出现提示
(ido-mode t)
;; 以 y/n代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p) 
;; 实现全屏效果，快捷键为f11
(global-set-key [f11] 'my-fullscreen) 
(defun my-fullscreen ()
(interactive)
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_FULLSCREEN" 0)) 
)
;; ;; 最大化
(global-set-key [f10] 'my-maximized) 
(defun my-maximized ()
(interactive)
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)) 
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0)) 
)
(my-maximized)
;;

(defun linux-c-mode ()
	"C mode with adjusted defaults for use with the Linux kernel."
	(interactive)
	(c-mode)
	(c-set-style "K&R")
	(setq tab-width 8)
	(setq indent-tabs-mode t)
	(setq c-basic-offset 8)
)

(defun	my-c-mode ()
	"C mode with adjusted defaults for use with the C sources."
	(interactive)
	(c-mode)
	(c-set-style "K&R")
	(setq tab-width 8)
	(setq indent-tabs-mode t)
	(setq c-basic-offset 8)
)

(defun	my-c++-mode ()
	"C++ mode with adjusted defaults for use with the C++ sources."
	(interactive)
	(c++-mode)
	(c-set-style "K&R")
	(setq tab-width 4)
	(setq indent-tabs-mode t)
	(setq c-basic-offset 4)
)

(defun	my-asm-mode ()
	"ASM mode with adjusted defaults for use with the asm sources."
	(interactive)
	(asm-mode)
	(setq tab-width 8)
	(setq indent-tabs-mode t)
	(setq c-basic-offset 8)
)

(setq auto-mode-alist (cons '(".*\\.\\(inl$\\|cxx$\\|hxx$\\|cpp$\\|hpp$\\)" .
			my-c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*\\.\\(inc$\\|[Ss]$\\)" .
			my-asm-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*\\.\\(inl$\\|c$\\|h$\\)" .
			my-c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*/*linux.*/+.*\\.[ch]$" .
			linux-c-mode) auto-mode-alist))

(setq witch-function-mode t)
(which-func-mode)

;; This maps edit keys to standard Windows keystokes. It requires the
;; library cua-mode.el from Kim Storm at the following URL:
(load "~/.emacs.d/cua-mode.el")
(CUA-mode t)

;; Set foreground and background. black or dimgrey may be choosed
(set-foreground-color "white")
(set-background-color "gray11")
;set-background-color "CornflowerBlue")
;(set-background-color "DarkSlateBlue")
;(set-background-color "MidnightBlue")
;(set-background-color "Black")

;; Set the mouse and cursor color
(set-mouse-color "yellow")
(set-cursor-color "red")

(setq Man-overstrike-face 'info-node)
(setq Man-underline-face 'info-xref)

(shell)
(rename-buffer "aaaa-shell")
(shell)
(rename-buffer "bbbb-shell")
(shell)
(rename-buffer "cccc-shell")
(shell)
(rename-buffer "dddd-shell")
(shell)
(rename-buffer "eeee-shell")
(shell)
(rename-buffer "ffff-shell")
(shell)
(rename-buffer "make-shell")
(shell)
(rename-buffer "work-shell")

(show-paren-mode)
(global-auto-revert-mode)

;;; uncomment this line to disable loading of "default.el" at startup
;;(setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

(add-hook 'comint-output-filter-functions
	'comint-watch-for-password-prompt)

(setq display-time-24hr-format t)
(setq display-time-day-and-date nil)
(display-time)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setq column-number-mode t)
;;(setq line-number-mode t)

;;yk--quick start
(setq inhibit-startup-message t)

;;high line
;(require 'hl-line)
;(global-hl-line-mode t)

;;tab
;(require 'tabbar)
;(tabbar-mode)
;(global-set-key (kbd "M-[") 'tabbar-backward-group)
;(global-set-key (kbd "M-]") 'tabbar-forward-group)
;(global-set-key (kbd "M-p") 'tabbar-backward-tab)
;(global-set-key (kbd "M-n") 'tabbar-forward-tab)

(column-number-mode t)

(setq make-backup-files nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(browse-url-netscape-program "mozilla")
 '(case-fold-search t)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(display-time-mode t)
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(emacs-wiki-charset-default "gb2312")
 '(emacs-wiki-coding-default (quote gb2312))
 '(global-font-lock-mode t nil (font-lock))
 '(grep-command "grep * -rn  ")
 '(grep-find-template "find . <X> -type f <F> -print0 | \"xargs\" -0 -e grep <C> -rnH -e <R>")
 '(next-line-add-newlines nil)
 '(scroll-bar-mode (quote right))
 '(semantic-c-dependency-system-include-path (quote ("/usr/include" "~/work/kernel/kernel-1/include" "~/work/kernel/kernel-1/arch/mips/include" "~/work/kernel/kernel-1/arch/mips/xburst/soc-4780/include")))
 '(session-use-package t nil (session))
 '(show-paren-mode t nil (paren)))

(setq ps-font-size 8)
(defun my-ps-print-buffer()
	(interactive)
	(message "  print ... ")
	(setq filename "~/tmp/1.ps")
	(ps-print-buffer-with-faces filename))

(global-set-key "\M-\C-p" 'my-ps-print-buffer)
(global-set-key "\C-g" 'goto-line)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray11" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 156 :width normal :foundry "unknown" :family "DejaVu Sans")))))

(customize-set-variable 'scroll-bar-mode 'right)

(setq inhibit-startup-message t)

(setq gnus-inhibit-startup-message t)

(setq scroll-margin 3 scroll-conservatively 10000)

(defun open-eshell-other-buffer ()
"Open eshell in other buffer"
(interactive)
(split-window-vertically)
(eshell))
(defun kill-shell ()
"Kill shell"
(interactive)
(kill-buffer-and-window))
(global-set-key [(f8)] 'open-eshell-other-buffer)
(global-set-key [C-f8] 'eshell)
(global-set-key [(f9)] 'kill-shell)

;; Load CEDET
;;(load-file "/home/hyli/.emacs.d/cedet/common/cedet.el")
;(global-ede-mode 1)
;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
;; Select one of the following:

;; * This enables the database and idle reparse engines
;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as the nascent intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;;(semantic-load-enable-guady-code-helpers)

;; * This turns on which-func support (Plus all other code helpers)
;;(semantic-load-enable-excessive-code-helpers)

;; This turns on modes that aid in grammar writing and semantic tool
;; development.  It does not enable any other features such as code
;; helpers above.
;;(semantic-load-enable-semantic-debugging-helpers)

;;; gcc setup
;(require 'semantic-gcc)

;;; smart complitions setup
;;(require 'semantic-ia)


;(add-to-list 'load-path "~/.emacs.d/ecb-2.40")
(add-to-list 'load-path "~/.emacs.d/ecb-snap")
;;eg(add-to-list 'load-path "~/.emacs.d/ecb-2.32")
(require 'ecb)

;;(set-default-font "Mono-14")
;;(set-default-font "Courier-11")
;; (set-default-font "-bitstream-Courier 10 Pitch-bold-italic-normal-*-19-*-*-*-m-0-iso10646-1")
;; (set-default-font "Courier New-14") 
(set-default-font "-unknown-Liberation Mono-normal-normal-normal-*-19-*-*-*-m-0-iso10646-1")
;;(add-to-list 'default-frame-alist '(font . "Mono-14"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  semantic
(require 'cc-mode)
;(define-key c-mode-base-map (kbd "\C-tab") 'semantic-ia-complete-symbol-menu)
(define-key c-mode-base-map [(M-n)] 'semantic-ia-complete-symbol-menu)
(define-key c-mode-base-map [(f7)] 'semantic-ia-fast-jump)
(define-key c-mode-base-map [(S-f7)] 'semantic-mrub-switch-tags)
(define-key c-mode-base-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)
;(define-key c-mode-base-map [(control tab)] 'ac-complete-semantic-raw)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ecb

;(setq ecb-auto-activate t)
(setq ecb-tip-of-the-day nil)
(ecb-activate)
(ecb-hide-ecb-windows)

(global-set-key [M-left] 'windmove-left)

(global-set-key [M-right] 'windmove-right)

(global-set-key [M-up] 'windmove-up)

(global-set-key [M-down] 'windmove-down) 

(define-key global-map [f5] 'ecb-show-ecb-windows)
(define-key global-map [f6] 'ecb-hide-ecb-windows)


;(define-key global-map "/C-c1" 'ecb-maximize-window-directories)

;(define-key global-map "/C-c2" 'ecb-maximize-window-sources)

;(define-key global-map "/C-c3" 'ecb-maximize-window-methods)

;(define-key global-map "/C-c4" 'ecb-maximize-window-history)

;(define-key global-map "/C-c`" 'ecb-restore-default-window-sizes)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ecb layout
(ecb-layout-define "ykli-ecb-layout" right nil  
                   (ecb-set-directories-buffer)
                   (ecb-split-ver 0.3 t)  
                   (other-window 1)  
                   (ecb-set-sources-buffer)  
                   (ecb-split-ver 0.3 t)  
                   (other-window 1)  
                   (ecb-set-methods-buffer))  
  
(setq ecb-layout-name "hyli-ecb-layout")  
  
;; Disable buckets so that history buffer can display more entries  
;(setq ecb-history-make-buckets 'never)  


;(add-to-list 'load-path "/home/ykli/.emacs.d/auto-complete-1.3.1")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "/home/ykli/.emacs.d/ac-dict")

;(ac-config-default)
;(setq-default ac-sources '(ac-source-semantic ac-source-semantic-raw ac-source-yasnippet))
;(ac-cc-mode-setup)

;(require 'auto-complete-semantic nil t)
;(setq-default ac-sources '(ac-source-semantic))   
(setq semantic-edits-verbose-flag nil)

;;do not modify .emacs ,you only should add .el int ~/.emacs.d/myconfig/xxx.el
;;you only need to modify the config file to not .el if you want to close a function

;; (add-to-list 'load-path "~/Shell/config/emacs.el" "~/Shell/config/emacs.init")
(mapc 'load (directory-files "~/.emacs.d/config" t "\\.el$"))
;;;----------------------automatic customize----------------------------


;; ---

