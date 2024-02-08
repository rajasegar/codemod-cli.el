(defun codemod-cli-new-project ()
  "Create a new codemod-cli project"
  (interactive)
  (let ((project-name (read-string "Project name: "))
        (default-directory (read-directory-name "Select Directory: " "~/www/")))
    (async-shell-command (format "npx codemod-cli new %s" project-name))))

(defun codemod-cli-generate-codemod ()
  "Generate a new codemod"
  (interactive)
  (let ((codemod-name (read-string "Codemod name: ")))
    (async-shell-command (format "npx codemod-cli generate codemod %s" codemod-name))))

(defun codemod-cli-test ()
  "Run tests for codemods"
  (interactive)
  (async-shell-command "npx codemod-cli test"))

(defun codemod-cli-generate-fixture ()
  "Generate fixture for a codemod"
  (interactive)
  (if (> (length (get-codemods)) 0)
        (ivy-read "Select a Codemod: "
                  (lambda (str pred _)
                    (let* ((props (get-codemods))
                           (strs (get-codemods)))
                      (cl-mapcar (lambda (s p) (propertize s 'property p)) strs props)))
                  :action (lambda (x)
                            (let ((codemod-name (get-text-property 0 'property x))
                                  (fixture-name (read-string "Fixture name: "))
                                  (default-directory (get-project-root)))
                              (async-shell-command (format "npx codemod-cli generate fixture %s %s" codemod-name fixture-name)))))
      (if 
          (y-or-n-p "You haven't created any codemods, do you want to create one? ")
          (let ((codemod-name (read-string "Codemod name: ")))
            (if (shell-command (format "npx codemod-cli generate codemod %s" codemod-name))
                (let ((fixture-name (read-string "Fixture name: ")))
                  (async-shell-command (format "npx codemod-cli generate fixture %s %s" codemod-name fixture-name)))
              (message "Codemod creation failed. please try again")))
        (message "Please create a codemod first and then generate fixtures"))
      
      ))

(defun codemod-cli-update-docs ()
  "Update the codemod docs"
  (interactive)
  (async-shell-command "npx codemod-cli update-docs"))

(defun get-codemods ()
(remove-if (lambda (x)
             (or (string= x ".") (string= x "..") (string= x ".gitkeep")))
           (directory-files (concat (get-project-root) "/transforms"))))

(defun get-project-root ()
  "Find the project root."
    (locate-dominating-file (file-name-directory (buffer-file-name)) "package.json"))





(get-codemods)


(codemod-cli-new-project)



