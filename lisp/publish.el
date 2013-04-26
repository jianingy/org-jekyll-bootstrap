(setq debug-on-error t)
(setq base-dir (getenv "PWD"))
(message (concat "current base directory:" base-dir))
(add-to-list 'load-path (concat base-dir "/lisp/el-get"))
(add-to-list 'load-path (concat base-dir "/lisp/org-jekyll"))
;(princ load-path)
(setq el-get-dir (concat base-dir "/packages"))
(make-directory el-get-dir t)
(require 'el-get)

(setq required-packages (append
                         '(tomorrow-theme org-mode color-theme)
                         (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync required-packages)
                                        ;(el-get 'wait)


;; setup org-mode
(add-to-list 'load-path (concat base-dir "/packages/tomorrow-theme/GNU Emacs"))
(require 'htmlize)
(require 'color-theme)
(require 'tomorrow-day-theme)
(require 'org)
(require 'ox-html)
(require 'org-jekyll)
(setq org-confirm-babel-evaluate nil
      org-export-htmlize-output-type 'css
      org-babel-temporary-directory "/tmp/babel" ;; babel directory will be clean up on exit
)
(defun add-new-blog (site)
  (let ((org-source-dir (concat base-dir "/source/" site "/"))
        (org-publish-dir (concat base-dir "/site/" site "/"))
        (org-site-root (concat "http://" site)))
    (message (concat "source directory: " org-source-dir))
    (message (concat "publish directory: " org-publish-dir))
    (add-to-list 'org-publish-project-alist
                 `(,site
                   :base-directory ,org-source-dir
                   :recursive t
                   :base-extension "org"
                   :publishing-directory ,org-publish-dir
                   :site-root ,org-site-root
                   :jekyll-sanitize-permalinks t
                   :publishing-function org-html-publish-to-html
                   :section-numbers nil
                   :headline-levels 4
                   :table-of-contents t
                   :auto-index nil
                   :auto-preamble nil
                   :body-only t
                   :auto-postamble nil))))

;(org-publish-all t nil)
;(org-jekyll-export-project "org-source")
