From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:46 +0200
Subject: [nvme-cli 1/9] tests/nvme_writezeros_test.py: check if write zeroes
 is supported
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-2-hare@suse.de>

Before testing the WRITE ZEROS command we should be testing the
ONCS value of the IDENTIFY CONTROLLER command to figure out if
the command is supported.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_test.py            | 23 +++++++++++++++++++++++
 tests/nvme_writezeros_test.py | 15 ++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/tests/nvme_test.py b/tests/nvme_test.py
index 80939dc..1c17ba1 100644
--- a/tests/nvme_test.py
+++ b/tests/nvme_test.py
@@ -253,6 +253,29 @@ class TestNVMe(object):
         return int(nvm_format)
 
     @tools.nottest
+    def get_oncs_write_zeroes(self):
+        """ Wrapper for extracting write zeroes command support.
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
+        return int(oncs, 16) & 8
+
+    @tools.nottest
     def delete_all_ns(self):
         """ Wrapper for deleting all the namespaces.
             - Args:
diff --git a/tests/nvme_writezeros_test.py b/tests/nvme_writezeros_test.py
index 157fd78..e549f3b 100644
--- a/tests/nvme_writezeros_test.py
+++ b/tests/nvme_writezeros_test.py
@@ -93,10 +93,11 @@ class TestNVMeWriteZeros(TestNVMeIO):
         return 0 if filecmp.cmp(self.zero_file, self.read_file) is True else 1
 
     def test_write_zeros(self):
-        """ Testcae main """
-        assert_equal(self.nvme_write(), 0)
-        assert_equal(self.nvme_read(), 0)
-        assert_equal(self.validate_write_read(), 0)
-        assert_equal(self.write_zeroes(), 0)
-        assert_equal(self.nvme_read(), 0)
-        assert_equal(self.validate_zeroes(), 0)
+        """ Testcase main """
+        if self.get_oncs_write_zeroes() == 1:
+            assert_equal(self.nvme_write(), 0)
+            assert_equal(self.nvme_read(), 0)
+            assert_equal(self.validate_write_read(), 0)
+            assert_equal(self.write_zeroes(), 0)
+            assert_equal(self.nvme_read(), 0)
+            assert_equal(self.validate_zeroes(), 0)
-- 
2.13.7
