From: hamdyk@mellanox.com (Hamdy Khader)
Date: Mon, 16 Jul 2018 17:01:19 +0300
Subject: [PATCH] Adds the ability to delete namespace.
Message-ID: <1531749679-10504-1-git-send-email-hamdyk@mellanox.com>

---
 nvmetcli | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/nvmetcli b/nvmetcli
index 6b102a2..20bdfa6 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -583,6 +583,7 @@ def usage():
     print("        %s restore [file_to_restore_from]" % sys.argv[0])
     print("        %s clear" % sys.argv[0])
     print("        %s ls" % sys.argv[0])
+    print("        %s delete_ns [namespace_id] [subsystem_name]" % sys.argv[0])
     sys.exit(-1)
 
 
@@ -613,7 +614,18 @@ def ls(unused):
     sys.exit(0)
 
 
-funcs = dict(save=save, restore=restore, clear=clear, ls=ls)
+def delete_ns(unused):
+    ns_name = sys.argv[2]
+    ss_name = sys.argv[3]
+    print("deleting namespace:%s ,subsystem:%s" % (ns_name, ss_name))
+    subsystem_node = nvme.Subsystem(nqn=ss_name, mode='lookup')
+    namespace_node = nvme.Namespace(subsystem_node, nsid=ns_name, mode='lookup')
+    namespace_node.set_enable(0)
+    namespace_node.delete()
+
+
+funcs = dict(save=save, restore=restore, clear=clear, ls=ls,
+             delete_ns=delete_ns)
 
 
 def main():
@@ -621,10 +633,7 @@ def main():
         print("%s: must run as root." % sys.argv[0], file=sys.stderr)
         sys.exit(-1)
 
-    if len(sys.argv) > 3:
-        usage()
-
-    if len(sys.argv) == 2 or len(sys.argv) == 3:
+    if len(sys.argv) >= 2:
         if sys.argv[1] == "--help":
             usage()
 
-- 
1.9.1
