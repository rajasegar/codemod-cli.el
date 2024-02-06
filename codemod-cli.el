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
  (let ((codemod-name (read-string "Codemod name: "))
        (fixture-name (read-string "Fixture name: ")))
    (async-shell-command (format "npx codemod-cli generate fixture %s %s" codemod-name fixture-name))))

(defun codemod-cli-update-docs ()
  "Update the codemod docs"
  (interactive)
  (async-shell-command "npx codemod-cli update-docs"))

(defun get-codemods ()
(remove-if (lambda (x)
             (or (string= x ".") (string= x "..") (string= x ".gitkeep")))
           (directory-files "~/www/react-codemod/transforms")))

(codemod-cli-new-project)


