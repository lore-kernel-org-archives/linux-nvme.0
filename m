From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 Nov 2016 17:26:27 +0100
Subject: [PATCH 3/3] add a disconnect man page
In-Reply-To: <1479399987-9220-1-git-send-email-hch@lst.de>
References: <1479399987-9220-1-git-send-email-hch@lst.de>
Message-ID: <1479399987-9220-4-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 Documentation/nvme-disconnect.txt | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/nvme-disconnect.txt

diff --git a/Documentation/nvme-disconnect.txt b/Documentation/nvme-disconnect.txt
new file mode 100644
index 0000000..703d901
--- /dev/null
+++ b/Documentation/nvme-disconnect.txt
@@ -0,0 +1,58 @@
+nvme-disconnect(1)
+==================
+
+NAME
+----
+nvme-disconnect - Disonnect one or more Fabrics controller(s).
+
+SYNOPSIS
+--------
+[verse]
+'nvme connect'
+		[--nqn=<subnqn>           | -n <subnqn>]
+		[--device=<device>        | -d <device>]
+
+DESCRIPTION
+-----------
+Disconnects and removes one or more existing NVMe over Fabrics controllers.
+If the --nqn option is specified all controllers connecting to the Subsystem
+identified by subnqn will be removed.  If the --device option is specified
+the controller specified by the --device option will be removed.
+
+OPTIONS
+-------
+-n <subnqn>::
+--nqn <subnqn>::
+	Indicates that all controllers for the NVMe subsystems specified
+	should be removed.
+
+-d <device>::
+--device <device>::
+	Indicates that the controller with the specified name should be
+	removed.
+
+EXAMPLES
+--------
+* Disconnect all controllers for a subsystem named
+nqn.2014-08.com.example:nvme:nvm-subsystem-sn-d78432:
++
+------------
+# nvme disconnect --nqn=nqn.2014-08.com.example:nvme:nvm-subsystem-sn-d78432
+------------
+
+* Disconnect the controller nvme4
++
+------------
+# nvme disconnect --device=nvme4
+------------
+
+------------
+
+SEE ALSO
+--------
+nvme-connect(1)
+
+
+NVME
+----
+Part of the nvme-user suite
-- 
2.1.4
