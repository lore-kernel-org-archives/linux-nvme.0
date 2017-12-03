From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  3 Dec 2017 10:25:34 +0200
Subject: [PATCH v2 1/2] nvmetcli: Expose ls to dump UI configuration
Message-ID: <20171203082535.17663-1-sagi@grimberg.me>

for running: nvmetcli ls

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- Added a man entry for nvmetcli ls cmdline operation

 Documentation/nvmetcli.txt |  1 +
 nvmetcli                   | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/nvmetcli.txt b/Documentation/nvmetcli.txt
index 1f381cc7ad2e..05a0344dfd91 100644
--- a/Documentation/nvmetcli.txt
+++ b/Documentation/nvmetcli.txt
@@ -105,6 +105,7 @@ and not enter the interactive configuration shell.
                             Without specifying the filename this will use
                             */etc/nvmet/config.json*.
 | clear                   | Clears a current NVMe Target configuration.
+| ls                      | Dumps the current NVMe Target configuration.
 |==================
 
 EXAMPLES
diff --git a/nvmetcli b/nvmetcli
index 4fbc12ec430f..0c590c9638f1 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -549,6 +549,7 @@ def usage():
     print("syntax: %s save [file_to_save_to]" % sys.argv[0])
     print("        %s restore [file_to_restore_from]" % sys.argv[0])
     print("        %s clear" % sys.argv[0])
+    print("        %s ls" % sys.argv[0])
     sys.exit(-1)
 
 
@@ -572,7 +573,14 @@ def clear(unused):
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
2.14.1
