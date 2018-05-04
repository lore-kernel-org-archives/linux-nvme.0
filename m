From: jeff.lien@wdc.com (Jeff Lien)
Date: Fri,  4 May 2018 10:20:08 -0500
Subject: [PATCH] NVMe-CLI Add tests for fw-log, id-ctrl and id-ns commands.
Message-ID: <20180504152008.1253-1-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 tests/nvme_fw_log_test.py  | 130 ++++++++++++++++++++++++++++++++++++++++++
 tests/nvme_id_ctrl_test.py | 137 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme_id_ns_test.py   | 134 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 401 insertions(+)
 create mode 100644 tests/nvme_fw_log_test.py
 create mode 100644 tests/nvme_id_ctrl_test.py
 create mode 100644 tests/nvme_id_ns_test.py

diff --git a/tests/nvme_fw_log_test.py b/tests/nvme_fw_log_test.py
new file mode 100644
index 0000000..40b2685
--- /dev/null
+++ b/tests/nvme_fw_log_test.py
@@ -0,0 +1,130 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Madhusudhana S.J <madhusudhana.sj at wdc.com>
+#
+"""
+NVMe nvme-fw-log  Testcase:-
+
+    1. Send NVMe Firmware log page request, returns result and log
+    2. Retrieves the NVMe Firmware log page from an NVMe device and report format to normal, json, or binary
+    3. Retrieve the firmware log for the specified device in either decoded format(default) or binary
+"""
+
+import subprocess
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+import time
+
+class TestNVMe_fw_log(TestNVMe):
+
+	"""
+	Represents Firmware log testcase.
+
+        - Attributes:
+                     - nvme-fw-log : list of Firmware log page request actions.     
+	"""
+	def __init__(self):
+         	""" Pre Section for TestNVMe_fw_log mandatory Actions """
+		TestNVMe.__init__(self)
+        	self.setup_log_dir(self.__class__.__name__)
+        	self.fw_log_action_list = ["--raw-binary", "-b"]
+        	self.fw_log_outtput_format_list = ["normal", "json","binary"]
+	
+	def __del__(self):
+		""" Post Section for TestNVMe_fw_log mandatory Actions
+
+            	     Call super class's destructor.
+		"""
+		TestNVMe.__del__(self)
+ 
+	def get_fw_log(self):
+        	""" Wrapper for NVMe fw_log  command
+                - Args:
+                       - fw-log: NVMe character device to be used to check the fw-log page.
+                - Returns: None
+        	"""
+        	get_fw_log_cmd = "nvme fw-log /dev/nvme0"
+		print "nvme fw-log command :",get_fw_log_cmd, "\n"
+		proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
+		fw_log_output = proc.communicate()[0]
+		print "command_output : "
+		print fw_log_output, "\n"
+        	assert_equal(proc.wait(), 0)
+ 
+	def get_mandetory_fw_log_action(self,fw_log_action):
+			""" Wrapper for NVMe fw-log  command 
+				- Args: NVMe character device ex: /dev/nvme0
+				- nvme-fw-log : list of Firmware log page request actions.
+				- Returns: None
+			"""
+			print "fw_log_action value:", fw_log_action
+			if str(fw_log_action) in ["-b","--raw-binary"]:
+				get_fw_log_cmd = "nvme fw-log /dev/nvme0" + " " +  fw_log_action + " | hexdump -C"
+				print "get_fw_log_cmd with binary :",get_fw_log_cmd,"\n"
+				proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
+				fw_log_output = proc.communicate()[0]
+				print "command_output : "
+				print fw_log_output, "\n"
+				assert_equal(proc.wait(), 0)
+			else:
+				get_fw_log_cmd = "nvme fw-log /dev/nvme0" 
+				print "command executing to retrive fw log :",get_fw_log_cmd
+               			proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
+                		fw_log_output = proc.communicate()[0]
+				print "command_output : "
+				print fw_log_output, "\n"
+                        assert_equal(proc.wait(), 0)
+	def get_mandetory_fw_log_outputformat(self,fw_log_outputformat):
+                        """ Wrapper for NVMe FW-LOG command
+                                - Args:
+                                - fw_log_action : output format  to be used with fw-log command.
+                                - Returns: None
+                        """
+                        print "fw_log_outputformat Type:", fw_log_outputformat
+                        if str(fw_log_outputformat) == "binary":
+                                get_fw_log_cmd = "nvme fw-log /dev/nvme0 " + " --output-format=binary | hexdump -C"
+                                print "get_fw_log command with output format:",get_fw_log_cmd
+				print "\n"
+                                proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
+                                fw_log_output = proc.communicate()[0]
+                                print "command_output : "
+                                print fw_log_output, "\n"
+                                assert_equal(proc.wait(), 0)
+                        else:
+                                get_fw_log_cmd = "nvme fw-log /dev/nvme0 " + " --output-format=" + fw_log_outputformat
+                                print "command executing to get fw_log of the given NVMe device :",get_fw_log_cmd
+                                proc = subprocess.Popen(get_fw_log_cmd,shell=True,stdout=subprocess.PIPE)
+                                fw_log_output = proc.communicate()[0]
+                                print "command_output : "
+                                print fw_log_output, "\n"
+                                assert_equal(proc.wait(), 0)
+
+	def test_fw_log_actions(self):
+        		""" Testcase main """ 
+			print "calling main function ..!"
+			self.get_fw_log()
+       			for fw_log_action in self.fw_log_action_list:
+				if str(fw_log_action) in ["-b", "--raw-binary"]:
+					self.get_mandetory_fw_log_action(fw_log_action)
+				else:
+					self.get_mandetory_fw_log_action(fw_log_action)
+			for fw_log_outputformat in self.fw_log_outtput_format_list:
+				if str(fw_log_outputformat) == "binary":
+					self.get_mandetory_fw_log_outputformat(fw_log_outputformat)
+				else:
+					self.get_mandetory_fw_log_outputformat(fw_log_outputformat)
diff --git a/tests/nvme_id_ctrl_test.py b/tests/nvme_id_ctrl_test.py
new file mode 100644
index 0000000..b6b0d89
--- /dev/null
+++ b/tests/nvme_id_ctrl_test.py
@@ -0,0 +1,137 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Madhusudhana S.J <madhusudhana.sj at wdc.com>
+#
+"""
+NVMe Identify Controller Testcase:-
+
+    1. Send NVMe Identify Controller, return result and structure
+    2. Send an Identify Controller command to the given device and report information about the specified controller 
+       in human-readable or binary format. 
+       May also return vendor-specific controller attributes in hex-dump if requested.
+
+"""
+
+import subprocess
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+import time
+
+class TestNVMeIdentifyIdctrlActions(TestNVMe):
+
+	"""
+	Represent Identify Controller testcase.
+
+        - Attributes:
+                     - Identify Controller : list of Identify Controller actions.     
+	"""
+	def __init__(self):
+         	""" Pre Section for Identify Controller mandatory Actions """
+		TestNVMe.__init__(self)
+        	self.setup_log_dir(self.__class__.__name__)
+        	self.identifycontroller__action_list = ["--human-readable","--raw-binary","--vendor-specific","-b"]
+        	self.identifycontroller__outtput_format_list = ["normal", "json","binary"]
+	
+	def __del__(self):
+		""" Post Section for TestNVMeIdentify Controller mandatory Actions
+
+            	     Call super class's destructor.
+		"""
+		TestNVMe.__del__(self)
+ 
+	def get_identifycontroller(self):
+        	""" Wrapper for NVMe Identify Controller command
+                - Args:
+                       - Identify Controller : sends an identify controller command to device and  
+                         provides the result and returned structure
+                - Returns: None
+        	"""
+        	get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" 
+		print "Identify Controller command:",get_identifycontroller_cmd, "\n"
+		proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
+		identifycontroller_output = proc.communicate()[0]
+		print "command_output : "
+		print identifycontroller_output, "\n"
+        	assert_equal(proc.wait(), 0)
+ 
+	def get_mandetory_identifycontroller_action(self,identifycontroller_action):
+			""" Wrapper for NVMe Identify Controller  command 
+				- Args:
+				- identifycontroller_action : action id to be used with identifycontroller_action  command.
+				- Returns: None
+			"""
+			print "identifycontroller_action value:", identifycontroller_action
+			if str(identifycontroller_action) in ["-b","--raw-binary"]:
+				get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" + \
+                                                             " " + identifycontroller_action + " | hexdump -C"
+				print "get_identifycontroller_cmd with binary :",get_identifycontroller_cmd,"\n"
+				proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
+				identifycontroller_output = proc.communicate()[0]
+				print "command_output : "
+				print identifycontroller_output, "\n"
+				assert_equal(proc.wait(), 0)
+			else:
+				get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" \
+				                            + " " + identifycontroller_action 
+				print "command executing to get id_ctrl of the given device :",get_identifycontroller_cmd
+               			proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
+                		identifycontroller_output = proc.communicate()[0]
+				print "command_output : "
+				print identifycontroller_output, "\n"
+                		assert_equal(proc.wait(), 0)
+	def get_mandetory_identifycontroller_outputformat(self,identifycontroller_outputformat):
+                        """ Wrapper for NVMe Identify Controller command
+                                - Args:
+                                - identifycontroller_action : output format  to be used with identifycontroller  command.
+                                - Returns: None
+                        """
+                        print "identifycontroller_outputformat Type:", identifycontroller_outputformat
+                        if str(identifycontroller_outputformat) == "binary":
+                                get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" + \
+                                                             " --output-format=binary | hexdump -C"
+                                print "get_identifycontroller_cmd with binary output format:",get_identifycontroller_cmd
+				print "\n"
+                                proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
+                                identifycontroller_output = proc.communicate()[0]
+                                print "command_output : "
+                                print identifycontroller_output, "\n"
+                                assert_equal(proc.wait(), 0)
+                        else:
+                                get_identifycontroller_cmd = "nvme id-ctrl /dev/nvme0" \
+                                                             + " --output-format=" + identifycontroller_outputformat
+                                print "command executing to get id_ctrl of the given device :",get_identifycontroller_cmd
+                                proc = subprocess.Popen(get_identifycontroller_cmd,shell=True,stdout=subprocess.PIPE)
+                                identifycontroller_output = proc.communicate()[0]
+                                print "command_output : "
+                                print identifycontroller_output, "\n"
+                                assert_equal(proc.wait(), 0)
+
+	def test_get_identify_controller_actions(self):
+        		""" Testcase main """ 
+			print "calling main function ..!"
+			self.get_identifycontroller()
+       			for identifycontroller_action in self.identifycontroller__action_list:
+				if str(identifycontroller_action) in ["-b", "--raw-binary"]:
+					self.get_mandetory_identifycontroller_action(identifycontroller_action)
+				else:
+					self.get_mandetory_identifycontroller_action(identifycontroller_action)
+			for identifycontroller_outputformat in self.identifycontroller__outtput_format_list:
+				if str(identifycontroller_outputformat) == "binary":
+					self.get_mandetory_identifycontroller_outputformat(identifycontroller_outputformat)
+				else:
+					self.get_mandetory_identifycontroller_outputformat(identifycontroller_outputformat)
diff --git a/tests/nvme_id_ns_test.py b/tests/nvme_id_ns_test.py
new file mode 100644
index 0000000..1b8e70c
--- /dev/null
+++ b/tests/nvme_id_ns_test.py
@@ -0,0 +1,134 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Madhusudhana S.J <madhusudhana.sj at wdc.com>
+#
+"""
+NVMe Identify Namespace  Testcase:-
+
+    1. Send an Identify Namespace command to the given device.
+    2. Specified namespace in either human-readable,--vendor-specific or binary format.
+    3. Specified namespace in --output-format  -o in normal|json|binary
+"""
+
+import subprocess
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+import time
+
+class TestNVMeIdentifyNamespaceActions(TestNVMe):
+
+	"""
+	Represents Identify Namespace testcase.
+
+        - Attributes:
+                     - Identify Namespace : list of Identify Namespace actions.     
+	"""
+	def __init__(self):
+         	""" Pre Section for TestNVMeIdentify Namespace mandatory Actions """
+		TestNVMe.__init__(self)
+        	self.setup_log_dir(self.__class__.__name__)
+        	self.identifynamespace__action_list = ["--human-readable","--raw-binary","--vendor-specific","-b"]
+        	self.identifynamespace__outtput_format_list = ["normal", "json","binary"]
+	
+	def __del__(self):
+		""" Post Section for TestNVMeIdentify Namespace mandatory Actions
+
+            	     Call super class's destructor.
+		"""
+		TestNVMe.__del__(self)
+ 
+	def get_identifynamespace(self):
+        	""" Wrapper for NVMe Identify Namespace command
+                - Args:
+                       - Identify Namespace : Namespace id to be used to check the Identify Namespace.
+                - Returns: None
+        	"""
+        	get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" + str(self.default_nsid) 
+		print "Identify Namespace command:",get_identifynamespace_cmd, "\n"
+		proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
+		identifynamespace_output = proc.communicate()[0]
+		print "command_output : "
+		print identifynamespace_output, "\n"
+        	assert_equal(proc.wait(), 0)
+ 
+	def get_mandetory_identifynamespace_action(self,identifynamespace_action):
+			""" Wrapper for NVMe Identify Namespace  command 
+				- Args:
+				- identifynamespace_action : action id to be used with identifynamespace_action  command.
+				- Returns: None
+			"""
+			print "identifynamespace_action value:", identifynamespace_action
+			if str(identifynamespace_action) in ["-b","--raw-binary"]:
+				get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" \
+                                + str(self.default_nsid) + " " + identifynamespace_action + " | hexdump -C"
+				print "get_identifynamespace_cmd with --binary :",get_identifynamespace_cmd,"\n"
+				proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
+				identifynamespace_output = proc.communicate()[0]
+				print "command_output : "
+				print identifynamespace_output, "\n"
+				assert_equal(proc.wait(), 0)
+			else:
+				get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" \
+				+ str(self.default_nsid) + " " + identifynamespace_action 
+				print "command executing to get id_ns of the given namespace :",get_identifynamespace_cmd
+               			proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
+                		identifynamespace_output = proc.communicate()[0]
+				print "command_output : "
+				print identifynamespace_output, "\n"
+                		assert_equal(proc.wait(), 0)
+	def get_mandetory_identifynamespace_outputformat(self,identifynamespace_outputformat):
+                        """ Wrapper for NVMe Identify Namespace command
+                                - Args:
+                                - identifynamespace_action : output format  to be used with identifynamespace  command.
+                                - Returns: None
+                        """
+                        print "identifynamespace_outputformat Type:", identifynamespace_outputformat
+                        if str(identifynamespace_outputformat) == "binary":
+                                get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" \
+                                + str(self.default_nsid) + " --output-format=binary | hexdump -C"
+                                print "get_identifynamespace_cmd with binary output format:",get_identifynamespace_cmd
+				print "\n"
+                                proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
+                                identifynamespace_output = proc.communicate()[0]
+                                print "command_output : "
+                                print identifynamespace_output, "\n"
+                                assert_equal(proc.wait(), 0)
+                        else:
+                                get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" \
+                                + str(self.default_nsid) + " --output-format=" + identifynamespace_outputformat
+                                print "command executing to get id_ns of the given namespace :",get_identifynamespace_cmd
+                                proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
+                                identifynamespace_output = proc.communicate()[0]
+                                print "command_output : "
+                                print identifynamespace_output, "\n"
+                                assert_equal(proc.wait(), 0)
+
+	def test_get_identify_namespace_actions(self):
+        		""" Testcase main """ 
+			print "calling main function ..!"
+			self.get_identifynamespace()
+       			for identifynamespace_action in self.identifynamespace__action_list:
+				if str(identifynamespace_action) in ["-b", "--raw-binary"]:
+					self.get_mandetory_identifynamespace_action(identifynamespace_action)
+				else:
+					self.get_mandetory_identifynamespace_action(identifynamespace_action)
+			for identifynamespace_outputformat in self.identifynamespace__outtput_format_list:
+				if str(identifynamespace_outputformat) == "binary":
+					self.get_mandetory_identifynamespace_outputformat(identifynamespace_outputformat)
+				else:
+					self.get_mandetory_identifynamespace_outputformat(identifynamespace_outputformat)
-- 
2.14.2.746.g8fb8a94
