From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Tue, 30 Apr 2019 18:48:32 +0000
Subject: [PATCH] [NVMe-CLI] Add Disable IO flag to wdc_dump_dui_data function
Message-ID: <1556650099-28572-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index f3744ce..4e9cfa3 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -126,6 +126,7 @@
 /* Capture Device Unit Info */
 #define WDC_NVME_CAP_DUI_HEADER_SIZE			0x400
 #define WDC_NVME_CAP_DUI_OPCODE				0xFA
+#define WDC_NVME_CAP_DUI_DISABLE_IO         0x01
 #define WDC_NVME_DUI_MAX_SECTION			0x3A
 #define WDC_NVME_DUI_MAX_DATA_AREA			0x05
 
@@ -1061,7 +1062,7 @@ static __u32 wdc_dump_length_e6(int fd, __u32 opcode, __u32 cdw10, __u32 cdw12,
 	return ret;
 }
 
-static __u32 wdc_dump_dui_data(int fd, __u32 dataLen, __u32 offset, __u8 *dump_data)
+static __u32 wdc_dump_dui_data(int fd, __u32 dataLen, __u32 offset, __u8 *dump_data, bool last_xfer)
 {
 	int ret;
 	struct nvme_admin_cmd admin_cmd;
@@ -1073,6 +1074,11 @@ static __u32 wdc_dump_dui_data(int fd, __u32 dataLen, __u32 offset, __u8 *dump_d
 	admin_cmd.data_len = dataLen;
 	admin_cmd.cdw10 = ((dataLen >> 2) - 1);
 	admin_cmd.cdw12 = offset;
+	if (last_xfer)
+		admin_cmd.cdw14 = 0;
+	else
+		admin_cmd.cdw14 = WDC_NVME_CAP_DUI_DISABLE_IO;
+
 
 	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
 	if (ret != 0) {
@@ -1258,6 +1264,7 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size, int data_area)
 	__s32 log_size = 0;
 	__s32 total_size = 0;
 	int i;
+	bool last_xfer = false;
 
 	log_hdr = (struct wdc_dui_log_hdr *) malloc(dui_log_hdr_size);
 	if (log_hdr == NULL) {
@@ -1267,7 +1274,7 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size, int data_area)
 	memset(log_hdr, 0, dui_log_hdr_size);
 
 	/* get the dui telemetry and log headers  */
-	ret = wdc_dump_dui_data(fd, WDC_NVME_CAP_DUI_HEADER_SIZE, 0x00,	(__u8 *)log_hdr);
+	ret = wdc_dump_dui_data(fd, WDC_NVME_CAP_DUI_HEADER_SIZE, 0x00,	(__u8 *)log_hdr, last_xfer);
 	if (ret != 0) {
 		fprintf(stderr, "%s: ERROR : WDC : Get DUI headers failed\n", __func__);
 		fprintf(stderr, "%s: ERROR : WDC : NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
@@ -1312,8 +1319,12 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size, int data_area)
 		for(; log_size > 0; log_size -= xfer_size) {
 			xfer_size = min(xfer_size, log_size);
 
+			if (log_size <= xfer_size)
+				last_xfer = true;
+
 			buffer_addr = (__u64)(uintptr_t)dump_data + (__u64)curr_data_offset;
-			ret = wdc_dump_dui_data(fd, xfer_size, curr_data_offset, (__u8 *)buffer_addr);
+
+			ret = wdc_dump_dui_data(fd, xfer_size, curr_data_offset, (__u8 *)buffer_addr, last_xfer);
 			if (ret != 0) {
 				fprintf(stderr, "%s: ERROR : WDC : Get chunk %d, size = 0x%x, offset = 0x%x, addr = 0x%lx\n",
 						__func__, i, total_size, curr_data_offset, (long unsigned int)buffer_addr);
-- 
1.8.3.1
