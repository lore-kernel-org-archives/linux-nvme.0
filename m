From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Mon, 3 Jun 2019 21:30:08 +0000
Subject: [PATCH] Add support for 64 bit addresses in Get DUI Data functions
Message-ID: <1559597395-26582-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 223 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 170 insertions(+), 53 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index a1cb1eb..d122c16 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -129,6 +129,7 @@
 #define WDC_NVME_CAP_DUI_OPCODE				0xFA
 #define WDC_NVME_CAP_DUI_DISABLE_IO         0x01
 #define WDC_NVME_DUI_MAX_SECTION			0x3A
+#define WDC_NVME_DUI_MAX_SECTION_V2			0x26
 #define WDC_NVME_DUI_MAX_DATA_AREA			0x05
 
 /* Crash dump */
@@ -453,15 +454,31 @@ struct wdc_dui_log_section {
 	__le32	section_size;
 };
 
+/* DUI log header V2 */
+struct __attribute__((__packed__)) wdc_dui_log_section_v2 {
+	__le16	section_type;
+	__le16	data_area_id;
+	__le64	section_size;
+};
+
 struct wdc_dui_log_hdr {
 	__u8    telemetry_hdr[512];
 	__le16	hdr_version;
 	__le16	section_count;
-	__u8	log_size[4];
+	__le32	log_size;
 	struct	wdc_dui_log_section log_section[WDC_NVME_DUI_MAX_SECTION];
 	__u8    log_data[40];
 };
 
+struct __attribute__((__packed__)) wdc_dui_log_hdr_v2 {
+	__u8    telemetry_hdr[512];
+	__le16	hdr_version;
+	__le16	section_count;
+	__le64	log_size;
+	struct	wdc_dui_log_section_v2 log_section[WDC_NVME_DUI_MAX_SECTION_V2];
+	__u8    log_data[40];
+};
+
 /* Purge monitor response */
 struct wdc_nvme_purge_monitor_data {
 	__le16 	rsvd1;
@@ -1081,7 +1098,34 @@ static __u32 wdc_dump_dui_data(int fd, __u32 dataLen, __u32 offset, __u8 *dump_d
 
 	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
 	if (ret != 0) {
-		fprintf(stderr, "ERROR : WDC : reading DUI length failed\n");
+		fprintf(stderr, "ERROR : WDC : reading DUI data failed\n");
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	}
+
+	return ret;
+}
+
+static __u32 wdc_dump_dui_data_v2(int fd, __u32 dataLen, __u64 offset, __u8 *dump_data, bool last_xfer)
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
+	admin_cmd.cdw12 = (__u32)(offset & 0x00000000FFFFFFFF);
+	admin_cmd.cdw13 = (__u32)(offset >> 32);
+	if (last_xfer)
+		admin_cmd.cdw14 = 0;
+	else
+		admin_cmd.cdw14 = WDC_NVME_CAP_DUI_DISABLE_IO;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	if (ret != 0) {
+		fprintf(stderr, "ERROR : WDC : reading DUI data V2 failed\n");
 		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	}
 
@@ -1256,18 +1300,18 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size, int data_area)
 	int ret = 0;
 	__u32 dui_log_hdr_size = WDC_NVME_CAP_DUI_HEADER_SIZE;
 	struct wdc_dui_log_hdr *log_hdr;
+	struct wdc_dui_log_hdr_v2 *log_hdr_v2;
 	__u32 cap_dui_length;
-	__u8 *dump_data;
+	__u64 cap_dui_length_v2;
+	__u8 *dump_data = NULL;
 	__u64 buffer_addr;
-	__u32 curr_data_offset;
-	__s32 log_size = 0;
-	__s32 total_size = 0;
+	__s64 total_size = 0;
 	int i;
 	bool last_xfer = false;
 
 	log_hdr = (struct wdc_dui_log_hdr *) malloc(dui_log_hdr_size);
 	if (log_hdr == NULL) {
-		fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
+		fprintf(stderr, "%s: ERROR : log header malloc failed : %s\n", __func__, strerror(errno));
 		return -1;
 	}
 	memset(log_hdr, 0, dui_log_hdr_size);
@@ -1280,69 +1324,142 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size, int data_area)
 		goto out;
 	}
 
-	cap_dui_length = (log_hdr->log_size[3] << 24 | log_hdr->log_size[2] << 16 |
-			log_hdr->log_size[1] << 8 | log_hdr->log_size[0]);
+	/* Check the Log Header version  */
+	if (log_hdr->hdr_version == 2) {								/* Process Version 2 of the header */
+		__s64 log_size = 0;
+		__u64 curr_data_offset = 0;
+		__u64 xfer_size_long = (__u64)xfer_size;
 
-	if (cap_dui_length == 0) {
-		fprintf(stderr, "INFO : WDC : Capture Device Unit Info log is empty\n");
-	} else {
+		log_hdr_v2 = (struct wdc_dui_log_hdr_v2 *)log_hdr;
 
-		/* parse log header for all sections up to specified data area inclusively */
-		if (data_area != WDC_NVME_DUI_MAX_DATA_AREA) {
-			for(int i = 0; i < WDC_NVME_DUI_MAX_SECTION; i++) {
-				if (log_hdr->log_section[i].data_area_id <= data_area &&
-				    log_hdr->log_section[i].data_area_id != 0)
-					log_size += log_hdr->log_section[i].section_size;
-				else
-					break;
+		cap_dui_length_v2 = le64_to_cpu(log_hdr_v2->log_size);
+
+		fprintf(stderr, "INFO : WDC : Capture V2 Device Unit Info log\n");
+
+		if (cap_dui_length_v2 == 0) {
+			fprintf(stderr, "INFO : WDC : Capture V2 Device Unit Info log is empty\n");
+		} else {
+			/* parse log header for all sections up to specified data area inclusively */
+			if (data_area != WDC_NVME_DUI_MAX_DATA_AREA) {
+				for(int i = 0; i < WDC_NVME_DUI_MAX_SECTION_V2; i++) {
+					if (log_hdr_v2->log_section[i].data_area_id <= data_area &&
+							log_hdr_v2->log_section[i].data_area_id != 0)
+						log_size += log_hdr_v2->log_section[i].section_size;
+					else
+						break;
+				}
+			} else
+				log_size = cap_dui_length_v2;
+
+			total_size = log_size;
+
+			dump_data = (__u8 *) malloc(sizeof (__u8) * total_size);
+			if (dump_data == NULL) {
+				fprintf(stderr, "%s: ERROR : dump data V2 malloc failed : %s, size = 0x%lx\n",
+						__func__, strerror(errno), (long unsigned int)total_size);
+				ret = -1;
+				goto out;
 			}
-		} else
-			log_size = cap_dui_length;
+			memset(dump_data, 0, sizeof (__u8) * total_size);
 
-		total_size = log_size;
-		dump_data = (__u8 *) malloc(sizeof (__u8) * total_size);
-		if (dump_data == NULL) {
-			fprintf(stderr, "%s: ERROR : malloc : %s\n", __func__, strerror(errno));
-			ret = -1;
-			goto out;
+			/* copy the telemetry and log headers into the dump_data buffer */
+			memcpy(dump_data, log_hdr_v2, WDC_NVME_CAP_DUI_HEADER_SIZE);
+
+			log_size -= WDC_NVME_CAP_DUI_HEADER_SIZE;
+			curr_data_offset = WDC_NVME_CAP_DUI_HEADER_SIZE;
+			i = 0;
+
+			for(; log_size > 0; log_size -= xfer_size_long) {
+				xfer_size_long = min(xfer_size_long, log_size);
+
+				if (log_size <= xfer_size_long)
+					last_xfer = true;
+
+				buffer_addr = (__u64)(uintptr_t)dump_data + (__u64)curr_data_offset;
+
+				ret = wdc_dump_dui_data_v2(fd, (__u32)xfer_size_long, curr_data_offset, (__u8 *)buffer_addr, last_xfer);
+				if (ret != 0) {
+					fprintf(stderr, "%s: ERROR : WDC : Get chunk %d, size = 0x%lx, offset = 0x%lx, addr = 0x%lx\n",
+							__func__, i, (long unsigned int)total_size, (long unsigned int)curr_data_offset, (long unsigned int)buffer_addr);
+					fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+					break;
+				}
+
+				curr_data_offset += xfer_size_long;
+				i++;
+			}
 		}
-		memset(dump_data, 0, sizeof (__u8) * total_size);
+	} else	{
+		__s32 log_size = 0;
+		__u32 curr_data_offset = 0;
 
-		/* copy the telemetry and log headers into the dump_data buffer */
-		memcpy(dump_data, log_hdr, WDC_NVME_CAP_DUI_HEADER_SIZE);
+		cap_dui_length = le32_to_cpu(log_hdr->log_size);
 
-		log_size -= WDC_NVME_CAP_DUI_HEADER_SIZE;
-		curr_data_offset = WDC_NVME_CAP_DUI_HEADER_SIZE;
-		i = 0;
+		fprintf(stderr, "INFO : WDC : Capture V1 Device Unit Info log\n");
 
-		for(; log_size > 0; log_size -= xfer_size) {
-			xfer_size = min(xfer_size, log_size);
+		if (cap_dui_length == 0) {
+			fprintf(stderr, "INFO : WDC : Capture V1 Device Unit Info log is empty\n");
+		} else {
+			/* parse log header for all sections up to specified data area inclusively */
+			if (data_area != WDC_NVME_DUI_MAX_DATA_AREA) {
+				for(int i = 0; i < WDC_NVME_DUI_MAX_SECTION; i++) {
+					if (log_hdr->log_section[i].data_area_id <= data_area &&
+							log_hdr->log_section[i].data_area_id != 0)
+						log_size += log_hdr->log_section[i].section_size;
+					else
+						break;
+				}
+			} else
+				log_size = cap_dui_length;
+
+			total_size = log_size;
+			dump_data = (__u8 *) malloc(sizeof (__u8) * total_size);
+			if (dump_data == NULL) {
+				fprintf(stderr, "%s: ERROR : dump data V1 malloc failed : %s\n", __func__, strerror(errno));
+				ret = -1;
+				goto out;
+			}
+			memset(dump_data, 0, sizeof (__u8) * total_size);
 
-			if (log_size <= xfer_size)
-				last_xfer = true;
+			/* copy the telemetry and log headers into the dump_data buffer */
+			memcpy(dump_data, log_hdr, WDC_NVME_CAP_DUI_HEADER_SIZE);
 
-			buffer_addr = (__u64)(uintptr_t)dump_data + (__u64)curr_data_offset;
+			log_size -= WDC_NVME_CAP_DUI_HEADER_SIZE;
+			curr_data_offset = WDC_NVME_CAP_DUI_HEADER_SIZE;
+			i = 0;
 
-			ret = wdc_dump_dui_data(fd, xfer_size, curr_data_offset, (__u8 *)buffer_addr, last_xfer);
-			if (ret != 0) {
-				fprintf(stderr, "%s: ERROR : WDC : Get chunk %d, size = 0x%x, offset = 0x%x, addr = 0x%lx\n",
-						__func__, i, total_size, curr_data_offset, (long unsigned int)buffer_addr);
-				fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
-				break;
+			for(; log_size > 0; log_size -= xfer_size) {
+				xfer_size = min(xfer_size, log_size);
+
+				if (log_size <= xfer_size)
+					last_xfer = true;
+
+				buffer_addr = (__u64)(uintptr_t)dump_data + (__u64)curr_data_offset;
+
+				ret = wdc_dump_dui_data(fd, xfer_size, curr_data_offset, (__u8 *)buffer_addr, last_xfer);
+				if (ret != 0) {
+					fprintf(stderr, "%s: ERROR : WDC : Get chunk %d, size = 0x%lx, offset = 0x%x, addr = 0x%lx\n",
+							__func__, i, (long unsigned int)total_size, curr_data_offset, (long unsigned int)buffer_addr);
+					fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+					break;
+				}
+
+				curr_data_offset += xfer_size;
+				i++;
 			}
 
-			curr_data_offset += xfer_size;
-			i++;
 		}
+	}
 
-		if (ret == 0) {
-			fprintf(stderr, "%s:  NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
-			fprintf(stderr, "INFO : WDC : Capture Device Unit Info log, length = 0x%x\n", total_size);
+	if (ret == 0) {
+		fprintf(stderr, "%s:  NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+		fprintf(stderr, "INFO : WDC : Capture Device Unit Info log, length = 0x%lx\n", (long unsigned int)total_size);
 
-			ret = wdc_create_log_file(file, dump_data, total_size);
-		}
-		free(dump_data);
+		ret = wdc_create_log_file(file, dump_data, total_size);
 	}
+
+	free(dump_data);
+
 out:
 	free(log_hdr);
 	return ret;
-- 
1.8.3.1
