From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:49 +0200
Subject: [nvme-cli 4/9] tests: ignore log tests for Qemu
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-5-hare@suse.de>

The Qemu NVMe implementation doesn't support the GET LOG command,
so these tests are expected to fail.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_error_log_test.py |  3 ++-
 tests/nvme_smart_log_test.py |  5 +++--
 tests/nvme_test.py           | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tests/nvme_error_log_test.py b/tests/nvme_error_log_test.py
index a6a451d..68a0b1f 100644
--- a/tests/nvme_error_log_test.py
+++ b/tests/nvme_error_log_test.py
@@ -60,4 +60,5 @@ class TestNVMeErrorLogCmd(TestNVMe):
 
     def test_get_error_log(self):
         """ Testcase main """
-        assert_equal(self.get_error_log_ctrl(), 0)
+        if self.is_qemu_controller() == 0:
+            assert_equal(self.get_error_log_ctrl(), 0)
diff --git a/tests/nvme_smart_log_test.py b/tests/nvme_smart_log_test.py
index e1eb6e5..ddfac72 100644
--- a/tests/nvme_smart_log_test.py
+++ b/tests/nvme_smart_log_test.py
@@ -82,5 +82,6 @@ class TestNVMeSmartLogCmd(TestNVMe):
 
     def test_smart_log(self):
         """ Testcase main """
-        assert_equal(self.get_smart_log_ctrl(), 0)
-        assert_equal(self.get_smart_log_all_ns(), 0)
+        if self.is_qemu_controller() == 0:
+            assert_equal(self.get_smart_log_ctrl(), 0)
+            assert_equal(self.get_smart_log_all_ns(), 0)
diff --git a/tests/nvme_test.py b/tests/nvme_test.py
index 7fa0734..538d30c 100644
--- a/tests/nvme_test.py
+++ b/tests/nvme_test.py
@@ -324,6 +324,30 @@ class TestNVMe(object):
         return int(oncs, 16) & 1
 
     @tools.nottest
+    def is_qemu_controller(self):
+        """ Wrapper for checking for Qemu NVMe controller.
+            - Args:
+                - None
+            - Returns:
+                - true if supported.
+        """
+        pattern = re.compile("^mn[ ]+: [a-z ]", re.IGNORECASE)
+        model = ""
+        get_ctrl_id = "nvme id-ctrl " + self.ctrl
+        proc = subprocess.Popen(get_ctrl_id,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        assert_equal(err, 0, "ERROR : reading controller model value failed")
+
+        for line in proc.stdout:
+            if pattern.match(line):
+                model = line.split(":")[1].strip()
+                break
+
+        return model in "QEMU NVMe Ctrl"
+
+    @tools.nottest
     def delete_all_ns(self):
         """ Wrapper for deleting all the namespaces.
             - Args:
-- 
2.13.7
