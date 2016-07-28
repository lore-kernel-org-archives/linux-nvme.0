From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Thu, 28 Jul 2016 10:37:06 -0700
Subject: [PATCH] nvmetcli: More refined cleanup of README
Message-ID: <1469727426-1178-1-git-send-email-james_p_freyensee@linux.intel.com>

Adds a few more tidbits to the README file, minus
discovery/referral info (still WIP).

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 README | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 82d63ab..4c3daac 100644
--- a/README
+++ b/README
@@ -12,6 +12,11 @@ https://github.com/agrover/configshell-fb first.
 nvmetcli can be run directly from the source directory or installed
 using setup.py.
 
+If you choose to use the provided exe 'nvmetcli', you can move
+'nvmetcli' to /usr/sbin and the file 'nvmet.service' to
+/lib/systemd/system for global management of NVMe target setups
+for the machine.
+
 Common Package Dependencies and Problems
 -----------------------------------------
 nvmetcli uses the 'python-six' and 'pyparsing' packages
@@ -53,6 +58,13 @@ The following walks through an example using interactive mode.
 ...> create hostnqn
 
 #
+# remove access of a subsystem by deleting the Host NQN
+#
+
+...> cd /subsystems/testnqn/allowed_hosts/
+...> delete hostnqn
+
+#
 # Alternatively this allows any host to connect to the subsystsem.  Only
 # use this in tightly controller environments:
 #
@@ -65,7 +77,7 @@ The following walks through an example using interactive mode.
 # unused one will be used.
 #
 
-...> cd namespaces
+...> cd /subsystems/testnqn/namespaces
 ...> create 1
 ...> cd 1
 ...> set device path=/dev/nvme0n1
-- 
2.4.3
