From: Dong.Ho@wdc.com (Dong Ho)
Date: Fri, 21 Sep 2018 18:10:39 +0000
Subject: [PATCH 4/4] nvme-cli: tests: Add get_id_ctrl function
Message-ID: <1537578625-14880-1-git-send-email-dong.ho@wdc.com>

Signed-off-by: Dong Ho <dong.ho at wdc.com>
---
 tests/nvme_test.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/nvme_test.py b/tests/nvme_test.py
index 94406b5..d735863 100644
--- a/tests/nvme_test.py
+++ b/tests/nvme_test.py
@@ -396,6 +396,25 @@ class TestNVMe(object):
         print "host_write_commands " + host_write_commands
         return err
 
+    def get_id_ctrl(self, vendor=False):
+        """ Wrapper for nvme id-ctrl command.
+            - Args:
+              - None
+            - Returns:
+              - 0 on success, error code on failure.
+        """
+        if not vendor:
+            id_ctrl_cmd = "nvme id-ctrl " + self.ctrl
+        else:
+            id_ctrl_cmd = "nvme id-ctrl -v " + self.ctrl
+        print id_ctrl_cmd
+        proc = subprocess.Popen(id_ctrl_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        assert_equal(err, 0, "ERROR : nvme id controller failed")
+        return err
+
     def get_error_log(self):
         """ Wrapper for nvme error-log command.
             - Args:
-- 
1.8.3.1
