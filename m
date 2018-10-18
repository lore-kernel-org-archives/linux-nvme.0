From: Dong.Ho@wdc.com (Dong Ho)
Date: Thu, 18 Oct 2018 21:06:57 +0000
Subject: [PATCH 2/2] nvme-cli wdc plugin: Add documentation for pfail dump.
In-Reply-To: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>
References: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>
Message-ID: <1539921985-17139-2-git-send-email-dong.ho@wdc.com>

---
 Documentation/nvme-wdc-get-pfail-dump.txt | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/nvme-wdc-get-pfail-dump.txt

diff --git a/Documentation/nvme-wdc-get-pfail-dump.txt b/Documentation/nvme-wdc-get-pfail-dump.txt
new file mode 100644
index 0000000..63688c0
--- /dev/null
+++ b/Documentation/nvme-wdc-get-pfail-dump.txt
@@ -0,0 +1,54 @@
+nvme-wdc-get-pfail-dump(1)
+==========================
+
+NAME
+----
+nvme-wdc-get-pfail-dump - Retrieve WDC device's pfail crash dump.
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc get-pfail-dump' <device> [--output-file=<FILE>, -o <FILE>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends the WDC vendor unique pfail crash dump
+request and saves the result to file. In current implementation pfail crash
+dump is captured if it is present. On success it will save the dump in file 
+with appropriate suffix. Note that this command will clear the available
+dump from the device on success.
+
+The <device> parameter is mandatory NVMe character device (ex: /dev/nvme0).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+OPTIONS
+-------
+-o <FILE>::
+--output-file=<FILE>::
+	Output file; defaults to device serial number followed by "pfail_dump" suffix
+
+EXAMPLES
+--------
+* Gets the pfail crash dump from the device and saves to default file in current directory 
+(e.g. STM00019F3F9_pfail_dump.bin):
++
+------------
+# nvme wdc get-pfail-dump /dev/nvme0
+------------
+* Gets the pfail crash dump from the device and saves to defined file in current directory 
+(e.g. testSTM00019F3F9_pfail_dump.bin):
++
+------------
+# nvme wdc get-pfail-dump /dev/nvme0 -o test
+------------
+* Gets the pfail crash dump from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9_pfail_dump.bin):
++
+------------
+# nvme wdc get-pfail-dump /dev/nvme0 -o /tmp/test
+------------
+
+NVME
+----
+Part of the nvme-user suite
-- 
1.8.3.1
