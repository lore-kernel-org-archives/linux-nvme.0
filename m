From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Thu, 23 Jun 2016 14:41:16 -0700
Subject: [PATCH] nvmetcli: Updated README to current functionality
Message-ID: <1466718076-8896-1-git-send-email-james_p_freyensee@linux.intel.com>

Also added a referrals/discovery placeholder TBD section.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 README | 93 ++++++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 62 insertions(+), 31 deletions(-)

diff --git a/README b/README
index 41d148f..0fa2775 100644
--- a/README
+++ b/README
@@ -1,32 +1,42 @@
-
 nvmetcli
 ========
-
 This contains the NVMe target admin tool "nvmetcli".  It can either be
 used interactively by invoking it without arguments, or it can be used
 to save, restore or clear the current NVMe target configuration.
 
+Patch Submissions
+-----------------
+Please send to linux-nvme at lists.infradead.org for review and acceptance.
 
 Installation
 ------------
-
 Please install the configshell-fb package from
 https://github.com/agrover/configshell-fb first.
 
-Nvmetcli can be run directly from the source directory or installed
+nvmetcli can be run directly from the source directory or installed
 using setup.py.
 
+Common Package Dependencies and Problems
+-----------------------------------------
+nvmetcli uses the 'python-six' and 'pyparsing' packages
+(running nvmetcli without these packages may produce
+hard-to-decipher errors).
 
-Usage
------
-
-Make sure to run nvmetcli as root, the nvmet module is loaded and
-configfs is mounted on /sys/kernel/config, using:
+Walk-Through Example Usage
+---------------------------
+Make sure to run nvmetcli as root, the nvmet module is loaded,
+your devices are loaded, and configfs is mounted on /sys/kernel/config
+using:
 
 	mount -t configs none /sys/kernel/config
 
-To get started with the interactive mode start nvmetcli without
-arguments.  Then in the nvmetcli prompt type:
+To get started with the interactive mode and the nvmetcli command prompt,
+type (in root):
+
+./nvmetcli
+...>
+
+The following walks through an example using interactive mode.
 
 # 
 # Create a subsystem.  If you do not specify a name a NQN will be generated,
@@ -40,6 +50,7 @@ arguments.  Then in the nvmetcli prompt type:
 #
 # Add access for a specific NVMe Host by it's NQN:
 #
+
 ...> cd /hosts
 ...> create hostnqn
 ...> cd /subsystems/testnqn/allowed_hosts/
@@ -49,16 +60,32 @@ arguments.  Then in the nvmetcli prompt type:
 # Alternatively this allows any host to connect to the subsystsem.  Only
 # use this in tightly controller environments:
 #
+
 ...> cd /subsystems/testnqn/
 ...> set attr allow_any_host=1
 
 #
+# Create a new namespace.  If you do not specify a namespace ID the fist
+# unused one will be used.
+#
+
+...> cd namespaces 
+...> create 1
+...> cd 1
+...> set device path=/dev/nvme0n1
+...> enable
+
+# Note that in the above setup the 'device_nguid' attribute
+# does not have to be set for correct NVMe Target functionality.
+
+#
 # Create a port through which access is allowed, and enable access to
 # a subsystem through it.
 #
 # This creates a trivial loopback port that can be used with nvme-loop on
 # the same machine:
 #
+
 ...> cd /ports/
 ...> create 1
 ...> cd 1/
@@ -67,20 +94,10 @@ arguments.  Then in the nvmetcli prompt type:
 ...> create testnqn
 
 #
-# Create a new namespace.  If you do not specify a namespace ID the fist
-# unused one will be used.
-#
-
-...> cd namespaces 
-...> create 1
-...> cd 1
-...> set device path=/dev/nvme0n1
-...> enable
-
-#
 # Or create a RDMA (IB, RoCE, iWarp) port using IPv4 addressing, 4420 is the
 # IANA assigned port for NVMe over Fabrics using RDMA:
 #
+
 ...> cd /ports/
 ...> create 2
 ...> cd 2/
@@ -91,30 +108,44 @@ arguments.  Then in the nvmetcli prompt type:
 ...> cd subsystems/
 ...> create testnqn
 
+Referrals/Discovery
+--------------------
+TBD
 
 Saving and restoring the configuration
 --------------------------------------
+The saveconfig command in the interactive
+nvmetcli mode saves the current configuration.  For example,
+
+./nvmetcli
+...> saveconfig test.json
+
+You can also invoke a 'save' command, as well as a 'restore'
+and 'clear' command on the Linux command line.  For example,
 
-The saveconfig and restoreconfig commands inside nvmetcli save and restore
-the current configuration, but you can also invoke these commands for the
-command line using the load and restore arguments to nvmetcli.  Without
-an additional file name these operate on /etc/nvmet/config.json.
+(to load an NVMe Target configuration):
+  ./nvmetcli restore test.json
 
+(to clear a current NVMe Target configuration):
+  ./nvmetcli clear test.json
+
+Without an additional file name these operate on /etc/nvmet/config.json.
+
+Example NVMe Target .json files
+--------------------------------------
 To load the loop + explicit host version above do the following:
 
-  ./nvmetcli load loop.json
+  ./nvmetcli restore loop.json
 
 Or to load the rdma + no host authentication version do the following
 after you've ensured that the IP address in rdma.json fits your setup:
 
-  ./nvmetcli load rdma.json
-
-You can also edit the json files directly.
+  ./nvmetcli restore rdma.json
 
+These files can also be edited directly using your favorite editor.
 
 Testing
 -------
-
 nvmetcli comes with a testsuite that tests itself and the kernel configfs
 interface for the NVMe target.  To run it make sure you have nose2 and
 the coverage plugin for it installed and simple run 'make test'.
-- 
2.5.5
