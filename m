From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:50 +0200
Subject: [nvme-cli 5/9] tests/nvme_text.py: add test for namespace management
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-6-hare@suse.de>

Some commands are only mandatory if namespace management is
supported, so add a test to detect it.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_test.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/nvme_test.py b/tests/nvme_test.py
index 538d30c..2f50a51 100644
--- a/tests/nvme_test.py
+++ b/tests/nvme_test.py
@@ -324,6 +324,30 @@ class TestNVMe(object):
         return int(oncs, 16) & 1
 
     @tools.nottest
+    def get_oacs_namespace_mgmt(self):
+        """ Wrapper for extracting namespace management support.
+            - Args:
+                - None
+            - Returns:
+                - true if supported.
+        """
+        pattern = re.compile("^oacs[ ]+: [0-9]", re.IGNORECASE)
+        oacs = 0
+        get_ctrl_id = "nvme id-ctrl " + self.ctrl
+        proc = subprocess.Popen(get_ctrl_id,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        assert_equal(err, 0, "ERROR : reading oacs value failed")
+
+        for line in proc.stdout:
+            if pattern.match(line):
+                oacs = line.split(":")[1].strip()
+                break
+
+        return int(oacs, 16) & 8
+
+    @tools.nottest
     def is_qemu_controller(self):
         """ Wrapper for checking for Qemu NVMe controller.
             - Args:
-- 
2.13.7
