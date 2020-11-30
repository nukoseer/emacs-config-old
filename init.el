(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe-mode '(1 . 1) nil (fringe))
 '(package-selected-packages
   '(writeroom-mode smartscan rainbow-delimiters naysayer-theme highlight-numbers glsl-mode gcmh buffer-move aggressive-indent))
 '(rainbow-delimiters-max-face-count 1)
 '(window-divider-default-bottom-width 1)
 '(window-divider-default-places t)
 '(window-divider-default-right-width 1)
 '(window-divider-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(gcmh-mode 1)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(blink-cursor-mode 0)
(global-display-line-numbers-mode 0)
(column-number-mode 1)
(icomplete-mode 1)
(electric-pair-mode 1)
(global-visual-line-mode 1)
(global-hl-line-mode 1)
(global-smartscan-mode 1)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(run-with-idle-timer 0.2 nil (lambda ()
			       (ido-mode 1)
			       (setq ido-enable-flex-matching t)
			       (setq ido-everywhere t)))

(setq file-name-handler-alist nil)

(setq frame-inhibit-implied-resize t)

(add-to-list 'default-frame-alist '(font . "Liberation Mono-12"))

;; force emacs for utf-8
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
;;(modify-coding-system-alist 'file "" 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq default-buffer-file-coding-system 'utf-8) 
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; set default directory to c++ folder
(setq default-directory "D:/Programming/c&cpp/cpp" )

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; theme
(setq custom--inhibit-theme-enable nil)
(load-theme 'naysayer t)

;; activate fullscreen, open empty buffer and init.el
(defun start-up-screen ()
  (if (< (count-windows) 2)
      (progn
	(toggle-frame-fullscreen)
	(setq inhibit-splash-screen 'my-start-screen)
	(switch-to-buffer "*scratch*")
	(setq initial-scratch-message nil)
	(split-window-right)
	(other-window 1)
	(find-file "~/.emacs.d/init.el")
	(other-window 1))))

(start-up-screen)

;; parens
(custom-theme-set-faces
 'naysayer ;; e.g. 'spacemacs-dark
 '(show-paren-match ((t (:foreground "#ae81ff" :background "#0b3335")))) ;; colors from theme
 '(show-paren-mismatch ((t (:foreground nil :background nil))))) ;; disable set show-paren-mismatch nil to use rainbow-delimeter mismatching parens
(show-paren-mode 1)
(setq show-paren-delay 0)

;; rainbow-delimeter for mismatching parens
;;(require 'rainbow-delimiters)
;; (set-face-attribute 'rainbow-delimiters-unmatched-face nil
;;                     :foreground "#88090b"
;;                     :inherit 'error)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; set rainbow-delimiters to not highlight < and >
(defun my-rainbow-delimiters-face (depth match loc)
  (unless (memq (char-after loc) '(?\< ?\>))
    (rainbow-delimiters-default-pick-face depth match loc)))

(setq rainbow-delimiters-pick-face-function #'my-rainbow-delimiters-face)

;; shortcuts to change buffer position
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; change window split orientation (horizontal to vertical or opposite)
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(define-key ctl-x-4-map "t" 'toggle-window-split)

;; equal to C-<down> and C-<up>
;; Replaced with smartscan
;;(global-set-key (kbd "M-n") 'forward-paragraph)
;;(global-set-key (kbd "M-p") 'backward-paragraph)

;; move line
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; basic completation
(global-set-key (kbd "<C-tab>") 'dabbrev-expand)

;; shortcut for buffer switching
(global-set-key (kbd "C-,") 'switch-to-buffer)
(global-set-key (kbd "C-;") 'switch-to-buffer-other-window)
(global-set-key (kbd "C-z") 'undo)

;; aggresive indent mode
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;; c / c++ visual studio style code indentation
(defun my-c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  ;; other customizations can go here

  (setq c++-tab-always-indent t)
  (setq c-basic-offset 4)                  ;; Default is 2
  (setq c-indent-level 4)                  ;; Default is 2
  
  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
  (setq tab-width 4)
  (setq indent-tabs-mode t)  ; use spaces only if nil
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-hook
 'c++-mode-hook
 (lambda ()
   ;; C-c C-c comment region (in c++ mode) (already defined)
   ;; C-c C-v uncomment region (in c++ mode)
   (local-set-key (kbd "C-c C-v") #'uncomment-region)
   ;; ***_API keywords will be like noise macros (ex. __declspec(dllexport))
   ;; for correct indentation
   (setq c-noise-macro-names "[A-Z_]+_API")
   ))

;; disable auto save mode
(setq auto-save-default nil)
;; disable back up
(setq make-backup-file-name-function (quote ignore))
(setq make-backup-files nil)

;; add todo function
(defun add-todo ()
  (interactive)
  (insert "// TODO(SSJSR): "))

;; add #if 0 #endif block
(defun add-if0 (start end)
  (interactive "r")
  (let ((end (copy-marker end)))
    (goto-char start)
    (beginning-of-line)
    (open-line 1)
    (insert "#if 0")
    (goto-char end)
    (end-of-line)
    (newline)
    (insert "#endif")
    (goto-char start)
    (beginning-of-line)))

;; delete #if 0 #endif block
(defun delete-if0 ()
  (interactive)
  (if (search-forward "#if 0" nil t)
      (progn
	(kill-whole-line)
	(if (search-forward "#endif" nil t)
	    (kill-whole-line)))))

;; highlighting for TODO and NOTE
(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-note-face)
(mapc (lambda (mode)
	(font-lock-add-keywords
	 mode
	 '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
           ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
      fixme-modes)
(modify-face 'font-lock-fixme-face "Red" nil nil t nil nil nil nil)
(modify-face 'font-lock-note-face "Dark Green" nil nil t nil nil nil nil)

;; turn off the bell
(defun nil-bell ())
(setq ring-bell-function 'nil-bell)

;; smooth scroll
(setq scroll-step 3)

;; find project root, build, run
(setq project-base "build.bat")
(setq compilation-directory-locked nil)

(defun find-project-directory-recursive ()
  "Recursively search for a makefile."
  (interactive)
  (if (file-exists-p project-base) t
    (cd "../")
    (find-project-directory-recursive)))

(defun lock-compilation-directory ()
  "The compilation process should NOT hunt for a makefile"
  (interactive)
  (setq compilation-directory-locked t)
  (message "Compilation directory is locked."))

(defun unlock-compilation-directory ()
  "The compilation process SHOULD hunt for a makefile"
  (interactive)
  (setq compilation-directory-locked nil)
  (message "Compilation directory is unlocked."))

(defun find-project-directory ()
  "Find the project directory."
  (interactive)
  (setq find-project-from-directory default-directory)
  (switch-to-buffer-other-window "*compilation*")
  (if compilation-directory-locked (cd last-compilation-directory)
    (lock-compilation-directory)
    (cd find-project-from-directory)
    (find-project-directory-recursive)
    (setq last-compilation-directory default-directory)))

(defun build ()
  "Make the current build."
  (interactive)
  (if (find-project-directory) (compile project-base))
  (other-window 1))

(defun run ()
  "Run the current build."
  (interactive)
  (if (find-project-directory) (compile "run.bat"))
  (other-window 1))

(defun generate ()
  "Generate the current project."
  (interactive)
  (if (find-project-directory) (compile "generate.bat"))
  (other-window 1))

;; always kill *compilation* buffer before new *compilation* start
(setq compilation-always-kill t)

(setq project-files-loaded nil)

(defun lock-project-directory ()
  (interactive)
  (setq project-files-loaded t)
  (message "Project directory is locked."))

(defun unlock-project-directory ()
  (interactive)
  (setq project-files-loaded nil)
  (message "Project directory is unlocked."))

(defun load-project-files ()
  (interactive)
  (if (not project-files-loaded)
      (progn
	(other-window 1)
	(setq other-window-buffer (buffer-name))
	(other-window 1)
	(if (find-project-directory)
	    (progn
	      (setq project-files-loaded t)
	      (setq project-root-directory default-directory)
	      (mapc #'find-file (directory-files-recursively project-root-directory "\\(\\.glsl$\\|\\.cpp$\\|\\.h$\\|\\.c$\\)" nil))
	      (switch-to-buffer other-window-buffer)
	      (other-window 1)
	      (message "Project files have been loaded."))))
    (message "Project files have already been loaded.")))

(define-key global-map (kbd "<f1>") 'build)
(define-key global-map (kbd "<f2>") 'run)
(define-key global-map (kbd "<f3>") 'generate)

(setq auto-mode-alist
      (append
       '(("\\.cpp$"    . c++-mode)
	 ;;   ("\\.glsl$"    . c++-mode)
         ("\\.h$"    . c++-mode)
         ("\\.c$"   . c++-mode)
	 ) auto-mode-alist))

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Mark set"))

(global-set-key (kbd "C-SPC") 'push-mark-no-activate)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
  This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-\"") 'jump-to-mark)

;; C-n adds new line if it is end of the buffer
(setq next-line-add-newlines t)

(global-set-key (kbd "M-o") 'other-window) ;; default C-x o
(global-set-key (kbd "M-w") 'copy-region-as-kill)

;; Replace C-a and M-m
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "M-m") 'beginning-of-visual-line)

(global-set-key (kbd "M-h") 'backward-kill-word) ;; default C-<backspace>
(global-set-key (kbd "C-h") 'backward-delete-char)
;;(global-set-key (kbd "C-c d") 'kill-region) ;; default C-w

(global-set-key (kbd "C-?") 'help-command) ;; default C-h

;; enlarge and shrink window
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)

;; HideShow minor mode
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(global-set-key (kbd "C-+") 'hs-toggle-hiding)

(setq gc-cons-threshold 16777216 ; 16mb
      gc-cons-percentage 0.1)
