From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:47 +0200
Subject: [nvme-cli 2/9] tests/nvme_writeuncor_test.py: check if write
 uncorrectable is supported
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-3-hare@suse.de>

Before testing the WRITE UNCORRECTABLE command we should be testing the
ONCS value of the IDENTIFY CONTROLLER command to figure out if
the command is supported.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_test.py            | 24 ++++++++++++++++++++++++
 tests/nvme_writeuncor_test.py | 11 ++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/tests/nvme_test.py b/tests/nvme_test.py
index 1c17ba1..7db277f 100644
--- a/tests/nvme_test.py
+++ b/tests/nvme_test.py
@@ -276,6 +276,30 @@ class TestNVMe(object):
         return int(oncs, 16) & 8
 
     @tools.nottest
+    def get_oncs_write_uncorr(self):
+        """ Wrapper for extracting write uncorrectable command support.
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
+        return int(oncs, 16) & 2
+
+    @tools.nottest
     def delete_all_ns(self):
         """ Wrapper for deleting all the namespaces.
             - Args:
diff --git a/tests/nvme_writeuncor_test.py b/tests/nvme_writeuncor_test.py
index 9f96f63..e4dc7b4 100644
--- a/tests/nvme_writeuncor_test.py
+++ b/tests/nvme_writeuncor_test.py
@@ -69,8 +69,9 @@ class TestNVMeUncor(TestNVMeIO):
 
     def test_write_uncor(self):
         """ Testcase main """
-        assert_equal(self.nvme_read(), 0)
-        assert_equal(self.write_uncor(), 0)
-        assert_not_equal(self.nvme_read(), 0)
-        assert_equal(self.nvme_write(), 0)
-        assert_equal(self.nvme_read(), 0)
+        if self.get_oncs_write_uncorr() == 1:
+            assert_equal(self.nvme_read(), 0)
+            assert_equal(self.write_uncor(), 0)
+            assert_not_equal(self.nvme_read(), 0)
+            assert_equal(self.nvme_write(), 0)
+            assert_equal(self.nvme_read(), 0)
-- 
2.13.7
