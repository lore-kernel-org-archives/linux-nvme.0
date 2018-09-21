From: Dong.Ho@wdc.com (Dong Ho)
Date: Fri, 21 Sep 2018 18:06:51 +0000
Subject: [PATCH 1/4] nvme-cli: tests: fix fw_log test coding style
Message-ID: <1537578355-6828-1-git-send-email-dong.ho@wdc.com>

Simplified and fixed coding style to conform with the style of all other tests.

Signed-off-by: Dong Ho <dong.ho at wdc.com>
---
 tests/nvme_fw_log_test.py | 138 +++++++++++++---------------------------------
 1 file changed, 39 insertions(+), 99 deletions(-)

diff --git a/tests/nvme_fw_log_test.py b/tests/nvme_fw_log_test.py
index 40b2685..cf01307 100644
--- a/tests/nvme_fw_log_test.py
+++ b/tests/nvme_fw_log_test.py
@@ -16,115 +16,55 @@
 # MA  02110-1301, USA.
 #
 #   Author: Madhusudhana S.J <madhusudhana.sj at wdc.com>
+#   Author: Dong Ho <dong.ho at wdc.com>
 #
 """
-NVMe nvme-fw-log  Testcase:-
+NVMe Firmware Log Testcase :-
 
-    1. Send NVMe Firmware log page request, returns result and log
-    2. Retrieves the NVMe Firmware log page from an NVMe device and report format to normal, json, or binary
-    3. Retrieve the firmware log for the specified device in either decoded format(default) or binary
+    1. Execute fw-log on a device.
 """
 
 import subprocess
 from nose.tools import assert_equal
 from nvme_test import TestNVMe
-import time
 
-class TestNVMe_fw_log(TestNVMe):
 
-	"""
-	Represents Firmware log testcase.
+class TestNVMeFwLogCmd(TestNVMe):
 
-        - Attributes:
-                     - nvme-fw-log : list of Firmware log page request actions.     
-	"""
-	def __init__(self):
-         	""" Pre Section for TestNVMe_fw_log mandatory Actions """
-		TestNVMe.__init__(self)
-        	self.setup_log_dir(self.__class__.__name__)
-        	self.fw_log_action_list = ["--raw-binary", "-b"]
-        	self.fw_log_outtput_format_list = ["normal", "json","binary"]
-	
-	def __del__(self):
-		""" Post Section for TestNVMe_fw_log mandatory Actions
+    """
+    Represents NVMe Firmware Log test.
+    """
 
-            	     Call super class's destructor.
-		"""
-		TestNVMe.__del__(self)
- 
-	def get_fw_log(self):
-        	""" Wrapper for NVMe fw_log  command
-                - Args:
-                       - fw-log: NVMe character device to be used to check the fw-log page.
-                - Returns: None
-        	"""
-        	get_fw_log_cmd = "nvme fw-log /dev/nvme0"
-		print "nvme fw-log command :",get_fw_log_cmd, "\n"
-		proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
-		fw_log_output = proc.communicate()[0]
-		print "command_output : "
-		print fw_log_output, "\n"
-        	assert_equal(proc.wait(), 0)
- 
-	def get_mandetory_fw_log_action(self,fw_log_action):
-			""" Wrapper for NVMe fw-log  command 
-				- Args: NVMe character device ex: /dev/nvme0
-				- nvme-fw-log : list of Firmware log page request actions.
-				- Returns: None
-			"""
-			print "fw_log_action value:", fw_log_action
-			if str(fw_log_action) in ["-b","--raw-binary"]:
-				get_fw_log_cmd = "nvme fw-log /dev/nvme0" + " " +  fw_log_action + " | hexdump -C"
-				print "get_fw_log_cmd with binary :",get_fw_log_cmd,"\n"
-				proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
-				fw_log_output = proc.communicate()[0]
-				print "command_output : "
-				print fw_log_output, "\n"
-				assert_equal(proc.wait(), 0)
-			else:
-				get_fw_log_cmd = "nvme fw-log /dev/nvme0" 
-				print "command executing to retrive fw log :",get_fw_log_cmd
-               			proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
-                		fw_log_output = proc.communicate()[0]
-				print "command_output : "
-				print fw_log_output, "\n"
-                        assert_equal(proc.wait(), 0)
-	def get_mandetory_fw_log_outputformat(self,fw_log_outputformat):
-                        """ Wrapper for NVMe FW-LOG command
-                                - Args:
-                                - fw_log_action : output format  to be used with fw-log command.
-                                - Returns: None
-                        """
-                        print "fw_log_outputformat Type:", fw_log_outputformat
-                        if str(fw_log_outputformat) == "binary":
-                                get_fw_log_cmd = "nvme fw-log /dev/nvme0 " + " --output-format=binary | hexdump -C"
-                                print "get_fw_log command with output format:",get_fw_log_cmd
-				print "\n"
-                                proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
-                                fw_log_output = proc.communicate()[0]
-                                print "command_output : "
-                                print fw_log_output, "\n"
-                                assert_equal(proc.wait(), 0)
-                        else:
-                                get_fw_log_cmd = "nvme fw-log /dev/nvme0 " + " --output-format=" + fw_log_outputformat
-                                print "command executing to get fw_log of the given NVMe device :",get_fw_log_cmd
-                                proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
-                                fw_log_output = proc.communicate()[0]
-                                print "command_output : "
-                                print fw_log_output, "\n"
-                                assert_equal(proc.wait(), 0)
+    def __init__(self):
+        """ Pre Section for TestNVMeFwLogCmd. """
+        TestNVMe.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
 
-	def test_fw_log_actions(self):
-        		""" Testcase main """ 
-			print "calling main function ..!"
-			self.get_fw_log()
-       			for fw_log_action in self.fw_log_action_list:
-				if str(fw_log_action) in ["-b", "--raw-binary"]:
-					self.get_mandetory_fw_log_action(fw_log_action)
-				else:
-					self.get_mandetory_fw_log_action(fw_log_action)
-			for fw_log_outputformat in self.fw_log_outtput_format_list:
-				if str(fw_log_outputformat) == "binary":
-					self.get_mandetory_fw_log_outputformat(fw_log_outputformat)
-				else:
-					self.get_mandetory_fw_log_outputformat(fw_log_outputformat)
+    def __del__(self):
+        """
+        Post Section for TestNVMeSimpleTestTemplate.
+
+            - Call super class's destructor.
+        """
+        TestNVMe.__del__(self)
+
+    def get_fw_log(self):
+        """ Wrapper for executing nvme fw-log.
+            - Args:
+                - None
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        err = 0
+        fw_log_cmd = "nvme fw-log " + self.ctrl
+        proc = subprocess.Popen(fw_log_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        fw_log_output = proc.communicate()[0]
+        print fw_log_output + "\n"
+        err = proc.wait()
+        return err
+
+    def test_fw_log(self):
+        """ Testcase main """
+        assert_equal(self.get_fw_log(), 0)
-- 
1.8.3.1
