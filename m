From: hare@suse.de (Hannes Reinecke)
Date: Thu, 20 Sep 2018 11:09:38 +0200
Subject: [PATCH 5/6] nvme-cli: Add 'rae' argument to nvme_get_log()
In-Reply-To: <20180920090939.6348-1-hare@suse.de>
References: <20180920090939.6348-1-hare@suse.de>
Message-ID: <20180920090939.6348-6-hare@suse.de>

We should be setting the 'rae' bit when sending a log page; we don't
want to accidentally overwriting any outstanding AENs when calling
nvme-cli.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 intel-nvme.c    | 12 ++++++++----
 memblaze-nvme.c |  3 ++-
 nvme-ioctl.c    | 27 +++++++++++++++++----------
 nvme-ioctl.h    |  3 ++-
 seagate-nvme.c  | 12 ++++++------
 toshiba-nvme.c  |  2 +-
 wdc-nvme.c      | 10 +++++-----
 7 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index 67b8003..e65ed4a 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -254,7 +254,8 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, cfg.namespace_id, 0xca, sizeof(smart_log), &smart_log);
+	err = nvme_get_log(fd, cfg.namespace_id, 0xca, false,
+			   sizeof(smart_log), &smart_log);
 	if (!err) {
 		if (cfg.json)
 			show_intel_smart_log_jsn(&smart_log, cfg.namespace_id, devicename);
@@ -292,7 +293,8 @@ static int get_market_log(int argc, char **argv, struct command *cmd, struct plu
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, NVME_NSID_ALL, 0xdd, sizeof(log), log);
+	err = nvme_get_log(fd, NVME_NSID_ALL, 0xdd, false,
+			   sizeof(log), log);
 	if (!err) {
 		if (!cfg.raw_binary)
 			printf("Intel Marketing Name Log:\n%s\n", log);
@@ -354,7 +356,8 @@ static int get_temp_stats_log(int argc, char **argv, struct command *cmd, struct
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, NVME_NSID_ALL, 0xc5, sizeof(stats), &stats);
+	err = nvme_get_log(fd, NVME_NSID_ALL, 0xc5, false,
+			   sizeof(stats), &stats);
 	if (!err) {
 		if (!cfg.raw_binary)
 			show_temp_stats(&stats);
@@ -422,7 +425,8 @@ static int get_lat_stats_log(int argc, char **argv, struct command *cmd, struct
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, NVME_NSID_ALL, cfg.write ? 0xc2 : 0xc1, sizeof(stats), &stats);
+	err = nvme_get_log(fd, NVME_NSID_ALL, cfg.write ? 0xc2 : 0xc1,
+			   false, sizeof(stats), &stats);
 	if (!err) {
 		if (!cfg.raw_binary)
 			show_lat_stats(&stats, cfg.write);
diff --git a/memblaze-nvme.c b/memblaze-nvme.c
index a5a74d3..471f31c 100644
--- a/memblaze-nvme.c
+++ b/memblaze-nvme.c
@@ -225,7 +225,8 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, cfg.namespace_id, 0xca, sizeof(smart_log), &smart_log);
+	err = nvme_get_log(fd, cfg.namespace_id, 0xca, false,
+			   sizeof(smart_log), &smart_log);
 	if (!err) {
 		if (!cfg.raw_binary)
 			err = show_memblaze_smart_log(fd, cfg.namespace_id, devicename, &smart_log);
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index b168699..dc9aad8 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -419,7 +419,8 @@ int nvme_get_log13(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
 
 }
 
-int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data)
+int nvme_get_log(int fd, __u32 nsid, __u8 log_id, bool rae,
+		 __u32 data_len, void *data)
 {
 	void *ptr = data;
 	__u32 offset = 0, xfer_len = data_len;
@@ -436,7 +437,7 @@ int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data)
 			xfer_len = 4096;
 
 		ret = nvme_get_log13(fd, nsid, log_id, NVME_NO_LOG_LSP,
-				     offset, 0, false, xfer_len, ptr);
+				     offset, 0, rae, xfer_len, ptr);
 		if (ret)
 			return ret;
 
@@ -466,18 +467,21 @@ int nvme_get_telemetry_log(int fd, void *lp, int generate_report,
 
 int nvme_fw_log(int fd, struct nvme_firmware_log_page *fw_log)
 {
-	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_FW_SLOT, sizeof(*fw_log), fw_log);
+	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_FW_SLOT, true,
+			sizeof(*fw_log), fw_log);
 }
 
 int nvme_changed_ns_list_log(int fd, struct nvme_changed_ns_list_log *changed_ns_list_log)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_CHANGED_NS, sizeof(changed_ns_list_log->log),
+	return nvme_get_log(fd, 0, NVME_LOG_CHANGED_NS, true,
+			sizeof(changed_ns_list_log->log),
 			changed_ns_list_log->log);
 }
 
 int nvme_error_log(int fd, int entries, struct nvme_error_log_page *err_log)
 {
-	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_ERROR, entries * sizeof(*err_log), err_log);
+	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_ERROR, false,
+			entries * sizeof(*err_log), err_log);
 }
 
 int nvme_endurance_log(int fd, __u16 group_id, struct nvme_endurance_group_log *endurance_log)
@@ -488,7 +492,8 @@ int nvme_endurance_log(int fd, __u16 group_id, struct nvme_endurance_group_log *
 
 int nvme_smart_log(int fd, __u32 nsid, struct nvme_smart_log *smart_log)
 {
-	return nvme_get_log(fd, nsid, NVME_LOG_SMART, sizeof(*smart_log), smart_log);
+	return nvme_get_log(fd, nsid, NVME_LOG_SMART, false,
+			sizeof(*smart_log), smart_log);
 }
 
 int nvme_ana_log(int fd, void *ana_log, size_t ana_log_len, int rgo)
@@ -501,23 +506,25 @@ int nvme_ana_log(int fd, void *ana_log, size_t ana_log_len, int rgo)
 
 int nvme_self_test_log(int fd, struct nvme_self_test_log *self_test_log)
 {
-	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_DEVICE_SELF_TEST,
+	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_DEVICE_SELF_TEST, false,
 		sizeof(*self_test_log), self_test_log);
 }
 
 int nvme_effects_log(int fd, struct nvme_effects_log_page *effects_log)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_CMD_EFFECTS, sizeof(*effects_log), effects_log);
+	return nvme_get_log(fd, 0, NVME_LOG_CMD_EFFECTS, false,
+			sizeof(*effects_log), effects_log);
 }
 
 int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_DISC, size, log);
+	return nvme_get_log(fd, 0, NVME_LOG_DISC, true, size, log);
 }
 
 int nvme_sanitize_log(int fd, struct nvme_sanitize_log_page *sanitize_log)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_SANITIZE, sizeof(*sanitize_log), sanitize_log);
+	return nvme_get_log(fd, 0, NVME_LOG_SANITIZE, false,
+			sizeof(*sanitize_log), sanitize_log);
 }
 
 int nvme_feature(int fd, __u8 opcode, __u32 nsid, __u32 cdw10, __u32 cdw11,
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index d3823a4..b6abade 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -82,7 +82,8 @@ int nvme_identify_ns_descs(int fd, __u32 nsid, void *data);
 int nvme_identify_nvmset(int fd, __u16 nvmset_id, void *data);
 int nvme_get_log13(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
 		   __u16 group_id, bool rae, __u32 data_len, void *data);
-int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data);
+int nvme_get_log(int fd, __u32 nsid, __u8 log_id, bool rae,
+		 __u32 data_len, void *data);
 
 
 int nvme_get_telemetry_log(int fd, void *lp, int generate_report,
diff --git a/seagate-nvme.c b/seagate-nvme.c
index 2d8c708..15a91ef 100755
--- a/seagate-nvme.c
+++ b/seagate-nvme.c
@@ -180,7 +180,7 @@ static int log_pages_supp(int argc, char **argv, struct command *cmd,
 	fd = parse_and_open(argc, argv, desc, command_line_options,
 			    &cfg, sizeof(cfg));
 
-	err = nvme_get_log(fd, 1, 0xc5, sizeof(logPageMap), &logPageMap);
+	err = nvme_get_log(fd, 1, 0xc5, false, sizeof(logPageMap), &logPageMap);
 	if (!err) {
 		if (strcmp(cfg.output_format,"json")) {
 			printf ("Seagate Supported Log-pages count :%d\n",
@@ -743,7 +743,7 @@ static int vs_smart_log(int argc, char **argv, struct command *cmd, struct plugi
 	if (strcmp(cfg.output_format,"json"))
 		printf("Seagate Extended SMART Information :\n");
 
-	err = nvme_get_log(fd, 1, 0xC4, sizeof(ExtdSMARTInfo), &ExtdSMARTInfo);
+	err = nvme_get_log(fd, 1, 0xC4, false, sizeof(ExtdSMARTInfo), &ExtdSMARTInfo);
 	if (!err) {
 		if (strcmp(cfg.output_format,"json")) {
 			printf("%-39s %-15s %-19s \n", "Description", "Ext-Smart-Id", "Ext-Smart-Value");
@@ -765,7 +765,7 @@ static int vs_smart_log(int argc, char **argv, struct command *cmd, struct plugi
 		 * Next get Log Page 0xCF
 		 */
 
-		err = nvme_get_log(fd, 1, 0xCF, sizeof(logPageCF), &logPageCF);
+		err = nvme_get_log(fd, 1, 0xCF, false, sizeof(logPageCF), &logPageCF);
 		if (!err) {
 			if(strcmp(cfg.output_format,"json")) {
 				/*printf("Seagate DRAM Supercap SMART Attributes :\n");*/
@@ -861,7 +861,7 @@ static int temp_stats(int argc, char **argv, struct command *cmd, struct plugin
 	}
 
 	// STEP-2 : Get Max temperature form Ext SMART-id 194
-	err = nvme_get_log(fd, 1, 0xC4, sizeof(ExtdSMARTInfo), &ExtdSMARTInfo);
+	err = nvme_get_log(fd, 1, 0xC4, false, sizeof(ExtdSMARTInfo), &ExtdSMARTInfo);
 	if (!err) {
 		for(index = 0; index < NUMBER_EXTENDED_SMART_ATTRIBUTES; index++) {
 			if (ExtdSMARTInfo.vendorData[index].AttributeNumber == VS_ATTR_ID_MAX_LIFE_TEMPERATURE) {
@@ -883,7 +883,7 @@ static int temp_stats(int argc, char **argv, struct command *cmd, struct plugin
 		fprintf(stderr, "NVMe Status:%s(%x)\n",
 			nvme_status_to_string(err), err);
 
-	cf_err = nvme_get_log(fd, 1, 0xCF, sizeof(ExtdSMARTInfo), &logPageCF);
+	cf_err = nvme_get_log(fd, 1, 0xCF, false, sizeof(ExtdSMARTInfo), &logPageCF);
 
 	if(!cf_err) {
 		scCurrentTemp = logPageCF.AttrCF.SuperCapCurrentTemperature;
@@ -1012,7 +1012,7 @@ static int vs_pcie_error_log(int argc, char **argv, struct command *cmd, struct
 	if(strcmp(cfg.output_format,"json"))
 		printf("Seagate PCIe error counters Information :\n");
 
-	err = nvme_get_log(fd, 1, 0xCB, sizeof(pcieErrorLog), &pcieErrorLog);
+	err = nvme_get_log(fd, 1, 0xCB, false, sizeof(pcieErrorLog), &pcieErrorLog);
 	if (!err) {
 		if(strcmp(cfg.output_format,"json")) {
 			print_vs_pcie_error_log(pcieErrorLog);
diff --git a/toshiba-nvme.c b/toshiba-nvme.c
index d90650b..116c8a0 100644
--- a/toshiba-nvme.c
+++ b/toshiba-nvme.c
@@ -367,7 +367,7 @@ static int nvme_get_vendor_log(int fd, __u32 namespace_id, int log_page, const c
 	if (err) {
 		goto end;
 	}
-	err = nvme_get_log(fd, namespace_id, log_page,
+	err = nvme_get_log(fd, namespace_id, log_page, false,
 		    log_len, log);
 	if (err) {
 		fprintf(stderr, "%s: couldn't get log 0x%x\n", __func__, log_page);
diff --git a/wdc-nvme.c b/wdc-nvme.c
index 5dd1d9d..dd6d34a 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -603,7 +603,7 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 
 	/* get the log page length */
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
-			   WDC_C2_LOG_BUF_LEN, data);
+			   false, WDC_C2_LOG_BUF_LEN, data);
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : Unable to get C2 Log Page length, ret = %d\n", ret);
 		goto out;
@@ -617,7 +617,7 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 	}
 
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
-			   hdr_ptr->length, data);
+			   false,  hdr_ptr->length, data);
 	/* parse the data until the List of log page ID's is found */
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : Unable to read C2 Log Page data, ret = %d\n", ret);
@@ -1371,7 +1371,7 @@ static int wdc_get_ca_log_page(int fd, char *format)
 	memset(data, 0, sizeof (__u8) * WDC_CA_LOG_BUF_LEN);
 
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE,
-			   WDC_CA_LOG_BUF_LEN, data);
+			   false, WDC_CA_LOG_BUF_LEN, data);
 	if (strcmp(format, "json"))
 		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 
@@ -1420,7 +1420,7 @@ static int wdc_get_c1_log_page(int fd, char *format, uint8_t interval)
 	memset(data, 0, sizeof (__u8) * WDC_ADD_LOG_BUF_LEN);
 
 	ret = nvme_get_log(fd, 0x01, WDC_NVME_ADD_LOG_OPCODE,
-			   WDC_ADD_LOG_BUF_LEN, data);
+			   false, WDC_ADD_LOG_BUF_LEN, data);
 	if (strcmp(format, "json"))
 		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	if (ret == 0) {
@@ -2107,7 +2107,7 @@ static int wdc_do_drive_essentials(int fd, char *dir, char *key)
 		memset(dataBuffer, 0, dataBufferSize);
 
 		ret = nvme_get_log(fd, WDC_DE_GLOBAL_NSID, deVULogPagesList[vuLogIdx].logPageId,
-				   dataBufferSize, dataBuffer);
+				   false, dataBufferSize, dataBuffer);
 		if (ret) {
 			fprintf(stderr, "ERROR : WDC : nvme_get_log() for log page 0x%x failed, ret = %d\n",
 					deVULogPagesList[vuLogIdx].logPageId, ret);
-- 
2.13.7
