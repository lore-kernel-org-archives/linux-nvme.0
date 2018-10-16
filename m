From: Dong.Ho@wdc.com (Dong Ho)
Date: Tue, 16 Oct 2018 19:26:22 +0000
Subject: [PATCH 2/2] nvme-cli: add help text for get and set timestamp commands
In-Reply-To: <1539743178-6573-1-git-send-email-dong.ho@wdc.com>
References: <1539743178-6573-1-git-send-email-dong.ho@wdc.com>
Message-ID: <1539743178-6573-2-git-send-email-dong.ho@wdc.com>

---
 Documentation/nvme-get-timestamp.txt | 50 ++++++++++++++++++++++++++++++++++++
 Documentation/nvme-set-timestamp.txt | 46 +++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/nvme-get-timestamp.txt
 create mode 100644 Documentation/nvme-set-timestamp.txt

diff --git a/Documentation/nvme-get-timestamp.txt b/Documentation/nvme-get-timestamp.txt
new file mode 100644
index 0000000..a490fe9
--- /dev/null
+++ b/Documentation/nvme-get-timestamp.txt
@@ -0,0 +1,50 @@
+nvme-get-timestamp(1)
+=====================
+
+NAME
+----
+nvme-get-timestamp - Gets the timestamp feature ID data from the nvme controller.
+
+SYNOPSIS
+--------
+[verse]
+'nvme get-timestamp' <device>
+
+DESCRIPTION
+-----------
+Gets the timestamp feature id data from the NVMe controller.  The <device> parameter
+is mandatory and must be an NVMe character device (ex: /dev/nvme0).
+
+Returns the current timestamp value along the Timestamp Origin and Synch bits.  
+
+If the origin field is set to 000b, then the returned timestamp value is set to the 
+time in milliseconds since the last controller level reset.  If the origin field is 
+set to 0001b, then the returned timestamp value is set to the last timestamp value
+set by the host plus the time milliseconds since the timestamp was set.
+
+The Origin/Synch field is a byte in length with bits defined as follows:
+
+*  Bits 07:04  Reserved 
+*  Bits 03:01  Timestamp Origin
+**               000b - The timestamp field was initialized to '0' by a Controller Level Reset
+**               001b - The timestamp field was initialized with a value using the set features command.
+**               010b-111b - Reserved
+*  Bit  00     Synch
+**               0b - The controller counted time in milliseconds continuously since the timestamp value was initialized.
+**               1b - The controller may have stopped counting during vendor specific intervals after the timestamp value was initialized.
+                                           
+OPTIONS
+-------
+None
+
+EXAMPLES
+--------
+* Gets the timestamp feature id data from the NVMe controller.
++
+------------
+# nvme get-timestamp /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Documentation/nvme-set-timestamp.txt b/Documentation/nvme-set-timestamp.txt
new file mode 100644
index 0000000..bcaacfc
--- /dev/null
+++ b/Documentation/nvme-set-timestamp.txt
@@ -0,0 +1,46 @@
+nvme-set-timestamp(1)
+=====================
+
+NAME
+----
+nvme-set-timestamp - Sets a timestamp value in the nvme controller.
+
+SYNOPSIS
+--------
+[verse]
+'nvme set-timestamp' <device> [--timestamp=<timestamp> | -t <timestamp>]
+
+DESCRIPTION
+-----------
+Sets a timestamp value in NVMe controller.  The timestamp value used must be specified 
+in number of milliseconds.  The <device> parameter is mandatory and must be an NVMe 
+character device (ex: /dev/nvme0).
+
+OPTIONS
+-------
+-t <timestamp>::
+--timestamp=<timestamp>::
+    Timestamp: This field specifies the timestamp (in milliseconds) value to set.  If one
+    is not specified, it will default to the number of milliseconds that have elapsed 
+    since midnight, January 01, 1970.
+
+
+
+EXAMPLES
+--------
+* Sets the default timestamp value (milliseconds elapsed since midnight, January 01, 1970) 
+  in the NVMe controller.
++
+------------
+# nvme set-timestamp /dev/nvme0
+------------
+
+* Sets the timestamp value to 0 in the NVMe controller.
++
+------------
+# nvme set-timestamp /dev/nvme0 -t 0
+------------
+
+NVME
+----
+Part of the nvme-user suite
-- 
1.8.3.1
