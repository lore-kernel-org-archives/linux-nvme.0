From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 22 Jan 2018 13:35:34 -0700
Subject: [PATCH] nvme-cli: Implement nvme_get_log13
Message-ID: <20180122203534.22765-1-scott.bauer@intel.com>

This fixes a portion of 722c71bb:
nvme/vendor: Add get log LSP/LSO fields from 1.3 spec

This fixes up the code so it can use the same interface
log we've had for awhile. People who wish to pass log
specific parameters can use the new API.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 intel-nvme.c    | 16 ++++------------
 memblaze-nvme.c |  4 +---
 nvme-ioctl.c    | 45 ++++++++++++++++++++-------------------------
 nvme-ioctl.h    |  6 ++++--
 nvme.c          |  6 +++---
 wdc-nvme.c      | 10 +++++-----
 6 files changed, 37 insertions(+), 50 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index 7b32303..7a44683 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -255,9 +255,7 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, cfg.namespace_id, 0xca,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   sizeof(smart_log), &smart_log);
+	err = nvme_get_log(fd, cfg.namespace_id, 0xca, sizeof(smart_log), &smart_log);
 	if (!err) {
 		if (cfg.json)
 			show_intel_smart_log_jsn(&smart_log, cfg.namespace_id, devicename);
@@ -295,9 +293,7 @@ static int get_market_log(int argc, char **argv, struct command *cmd, struct plu
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, NVME_NSID_ALL, 0xdd,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   sizeof(log), log);
+	err = nvme_get_log(fd, NVME_NSID_ALL, 0xdd, sizeof(log), log);
 	if (!err) {
 		if (!cfg.raw_binary)
 			printf("Intel Marketing Name Log:\n%s\n", log);
@@ -359,9 +355,7 @@ static int get_temp_stats_log(int argc, char **argv, struct command *cmd, struct
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, NVME_NSID_ALL, 0xc5,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   sizeof(stats), &stats);
+	err = nvme_get_log(fd, NVME_NSID_ALL, 0xc5, sizeof(stats), &stats);
 	if (!err) {
 		if (!cfg.raw_binary)
 			show_temp_stats(&stats);
@@ -429,9 +423,7 @@ static int get_lat_stats_log(int argc, char **argv, struct command *cmd, struct
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, NVME_NSID_ALL, cfg.write ? 0xc2 : 0xc1,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   sizeof(stats), &stats);
+	err = nvme_get_log(fd, NVME_NSID_ALL, cfg.write ? 0xc2 : 0xc1, sizeof(stats), &stats);
 	if (!err) {
 		if (!cfg.raw_binary)
 			show_lat_stats(&stats, cfg.write);
diff --git a/memblaze-nvme.c b/memblaze-nvme.c
index 56af140..259022e 100644
--- a/memblaze-nvme.c
+++ b/memblaze-nvme.c
@@ -225,9 +225,7 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, cfg.namespace_id, 0xca,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   sizeof(smart_log), &smart_log);
+	err = nvme_get_log(fd, cfg.namespace_id, 0xca, sizeof(smart_log), &smart_log);
 	if (!err) {
 		if (!cfg.raw_binary)
 			err = show_memblaze_smart_log(fd, cfg.namespace_id, devicename, &smart_log);
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 5c900b7..454a2b9 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -381,7 +381,7 @@ int nvme_identify_ns_descs(int fd, __u32 nsid, void *data)
 	return nvme_identify(fd, nsid, NVME_ID_CNS_NS_DESC_LIST, data);
 }
 
-int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
+int nvme_get_log13(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
                  __u32 data_len, void *data)
 {
 	struct nvme_admin_cmd cmd = {
@@ -402,61 +402,56 @@ int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
 	cmd.cdw13 = (lpo >> 32);
 
 	return nvme_submit_admin_passthru(fd, &cmd);
+
+}
+
+int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data)
+{
+	return nvme_get_log13(fd, nsid, log_id, NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
+			      data_len, data);
 }
 
 int nvme_get_telemetry_log(int fd, void *lp, int generate_report,
 			   size_t log_page_size, __u64 offset)
 {
 	if (generate_report)
-		return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_TELEMETRY_HOST,
-				    NVME_TELEM_LSP_CREATE, offset,
-				    log_page_size, lp);
+		return nvme_get_log13(fd, NVME_NSID_ALL, NVME_LOG_TELEMETRY_HOST,
+				      NVME_TELEM_LSP_CREATE, offset,
+				      log_page_size, lp);
 	else
-		return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_TELEMETRY_HOST,
-				    NVME_NO_LOG_LSP, offset,
-				    log_page_size, lp);
+		return nvme_get_log13(fd, NVME_NSID_ALL, NVME_LOG_TELEMETRY_HOST,
+				      NVME_NO_LOG_LSP, offset,
+				      log_page_size, lp);
 }
 
 int nvme_fw_log(int fd, struct nvme_firmware_log_page *fw_log)
 {
-	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_FW_SLOT,
-			    NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			    sizeof(*fw_log), fw_log);
+	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_FW_SLOT, sizeof(*fw_log), fw_log);
 }
 
 int nvme_error_log(int fd, int entries, struct nvme_error_log_page *err_log)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_ERROR,
-			    NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			    entries * sizeof(*err_log), err_log);
+	return nvme_get_log(fd, 0, NVME_LOG_ERROR, entries * sizeof(*err_log), err_log);
 }
 
 int nvme_smart_log(int fd, __u32 nsid, struct nvme_smart_log *smart_log)
 {
-	return nvme_get_log(fd, nsid, NVME_LOG_SMART,
-			    NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			    sizeof(*smart_log), smart_log);
+	return nvme_get_log(fd, nsid, NVME_LOG_SMART, sizeof(*smart_log), smart_log);
 }
 
 int nvme_effects_log(int fd, struct nvme_effects_log_page *effects_log)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_CMD_EFFECTS,
-			    NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			    sizeof(*effects_log), effects_log);
+	return nvme_get_log(fd, 0, NVME_LOG_CMD_EFFECTS, sizeof(*effects_log), effects_log);
 }
 
 int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_DISC,
-			    NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			    size, log);
+	return nvme_get_log(fd, 0, NVME_LOG_DISC, size, log);
 }
 
 int nvme_sanitize_log(int fd, struct nvme_sanitize_log_page *sanitize_log)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_SANITIZE,
-			    NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			    sizeof(*sanitize_log), sanitize_log);
+	return nvme_get_log(fd, 0, NVME_LOG_SANITIZE, sizeof(*sanitize_log), sanitize_log);
 }
 
 int nvme_feature(int fd, __u8 opcode, __u32 nsid, __u32 cdw10, __u32 cdw11,
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 4031c70..6569665 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -78,8 +78,10 @@ int nvme_identify_ns(int fd, __u32 nsid, bool present, void *data);
 int nvme_identify_ns_list(int fd, __u32 nsid, bool all, void *data);
 int nvme_identify_ctrl_list(int fd, __u32 nsid, __u16 cntid, void *data);
 int nvme_identify_ns_descs(int fd, __u32 nsid, void *data);
-int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
-                 __u32 data_len, void *data);
+int nvme_get_log13(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
+		   __u32 data_len, void *data);
+int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data);
+
 
 int nvme_get_telemetry_log(int fd, void *lp, int generate_report,
 			   size_t log_page_size, __u64 offset);
diff --git a/nvme.c b/nvme.c
index 2723cb6..aa2b8ec 100644
--- a/nvme.c
+++ b/nvme.c
@@ -579,9 +579,9 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 			return EINVAL;
 		}
 
-		err = nvme_get_log(fd, cfg.namespace_id, cfg.log_id,
-				   cfg.lsp, cfg.lpo,
-				   cfg.log_len, log);
+		err = nvme_get_log13(fd, cfg.namespace_id, cfg.log_id,
+				     cfg.lsp, cfg.lpo,
+				     cfg.log_len, log);
 		if (!err) {
 			if (!cfg.raw_binary) {
 				printf("Device:%s log-id:%d namespace-id:%#x\n",
diff --git a/wdc-nvme.c b/wdc-nvme.c
index 9590a9c..e62a582 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -590,7 +590,7 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 
 	/* get the log page length */
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, WDC_C2_LOG_BUF_LEN, data);
+			   WDC_C2_LOG_BUF_LEN, data);
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : Unable to get C2 Log Page length, ret = %d\n", ret);
 		goto out;
@@ -604,7 +604,7 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 	}
 
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, hdr_ptr->length, data);
+			   hdr_ptr->length, data);
 	/* parse the data until the List of log page ID's is found */
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : Unable to read C2 Log Page data, ret = %d\n", ret);
@@ -1339,7 +1339,7 @@ static int wdc_get_ca_log_page(int fd, char *format)
 	memset(data, 0, sizeof (__u8) * WDC_CA_LOG_BUF_LEN);
 
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, WDC_CA_LOG_BUF_LEN, data);
+			   WDC_CA_LOG_BUF_LEN, data);
 	if (strcmp(format, "json"))
 		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 
@@ -1388,7 +1388,7 @@ static int wdc_get_c1_log_page(int fd, char *format, uint8_t interval)
 	memset(data, 0, sizeof (__u8) * WDC_ADD_LOG_BUF_LEN);
 
 	ret = nvme_get_log(fd, 0x01, WDC_NVME_ADD_LOG_OPCODE,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, WDC_ADD_LOG_BUF_LEN, data);
+			   WDC_ADD_LOG_BUF_LEN, data);
 	if (strcmp(format, "json"))
 		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	if (ret == 0) {
@@ -2075,7 +2075,7 @@ static int wdc_do_drive_essentials(int fd, char *dir, char *key)
 		memset(dataBuffer, 0, dataBufferSize);
 
 		ret = nvme_get_log(fd, WDC_DE_GLOBAL_NSID, deVULogPagesList[vuLogIdx].logPageId,
-				NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, dataBufferSize, dataBuffer);
+				   dataBufferSize, dataBuffer);
 		if (ret) {
 			fprintf(stderr, "ERROR : WDC : nvme_get_log() for log page 0x%x failed, ret = %d\n",
 					deVULogPagesList[vuLogIdx].logPageId, ret);
-- 
2.11.0
