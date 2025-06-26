# Force a stable temp dir for VSCode workspace files
Sys.setenv(VSCODE_R_SESSION_TMPDIR = "/tmp/vscode-R")
if (!dir.exists(Sys.getenv("VSCODE_R_SESSION_TMPDIR"))) {
  dir.create(Sys.getenv("VSCODE_R_SESSION_TMPDIR"), recursive = TRUE)
}
source("renv/activate.R")
