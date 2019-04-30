From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:51 +0200
Subject: [nvme-cli 6/9] tests/nvme_attach_detach_ns_test.py: skip if namespace
 mgmt is not supported
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-7-hare@suse.de>

If namespace management is not supported the test will fail, too.
So check for it prior to executing the test.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_attach_detach_ns_test.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/nvme_attach_detach_ns_test.py b/tests/nvme_attach_detach_ns_test.py
index 92a82dd..2225e2c 100644
--- a/tests/nvme_attach_detach_ns_test.py
+++ b/tests/nvme_attach_detach_ns_test.py
@@ -53,18 +53,17 @@ class TestNVMeAttachDetachNSCmd(TestNVMe):
         self.nsze = 0x1400000
         self.ncap = 0x1400000
         self.setup_log_dir(self.__class__.__name__)
-        self.ctrl_id = self.get_ctrl_id()
-        self.delete_all_ns()
-        time.sleep(1)
 
     def __del__(self):
         """
         Post Section for TestNVMeAttachDetachNSCmd
 
             - Create primary namespace.
-            - Atttach it to controller.
+            - Attach it to controller.
             - Call super class's destructor.
         """
+        if self.get_oacs_namespace_mgmt() == 0:
+            return
         assert_equal(self.create_and_validate_ns(self.default_nsid,
                                                  self.nsze,
                                                  self.ncap,
@@ -75,6 +74,12 @@ class TestNVMeAttachDetachNSCmd(TestNVMe):
 
     def test_attach_detach_ns(self):
         """ Testcase main """
+        if self.get_oacs_namespace_mgmt() == 0:
+            return
+
+        self.ctrl_id = self.get_ctrl_id()
+        self.delete_all_ns()
+        time.sleep(1)
         err = self.create_and_validate_ns(self.default_nsid,
                                           self.nsze,
                                           self.ncap,
-- 
2.13.7
