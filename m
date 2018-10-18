From: Dong.Ho@wdc.com (Dong Ho)
Date: Thu, 18 Oct 2018 21:06:53 +0000
Subject: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.
Message-ID: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>

---
This patch implements the function to retreive a WDC device's pfail crash dump.

 wdc-nvme.c | 200 +++++++++++++++++++++++++++++++++++++++++++++++++------------
 wdc-nvme.h |   1 +
 2 files changed, 164 insertions(+), 37 deletions(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 330150a..55b2889 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -72,6 +72,9 @@
 #define WDC_NVME_CAP_DIAG_SUBCMD			0x00
 #define WDC_NVME_CAP_DIAG_CMD				0x00
 
+#define WDC_NVME_CRASH_DUMP_TYPE		1
+#define WDC_NVME_PFAIL_DUMP_TYPE		2
+
 /* Crash dump */
 #define WDC_NVME_CRASH_DUMP_SIZE_OPCODE		WDC_NVME_CAP_DIAG_CMD_OPCODE
 #define WDC_NVME_CRASH_DUMP_SIZE_DATA_LEN	WDC_NVME_LOG_SIZE_DATA_LEN
@@ -83,6 +86,16 @@
 #define WDC_NVME_CRASH_DUMP_CMD				0x20
 #define WDC_NVME_CRASH_DUMP_SUBCMD			0x04
 
+/* PFail Crash dump */
+#define WDC_NVME_PF_CRASH_DUMP_SIZE_DATA_LEN	WDC_NVME_LOG_SIZE_HDR_LEN
+#define WDC_NVME_PF_CRASH_DUMP_SIZE_NDT		0x02
+#define WDC_NVME_PF_CRASH_DUMP_SIZE_CMD		0x20
+#define WDC_NVME_PF_CRASH_DUMP_SIZE_SUBCMD	0x05
+
+#define WDC_NVME_PF_CRASH_DUMP_OPCODE	    WDC_NVME_CAP_DIAG_CMD_OPCODE
+#define WDC_NVME_PF_CRASH_DUMP_CMD	    0x20
+#define WDC_NVME_PF_CRASH_DUMP_SUBCMD	    0x06
+
 /* Drive Log */
 #define WDC_NVME_DRIVE_LOG_SIZE_OPCODE		WDC_NVME_CAP_DIAG_CMD_OPCODE
 #define WDC_NVME_DRIVE_LOG_SIZE_DATA_LEN	WDC_NVME_LOG_SIZE_DATA_LEN
@@ -110,9 +123,10 @@
 #define WDC_NVME_PURGE_STATE_PWR_CYC_PURGE	0x04
 
 /* Clear dumps */
-#define WDC_NVME_CLEAR_DUMP_OPCODE			0xFF
+#define WDC_NVME_CLEAR_DUMP_OPCODE		0xFF
 #define WDC_NVME_CLEAR_CRASH_DUMP_CMD		0x03
 #define WDC_NVME_CLEAR_CRASH_DUMP_SUBCMD	0x05
+#define WDC_NVME_CLEAR_PF_CRASH_DUMP_SUBCMD	0x06
 
 /* Additional Smart Log */
 #define WDC_ADD_LOG_BUF_LEN							0x4000
@@ -294,10 +308,10 @@ static int wdc_get_serial_name(int fd, char *file, size_t len, char *suffix);
 static int wdc_create_log_file(char *file, __u8 *drive_log_data,
 		__u32 drive_log_length);
 static int wdc_do_clear_dump(int fd, __u8 opcode, __u32 cdw12);
-static int wdc_do_dump(int fd, __u32 opcode,__u32 data_len, __u32 cdw10,
-		__u32 cdw12, __u32 dump_length, char *file);
-static int wdc_do_crash_dump(int fd, char *file);
-static int wdc_crash_dump(int fd, char *file);
+static int wdc_do_dump(int fd, __u32 opcode,__u32 data_len,
+		__u32 cdw12, char *file, __u32 xfer_size);
+static int wdc_do_crash_dump(int fd, char *file, int type);
+static int wdc_crash_dump(int fd, char *file, int type);
 static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
 static int wdc_do_drive_log(int fd, char *file);
@@ -766,29 +780,59 @@ static __u32 wdc_dump_length_e6(int fd, __u32 opcode, __u32 cdw10, __u32 cdw12,
 	return ret;
 }
 
-static int wdc_do_dump(int fd, __u32 opcode,__u32 data_len, __u32 cdw10,
-		__u32 cdw12, __u32 dump_length, char *file)
+static int wdc_do_dump(int fd, __u32 opcode,__u32 data_len,
+		__u32 cdw12, char *file, __u32 xfer_size)
 {
-	int ret;
+	int ret = 0;
 	__u8 *dump_data;
+	__u32 curr_data_offset, curr_data_len;
+	int i;
 	struct nvme_admin_cmd admin_cmd;
+	__u32 dump_length = data_len;
 
 	dump_data = (__u8 *) malloc(sizeof (__u8) * dump_length);
 	if (dump_data == NULL) {
-		fprintf(stderr, "ERROR : malloc : %s\n", strerror(errno));
+		fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
 		return -1;
 	}
 	memset(dump_data, 0, sizeof (__u8) * dump_length);
 	memset(&admin_cmd, 0, sizeof (struct nvme_admin_cmd));
+	curr_data_offset = 0;
+	curr_data_len = xfer_size;
+	i = 0;
+
 	admin_cmd.opcode = opcode;
 	admin_cmd.addr = (__u64)(uintptr_t)dump_data;
-	admin_cmd.data_len = data_len;
-	admin_cmd.cdw10 = cdw10;
+	admin_cmd.data_len = curr_data_len;
+	admin_cmd.cdw10 = curr_data_len >> 2;
 	admin_cmd.cdw12 = cdw12;
+	admin_cmd.cdw13 = curr_data_offset;
+
+	while (curr_data_offset < data_len) {
+		ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+		if (ret != 0) {
+			fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n",
+				__func__, nvme_status_to_string(ret), ret);
+			fprintf(stderr, "%s: ERROR : WDC : Get chunk %d, size = 0x%x, offset = 0x%x, addr = 0x%lx\n",
+				__func__, i, admin_cmd.data_len, curr_data_offset, (long unsigned int)admin_cmd.addr);
+			break;
+		}
+
+		if ((curr_data_offset + xfer_size) <= data_len)
+			curr_data_len = xfer_size;
+		else
+			curr_data_len = data_len - curr_data_offset;   // last transfer
+
+		curr_data_offset += curr_data_len;
+		admin_cmd.addr = (__u64)(uintptr_t)dump_data + (__u64)curr_data_offset;
+		admin_cmd.data_len = curr_data_len;
+		admin_cmd.cdw10 = curr_data_len >> 2;
+		admin_cmd.cdw13 = curr_data_offset >> 2;
+		i++;
+	}
 
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
-	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	if (ret == 0) {
+		fprintf(stderr, "%s:  NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
 		ret = wdc_create_log_file(file, dump_data, dump_length);
 	}
 	free(dump_data);
@@ -1023,47 +1067,96 @@ static int wdc_internal_fw_log(int argc, char **argv, struct command *command,
 	}
 }
 
-static int wdc_do_crash_dump(int fd, char *file)
+static int wdc_do_crash_dump(int fd, char *file, int type)
 {
 	int ret;
 	__u32 crash_dump_length;
-	__u8 opcode = WDC_NVME_CLEAR_DUMP_OPCODE;
-	__u32 cdw12 = ((WDC_NVME_CLEAR_CRASH_DUMP_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+	__u32 opcode;
+	__u32 cdw12;
+	__u32 cdw10_size;
+	__u32 cdw12_size;
+	__u32 cdw12_clear;
+
+	if (type == WDC_NVME_PFAIL_DUMP_TYPE) {
+		/* set parms to get the PFAIL Crash Dump */
+		opcode = WDC_NVME_PF_CRASH_DUMP_OPCODE;
+		cdw10_size = WDC_NVME_PF_CRASH_DUMP_SIZE_NDT;
+		cdw12_size = ((WDC_NVME_PF_CRASH_DUMP_SIZE_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+			WDC_NVME_PF_CRASH_DUMP_SIZE_CMD);
+
+		cdw12 = (WDC_NVME_PF_CRASH_DUMP_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+			WDC_NVME_PF_CRASH_DUMP_CMD;
+
+		cdw12_clear = ((WDC_NVME_CLEAR_PF_CRASH_DUMP_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+			WDC_NVME_CLEAR_CRASH_DUMP_CMD);
+
+	} else {
+		/* set parms to get the Crash Dump */
+		opcode = WDC_NVME_CRASH_DUMP_OPCODE;
+		cdw10_size = WDC_NVME_CRASH_DUMP_SIZE_NDT;
+		cdw12_size = ((WDC_NVME_CRASH_DUMP_SIZE_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+			WDC_NVME_CRASH_DUMP_SIZE_CMD);
+
+		cdw12 = (WDC_NVME_CRASH_DUMP_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+			WDC_NVME_CRASH_DUMP_CMD;
+
+		cdw12_clear = ((WDC_NVME_CLEAR_CRASH_DUMP_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
 			WDC_NVME_CLEAR_CRASH_DUMP_CMD);
+	}
+
+	ret = wdc_dump_length(fd,
+		opcode,
+		cdw10_size,
+		cdw12_size,
+		&crash_dump_length);
 
-	ret = wdc_dump_length(fd, WDC_NVME_CRASH_DUMP_SIZE_OPCODE,
-			WDC_NVME_CRASH_DUMP_SIZE_NDT,
-			((WDC_NVME_CRASH_DUMP_SIZE_SUBCMD <<
-			WDC_NVME_SUBCMD_SHIFT) | WDC_NVME_CRASH_DUMP_SIZE_CMD),
-			&crash_dump_length);
 	if (ret == -1) {
+		if (type == WDC_NVME_PFAIL_DUMP_TYPE)
+		    fprintf(stderr, "INFO : WDC: Pfail dump get size failed\n");
+		else
+		    fprintf(stderr, "INFO : WDC: Crash dump get size failed\n");
+
 		return -1;
 	}
+
 	if (crash_dump_length == 0) {
-		fprintf(stderr, "INFO : WDC: Crash dump is empty\n");
+		if (type == WDC_NVME_PFAIL_DUMP_TYPE)
+		    fprintf(stderr, "INFO : WDC: Pfail dump is empty\n");
+		else
+		    fprintf(stderr, "INFO : WDC: Crash dump is empty\n");
 	} else {
-		ret = wdc_do_dump(fd, WDC_NVME_CRASH_DUMP_OPCODE, crash_dump_length,
-				crash_dump_length,
-				(WDC_NVME_CRASH_DUMP_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
-				 WDC_NVME_CRASH_DUMP_CMD, crash_dump_length, file);
+		ret = wdc_do_dump(fd,
+			opcode,
+			crash_dump_length,
+			cdw12,
+			file,
+			crash_dump_length);
+
 		if (ret == 0)
-			ret = wdc_do_clear_dump(fd, opcode, cdw12);
+			ret = wdc_do_clear_dump(fd, WDC_NVME_CLEAR_DUMP_OPCODE, cdw12_clear);
 	}
 	return ret;
 }
 
-static int wdc_crash_dump(int fd, char *file)
+static int wdc_crash_dump(int fd, char *file, int type)
 {
 	char f[PATH_MAX] = {0};
+	char dump_type[PATH_MAX] = {0};
 
 	if (file != NULL) {
 		strncpy(f, file, PATH_MAX - 1);
 	}
-	if (wdc_get_serial_name(fd, f, PATH_MAX, "crash_dump") == -1) {
+
+	if (type == WDC_NVME_PFAIL_DUMP_TYPE)
+		strncpy(dump_type, "_pfail_dump", 11);
+	else
+		strncpy(dump_type, "_crash_dump", 11);
+
+	if (wdc_get_serial_name(fd, f, PATH_MAX, dump_type) == -1) {
 		fprintf(stderr, "ERROR : WDC : failed to generate file name\n");
 		return -1;
-	}
-	return wdc_do_crash_dump(fd, f);
+	    }
+	return wdc_do_crash_dump(fd, f, type);
 }
 
 static int wdc_do_drive_log(int fd, char *file)
@@ -1149,7 +1242,6 @@ static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 	const char *desc = "Get Crash Dump.";
 	const char *file = "Output file pathname.";
 	int fd;
-	int ret;
 	struct config {
 		char *file;
 	};
@@ -1168,12 +1260,46 @@ static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-	wdc_check_device(fd);
-	ret = wdc_crash_dump(fd, cfg.file);
-	if (ret != 0) {
-		fprintf(stderr, "ERROR : WDC : failed to read crash dump\n");
+	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID) ||
+		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ) {
+		return wdc_crash_dump(fd, cfg.file, WDC_NVME_CRASH_DUMP_TYPE);
+	} else {
+		fprintf(stderr, "ERROR : WDC: unsupported device for get-crash-dump command\n");
+		return -1;
+	}
+}
+
+static int wdc_get_pfail_dump(int argc, char **argv, struct command *command,
+	struct plugin *plugin)
+{
+	char *desc = "Get Pfail Crash Dump.";
+	char *file = "Output file pathname.";
+	int fd;
+	struct config {
+		char *file;
+	};
+
+	struct config cfg = {
+		.file = NULL,
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID) ||
+		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ) {
+		return wdc_crash_dump(fd, cfg.file, WDC_NVME_PFAIL_DUMP_TYPE);
+	} else {
+		fprintf(stderr, "ERROR : WDC: unsupported device for get-pfail-dump command\n");
+		return -1;
 	}
-	return ret;
 }
 
 static void wdc_do_id_ctrl(__u8 *vs, struct json_object *root)
diff --git a/wdc-nvme.h b/wdc-nvme.h
index f5531a2..3732005 100644
--- a/wdc-nvme.h
+++ b/wdc-nvme.h
@@ -11,6 +11,7 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("cap-diag", "WDC Capture-Diagnostics", wdc_cap_diag)
 		ENTRY("drive-log", "WDC Drive Log", wdc_drive_log)
 		ENTRY("get-crash-dump", "WDC Crash Dump", wdc_get_crash_dump)
+		ENTRY("get-pfail-dump", "WDC Pfail Dump", wdc_get_pfail_dump)
 		ENTRY("id-ctrl", "WDC identify controller", wdc_id_ctrl)
 		ENTRY("purge", "WDC Purge", wdc_purge)
 		ENTRY("purge-monitor", "WDC Purge Monitor", wdc_purge_monitor)
-- 
1.8.3.1
