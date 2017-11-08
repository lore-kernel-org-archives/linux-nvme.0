From: jeff.lien@wdc.com (jeffreyalien)
Date: Wed,  8 Nov 2017 10:49:47 -0600
Subject: [PATCH 1/2] NVMe-CLI : WDC-Plugin Updated Smart Log Commands
Message-ID: <20171108164947.28987-1-jeff.lien@wdc.com>

From: Jeff Lien <jlien@ddtest-jeff.hgst.com>

Renamed wdc smart-log-add command to vs-smart-add-log-c1 command.
This command is used to return and format the vendor specific data
from the 0xC1 smart log page.
Created the new command: vs-smart-add-log command; used to return
and format the vendor specific data from the 0xCA smart log page.

Signed-off-by: Jeff Lien <jlien at ddtest-jeff.hgst.com>
---
 wdc-nvme.c | 301 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 wdc-nvme.h |  15 +--
 2 files changed, 307 insertions(+), 9 deletions(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index b981298..2ad085e 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -108,6 +108,15 @@
 #define WDC_GET_LOG_PAGE_SSD_PERFORMANCE			0x37
 #define WDC_NVME_GET_STAT_PERF_INTERVAL_LIFETIME	0x0F
 
+/* C2 Log Page */
+#define WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE		0xC2
+#define WDC_C2_LOG_BUF_LEN							0x1000
+#define WDC_C2_LOG_PAGES_SUPPORTED_ID				0x08
+
+/* CA Log Page */
+#define WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE			0xCA
+#define WDC_CA_LOG_BUF_LEN							0x80
+
 static int wdc_get_serial_name(int fd, char *file, size_t len, char *suffix);
 static int wdc_create_log_file(char *file, __u8 *drive_log_data,
 		__u32 drive_log_length);
@@ -126,6 +135,7 @@ static int wdc_purge(int argc, char **argv,
 		struct command *command, struct plugin *plugin);
 static int wdc_purge_monitor(int argc, char **argv,
 		struct command *command, struct plugin *plugin);
+static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id);
 
 /* Drive log data size */
 struct wdc_log_size {
@@ -178,6 +188,47 @@ struct wdc_ssd_perf_stats {
 	__le64	nrbw;			/* NAND Read Before Write			*/
 };
 
+/* Additional C2 Log Page */
+struct wdc_c2_log_page_header {
+	__le32	length;
+	__le32	version;
+};
+
+struct wdc_c2_log_subpage_header {
+	__le32	length;
+	__le32	entry_id;
+	__le32	data;
+};
+
+struct wdc_c2_cbs_data {
+	__le32	length;
+	__u8	data[];
+};
+
+struct __attribute__((__packed__)) wdc_ssd_ca_perf_stats {
+	__le64	nand_bytes_wr_lo;			/* 0x00 - NAND Bytes Written lo				*/
+	__le64	nand_bytes_wr_hi;			/* 0x08 - NAND Bytes Written hi				*/
+	__le64	nand_bytes_rd_lo;			/* 0x10 - NAND Bytes Read lo				*/
+	__le64	nand_bytes_rd_hi;			/* 0x18 - NAND Bytes Read hi				*/
+	__le64	nand_bad_block;				/* 0x20 - NAND Bad Block Count				*/
+	__le64	uncorr_read_count;			/* 0x28 - Uncorrectable Read Count			*/
+	__le64	ecc_error_count;			/* 0x30 - Soft ECC Error Count				*/
+	__le32	ssd_detect_count;			/* 0x38 - SSD End to End Detection Count	*/
+	__le32	ssd_correct_count;			/* 0x3C - SSD End to End Correction Count	*/
+	__le32	data_percent_used;			/* 0x40 - System Data Percent Used			*/
+	__le32	data_erase_max;				/* 0x44 - User Data Erase Counts			*/
+	__le32	data_erase_min;				/* 0x48 - User Data Erase Counts			*/
+	__le64	refresh_count;				/* 0x4c - Refresh Count						*/
+	__le64	program_fail;				/* 0x54 - Program Fail Count				*/
+	__le64	user_erase_fail;			/* 0x5C - User Data Erase Fail Count		*/
+	__le64	system_erase_fail;			/* 0x64 - System Area Erase Fail Count		*/
+	__le16	thermal_throttle_status;	/* 0x6C - Thermal Throttling Status			*/
+	__le16	thermal_throttle_count;		/* 0x6E - Thermal Throttling Count			*/
+	__le64	pcie_corr_error;			/* 0x70 - pcie Correctable Error Count		*/
+	__le32	rsvd1;						/* 0x78 - Reserved							*/
+	__le32	rsvd2;						/* 0x7C - Reserved							*/
+};
+
 static double safe_div_fp(double numerator, double denominator)
 {
 	return denominator ? numerator / denominator : 0;
@@ -280,6 +331,75 @@ static int wdc_create_log_file(char *file, __u8 *drive_log_data,
 	return 0;
 }
 
+static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
+{
+	int i;
+	int ret = -1;
+	int found = 0;
+	__u8* data;
+	__u32 length = 0;
+	struct wdc_c2_cbs_data *cbs_data;
+	struct wdc_c2_log_page_header *hdr_ptr;
+	struct wdc_c2_log_subpage_header *sph;
+
+	if ((data = (__u8*) malloc(sizeof (__u8) * WDC_C2_LOG_BUF_LEN)) == NULL) {
+		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+		return ret;
+	}
+	memset(data, 0, sizeof (__u8) * WDC_C2_LOG_BUF_LEN);
+
+	/* get the log page length */
+	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE, WDC_C2_LOG_BUF_LEN, data);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : Unable to get C2 Log Page length, ret = %d\n", ret);
+		goto out;
+	}
+
+	hdr_ptr = (struct wdc_c2_log_page_header *)data;
+
+	if (hdr_ptr->length > WDC_C2_LOG_BUF_LEN) {
+		fprintf(stderr, "ERROR : WDC : data length > buffer size : 0x%x\n", hdr_ptr->length);
+		goto out;
+	}
+
+	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE, hdr_ptr->length, data);
+	/* parse the data until the List of log page ID's is found */
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : Unable to read C2 Log Page data, ret = %d\n", ret);
+		goto out;
+	}
+
+	length = sizeof(struct wdc_c2_log_page_header);
+	while (length < hdr_ptr->length) {
+		sph = (struct wdc_c2_log_subpage_header *)(data + length);
+
+		if (sph->entry_id == WDC_C2_LOG_PAGES_SUPPORTED_ID) {
+			cbs_data = (struct wdc_c2_cbs_data *)&sph->data;
+
+			for (i = 0; i < cbs_data->length; i++) {
+				if (log_id == cbs_data->data[i]) {
+					found = 1;
+					ret = 0;
+					break;
+				}
+			}
+
+			if (!found) {
+				fprintf(stderr, "ERROR : WDC : Log Page 0x%x not supported\n", log_id);
+				fprintf(stderr, "WDC : Supported Log Pages:\n");
+				/* print the supported pages */
+				d((__u8 *)&sph->data + 4, sph->length - 12, 16, 1);
+				ret = -1;
+			}
+			break;
+		}
+		length += le32_to_cpu(sph->length);
+	}
+out:
+	free(data);
+	return ret;
+}
+
 static int wdc_do_clear_dump(int fd, __u8 opcode, __u32 cdw12)
 {
 	int ret;
@@ -837,7 +957,119 @@ static int wdc_print_log(struct wdc_ssd_perf_stats *perf, int fmt)
 	return 0;
 }
 
-static int wdc_smart_log_add(int argc, char **argv, struct command *command,
+static void wdc_print_ca_log_normal(struct wdc_ssd_ca_perf_stats *perf)
+{
+	printf("  CA Log Page Performance Statistics :- \n");
+	printf("  NAND Bytes Written                             %20"PRIu64 "%20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->nand_bytes_wr_hi), (uint64_t)le64_to_cpu(perf->nand_bytes_wr_lo));
+	printf("  NAND Bytes Read                                %20"PRIu64 "%20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->nand_bytes_rd_hi), (uint64_t)le64_to_cpu(perf->nand_bytes_rd_lo));
+	printf("  NAND Bad Block Count (Normalized)              %20"PRIu16"\n",
+			(uint16_t)le16_to_cpu(perf->nand_bad_block & 0x000000000000FFFF));
+	printf("  NAND Bad Block Count (Raw)                     %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->nand_bad_block & 0xFFFFFFFFFFFF0000)>>16);
+	printf("  Uncorrectable Read Count                       %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->uncorr_read_count));
+	printf("  Soft ECC Error Count                           %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->ecc_error_count));
+	printf("  SSD End to End Detected Correction Count       %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->ssd_detect_count));
+	printf("  SSD End to End Corrected Correction Count      %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->ssd_correct_count));
+	printf("  System Data Percent Used                       %20"PRIu32"%%\n",
+			(uint32_t)le32_to_cpu(perf->data_percent_used));
+	printf("  User Data Erase Counts Max                     %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->data_erase_max));
+	printf("  User Data Erase Counts Min                     %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->data_erase_min));
+	printf("  Refresh Count                                  %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->refresh_count));
+	printf("  Program Fail Count (Normalized)                %20"PRIu16"\n",
+			(uint16_t)le16_to_cpu(perf->program_fail & 0x000000000000FFFF));
+	printf("  Program Fail Count (Raw)                       %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->program_fail & 0xFFFFFFFFFFFF0000)>>16);
+	printf("  User Data Erase Fail Count (Normalized)        %20"PRIu16"\n",
+			(uint16_t)le16_to_cpu(perf->user_erase_fail & 0x000000000000FFFF));
+	printf("  User Data Erase Fail Count (Raw)               %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->user_erase_fail & 0xFFFFFFFFFFFF0000)>>16);
+	printf("  System Area Erase Fail Count (Normalized)      %20"PRIu16"\n",
+			(uint16_t)le16_to_cpu(perf->system_erase_fail & 0x000000000000FFFF));
+	printf("  System Area Erase Fail Count (Raw)             %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->system_erase_fail & 0xFFFFFFFFFFFF0000)>>16);
+	printf("  Thermal Throttling Status                      %20"PRIu16"\n",
+			(uint16_t)le16_to_cpu(perf->thermal_throttle_status));
+	printf("  Thermal Throttling Count                       %20"PRIu16"\n",
+			(uint16_t)le16_to_cpu(perf->thermal_throttle_count));
+	printf("  PCIe Correctable Error Count                   %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->pcie_corr_error));
+}
+
+static void wdc_print_ca_log_json(struct wdc_ssd_ca_perf_stats *perf)
+{
+	struct json_object *root;
+
+	root = json_create_object();
+	json_object_add_value_int(root, "NAND Bytes Written Hi", le64_to_cpu(perf->nand_bytes_wr_hi));
+	json_object_add_value_int(root, "NAND Bytes Written Lo", le64_to_cpu(perf->nand_bytes_wr_lo));
+	json_object_add_value_int(root, "NAND Bytes Read Hi", le64_to_cpu(perf->nand_bytes_rd_hi));
+	json_object_add_value_int(root, "NAND Bytes Read Lo", le64_to_cpu(perf->nand_bytes_rd_lo));
+	json_object_add_value_int(root, "NAND Bad Block Count (Normalized)",
+			le16_to_cpu(perf->nand_bad_block & 0x000000000000FFFF));
+	json_object_add_value_int(root, "NAND Bad Block Count (Raw)",
+			le64_to_cpu(perf->nand_bad_block & 0xFFFFFFFFFFFF0000)>>16);
+	json_object_add_value_int(root, "Uncorrectable Read Count", le64_to_cpu(perf->uncorr_read_count));
+	json_object_add_value_int(root, "Soft ECC Error Count",	le64_to_cpu(perf->ecc_error_count));
+	json_object_add_value_int(root, "SSD End to End Detected Correction Count",
+			le32_to_cpu(perf->ssd_detect_count));
+	json_object_add_value_int(root, "SSD End to End Corrected Correction Count",
+			le32_to_cpu(perf->ssd_correct_count));
+	json_object_add_value_int(root, "System Data Percent Used",
+			le32_to_cpu(perf->data_percent_used));
+	json_object_add_value_int(root, "User Data Erase Counts Max",
+			le32_to_cpu(perf->data_erase_max));
+	json_object_add_value_int(root, "User Data Erase Counts Min",
+			le32_to_cpu(perf->data_erase_min));
+	json_object_add_value_int(root, "Refresh Count", le64_to_cpu(perf->refresh_count));
+	json_object_add_value_int(root, "Program Fail Count (Normalized)",
+			le16_to_cpu(perf->program_fail & 0x000000000000FFFF));
+	json_object_add_value_int(root, "Program Fail Count (Raw)",
+			le64_to_cpu(perf->program_fail & 0xFFFFFFFFFFFF0000)>>16);
+	json_object_add_value_int(root, "User Data Erase Fail Count (Normalized)",
+			le16_to_cpu(perf->user_erase_fail & 0x000000000000FFFF));
+	json_object_add_value_int(root, "User Data Erase Fail Count (Raw)",
+			le64_to_cpu(perf->user_erase_fail & 0xFFFFFFFFFFFF0000)>>16);
+	json_object_add_value_int(root, "System Area Erase Fail Count (Normalized)",
+			le16_to_cpu(perf->system_erase_fail & 0x000000000000FFFF));
+	json_object_add_value_int(root, "System Area Erase Fail Count (Raw)",
+			le64_to_cpu(perf->system_erase_fail & 0xFFFFFFFFFFFF0000)>>16);
+	json_object_add_value_int(root, "Thermal Throttling Status",
+			le16_to_cpu(perf->thermal_throttle_status));
+	json_object_add_value_int(root, "Thermal Throttling Count",
+			le16_to_cpu(perf->thermal_throttle_count));
+	json_object_add_value_int(root, "PCIe Correctable Error", le64_to_cpu(perf->pcie_corr_error));
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
+static int wdc_print_ca_log(struct wdc_ssd_ca_perf_stats *perf, int fmt)
+{
+	if (!perf) {
+		fprintf(stderr, "ERROR : WDC : Invalid buffer to read perf stats\n");
+		return -1;
+	}
+	switch (fmt) {
+	case NORMAL:
+		wdc_print_ca_log_normal(perf);
+		break;
+	case JSON:
+		wdc_print_ca_log_json(perf);
+		break;
+	}
+	return 0;
+}
+
+static int wdc_smart_add_log_c1(int argc, char **argv, struct command *command,
 		struct plugin *plugin)
 {
 	char *desc = "Retrieve additional performance statistics.";
@@ -894,7 +1126,8 @@ static int wdc_smart_log_add(int argc, char **argv, struct command *command,
 	memset(data, 0, sizeof (__u8) * WDC_ADD_LOG_BUF_LEN);
 
 	ret = nvme_get_log(fd, 0x01, WDC_NVME_ADD_LOG_OPCODE, WDC_ADD_LOG_BUF_LEN, data);
-	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	if (strcmp(cfg.output_format, "json"))
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	if (ret == 0) {
 		l = (struct wdc_log_page_header*)data;
 		total_subpages = l->num_subpages + WDC_NVME_GET_STAT_PERF_INTERVAL_LIFETIME - 1;
@@ -916,3 +1149,67 @@ static int wdc_smart_log_add(int argc, char **argv, struct command *command,
 	free(data);
 	return ret;
 }
+
+static int wdc_smart_add_log(int argc, char **argv, struct command *command,
+		struct plugin *plugin)
+{
+	char *desc = "Retrieve additional performance statistics.";
+	__u8 *data;
+	int fd;
+	int ret = 0;
+	int fmt = -1;
+	struct wdc_ssd_ca_perf_stats *perf;
+
+	struct config {
+		int vendor_specific;
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, "Output Format: normal|json" },
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	wdc_check_device(fd);
+	fmt = validate_output_format(cfg.output_format);
+	if (fmt < 0) {
+		fprintf(stderr, "ERROR : WDC : invalid output format\n");
+		return fmt;
+	}
+
+	/* verify the 0xCA log page is supported */
+	if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE)) {
+		fprintf(stderr, "ERROR : WDC : 0xCA Log Page not supported\n");
+		return -1;
+	}
+
+	if ((data = (__u8*) malloc(sizeof (__u8) * WDC_CA_LOG_BUF_LEN)) == NULL) {
+		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+		return -1;
+	}
+	memset(data, 0, sizeof (__u8) * WDC_CA_LOG_BUF_LEN);
+
+	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE, WDC_CA_LOG_BUF_LEN, data);
+	if (strcmp(cfg.output_format, "json"))
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+
+	if (ret == 0) {
+		/* parse the data */
+		perf = (struct wdc_ssd_ca_perf_stats *)(data);
+		ret = wdc_print_ca_log(perf, fmt);
+	} else {
+		fprintf(stderr, "ERROR : WDC : Unable to read CA Log Page data\n");
+		ret = -1;
+	}
+
+	free(data);
+	return ret;
+}
diff --git a/wdc-nvme.h b/wdc-nvme.h
index a3574c1..13496ae 100644
--- a/wdc-nvme.h
+++ b/wdc-nvme.h
@@ -8,13 +8,14 @@
 
 PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 	COMMAND_LIST(
-		ENTRY("cap-diag", "WDC Capture-Diagnostics", wdc_cap_diag)
-		ENTRY("drive-log", "WDC Drive Log", wdc_drive_log)
-		ENTRY("get-crash-dump", "WDC Crash Dump", wdc_get_crash_dump)
-		ENTRY("id-ctrl", "WDC identify controller", wdc_id_ctrl)
-		ENTRY("purge", "WDC Purge", wdc_purge)
-		ENTRY("purge-monitor", "WDC Purge Monitor", wdc_purge_monitor)
-		ENTRY("smart-log-add", "WDC Additional Smart Log", wdc_smart_log_add)
+ 		ENTRY("cap-diag", "              WDC Capture-Diagnostics", wdc_cap_diag)
+ 		ENTRY("drive-log", "              WDC Drive Log", wdc_drive_log)
+ 		ENTRY("get-crash-dump", "              WDC Crash Dump", wdc_get_crash_dump)
+ 		ENTRY("id-ctrl", "              WDC identify controller", wdc_id_ctrl)
+ 		ENTRY("purge", "              WDC Purge", wdc_purge)
+ 		ENTRY("purge-monitor", "              WDC Purge Monitor", wdc_purge_monitor)
+ 		ENTRY("vs-smart-add-log", "             WDC Additional Smart Log", wdc_smart_add_log)
+ 		ENTRY("vs-smart-add-log-c1", "          WDC Additional Smart Log for C1 Log page", wdc_smart_add_log_c1)
 	)
 );
 
-- 
2.14.2.746.g8fb8a94
