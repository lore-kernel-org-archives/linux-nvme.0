From: Dong.Ho@wdc.com (Dong Ho)
Date: Thu, 28 Feb 2019 19:57:36 +0000
Subject: [PATCH] wdc: Add data area extraction for DUI command
Message-ID: <1551383828-8783-1-git-send-email-dong.ho@wdc.com>

Signed-off-by: Dong Ho <dong.ho at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 91 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 29 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 9558322..6a2dac8 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -72,6 +72,7 @@
 #define WDC_NVME_SN720_DEV_ID				0x5002
 #define WDC_NVME_SN730_DEV_ID				0x3714
 #define WDC_NVME_SN730_DEV_ID_1				0x3734
+#define WDC_NVME_SN340_DEV_ID				0x500d
 
 #define WDC_DRIVE_CAP_CAP_DIAG				0x0000000000000001
 #define WDC_DRIVE_CAP_INTERNAL_LOG			0x0000000000000002
@@ -86,8 +87,8 @@
 
 #define WDC_DRIVE_CAP_DRIVE_ESSENTIALS			0x0000000100000000
 #define WDC_DRIVE_CAP_DUI_DATA				0x0000000200000000
-
 #define WDC_SN730_CAP_VUC_LOG				0x0000000400000000
+#define WDC_DRIVE_CAP_SN340_DUI				0x0000000800000000
 #define WDC_DRIVE_CAP_SMART_LOG_MASK	(WDC_DRIVE_CAP_C1_LOG_PAGE | WDC_DRIVE_CAP_CA_LOG_PAGE | \
 					 WDC_DRIVE_CAP_D0_LOG_PAGE)
 
@@ -122,6 +123,8 @@
 /* Capture Device Unit Info */
 #define WDC_NVME_CAP_DUI_HEADER_SIZE			0x400
 #define WDC_NVME_CAP_DUI_OPCODE				0xFA
+#define WDC_NVME_DUI_MAX_SECTION			0x3A
+#define WDC_NVME_DUI_MAX_DATA_AREA			0x05
 
 /* Crash dump */
 #define WDC_NVME_CRASH_DUMP_SIZE_DATA_LEN		WDC_NVME_LOG_SIZE_DATA_LEN
@@ -441,12 +444,19 @@ struct wdc_e6_log_hdr {
 };
 
 /* DUI log header */
+struct wdc_dui_log_section {
+	__le16	section_type;
+	__le16	data_area_id;
+	__le32	section_size;
+};
+
 struct wdc_dui_log_hdr {
 	__u8    telemetry_hdr[512];
 	__le16	hdr_version;
 	__le16	section_count;
 	__u8	log_size[4];
-	__u8    log_data[504];
+	struct	wdc_dui_log_section log_section[WDC_NVME_DUI_MAX_SECTION];
+	__u8    log_data[40];
 };
 
 /* Purge monitor response */
@@ -775,6 +785,8 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 		case WDC_NVME_SN720_DEV_ID:
 			capabilities = WDC_DRIVE_CAP_DUI_DATA | WDC_DRIVE_CAP_NAND_STATS;
 			break;
+		case WDC_NVME_SN340_DEV_ID:
+			capabilities = WDC_DRIVE_CAP_SN340_DUI;
 		default:
 			capabilities = 0;
 		}
@@ -1189,7 +1201,8 @@ static int wdc_do_cap_diag(int fd, char *file, __u32 xfer_size)
 	log_hdr = (struct wdc_e6_log_hdr *) malloc(e6_log_hdr_size);
 	if (log_hdr == NULL) {
 		fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
-		return -1;
+		ret = -1;
+		goto out;
 	}
 	memset(log_hdr, 0, e6_log_hdr_size);
 
@@ -1198,8 +1211,8 @@ static int wdc_do_cap_diag(int fd, char *file, __u32 xfer_size)
 						0x00,
 						log_hdr);
 	if (ret == -1) {
-		free(log_hdr);
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	cap_diag_length = (log_hdr->log_size[0] << 24 | log_hdr->log_size[1] << 16 |
@@ -1208,9 +1221,6 @@ static int wdc_do_cap_diag(int fd, char *file, __u32 xfer_size)
 	if (cap_diag_length == 0) {
 		fprintf(stderr, "INFO : WDC : Capture Diagnostics log is empty\n");
 	} else {
-		if (xfer_size == 0)
-			xfer_size = cap_diag_length;
-
 		ret = wdc_do_dump_e6(fd, WDC_NVME_CAP_DIAG_OPCODE, cap_diag_length,
 						(WDC_NVME_CAP_DIAG_SUBCMD << WDC_NVME_SUBCMD_SHIFT) | WDC_NVME_CAP_DIAG_CMD,
 						file, xfer_size, (__u8 *)log_hdr);
@@ -1218,11 +1228,12 @@ static int wdc_do_cap_diag(int fd, char *file, __u32 xfer_size)
 		fprintf(stderr, "INFO : WDC : Capture Diagnostics log, length = 0x%x\n", cap_diag_length);
 	}
 
+out:
 	free(log_hdr);
 	return ret;
 }
 
-static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size)
+static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size, int data_area)
 {
 	int ret = 0;
 	__u32 dui_log_hdr_size = WDC_NVME_CAP_DUI_HEADER_SIZE;
@@ -1231,7 +1242,8 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size)
 	__u8 *dump_data;
 	__u64 buffer_addr;
 	__u32 curr_data_offset;
-	__s32 log_size;
+	__s32 log_size = 0;
+	__s32 total_size = 0;
 	int i;
 
 	log_hdr = (struct wdc_dui_log_hdr *) malloc(dui_log_hdr_size);
@@ -1242,16 +1254,11 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size)
 	memset(log_hdr, 0, dui_log_hdr_size);
 
 	/* get the dui telemetry and log headers  */
-	ret = wdc_dump_dui_data(fd,
-						WDC_NVME_CAP_DUI_HEADER_SIZE,
-						0x00,
-						(__u8 *)log_hdr);
+	ret = wdc_dump_dui_data(fd, WDC_NVME_CAP_DUI_HEADER_SIZE, 0x00,	(__u8 *)log_hdr);
 	if (ret != 0) {
-		free(log_hdr);
 		fprintf(stderr, "%s: ERROR : WDC : Get DUI headers failed\n", __func__);
 		fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
-
-		return ret;
+		goto out;
 	}
 
 	cap_dui_length = (log_hdr->log_size[3] << 24 | log_hdr->log_size[2] << 16 |
@@ -1260,24 +1267,35 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size)
 	if (cap_dui_length == 0) {
 		fprintf(stderr, "INFO : WDC : Capture Device Unit Info log is empty\n");
 	} else {
-		if (xfer_size == 0)
-			xfer_size = cap_dui_length;
 
-		dump_data = (__u8 *) malloc(sizeof (__u8) * cap_dui_length);
+		/* parse log header for all sections up to specified data area inclusively */
+		if (data_area != WDC_NVME_DUI_MAX_DATA_AREA) {
+			for(int i = 0; i < WDC_NVME_DUI_MAX_SECTION; i++) {
+				if (log_hdr->log_section[i].data_area_id <= data_area &&
+				    log_hdr->log_section[i].data_area_id != 0)
+					log_size += log_hdr->log_section[i].section_size;
+				else
+					break;
+			}
+		} else
+			log_size = cap_dui_length;
 
+		total_size = log_size;
+		dump_data = (__u8 *) malloc(sizeof (__u8) * total_size);
 		if (dump_data == NULL) {
 			fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
-			return -1;
+			ret = -1;
+			goto out;
 		}
-		memset(dump_data, 0, sizeof (__u8) * cap_dui_length);
+		memset(dump_data, 0, sizeof (__u8) * total_size);
 
 		/* copy the telemetry and log headers into the dump_data buffer */
 		memcpy(dump_data, log_hdr, WDC_NVME_CAP_DUI_HEADER_SIZE);
 
+		log_size -= WDC_NVME_CAP_DUI_HEADER_SIZE;
 		curr_data_offset = WDC_NVME_CAP_DUI_HEADER_SIZE;
 		i = 0;
 
-		log_size = (cap_dui_length - WDC_NVME_CAP_DUI_HEADER_SIZE);
 		for(; log_size > 0; log_size -= xfer_size) {
 			xfer_size = min(xfer_size, log_size);
 
@@ -1285,7 +1303,7 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size)
 			ret = wdc_dump_dui_data(fd, xfer_size, curr_data_offset, (__u8 *)buffer_addr);
 			if (ret != 0) {
 				fprintf(stderr, "%s: ERROR : WDC : Get chunk %d, size = 0x%x, offset = 0x%x, addr = 0x%lx\n",
-						__func__, i, cap_dui_length, curr_data_offset, (long unsigned int)buffer_addr);
+						__func__, i, total_size, curr_data_offset, (long unsigned int)buffer_addr);
 				fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
 				break;
 			}
@@ -1296,12 +1314,13 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size)
 
 		if (ret == 0) {
 			fprintf(stderr, "%s:  NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
-			fprintf(stderr, "INFO : WDC : Capture Device Unit Info log, length = 0x%x\n", cap_dui_length);
+			fprintf(stderr, "INFO : WDC : Capture Device Unit Info log, length = 0x%x\n", total_size);
 
-			ret = wdc_create_log_file(file, dump_data, cap_dui_length);
+			ret = wdc_create_log_file(file, dump_data, total_size);
 		}
 		free(dump_data);
 	}
+out:
 	free(log_hdr);
 	return ret;
 }
@@ -1595,6 +1614,7 @@ static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command
 	char *desc = "Internal Firmware Log.";
 	char *file = "Output file pathname.";
 	char *size = "Data retrieval transfer size.";
+	char *data_area = "Data area to retrieve up to.";
 	char f[PATH_MAX] = {0};
 	char fileSuffix[PATH_MAX] = {0};
 	__u32 xfer_size = 0;
@@ -1606,16 +1626,19 @@ static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command
 	struct config {
 		char *file;
 		__u32 xfer_size;
+		int data_area;
 	};
 
 	struct config cfg = {
 		.file = NULL,
-		.xfer_size = 0x10000
+		.xfer_size = 0x10000,
+		.data_area = 5
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"output-file", 'o', "FILE", CFG_STRING, &cfg.file, required_argument, file},
 		{"transfer-size", 's', "NUM", CFG_POSITIVE, &cfg.xfer_size, required_argument, size},
+		{"data-area", 'd', "NUM", CFG_POSITIVE, &cfg.data_area, required_argument, data_area},
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
 	};
 
@@ -1625,8 +1648,11 @@ static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command
 
 	if (!wdc_check_device(fd))
 		return -1;
-	if (cfg.xfer_size != 0) {
+	if (cfg.xfer_size != 0)
 		xfer_size = cfg.xfer_size;
+	else {
+		fprintf(stderr, "ERROR : WDC : Invalid length\n");
+		return -1;
 	}
 
 	if (cfg.file != NULL) {
@@ -1657,11 +1683,18 @@ static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command
 		snprintf(f + strlen(f), PATH_MAX, "%s", ".bin");
 	fprintf(stderr, "%s: filename = %s\n", __func__, f);
 
+	if (cfg.data_area > 5 || cfg.data_area == 0) {
+		fprintf(stderr, "ERROR : WDC: Data area must be 1-5\n");
+		return -1;
+	}
+
 	capabilities = wdc_get_drive_capabilities(fd);
 	if ((capabilities & WDC_DRIVE_CAP_INTERNAL_LOG) == WDC_DRIVE_CAP_INTERNAL_LOG) {
 		return wdc_do_cap_diag(fd, f, xfer_size);
+	} else if ((capabilities & WDC_DRIVE_CAP_SN340_DUI) == WDC_DRIVE_CAP_SN340_DUI) {
+		return wdc_do_cap_dui(fd, f, xfer_size, cfg.data_area);
 	} else if ((capabilities & WDC_DRIVE_CAP_DUI_DATA) == WDC_DRIVE_CAP_DUI_DATA) {
-		return wdc_do_cap_dui(fd, f, xfer_size);
+		return wdc_do_cap_dui(fd, f, xfer_size, WDC_NVME_DUI_MAX_DATA_AREA);
 	} else if ((capabilities & WDC_SN730_CAP_VUC_LOG) == WDC_SN730_CAP_VUC_LOG) {
 		return wdc_do_sn730_get_and_tar(fd, f);
 	} else {
-- 
2.7.4
