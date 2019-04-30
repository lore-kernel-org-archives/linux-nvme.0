From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:48 +0200
Subject: [nvme-cli 3/9] tests/nvme_compare_test.py: check if compare is
 supported
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-4-hare@suse.de>

Before testing the COMPARE command we should be testing the
ONCS value of the IDENTIFY CONTROLLER command to figure out if
the command is supported.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_compare_test.py |  7 ++++---
 tests/nvme_test.py         | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tests/nvme_compare_test.py b/tests/nvme_compare_test.py
index c919c07..2dd0298 100644
--- a/tests/nvme_compare_test.py
+++ b/tests/nvme_compare_test.py
@@ -74,6 +74,7 @@ class TestNVMeCompareCmd(TestNVMeIO):
 
     def test_nvme_compare(self):
         """ Testcase main """
-        assert_equal(self.nvme_write(), 0)
-        assert_not_equal(self.nvme_compare(self.compare_file), 0)
-        assert_equal(self.nvme_compare(self.write_file), 0)
+        if self.get_oncs_compare() == 1:
+            assert_equal(self.nvme_write(), 0)
+            assert_not_equal(self.nvme_compare(self.compare_file), 0)
+            assert_equal(self.nvme_compare(self.write_file), 0)
diff --git a/tests/nvme_test.py b/tests/nvme_test.py
index 7db277f..7fa0734 100644
--- a/tests/nvme_test.py
+++ b/tests/nvme_test.py
@@ -300,6 +300,30 @@ class TestNVMe(object):
         return int(oncs, 16) & 2
 
     @tools.nottest
+    def get_oncs_compare(self):
+        """ Wrapper for extracting compare command support.
+            - Args:
+                - None
+            - Returns:
+                - true if supported.
+        """
+        pattern = re.compile("^oncs[ ]+: [0-9]", re.IGNORECASE)
+        oncs = 0
+        get_ctrl_id = "nvme id-ctrl " + self.ctrl
+        proc = subprocess.Popen(get_ctrl_id,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        assert_equal(err, 0, "ERROR : reading oncs value failed")
+
+        for line in proc.stdout:
+            if pattern.match(line):
+                oncs = line.split(":")[1].strip()
+                break
+
+        return int(oncs, 16) & 1
+
+    @tools.nottest
     def delete_all_ns(self):
         """ Wrapper for deleting all the namespaces.
             - Args:
-- 
2.13.7
