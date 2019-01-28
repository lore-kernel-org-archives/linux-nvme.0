From: Dong.Ho@wdc.com (Dong Ho)
Date: Mon, 28 Jan 2019 23:32:39 +0000
Subject: [PATCH 4/4] wdc: Add drive resize command
In-Reply-To: <1548718347-29874-1-git-send-email-dong.ho@wdc.com>
References: <1548718347-29874-1-git-send-email-dong.ho@wdc.com>
Message-ID: <1548718347-29874-4-git-send-email-dong.ho@wdc.com>

---
 Documentation/nvme-wdc-drive-resize.txt | 42 +++++++++++++++++++++
 plugins/wdc/wdc-nvme.c                  | 66 ++++++++++++++++++++++++++++++++-
 plugins/wdc/wdc-nvme.h                  |  1 +
 3 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/nvme-wdc-drive-resize.txt

diff --git a/Documentation/nvme-wdc-drive-resize.txt b/Documentation/nvme-wdc-drive-resize.txt
new file mode 100644
index 0000000..4be0cb2
--- /dev/null
+++ b/Documentation/nvme-wdc-drive-resize.txt
@@ -0,0 +1,42 @@
+nvme-wdc-drive-resize(1)
+========================
+
+NAME
+----
+nvme-wdc-drive-resize - Send NVMe WDC Resize Vendor Unique Command,
+return result.
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc drive-resize' <device> [--size=<sz> | -s <sz>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends a Vendor Unique WDC Resize command.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+On success it returns 0, error code otherwise.
+
+OPTIONS
+-------
+-s <sz>::
+--size=<sz>::
+	The new size (in GB) to resize the drive to.
+
+EXAMPLES
+--------
+* Has the program issue WDC Resize Vendor Unique Command :
++
+------------
+# nvme wdc drive-resize /dev/nvme0n1 --size=100
+------------
+
+NVME
+----
+Part of the nvme-user suite.
diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index e678028..3aeb28b 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -80,6 +80,7 @@
 #define WDC_DRIVE_CAP_DRIVE_STATUS			0x0000000000000020
 #define WDC_DRIVE_CAP_CLEAR_ASSERT			0x0000000000000040
 #define WDC_DRIVE_CAP_CLEAR_PCIE			0x0000000000000080
+#define WDC_DRIVE_CAP_RESIZE			0x0000000000000100
 
 #define WDC_DRIVE_CAP_DRIVE_ESSENTIALS			0x0000000100000000
 #define WDC_DRIVE_CAP_DUI_DATA				0x0000000200000000
@@ -101,6 +102,11 @@
 #define SN730_GET_EXTEND_LOG_SUBOPCODE			0x00040009
 #define SN730_LOG_CHUNK_SIZE				0x1000
 
+/* Drive Resize */
+#define WDC_NVME_DRIVE_RESIZE_OPCODE		0xCC
+#define WDC_NVME_DRIVE_RESIZE_CMD		0x03
+#define WDC_NVME_DRIVE_RESIZE_SUBCMD		0x01
+
 /* Capture Diagnostics */
 #define WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE	WDC_NVME_LOG_SIZE_DATA_LEN
 #define WDC_NVME_CAP_DIAG_OPCODE			0xE6
@@ -413,6 +419,9 @@ static int wdc_drive_status(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
 static int wdc_clear_assert_dump(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
+static int wdc_drive_resize(int argc, char **argv,
+		struct command *command, struct plugin *plugin);
+static int wdc_do_drive_resize(int fd, uint64_t new_size);
 
 /* Drive log data size */
 struct wdc_log_size {
@@ -701,7 +710,8 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 		/* FALLTHRU */
 		case WDC_NVME_SN840_DEV_ID:
 			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG |
-					WDC_DRIVE_CAP_DRIVE_STATUS | WDC_DRIVE_CAP_CLEAR_ASSERT);
+					WDC_DRIVE_CAP_DRIVE_STATUS | WDC_DRIVE_CAP_CLEAR_ASSERT |
+					WDC_DRIVE_CAP_RESIZE);
 
 			/* verify the 0xCA log page is supported */
 			if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE) == true)
@@ -3520,3 +3530,57 @@ static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 
 	return wdc_do_drive_essentials(fd, d_ptr, k);
 }
+
+static int wdc_do_drive_resize(int fd, uint64_t new_size)
+{
+	int ret;
+	struct nvme_admin_cmd admin_cmd;
+
+	memset(&admin_cmd, 0, sizeof (struct nvme_admin_cmd));
+	admin_cmd.opcode = WDC_NVME_DRIVE_RESIZE_OPCODE;
+	admin_cmd.cdw12 = ((WDC_NVME_DRIVE_RESIZE_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+			    WDC_NVME_DRIVE_RESIZE_CMD);
+	admin_cmd.cdw13 = new_size;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	return ret;
+}
+
+static int wdc_drive_resize(int argc, char **argv,
+		struct command *command, struct plugin *plugin)
+{
+	const char *desc = "Send a Resize command.";
+	const char *size = "The new size (in GB) to resize the drive to.";
+	int fd;
+	int ret;
+	uint64_t capabilities = 0;
+
+	struct config {
+		uint64_t size;
+	};
+
+	struct config cfg = {
+		.size = 0,
+	};
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"size", 's', "NUM", CFG_POSITIVE, &cfg.size, required_argument, size},
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	wdc_check_device(fd);
+	capabilities = wdc_get_drive_capabilities(fd);
+	if ((capabilities & WDC_DRIVE_CAP_RESIZE) == WDC_DRIVE_CAP_RESIZE) {
+		ret = wdc_do_drive_resize(fd, cfg.size);
+	} else {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+	}
+	if (!ret)
+		printf("New size: %lu GB\n", cfg.size);
+	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	return ret;
+}
diff --git a/plugins/wdc/wdc-nvme.h b/plugins/wdc/wdc-nvme.h
index 30ac27a..2492eab 100644
--- a/plugins/wdc/wdc-nvme.h
+++ b/plugins/wdc/wdc-nvme.h
@@ -21,6 +21,7 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("drive-essentials", "WDC Drive Essentials", wdc_drive_essentials)
 		ENTRY("get-drive-status", "WDC Get Drive Status", wdc_drive_status)
 		ENTRY("clear-assert-dump", "WDC Clear Assert Dump", wdc_clear_assert_dump)
+		ENTRY("drive-resize", "WDC Drive Resize", wdc_drive_resize)
 	)
 );
 
-- 
2.7.4
