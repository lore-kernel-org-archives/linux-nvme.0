From: Dong.Ho@wdc.com (Dong Ho)
Date: Fri, 21 Sep 2018 18:10:13 +0000
Subject: [PATCH 3/4] nvme-cli: tests: fix id_ns test coding style
Message-ID: <1537578607-14294-1-git-send-email-dong.ho@wdc.com>

Simplified and fixed coding style to conform with the style of all other tests.

Signed-off-by: Dong Ho <dong.ho at wdc.com>
---
 tests/nvme_id_ns_test.py | 159 +++++++++++++++++------------------------------
 1 file changed, 56 insertions(+), 103 deletions(-)

diff --git a/tests/nvme_id_ns_test.py b/tests/nvme_id_ns_test.py
index 1b8e70c..1cfd396 100644
--- a/tests/nvme_id_ns_test.py
+++ b/tests/nvme_id_ns_test.py
@@ -16,119 +16,72 @@
 # MA  02110-1301, USA.
 #
 #   Author: Madhusudhana S.J <madhusudhana.sj at wdc.com>
+#   Author: Dong Ho <dong.ho at wdc.com>
 #
 """
-NVMe Identify Namespace  Testcase:-
+NVme Identify Namespace Testcase:-
 
-    1. Send an Identify Namespace command to the given device.
-    2. Specified namespace in either human-readable,--vendor-specific or binary format.
-    3. Specified namespace in --output-format  -o in normal|json|binary
+    1. Execute id-ns on a namespace
+    2. Execute id-ns on all namespaces
 """
 
 import subprocess
 from nose.tools import assert_equal
 from nvme_test import TestNVMe
-import time
 
-class TestNVMeIdentifyNamespaceActions(TestNVMe):
 
-	"""
-	Represents Identify Namespace testcase.
+class TestNVMeIdentifyNamespace(TestNVMe):
 
-        - Attributes:
-                     - Identify Namespace : list of Identify Namespace actions.     
-	"""
-	def __init__(self):
-         	""" Pre Section for TestNVMeIdentify Namespace mandatory Actions """
-		TestNVMe.__init__(self)
-        	self.setup_log_dir(self.__class__.__name__)
-        	self.identifynamespace__action_list = ["--human-readable","--raw-binary","--vendor-specific","-b"]
-        	self.identifynamespace__outtput_format_list = ["normal", "json","binary"]
-	
-	def __del__(self):
-		""" Post Section for TestNVMeIdentify Namespace mandatory Actions
+    """
+    Represents Identify Namesepace testcase
+    """
 
-            	     Call super class's destructor.
-		"""
-		TestNVMe.__del__(self)
- 
-	def get_identifynamespace(self):
-        	""" Wrapper for NVMe Identify Namespace command
-                - Args:
-                       - Identify Namespace : Namespace id to be used to check the Identify Namespace.
-                - Returns: None
-        	"""
-        	get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" + str(self.default_nsid) 
-		print "Identify Namespace command:",get_identifynamespace_cmd, "\n"
-		proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
-		identifynamespace_output = proc.communicate()[0]
-		print "command_output : "
-		print identifynamespace_output, "\n"
-        	assert_equal(proc.wait(), 0)
- 
-	def get_mandetory_identifynamespace_action(self,identifynamespace_action):
-			""" Wrapper for NVMe Identify Namespace  command 
-				- Args:
-				- identifynamespace_action : action id to be used with identifynamespace_action  command.
-				- Returns: None
-			"""
-			print "identifynamespace_action value:", identifynamespace_action
-			if str(identifynamespace_action) in ["-b","--raw-binary"]:
-				get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" \
-                                + str(self.default_nsid) + " " + identifynamespace_action + " | hexdump -C"
-				print "get_identifynamespace_cmd with --binary :",get_identifynamespace_cmd,"\n"
-				proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
-				identifynamespace_output = proc.communicate()[0]
-				print "command_output : "
-				print identifynamespace_output, "\n"
-				assert_equal(proc.wait(), 0)
-			else:
-				get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" \
-				+ str(self.default_nsid) + " " + identifynamespace_action 
-				print "command executing to get id_ns of the given namespace :",get_identifynamespace_cmd
-               			proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
-                		identifynamespace_output = proc.communicate()[0]
-				print "command_output : "
-				print identifynamespace_output, "\n"
-                		assert_equal(proc.wait(), 0)
-	def get_mandetory_identifynamespace_outputformat(self,identifynamespace_outputformat):
-                        """ Wrapper for NVMe Identify Namespace command
-                                - Args:
-                                - identifynamespace_action : output format  to be used with identifynamespace  command.
-                                - Returns: None
-                        """
-                        print "identifynamespace_outputformat Type:", identifynamespace_outputformat
-                        if str(identifynamespace_outputformat) == "binary":
-                                get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" \
-                                + str(self.default_nsid) + " --output-format=binary | hexdump -C"
-                                print "get_identifynamespace_cmd with binary output format:",get_identifynamespace_cmd
-				print "\n"
-                                proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
-                                identifynamespace_output = proc.communicate()[0]
-                                print "command_output : "
-                                print identifynamespace_output, "\n"
-                                assert_equal(proc.wait(), 0)
-                        else:
-                                get_identifynamespace_cmd = "nvme id-ns /dev/nvme0 --namespace-id=" \
-                                + str(self.default_nsid) + " --output-format=" + identifynamespace_outputformat
-                                print "command executing to get id_ns of the given namespace :",get_identifynamespace_cmd
-                                proc = subprocess.Popen(get_identifynamespace_cmd,shell=True,stdout=subprocess.PIPE)
-                                identifynamespace_output = proc.communicate()[0]
-                                print "command_output : "
-                                print identifynamespace_output, "\n"
-                                assert_equal(proc.wait(), 0)
+    def __init__(self):
+        """ Pre Section for TestNVMeIdentifyNamespace. """
+        TestNVMe.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
+        self.ns_list = self.get_ns_list()
 
-	def test_get_identify_namespace_actions(self):
-        		""" Testcase main """ 
-			print "calling main function ..!"
-			self.get_identifynamespace()
-       			for identifynamespace_action in self.identifynamespace__action_list:
-				if str(identifynamespace_action) in ["-b", "--raw-binary"]:
-					self.get_mandetory_identifynamespace_action(identifynamespace_action)
-				else:
-					self.get_mandetory_identifynamespace_action(identifynamespace_action)
-			for identifynamespace_outputformat in self.identifynamespace__outtput_format_list:
-				if str(identifynamespace_outputformat) == "binary":
-					self.get_mandetory_identifynamespace_outputformat(identifynamespace_outputformat)
-				else:
-					self.get_mandetory_identifynamespace_outputformat(identifynamespace_outputformat)
+    def __del__(self):
+        """
+        Post Section for TestNVMeIdentifyNamespace
+
+            - Call super class's destructor.
+        """
+        TestNVMe.__del__(self)
+
+    def get_id_ns(self, nsid):
+        """
+        Wrapper for executing nvme id-ns on a namespace.
+            - Args:
+                - nsid : namespace id to get info from.
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        err = 0
+        id_ns_cmd = "nvme id-ns " + self.ctrl + "n" + str(nsid)
+        proc = subprocess.Popen(id_ns_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        id_ns_output = proc.communicate()[0]
+        print id_ns_output + "\n"
+        err = proc.wait()
+        return err
+
+    def get_id_ns_all(self):
+        """
+        Wrapper for executing nvme id-ns on all namespaces.
+            - Args:
+                - None
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        err = 0
+        for namespace  in self.ns_list:
+            err = self.get_id_ns(str(namespace).split("x", 1)[1])
+        return err
+
+    def test_id_ns(self):
+        """ Testcase main """
+        assert_equal(self.get_id_ns(1), 0)
+        assert_equal(self.get_id_ns_all(), 0)
-- 
1.8.3.1
