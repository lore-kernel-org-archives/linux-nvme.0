From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Fri, 12 Oct 2018 15:50:05 +0000
Subject: [PATCH 1/2] nvme-cli: Add wdc-plugin command vs-internal-log and
 update wdc-plug cap-diag command with transfer-size parameter.
Message-ID: <1539359392-29379-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 wdc-nvme.c | 214 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 wdc-nvme.h |   1 +
 2 files changed, 202 insertions(+), 13 deletions(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 33d38fc..330150a 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -49,6 +49,7 @@
 #define WDC_NVME_SUBCMD_SHIFT	8
 
 #define WDC_NVME_LOG_SIZE_DATA_LEN			0x08
+#define WDC_NVME_LOG_SIZE_HDR_LEN			0x08
 
 /* Device Config */
 #define WDC_NVME_VID  					0x1c58
@@ -159,6 +160,8 @@
 #define WDC_DE_DESTN_SPI							1
 #define WDC_DE_DUMPTRACE_DESTINATION				6
 
+#define min(x, y) ((x) > (y) ? (y) : (x))
+
 typedef enum _NVME_FEATURES_SELECT
 {
     FS_CURRENT                      = 0,
@@ -317,6 +320,12 @@ struct wdc_log_size {
 	__le32	log_size;
 };
 
+/* E6 log header */
+struct wdc_e6_log_hdr {
+	__le32  eye_catcher;
+	__u8	log_size[4];
+};
+
 /* Purge monitor response */
 struct wdc_nvme_purge_monitor_data {
 	__le16 	rsvd1;
@@ -736,6 +745,27 @@ static __u32 wdc_dump_length(int fd, __u32 opcode, __u32 cdw10, __u32 cdw12, __u
 	return ret;
 }
 
+static __u32 wdc_dump_length_e6(int fd, __u32 opcode, __u32 cdw10, __u32 cdw12, struct wdc_e6_log_hdr *dump_hdr)
+{
+	int ret;
+	struct nvme_admin_cmd admin_cmd;
+
+	memset(&admin_cmd, 0, sizeof (struct nvme_admin_cmd));
+	admin_cmd.opcode = opcode;
+	admin_cmd.addr = (__u64)(uintptr_t)dump_hdr;
+	admin_cmd.data_len = WDC_NVME_LOG_SIZE_HDR_LEN;
+	admin_cmd.cdw10 = cdw10;
+	admin_cmd.cdw12 = cdw12;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	if (ret != 0) {
+		fprintf(stderr, "ERROR : WDC : reading dump length failed\n");
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	}
+
+	return ret;
+}
+
 static int wdc_do_dump(int fd, __u32 opcode,__u32 data_len, __u32 cdw10,
 		__u32 cdw12, __u32 dump_length, char *file)
 {
@@ -765,48 +795,137 @@ static int wdc_do_dump(int fd, __u32 opcode,__u32 data_len, __u32 cdw10,
 	return ret;
 }
 
-static int wdc_do_cap_diag(int fd, char *file)
+static int wdc_do_dump_e6(int fd, __u32 opcode,__u32 data_len,
+		__u32 cdw12, char *file, __u32 xfer_size, __u8 *log_hdr)
+{
+	int ret = 0;
+	__u8 *dump_data;
+	__u32 curr_data_offset, log_size;
+	int i;
+	struct nvme_admin_cmd admin_cmd;
+
+	dump_data = (__u8 *) malloc(sizeof (__u8) * data_len);
+
+	if (dump_data == NULL) {
+		fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
+		return -1;
+	}
+	memset(dump_data, 0, sizeof (__u8) * data_len);
+	memset(&admin_cmd, 0, sizeof (struct nvme_admin_cmd));
+	curr_data_offset = WDC_NVME_LOG_SIZE_HDR_LEN;
+	i = 0;
+
+	/* copy the 8 byte header into the dump_data buffer */
+	memcpy(dump_data, log_hdr, WDC_NVME_LOG_SIZE_HDR_LEN);
+
+	admin_cmd.opcode = opcode;
+	admin_cmd.cdw12 = cdw12;
+
+	log_size = data_len;
+	while (log_size > 0) {
+		xfer_size = min(xfer_size, log_size);
+
+		admin_cmd.addr = (__u64)(uintptr_t)dump_data + (__u64)curr_data_offset;
+		admin_cmd.data_len = xfer_size;
+		admin_cmd.cdw10 = xfer_size >> 2;
+		admin_cmd.cdw13 = curr_data_offset >> 2;
+
+		ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+		if (ret != 0) {
+			fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+			fprintf(stderr, "%s: ERROR : WDC : Get chunk %d, size = 0x%x, offset = 0x%x, addr = 0x%lx\n",
+					__func__, i, admin_cmd.data_len, curr_data_offset, (long unsigned int)admin_cmd.addr);
+			break;
+		}
+
+		log_size         -= xfer_size;
+		curr_data_offset += xfer_size;
+		i++;
+	}
+
+	if (ret == 0) {
+		fprintf(stderr, "%s:  NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+		ret = wdc_create_log_file(file, dump_data, data_len);
+	}
+	free(dump_data);
+	return ret;
+}
+
+static int wdc_do_cap_diag(int fd, char *file, __u32 xfer_size)
 {
 	int ret;
+	__u32 e6_log_hdr_size = WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE;
+	struct wdc_e6_log_hdr *log_hdr;
 	__u32 cap_diag_length;
+	int verify_file;
+
+ 	/* verify the passed in file name and path is valid before getting the dump data */
+	verify_file = open(file, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (verify_file < 0) {
+		fprintf(stderr, "ERROR : WDC: open : %s\n", strerror(errno));
+		return -1;
+	}
+	close(verify_file);
 
-	ret = wdc_dump_length(fd, WDC_NVME_CAP_DIAG_OPCODE,
-						WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE,
+	log_hdr = (struct wdc_e6_log_hdr *) malloc(e6_log_hdr_size);
+	if (log_hdr == NULL) {
+		fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
+		return -1;
+	}
+	memset(log_hdr, 0, e6_log_hdr_size);
+
+	ret = wdc_dump_length_e6(fd, WDC_NVME_CAP_DIAG_OPCODE,
+						WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE>>2,
 						0x00,
-						&cap_diag_length);
+						log_hdr);
 	if (ret == -1) {
+		free(log_hdr);
 		return -1;
 	}
+
+	cap_diag_length = (log_hdr->log_size[0] << 24 | log_hdr->log_size[1] << 16 |
+			log_hdr->log_size[2] << 8 | log_hdr->log_size[3]);
+
 	if (cap_diag_length == 0) {
-		fprintf(stderr, "INFO : WDC : Capture Dignostics log is empty\n");
+		fprintf(stderr, "INFO : WDC : Capture Diagnostics log is empty\n");
 	} else {
-		ret = wdc_do_dump(fd, WDC_NVME_CAP_DIAG_OPCODE, cap_diag_length,
-				cap_diag_length,
-				(WDC_NVME_CAP_DIAG_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
-				 WDC_NVME_CAP_DIAG_CMD, cap_diag_length, file);
+		if (xfer_size == 0)
+			xfer_size = cap_diag_length;
 
+		ret = wdc_do_dump_e6(fd, WDC_NVME_CAP_DIAG_OPCODE, cap_diag_length,
+						(WDC_NVME_CAP_DIAG_SUBCMD << WDC_NVME_SUBCMD_SHIFT) | WDC_NVME_CAP_DIAG_CMD,
+						file, xfer_size, (__u8 *)log_hdr);
+
+		fprintf(stderr, "INFO : WDC : Capture Diagnostics log, length = 0x%x\n", cap_diag_length);
 	}
+
+	free(log_hdr);
 	return ret;
 }
 
 static int wdc_cap_diag(int argc, char **argv, struct command *command,
 		struct plugin *plugin)
 {
-	const char *desc = "Capture Diagnostics Log.";
-	const char *file = "Output file pathname.";
+	char *desc = "Capture Diagnostics Log.";
+	char *file = "Output file pathname.";
+	char *size = "Data retrieval transfer size.";
 	char f[PATH_MAX] = {0};
+	__u32 xfer_size = 0;
 	int fd;
 
 	struct config {
 		char *file;
+		__u32 xfer_size;
 	};
 
 	struct config cfg = {
-		.file = NULL
+		.file = NULL,
+		.xfer_size = 0x10000
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
+		{"transfer-size", 's', "NUM", CFG_POSITIVE, &cfg.xfer_size, required_argument, size},
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
 		{NULL}
 	};
@@ -818,6 +937,9 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 	if (cfg.file != NULL) {
 		strncpy(f, cfg.file, PATH_MAX - 1);
 	}
+	if (cfg.xfer_size != 0) {
+		xfer_size = cfg.xfer_size;
+	}
 	if (wdc_get_serial_name(fd, f, PATH_MAX, "cap_diag") == -1) {
 		fprintf(stderr, "ERROR : WDC: failed to generate file name\n");
 		return -1;
@@ -827,7 +949,7 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ||
 		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN310_DEV_ID) ||
 		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN510_DEV_ID)) {
-		return wdc_do_cap_diag(fd, f);
+		return wdc_do_cap_diag(fd, f, xfer_size);
 	} else {
 		fprintf(stderr, "ERROR : WDC: unsupported device for cap-diag command\n");
 	}
@@ -835,6 +957,72 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 	return 0;
 }
 
+static int wdc_internal_fw_log(int argc, char **argv, struct command *command,
+               struct plugin *plugin)
+{
+	char *desc = "Internal Firmware Log.";
+	char *file = "Output file pathname.";
+	char *size = "Data retrieval transfer size.";
+	char f[PATH_MAX] = {0};
+	char fileSuffix[PATH_MAX] = {0};
+	__u32 xfer_size = 0;
+	int fd;
+	UtilsTimeInfo             timeInfo;
+	__u8                      timeStamp[MAX_PATH_LEN];
+
+	struct config {
+		char *file;
+		__u32 xfer_size;
+	};
+
+	struct config cfg = {
+		.file = NULL,
+		.xfer_size = 0x10000
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
+		{"transfer-size", 's', "NUM", CFG_POSITIVE, &cfg.xfer_size, required_argument, size},
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	if (cfg.xfer_size != 0) {
+		xfer_size = cfg.xfer_size;
+	}
+
+	if (cfg.file != NULL) {
+		strncpy(f, cfg.file, PATH_MAX - 1);
+	} else {
+		wdc_UtilsGetTime(&timeInfo);
+		memset(timeStamp, 0, sizeof(timeStamp));
+		wdc_UtilsSnprintf((char*)timeStamp, MAX_PATH_LEN, "%02u%02u%02u_%02u%02u%02u",
+			timeInfo.year, timeInfo.month, timeInfo.dayOfMonth,
+			timeInfo.hour, timeInfo.minute, timeInfo.second);
+		snprintf(fileSuffix, PATH_MAX, "_internal_fw_log_%s", (char*)timeStamp);
+
+		if (wdc_get_serial_name(fd, f, PATH_MAX, fileSuffix) == -1) {
+			fprintf(stderr, "ERROR : WDC: failed to generate file name\n");
+			return -1;
+		}
+	}
+	fprintf(stderr, "%s: filename = %s\n", __func__, f);
+
+	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID) ||
+		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ||
+		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN310_DEV_ID) ||
+		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN510_DEV_ID)) {
+		return wdc_do_cap_diag(fd, f, xfer_size);
+	} else {
+		fprintf(stderr, "ERROR : WDC: unsupported device for internal_fw_log command\n");
+		return -1;
+	}
+}
+
 static int wdc_do_crash_dump(int fd, char *file)
 {
 	int ret;
diff --git a/wdc-nvme.h b/wdc-nvme.h
index 415bbc0..f5531a2 100644
--- a/wdc-nvme.h
+++ b/wdc-nvme.h
@@ -14,6 +14,7 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("id-ctrl", "WDC identify controller", wdc_id_ctrl)
 		ENTRY("purge", "WDC Purge", wdc_purge)
 		ENTRY("purge-monitor", "WDC Purge Monitor", wdc_purge_monitor)
+		ENTRY("vs-internal-log", "WDC Internal Firmware Log", wdc_internal_fw_log)
 		ENTRY("smart-add-log", "WDC Additional Smart Log", wdc_smart_add_log)
 		ENTRY("clear-pcie-corr", "WDC Clear PCIe Correctable Error Count", wdc_clear_pcie_corr)
 		ENTRY("drive-essentials", "WDC Drive Essentials", wdc_drive_essentials)
-- 
1.8.3.1
