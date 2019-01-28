From: Dong.Ho@wdc.com (Dong Ho)
Date: Mon, 28 Jan 2019 23:32:37 +0000
Subject: [PATCH 1/4] wdc: Add device unit info log extraction
Message-ID: <1548718347-29874-1-git-send-email-dong.ho@wdc.com>

---
 plugins/wdc/wdc-nvme.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 88c5c76..c9744a7 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -107,6 +107,10 @@
 #define WDC_NVME_CRASH_DUMP_TYPE		1
 #define WDC_NVME_PFAIL_DUMP_TYPE		2
 
+/* Capture Device Unit Info */
+#define WDC_NVME_CAP_DUI_HEADER_SIZE  		0x400
+#define WDC_NVME_CAP_DUI_OPCODE      		0xFA
+
 /* Crash dump */
 #define WDC_NVME_CRASH_DUMP_SIZE_OPCODE		WDC_NVME_CAP_DIAG_CMD_OPCODE
 #define WDC_NVME_CRASH_DUMP_SIZE_DATA_LEN	WDC_NVME_LOG_SIZE_DATA_LEN
@@ -384,6 +388,15 @@ struct wdc_e6_log_hdr {
 	__u8	log_size[4];
 };
 
+/* DUI log header */
+struct wdc_dui_log_hdr {
+	__u8    telemetry_hdr[512];
+	__le16	hdr_version;
+	__le16	section_count;
+	__u8	log_size[4];
+	__u8    log_data[504];
+};
+
 /* Purge monitor response */
 struct wdc_nvme_purge_monitor_data {
 	__le16 	rsvd1;
@@ -863,6 +876,28 @@ static __u32 wdc_dump_length_e6(int fd, __u32 opcode, __u32 cdw10, __u32 cdw12,
 	return ret;
 }
 
+static __u32 wdc_dump_dui_data(int fd, __u32 dataLen, __u32 offset, __u8 *dump_data)
+{
+	int ret;
+	struct nvme_admin_cmd admin_cmd;
+
+	memset(&admin_cmd, 0, sizeof (struct nvme_admin_cmd));
+	admin_cmd.opcode = WDC_NVME_CAP_DUI_OPCODE;
+	admin_cmd.nsid = 0xFFFFFFFF;
+	admin_cmd.addr = (__u64)(uintptr_t)dump_data;
+	admin_cmd.data_len = dataLen;
+	admin_cmd.cdw10 = ((dataLen >> 2) - 1);
+	admin_cmd.cdw12 = offset;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	if (ret != 0) {
+		fprintf(stderr, "ERROR : WDC : reading DUI length failed\n");
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	}
+
+	return ret;
+}
+
 static int wdc_do_dump(int fd, __u32 opcode,__u32 data_len,
 		__u32 cdw12, char *file, __u32 xfer_size)
 {
@@ -1030,6 +1065,90 @@ static int wdc_do_cap_diag(int fd, char *file, __u32 xfer_size)
 	return ret;
 }
 
+static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size)
+{
+	int ret = 0;
+	__u32 dui_log_hdr_size = WDC_NVME_CAP_DUI_HEADER_SIZE;
+	struct wdc_dui_log_hdr *log_hdr;
+	__u32 cap_dui_length;
+	__u8 *dump_data;
+	__u64 buffer_addr;
+	__u32 curr_data_offset;
+	__s32 log_size;
+	int i;
+
+	log_hdr = (struct wdc_dui_log_hdr *) malloc(dui_log_hdr_size);
+	if (log_hdr == NULL) {
+		fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
+		return -1;
+	}
+	memset(log_hdr, 0, dui_log_hdr_size);
+
+	/* get the dui telemetry and log headers  */
+	ret = wdc_dump_dui_data(fd,
+						WDC_NVME_CAP_DUI_HEADER_SIZE,
+						0x00,
+						(__u8 *)log_hdr);
+	if (ret != 0) {
+		free(log_hdr);
+		fprintf(stderr, "%s: ERROR : WDC : Get DUI headers failed\n", __func__);
+		fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+
+		return ret;
+	}
+
+	cap_dui_length = (log_hdr->log_size[3] << 24 | log_hdr->log_size[2] << 16 |
+			log_hdr->log_size[1] << 8 | log_hdr->log_size[0]);
+
+	if (cap_dui_length == 0) {
+		fprintf(stderr, "INFO : WDC : Capture Device Unit Info log is empty\n");
+	} else {
+		if (xfer_size == 0)
+			xfer_size = cap_dui_length;
+
+		dump_data = (__u8 *) malloc(sizeof (__u8) * cap_dui_length);
+
+		if (dump_data == NULL) {
+			fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
+			return -1;
+		}
+		memset(dump_data, 0, sizeof (__u8) * cap_dui_length);
+
+		/* copy the telemetry and log headers into the dump_data buffer */
+		memcpy(dump_data, log_hdr, WDC_NVME_CAP_DUI_HEADER_SIZE);
+
+		curr_data_offset = WDC_NVME_CAP_DUI_HEADER_SIZE;
+		i = 0;
+
+		log_size = (cap_dui_length - WDC_NVME_CAP_DUI_HEADER_SIZE);
+		for(; log_size > 0; log_size -= xfer_size) {
+			xfer_size = min(xfer_size, log_size);
+
+			buffer_addr = (__u64)(uintptr_t)dump_data + (__u64)curr_data_offset;
+			ret = wdc_dump_dui_data(fd, xfer_size, curr_data_offset, (__u8 *)buffer_addr);
+			if (ret != 0) {
+				fprintf(stderr, "%s: ERROR : WDC : Get chunk %d, size = 0x%x, offset = 0x%x, addr = 0x%lx\n",
+						__func__, i, cap_dui_length, curr_data_offset, (long unsigned int)buffer_addr);
+				fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+				break;
+			}
+
+			curr_data_offset += xfer_size;
+			i++;
+		}
+
+		if (ret == 0) {
+			fprintf(stderr, "%s:  NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+			fprintf(stderr, "INFO : WDC : Capture Device Unit Info log, length = 0x%x\n", cap_dui_length);
+
+			ret = wdc_create_log_file(file, dump_data, cap_dui_length);
+		}
+		free(dump_data);
+	}
+	free(log_hdr);
+	return ret;
+}
+
 static int wdc_cap_diag(int argc, char **argv, struct command *command,
 		struct plugin *plugin)
 {
@@ -1072,10 +1191,11 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 		fprintf(stderr, "ERROR : WDC: failed to generate file name\n");
 		return -1;
 	}
+	if (cfg.file == NULL)
+		snprintf(f + strlen(f), PATH_MAX, "%s", ".bin");
 
 	capabilities = wdc_get_drive_capabilities(fd);
 	if ((capabilities & WDC_DRIVE_CAP_CAP_DIAG) == WDC_DRIVE_CAP_CAP_DIAG) {
-		snprintf(f + strlen(f), PATH_MAX, "%s", ".bin");
 		return wdc_do_cap_diag(fd, f, xfer_size);
 	} else
 		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
@@ -1369,12 +1489,15 @@ static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command
 			return -1;
 		}
 	}
+	if (cfg.file == NULL)
+		snprintf(f + strlen(f), PATH_MAX, "%s", ".bin");
 	fprintf(stderr, "%s: filename = %s\n", __func__, f);
 
 	capabilities = wdc_get_drive_capabilities(fd);
 	if ((capabilities & WDC_DRIVE_CAP_INTERNAL_LOG) == WDC_DRIVE_CAP_INTERNAL_LOG) {
-		snprintf(f + strlen(f), PATH_MAX, "%s", ".bin");
 		return wdc_do_cap_diag(fd, f, xfer_size);
+	} else if ((capabilities & WDC_DRIVE_CAP_DUI_DATA) == WDC_DRIVE_CAP_DUI_DATA) {
+		return wdc_do_cap_dui(fd, f, xfer_size);
 	} else if ((capabilities & WDC_SN730_CAP_VUC_LOG) == WDC_SN730_CAP_VUC_LOG) {
 		return wdc_do_sn730_get_and_tar(fd, f);
 	} else {
-- 
2.7.4
