From: Dong.Ho@wdc.com (Dong Ho)
Date: Fri, 21 Sep 2018 18:09:35 +0000
Subject: [PATCH 2/4] nvme-cli: tests: fix id_ctrl test coding style
Message-ID: <1537578567-13036-1-git-send-email-dong.ho@wdc.com>

Simplified and fixed coding style to conform with the style of all other tests.

Signed-off-by: Dong Ho <dong.ho at wdc.com>
---
 tests/nvme_id_ctrl_test.py | 131 +++++++++------------------------------------
 1 file changed, 25 insertions(+), 106 deletions(-)

diff --git a/tests/nvme_id_ctrl_test.py b/tests/nvme_id_ctrl_test.py
index b6b0d89..0caf7b2 100644
--- a/tests/nvme_id_ctrl_test.py
+++ b/tests/nvme_id_ctrl_test.py
@@ -1,3 +1,4 @@
+
 # Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
 #
 # This program is free software; you can redistribute it and/or
@@ -16,122 +17,40 @@
 # MA  02110-1301, USA.
 #
 #   Author: Madhusudhana S.J <madhusudhana.sj at wdc.com>
+#   Author: Dong Ho <dong.ho at wdc.com>
 #
 """
-NVMe Identify Controller Testcase:-
+NVMe Identify ctrl Testcase:-
 
-    1. Send NVMe Identify Controller, return result and structure
-    2. Send an Identify Controller command to the given device and report information about the specified controller 
-       in human-readable or binary format. 
-       May also return vendor-specific controller attributes in hex-dump if requested.
+  1. Execute id-ctrl on ctrl
+  2. Execute id-ctrl vendor specific on ctrl
 
 """
 
-import subprocess
 from nose.tools import assert_equal
 from nvme_test import TestNVMe
-import time
 
-class TestNVMeIdentifyIdctrlActions(TestNVMe):
 
-	"""
-	Represent Identify Controller testcase.
+class TestNVMeIdctrlCmd(TestNVMe):
+
+    """
+    Represents Id ctrl testcase
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeIdctrlCmd. """
+        TestNVMe.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
 
-        - Attributes:
-                     - Identify Controller : list of Identify Controller actions.     
-	"""
-	def __init__(self):
-         	""" Pre Section for Identify Controller mandatory Actions """
-		TestNVMe.__init__(self)
-        	self.setup_log_dir(self.__class__.__name__)
-        	self.identifycontroller__action_list = ["--human-readable","--raw-binary","--vendor-specific","-b"]
-        	self.identifycontroller__outtput_format_list = ["normal", "json","binary"]
-	
-	def __del__(self):
-		""" Post Section for TestNVMeIdentify Controller mandatory Actions
+    def __del__(self):
+        """ Post Section for TestNVMeIdctrlCmd
 
-            	     Call super class's destructor.
-		"""
-		TestNVMe.__del__(self)
- 
-	def get_identifycontroller(self):
-        	""" Wrapper for NVMe Identify Controller command
-                - Args:
-                       - Identify Controller : sends an identify controller command to device and  
-                         provides the result and returned structure
-                - Returns: None
-        	"""
-        	get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" 
-		print "Identify Controller command:",get_identifycontroller_cmd, "\n"
-		proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
-		identifycontroller_output = proc.communicate()[0]
-		print "command_output : "
-		print identifycontroller_output, "\n"
-        	assert_equal(proc.wait(), 0)
- 
-	def get_mandetory_identifycontroller_action(self,identifycontroller_action):
-			""" Wrapper for NVMe Identify Controller  command 
-				- Args:
-				- identifycontroller_action : action id to be used with identifycontroller_action  command.
-				- Returns: None
-			"""
-			print "identifycontroller_action value:", identifycontroller_action
-			if str(identifycontroller_action) in ["-b","--raw-binary"]:
-				get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" + \
-                                                             " " + identifycontroller_action + " | hexdump -C"
-				print "get_identifycontroller_cmd with binary :",get_identifycontroller_cmd,"\n"
-				proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
-				identifycontroller_output = proc.communicate()[0]
-				print "command_output : "
-				print identifycontroller_output, "\n"
-				assert_equal(proc.wait(), 0)
-			else:
-				get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" \
-				                            + " " + identifycontroller_action 
-				print "command executing to get id_ctrl of the given device :",get_identifycontroller_cmd
-               			proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
-                		identifycontroller_output = proc.communicate()[0]
-				print "command_output : "
-				print identifycontroller_output, "\n"
-                		assert_equal(proc.wait(), 0)
-	def get_mandetory_identifycontroller_outputformat(self,identifycontroller_outputformat):
-                        """ Wrapper for NVMe Identify Controller command
-                                - Args:
-                                - identifycontroller_action : output format  to be used with identifycontroller  command.
-                                - Returns: None
-                        """
-                        print "identifycontroller_outputformat Type:", identifycontroller_outputformat
-                        if str(identifycontroller_outputformat) == "binary":
-                                get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" + \
-                                                             " --output-format=binary | hexdump -C"
-                                print "get_identifycontroller_cmd with binary output format:",get_identifycontroller_cmd
-				print "\n"
-                                proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
-                                identifycontroller_output = proc.communicate()[0]
-                                print "command_output : "
-                                print identifycontroller_output, "\n"
-                                assert_equal(proc.wait(), 0)
-                        else:
-                                get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" \
-                                                             + " --output-format=" + identifycontroller_outputformat
-                                print "command executing to get id_ctrl of the given device :",get_identifycontroller_cmd
-                                proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
-                                identifycontroller_output = proc.communicate()[0]
-                                print "command_output : "
-                                print identifycontroller_output, "\n"
-                                assert_equal(proc.wait(), 0)
+            Call super class's destructor.
+        """
+        TestNVMe.__del__(self)
 
-	def test_get_identify_controller_actions(self):
-        		""" Testcase main """ 
-			print "calling main function ..!"
-			self.get_identifycontroller()
-       			for identifycontroller_action in self.identifycontroller__action_list:
-				if str(identifycontroller_action) in ["-b", "--raw-binary"]:
-					self.get_mandetory_identifycontroller_action(identifycontroller_action)
-				else:
-					self.get_mandetory_identifycontroller_action(identifycontroller_action)
-			for identifycontroller_outputformat in self.identifycontroller__outtput_format_list:
-				if str(identifycontroller_outputformat) == "binary":
-					self.get_mandetory_identifycontroller_outputformat(identifycontroller_outputformat)
-				else:
-					self.get_mandetory_identifycontroller_outputformat(identifycontroller_outputformat)
+    def test_id_ctrl(self):
+        """ Testcase main """
+        vendor = True
+        assert_equal(self.get_id_ctrl(), 0)
+        assert_equal(self.get_id_ctrl(vendor), 0)
-- 
1.8.3.1
