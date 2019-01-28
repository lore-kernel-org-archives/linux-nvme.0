From: Dong.Ho@wdc.com (Dong Ho)
Date: Mon, 28 Jan 2019 23:32:39 +0000
Subject: [PATCH 3/4] wdc: Add clear assert dump status command
In-Reply-To: <1548718347-29874-1-git-send-email-dong.ho@wdc.com>
References: <1548718347-29874-1-git-send-email-dong.ho@wdc.com>
Message-ID: <1548718347-29874-3-git-send-email-dong.ho@wdc.com>

---
 Documentation/nvme-wdc-clear-assert-dump.txt | 39 +++++++++++++++
 plugins/wdc/wdc-nvme.c                       | 73 ++++++++++++++++++++++------
 plugins/wdc/wdc-nvme.h                       |  1 +
 3 files changed, 98 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/nvme-wdc-clear-assert-dump.txt

diff --git a/Documentation/nvme-wdc-clear-assert-dump.txt b/Documentation/nvme-wdc-clear-assert-dump.txt
new file mode 100644
index 0000000..a575089
--- /dev/null
+++ b/Documentation/nvme-wdc-clear-assert-dump.txt
@@ -0,0 +1,39 @@
+nvme-wdc-clear-assert-dump(1)
+=============================
+
+NAME
+----
+nvme-wdc-clear-assert-dump - Clears the assert dump (if present).
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc clear-assert-dump' <device>
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends the wdc vendor unique clear assert
+dump command.
+
+The <device> parameter is mandatory and must be the NVMe character
+device (ex: /dev/nvme0).
+
+This will only work on WDC devices supporting this feature.
+The command will not be executed on devices that don't support it.
+
+OPTIONS
+-------
+None
+
+EXAMPLES
+--------
+* Clears the assert dump (if present):
++
+------------
+# nvme wdc clear-assert-dump /dev/nvme0
+------------
+
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 96e8bae..e678028 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -212,6 +212,11 @@
 #define WDC_NVME_CLEAR_PCIE_CORR_CMD		0x22
 #define WDC_NVME_CLEAR_PCIE_CORR_SUBCMD		0x04
 
+/* Clear Assert Dump Status */
+#define WDC_NVME_CLEAR_ASSERT_DUMP_OPCODE  	0xD8
+#define WDC_NVME_CLEAR_ASSERT_DUMP_CMD		0x03
+#define WDC_NVME_CLEAR_ASSERT_DUMP_SUBCMD	0x05
+
 /* Drive Essentials */
 #define WDC_DE_DEFAULT_NUMBER_OF_ERROR_ENTRIES		64
 #define WDC_DE_GENERIC_BUFFER_SIZE					80
@@ -406,6 +411,8 @@ static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
 static int wdc_drive_status(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
+static int wdc_clear_assert_dump(int argc, char **argv, struct command *command,
+		struct plugin *plugin);
 
 /* Drive log data size */
 struct wdc_log_size {
@@ -1292,7 +1299,6 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 			{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
 			{"transfer-size", 's', "NUM", CFG_POSITIVE, &cfg.xfer_size, required_argument, size},
 			{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
-			{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -1579,7 +1585,6 @@ static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command
 		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
 		{"transfer-size", 's', "NUM", CFG_POSITIVE, &cfg.xfer_size, required_argument, size},
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
-		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -1775,7 +1780,6 @@ static int wdc_drive_log(int argc, char **argv, struct command *command,
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
-		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -1812,7 +1816,6 @@ static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
-		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -1846,7 +1849,6 @@ static int wdc_get_pfail_dump(int argc, char **argv, struct command *command,
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
-		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -1920,7 +1922,6 @@ static int wdc_purge(int argc, char **argv,
 	struct nvme_passthru_cmd admin_cmd;
 	const struct argconfig_commandline_options command_line_options[] = {
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
-		{NULL}
 	};
 
 	err_str = "";
@@ -1964,7 +1965,6 @@ static int wdc_purge_monitor(int argc, char **argv,
 	struct wdc_nvme_purge_monitor_data *mon;
 	const struct argconfig_commandline_options command_line_options[] = {
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
-		{NULL}
 	};
 
 	memset(output, 0, sizeof (output));
@@ -2558,7 +2558,7 @@ static int wdc_vs_smart_add_log(int argc, char **argv, struct command *command,
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"interval", 'i', "NUM", CFG_POSITIVE, &cfg.interval, required_argument, interval},
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, "Output Format: normal|json" },
-		{NULL}
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -2604,7 +2604,6 @@ static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct comma
 	struct nvme_passthru_cmd admin_cmd;
 	const struct argconfig_commandline_options command_line_options[] = {
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
-		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -2638,7 +2637,6 @@ static int wdc_drive_status(int argc, char **argv, struct command *command,
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
-		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
@@ -2737,6 +2735,52 @@ out:
 	return ret;
 }
 
+static int wdc_clear_assert_dump(int argc, char **argv, struct command *command,
+		struct plugin *plugin)
+{
+	char *desc = "Clear Assert Dump Present Status.";
+	int fd;
+	int ret = -1;
+	__u32 assert_status = 0xFFFFFFFF;
+	struct nvme_passthru_cmd admin_cmd;
+	const struct argconfig_commandline_options command_line_options[] = {
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
+	};
+	__u64 capabilities = 0;
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	capabilities = wdc_get_drive_capabilities(fd);
+	if ((capabilities & WDC_DRIVE_CAP_CLEAR_ASSERT) != WDC_DRIVE_CAP_CLEAR_ASSERT) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+		goto out;
+	}
+	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&assert_status,
+			WDC_C2_ASSERT_DUMP_PRESENT_ID)) {
+		fprintf(stderr, "ERROR : WDC : Get Assert Status Failed\n");
+		ret = -1;
+		goto out;
+	}
+
+	/* Get the assert dump present status */
+	if (assert_status == WDC_ASSERT_DUMP_PRESENT) {
+		memset(&admin_cmd, 0, sizeof (admin_cmd));
+		admin_cmd.opcode = WDC_NVME_CLEAR_ASSERT_DUMP_OPCODE;
+		admin_cmd.cdw12 = ((WDC_NVME_CLEAR_ASSERT_DUMP_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+				WDC_NVME_CLEAR_ASSERT_DUMP_CMD);
+
+		ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	} else
+		fprintf(stderr, "INFO : WDC : No Assert Dump Present\n");
+
+out:
+	return ret;
+}
+
 static int wdc_get_serial_and_fw_rev(int fd, char *sn, char *fw_rev)
 {
 	int i;
@@ -3007,7 +3051,7 @@ static int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn,
 	wdc_get_max_transfer_len(fd, &maximumTransferLength);
 
 	/* Fetch Log File Data */
-	if ((fileSize >= maximumTransferLength) || (fileSize > 0xffffffff))
+	if ((fileSize >= maximumTransferLength) || (fileSize > 0xFFFFFFFF))
 	{
 		chunckSize = WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET;
 		if (maximumTransferLength < WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET)
@@ -3381,10 +3425,10 @@ static int wdc_do_drive_essentials(int fd, char *dir, char *key)
 						memset(fileName, 0, sizeof(fileName));
 						wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s.bin", bufferFolderPath, WDC_DE_PATH_SEPARATOR,
 								deEssentialsList.logEntry[listIdx].metaData.fileName, serialNo, timeString);
-						if (deEssentialsList.logEntry[listIdx].metaData.fileSize > 0xffffffff)
+						if (deEssentialsList.logEntry[listIdx].metaData.fileSize > 0xFFFFFFFF)
 						{
-							wdc_WriteToFile(fileName, dataBuffer, 0xffffffff);
-							wdc_WriteToFile(fileName, dataBuffer + 0xffffffff, (__u32)(deEssentialsList.logEntry[listIdx].metaData.fileSize - 0xffffffff));
+							wdc_WriteToFile(fileName, dataBuffer, 0xFFFFFFFF);
+							wdc_WriteToFile(fileName, dataBuffer + 0xFFFFFFFF, (__u32)(deEssentialsList.logEntry[listIdx].metaData.fileSize - 0xFFFFFFFF));
 						} else {
 							wdc_WriteToFile(fileName, dataBuffer, (__u32)deEssentialsList.logEntry[listIdx].metaData.fileSize);
 						}
@@ -3454,7 +3498,6 @@ static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 	const struct argconfig_commandline_options command_line_options[] = {
 			{"dir-name", 'd', "DIRECTORY", CFG_STRING, &cfg.dirName, required_argument, dirName},
 			{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
-			{NULL}
 	};
 	__u64 capabilities = 0;
 
diff --git a/plugins/wdc/wdc-nvme.h b/plugins/wdc/wdc-nvme.h
index 6f00f02..30ac27a 100644
--- a/plugins/wdc/wdc-nvme.h
+++ b/plugins/wdc/wdc-nvme.h
@@ -20,6 +20,7 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("clear-pcie-correctable-errors", "WDC Clear PCIe Correctable Error Count", wdc_clear_pcie_correctable_errors)
 		ENTRY("drive-essentials", "WDC Drive Essentials", wdc_drive_essentials)
 		ENTRY("get-drive-status", "WDC Get Drive Status", wdc_drive_status)
+		ENTRY("clear-assert-dump", "WDC Clear Assert Dump", wdc_clear_assert_dump)
 	)
 );
 
-- 
2.7.4
