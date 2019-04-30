From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:54 +0200
Subject: [nvme-cli 9/9] tests/nvme_format_test.py: skip test if namespace
 management is not supported
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-10-hare@suse.de>

While the spec doesn't make any explicit reference to namespace management,
the 'format' command itself is optional, and as such should be allowed
to fail. And the test requires the use of the controller identifier, which
in itself requires namespace management.
So add a check for namespace management before executing the tests.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_format_test.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/nvme_format_test.py b/tests/nvme_format_test.py
index ce93f5e..093d1da 100644
--- a/tests/nvme_format_test.py
+++ b/tests/nvme_format_test.py
@@ -65,14 +65,11 @@ class TestNVMeFormatCmd(TestNVMe):
         self.flbas = 0               # ns formattes logical block settings
         self.nsze = 0x1400000        # ns size
         self.ncap = 0x1400000        # ns capacity
-        self.ctrl_id = self.get_ctrl_id()
         self.lba_format_list = []
         self.ms_list = []
         self.lbads_list = []
         self.test_log_dir = self.log_dir + "/" + self.__class__.__name__
         self.setup_log_dir(self.__class__.__name__)
-        self.delete_all_ns()
-        time.sleep(1)
 
     def __del__(self):
         """
@@ -82,6 +79,8 @@ class TestNVMeFormatCmd(TestNVMe):
             - Atttach it to controller.
             - Call super class's destructor.
         """
+        if self.get_oacs_namespace_mgmt() == 0:
+            return
         assert_equal(self.create_and_validate_ns(self.default_nsid,
                                                  self.nsze,
                                                  self.ncap,
@@ -92,6 +91,9 @@ class TestNVMeFormatCmd(TestNVMe):
 
     def attach_detach_primary_ns(self):
         """ Extract supported format information using default namespace """
+        self.ctrl_id = self.get_ctrl_id()
+        self.delete_all_ns()
+        time.sleep(1)
         assert_equal(self.create_and_validate_ns(self.default_nsid,
                                                  self.nsze,
                                                  self.ncap,
@@ -123,6 +125,8 @@ class TestNVMeFormatCmd(TestNVMe):
     def test_format_ns(self):
         """ Testcase main """
         # extract the supported format information.
+        if self.get_oacs_namespace_mgmt() == 0:
+            return
         self.attach_detach_primary_ns()
 
         # iterate through all supported format
-- 
2.13.7
