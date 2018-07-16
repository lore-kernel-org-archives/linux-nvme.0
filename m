From: hamdyk@mellanox.com (Hamdy Khader)
Date: Mon, 16 Jul 2018 14:58:20 +0300
Subject: [PATCH] Adds the ability to dump json to stdout
Message-ID: <1531742300-9888-1-git-send-email-hamdyk@mellanox.com>

---
 nvmet/nvme.py |  3 +++
 nvmetcli      | 12 +++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 8253ea9..3ca8429 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -388,6 +388,9 @@ class Root(CFSNode):
         d['hosts'] = [h.dump() for h in self.hosts]
         return d
 
+    def dump_json(self):
+        return json.dumps(self.dump(), sort_keys=True, indent=2)
+
 
 class Subsystem(CFSNode):
     '''
diff --git a/nvmetcli b/nvmetcli
index 6b102a2..de189c1 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -583,6 +583,7 @@ def usage():
     print("        %s restore [file_to_restore_from]" % sys.argv[0])
     print("        %s clear" % sys.argv[0])
     print("        %s ls" % sys.argv[0])
+    print("        %s dump" % sys.argv[0])
     sys.exit(-1)
 
 
@@ -590,6 +591,10 @@ def save(to_file):
     nvme.Root().save_to_file(to_file)
 
 
+def dump(unused):
+    print(nvme.Root().dump_json())
+
+
 def restore(from_file):
     try:
         errors = nvme.Root().restore_from_file(from_file)
@@ -613,7 +618,7 @@ def ls(unused):
     sys.exit(0)
 
 
-funcs = dict(save=save, restore=restore, clear=clear, ls=ls)
+funcs = dict(save=save, restore=restore, clear=clear, ls=ls, dump=dump)
 
 
 def main():
@@ -621,10 +626,7 @@ def main():
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
