From: Dong.Ho@wdc.com (Dong Ho)
Date: Wed, 27 Feb 2019 00:21:53 +0000
Subject: [PATCH] wdc: Add command to extract NAND statistics
Message-ID: <1551226906-13373-1-git-send-email-dong.ho@wdc.com>

---
 Documentation/nvme-wdc-vs-nand-stats.txt |  45 +++++++++
 plugins/wdc/wdc-nvme.c                   | 154 ++++++++++++++++++++++++++++++-
 plugins/wdc/wdc-nvme.h                   |   1 +
 3 files changed, 198 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/nvme-wdc-vs-nand-stats.txt

diff --git a/Documentation/nvme-wdc-vs-nand-stats.txt b/Documentation/nvme-wdc-vs-nand-stats.txt
new file mode 100644
index 0000000..cc1f422
--- /dev/null
+++ b/Documentation/nvme-wdc-vs-nand-stats.txt
@@ -0,0 +1,45 @@
+nvme-wdc-vs-nand-stats(1)
+=========================
+
+NAME
+----
+nvme-wdc-vs-nand-stats - Send NVMe WDC vs-nand-stats Vendor Unique Command, return result
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc vs-nand-stats' <device> [--output-format=<normal|json> -o <normal|json>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, send a Vendor Unique WDC vs-nand-stats command and
+output the NAND statistics. The --output-format option will format the output as
+specified.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+On success it returns the NAND statistics, error code otherwise.
+
+OPTIONS
+-------
+-o <format>::
+--output-format=<format>::
+	Set the reporting format to 'normal', or
+	'json'. Only one output format can be used at a time.
+	Default is normal.
+
+EXAMPLES
+--------
+* Has the program issue WDC vs-nand-stats Vendor Unique Command :
++
+------------
+# nvme wdc vs-nand-stats /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite.
diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index ba4d419..7e6988b 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -81,6 +81,7 @@
 #define WDC_DRIVE_CAP_CLEAR_ASSERT			0x0000000000000040
 #define WDC_DRIVE_CAP_CLEAR_PCIE			0x0000000000000080
 #define WDC_DRIVE_CAP_RESIZE				0x0000000000000100
+#define WDC_DRIVE_CAP_NAND_STATS			0x0000000000000200
 
 #define WDC_DRIVE_CAP_DRIVE_ESSENTIALS			0x0000000100000000
 #define WDC_DRIVE_CAP_DUI_DATA				0x0000000200000000
@@ -233,6 +234,10 @@
 #define WDC_DE_TAR_FILE_EXTN				".tar.gz"
 #define WDC_DE_TAR_CMD					"tar -czf"
 
+/* VS NAND Stats */
+#define WDC_NVME_NAND_STATS_LOG_ID			0xFB
+#define WDC_NVME_NAND_STATS_SIZE			0x200
+
 /* VU Opcodes */
 #define WDC_DE_VU_READ_SIZE_OPCODE			0xC0
 #define WDC_DE_VU_READ_BUFFER_OPCODE			0xC2
@@ -557,6 +562,17 @@ struct __attribute__((__packed__)) wdc_ssd_d0_smart_log {
     __u8    rsvd_104[0x198];                      /* 0x68-0x1FF Reserved                                */
 };
 
+/* NAND Stats */
+struct __attribute__((__packed__)) wdc_nand_stats {
+	__u8		nand_write_tlc[16];
+	__u8		nand_write_slc[16];
+	__le32		nand_prog_failure;
+	__le32		nand_erase_failure;
+	__le32		bad_block_count;
+	__le64		nand_rec_trigger_event;
+	__u8		rsvd[460];
+};
+
 static double safe_div_fp(double numerator, double denominator)
 {
 	return denominator ? numerator / denominator : 0;
@@ -568,6 +584,18 @@ static double calc_percent(uint64_t numerator, uint64_t denominator)
 		(uint64_t)(((double)numerator / (double)denominator) * 100) : 0;
 }
 
+static long double int128_to_double(__u8 *data)
+{
+	int i;
+	long double result = 0;
+
+	for (i = 0; i < 16; i++) {
+		result *= 256;
+		result += data[15 - i];
+	}
+	return result;
+}
+
 static int wdc_get_pci_ids(int *device_id, int *vendor_id)
 {
 	int fd, ret = -1;
@@ -740,9 +768,9 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 		case WDC_NVME_SN520_DEV_ID_1:
 		/* FALLTHRU */
 		case WDC_NVME_SN520_DEV_ID_2:
-		/* FALLTHRU */
-		case WDC_NVME_SN720_DEV_ID:
 			capabilities = WDC_DRIVE_CAP_DUI_DATA;
+		case WDC_NVME_SN720_DEV_ID:
+			capabilities = WDC_DRIVE_CAP_DUI_DATA | WDC_DRIVE_CAP_NAND_STATS;
 			break;
 		default:
 			capabilities = 0;
@@ -3595,3 +3623,125 @@ static int wdc_drive_resize(int argc, char **argv,
 	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	return ret;
 }
+
+static void wdc_print_nand_stats_normal(struct wdc_nand_stats *data)
+{
+	printf("  NAND Statistics :- \n");
+	printf("  NAND Writes TLC (Bytes)		         %.0Lf\n",
+			int128_to_double(data->nand_write_tlc));
+	printf("  NAND Writes SLC (Bytes)		         %.0Lf\n",
+			int128_to_double(data->nand_write_slc));
+	printf("  NAND Program Failures			  	 %"PRIu32"\n",
+			(uint32_t)le32_to_cpu(data->nand_prog_failure));
+	printf("  NAND Erase Failures				 %"PRIu32"\n",
+			(uint32_t)le32_to_cpu(data->nand_erase_failure));
+	printf("  Bad Block Count			         %"PRIu32"\n",
+			(uint32_t)le32_to_cpu(data->bad_block_count));
+	printf("  NAND XOR/RAID Recovery Trigger Events		 %"PRIu64"\n",
+			(uint64_t)le64_to_cpu(data->nand_rec_trigger_event));
+}
+
+static void wdc_print_nand_stats_json(struct wdc_nand_stats *data)
+{
+	struct json_object *root;
+
+	root = json_create_object();
+	json_object_add_value_float(root, "NAND Writes TLC (Bytes)",
+			int128_to_double(data->nand_write_tlc));
+	json_object_add_value_float(root, "NAND Writes SLC (Bytes)",
+			int128_to_double(data->nand_write_slc));
+	json_object_add_value_uint(root, "NAND Program Failures",
+			le32_to_cpu(data->nand_prog_failure));
+	json_object_add_value_uint(root, "NAND Erase Failures",
+			le32_to_cpu(data->nand_erase_failure));
+	json_object_add_value_uint(root, "Bad Block Count",
+			le32_to_cpu(data->bad_block_count));
+	json_object_add_value_uint(root, "NAND XOR/RAID Recovery Trigger Events",
+			le64_to_cpu(data->nand_rec_trigger_event));
+
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
+static int wdc_do_vs_nand_stats(int fd, char *format)
+{
+	int ret;
+	int fmt = -1;
+	uint8_t *output = NULL;
+	struct wdc_nand_stats *nand_stats;
+
+	if ((output = (uint8_t*)calloc(WDC_NVME_NAND_STATS_SIZE, sizeof(uint8_t))) == NULL) {
+		fprintf(stderr, "ERROR : WDC : calloc : %s\n", strerror(errno));
+		ret = -1;
+		goto out;
+	}
+
+	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_NAND_STATS_LOG_ID,
+			   false, WDC_NVME_NAND_STATS_SIZE, (void*)output);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : %s : Failed to retreive NAND stats\n", __func__);
+		goto out;
+	} else {
+		fmt = validate_output_format(format);
+		if (fmt < 0) {
+			fprintf(stderr, "ERROR : WDC : invalid output format\n");
+			ret = fmt;
+			goto out;
+		}
+
+		/* parse the data */
+		nand_stats = (struct wdc_nand_stats *)(output);
+		switch (fmt) {
+		case NORMAL:
+			wdc_print_nand_stats_normal(nand_stats);
+			break;
+		case JSON:
+			wdc_print_nand_stats_json(nand_stats);
+			break;
+		}
+	}
+
+out:
+	free(output);
+	return ret;
+}
+
+static int wdc_vs_nand_stats(int argc, char **argv, struct command *command,
+		struct plugin *plugin)
+{
+	const char *desc = "Retrieve NAND statistics.";
+	int fd;
+	int ret = 0;
+	__u64 capabilities = 0;
+
+	struct config {
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, "Output Format: normal|json" },
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	capabilities = wdc_get_drive_capabilities(fd);
+
+	if ((capabilities & WDC_DRIVE_CAP_NAND_STATS) == 0) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+	} else {
+		ret = wdc_do_vs_nand_stats(fd, cfg.output_format);
+		if (ret)
+			fprintf(stderr, "ERROR : WDC : Failure reading NAND statistics, ret = %d\n", ret);
+	}
+
+	return ret;
+}
diff --git a/plugins/wdc/wdc-nvme.h b/plugins/wdc/wdc-nvme.h
index 2492eab..85329cc 100644
--- a/plugins/wdc/wdc-nvme.h
+++ b/plugins/wdc/wdc-nvme.h
@@ -16,6 +16,7 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("purge", "WDC Purge", wdc_purge)
 		ENTRY("purge-monitor", "WDC Purge Monitor", wdc_purge_monitor)
 		ENTRY("vs-internal-log", "WDC Internal Firmware Log", wdc_vs_internal_fw_log)
+		ENTRY("vs-nand-stats", "WDC NAND Statistics", wdc_vs_nand_stats)
 		ENTRY("vs-smart-add-log", "WDC Additional Smart Log", wdc_vs_smart_add_log)
 		ENTRY("clear-pcie-correctable-errors", "WDC Clear PCIe Correctable Error Count", wdc_clear_pcie_correctable_errors)
 		ENTRY("drive-essentials", "WDC Drive Essentials", wdc_drive_essentials)
-- 
2.7.4
