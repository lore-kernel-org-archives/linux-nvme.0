From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 17 Oct 2017 13:34:55 +0300
Subject: [PATCH nvmetcli 1/2] nvmetcli: Expose ls to dump UI configuration
Message-ID: <1508236496-23921-1-git-send-email-sagi@grimberg.me>

for running: nvmetcli ls

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvmetcli | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/nvmetcli b/nvmetcli
index 5378365eb91f..951b6431e6f0 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -554,6 +554,7 @@ def usage():
     print("syntax: %s save [file_to_save_to]" % sys.argv[0])
     print("        %s restore [file_to_restore_from]" % sys.argv[0])
     print("        %s clear" % sys.argv[0])
+    print("        %s ls" % sys.argv[0])
     sys.exit(-1)
 
 
@@ -577,7 +578,14 @@ def clear(unused):
     nvme.Root().clear_existing()
 
 
-funcs = dict(save=save, restore=restore, clear=clear)
+def ls(unused):
+    shell = configshell.shell.ConfigShell('~/.nvmetcli')
+    UIRootNode(shell)
+    shell.run_cmdline("ls")
+    sys.exit(0)
+
+
+funcs = dict(save=save, restore=restore, clear=clear, ls=ls)
 
 
 def main():
-- 
2.7.4
