From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:52 +0200
Subject: [nvme-cli 7/9] tests/nvme_create_max_ns_test.py: skip if namespace
 mgmt is not supported
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-8-hare@suse.de>

If namespace management is not supported the test will fail, too.
So check for it prior to executing the test.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_create_max_ns_test.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/nvme_create_max_ns_test.py b/tests/nvme_create_max_ns_test.py
index f853732..b2b11b2 100644
--- a/tests/nvme_create_max_ns_test.py
+++ b/tests/nvme_create_max_ns_test.py
@@ -54,9 +54,6 @@ class TestNVMeCreateMaxNS(TestNVMe):
         self.ncap = self.nsze
         self.setup_log_dir(self.__class__.__name__)
         self.max_ns = self.get_max_ns()
-        self.ctrl_id = self.get_ctrl_id()
-        self.delete_all_ns()
-        time.sleep(1)
 
     def __del__(self):
         """
@@ -66,6 +63,8 @@ class TestNVMeCreateMaxNS(TestNVMe):
             - Atttach it to controller.
             - Call super class's destructor.
         """
+        if self.get_oacs_namespace_mgmt() == 0:
+            return
         assert_equal(self.create_and_validate_ns(self.default_nsid,
                                                  self.nsze,
                                                  self.ncap,
@@ -76,6 +75,11 @@ class TestNVMeCreateMaxNS(TestNVMe):
 
     def test_attach_detach_ns(self):
         """ Testcase main """
+        if self.get_oacs_namespace_mgmt() == 0:
+            return
+        self.ctrl_id = self.get_ctrl_id()
+        self.delete_all_ns()
+        time.sleep(1)
         for nsid in range(1, self.max_ns):
             print("##### Creating " + str(nsid))
             err = self.create_and_validate_ns(nsid,
-- 
2.13.7
