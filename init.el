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
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes
   '("2391f1bf535aae3db84ef590305142f9b9e591f5d6fb923aa39a8cbe7a9ee602" "d138755a2e3f917ecf0fd0bb4ef89b392c306919d537cef40e8acd22a171988b" "4a042157f7dd2c602f0da4f8dbc2c7216729f60005682931ca406a07d87c3511" "5d69322a2fb105a8a49fc4a15611c91c2e8ea502197c105ed26cfa2907d3dddb" "ddcb8be019592c6721c9baadb5727d3f7308b3321326ac101787a24235ddfc59" "1de65986faa8c92ab070847c84c2ef131c82ccf7b3b8aa48d51c32faead52f2a" "687c29c8038e9a2d489266f5dfe42c3d36cb36ccac0d1d3fb96b9d3d47b7734f" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "a10b37a83ca21e6b6a5cf9df0a20f1d128215ea22ef027f9ca44eacd944e952a" "6ea6396c0c630a9bd0119272a65d23f3c1d26d0682d6d6afb94171dab6f2863a" "6b85a69a062d0f61bdb02cb52fc7f3b74ecd7411b3fb27da1197ea728ee65093" "16d30b775ec4db2059a22a4def1589b318c20fb6f8472fda11f40a2b1597b83d" "86446f04dabe3535be0b3df45858b0d7d186c6bfdb4b0dd0936974349acac25c" "471a03414a2b4a9a078cc4f238420f4dc62fcb54f2532ac4c0d2cbbee87b46c5" "92cc4e4fbaa7ded0e4a69da1053641e32596cc0d7a21f39d52831f36712e9cae" "d89a9f942d46ec530c0707012dada7c12ac5e90a1211ab2e7148697f12b5a9e4" "0bb2a727e7a864f44b52698ee6fc9f7d3ba91e417f4bfa92b94ea420fa6ad239" "9e7d1b5db92c52b5687d05c170246ae1299f23ea5d116013ba4024edbf0d8326" "bc3af5405366794ed35266bf7b8b3579d25b47f5049f4aa2fc1c5d374ecdcda0" "47527ddad3855912c81322bbb62bd8dbad69f2f9a4967afb002c5715dd852dd0" "5d59bd44c5a875566348fa44ee01c98c1d72369dc531c1c5458b0864841f887c" default))
 '(display-line-numbers-type nil)
 '(electric-pair-mode t)
 '(fringe-mode '(1 . 1) nil (fringe))
 '(global-display-line-numbers-mode t)
 '(linum-format " %5i ")
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(smartscan glsl-mode aggressive-indent highlight-numbers rainbow-delimiters buffer-move naysayer-theme))
 '(rainbow-delimiters-max-face-count 1)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(window-divider-default-bottom-width 1)
 '(window-divider-default-places t)
 '(window-divider-default-right-width 1)
 '(window-divider-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))

(toggle-frame-fullscreen)

;; first screen (empty buffer)
(defun start_up_screen ()
  (if (< (count-windows) 2)
      (progn
	(setq inhibit-splash-screen 'my-start-screen)
	(switch-to-buffer "*scratch*")
	(setq initial-scratch-message nil)
	(split-window-right)
	(other-window 1)
	(find-file "~/.emacs.d/init.el")
	(other-window 1))))

(start_up_screen)

;; theme
(setq custom--inhibit-theme-enable nil)
(load-theme 'naysayer t)
;; parens
(custom-theme-set-faces
 'naysayer ;; e.g. 'spacemacs-dark
 '(show-paren-match ((t (:foreground "#ae81ff" :background "#0b3335")))) ;; colors from theme
 '(show-paren-mismatch ((t (:foreground nil :background nil))))) ;; disable show-paren-mismatch to use rainbow-delimeter mismatching parens
(show-paren-mode 1)
(setq show-paren-delay 0)

;; rainbow-delimeter for mismatching parens
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(require 'rainbow-delimiters)
(set-face-attribute 'rainbow-delimiters-unmatched-face nil
                    :foreground "#88090b"
                    :inherit 'error)

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

(blink-cursor-mode 0)
(icomplete-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(electric-pair-mode 1)
(global-visual-line-mode 1)
(global-hl-line-mode 1)
(global-smartscan-mode 1)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

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

(setq project-locked nil)

(defun load-project-files ()
  (interactive)
  (if (not project-locked)
      (progn
	(other-window 1)
	(setq other-window-buffer (buffer-name))
	(other-window 1)
	(if (find-project-directory)
	    (progn
	      (setq project-locked t)
	      (setq project-root-directory default-directory)
	      (mapc #'find-file (directory-files-recursively project-root-directory "\\(\\.glsl$\\|\\.cpp$\\|\\.h$\\|\\.c$\\)" nil))
	      (switch-to-buffer other-window-buffer)
	      (other-window 1)
	      (message "Project files have been loaded."))))
    (message "Project files have already been loaded.")))


(global-set-key (kbd "C-w") 'backward-kill-word) ;; default C-<backspace>
(global-set-key (kbd "C-c d") 'kill-region) ;; default C-w


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

;; C-c C-c comment region (in c++ mode) (already defined)
;; C-c C-v uncomment region (in c++ mode)
(add-hook
 'c++-mode-hook
 (lambda ()
   (local-set-key (kbd "C-c C-v") #'uncomment-region)))

;; C-n adds new line if it is end of the buffer
(setq next-line-add-newlines t)

(global-set-key (kbd "M-o") 'other-window)

(global-set-key (kbd "M-w") 'copy-region-as-kill)


