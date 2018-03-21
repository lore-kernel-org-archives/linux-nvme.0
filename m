From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Wed, 21 Mar 2018 17:46:59 +0200
Subject: [PATCH] nvmetcli: fix restore error printing mechanism
Message-ID: <1521647219-31076-1-git-send-email-nitzanc@mellanox.com>

restore function ignores all errors, and "quitely"
call exit(0). This patch add error prints prior
to the exit() call.

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvmetcli | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/nvmetcli b/nvmetcli
index 6b102a2..0c31046 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -591,15 +591,17 @@ def save(to_file):
 
 
 def restore(from_file):
+    errors = []
+
     try:
         errors = nvme.Root().restore_from_file(from_file)
     except IOError:
         # Not an error if the restore file is not present
         print("No saved config file at %s, ok, exiting" % from_file)
-    sys.exit(0)
 
     for error in errors:
         print(error)
+    sys.exit(0)
 
 
 def clear(unused):
-- 
1.8.3.1
