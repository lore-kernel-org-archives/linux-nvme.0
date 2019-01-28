From: Dong.Ho@wdc.com (Dong Ho)
Date: Mon, 28 Jan 2019 23:32:38 +0000
Subject: [PATCH 2/4] wdc: Add get drive status command
In-Reply-To: <1548718347-29874-1-git-send-email-dong.ho@wdc.com>
References: <1548718347-29874-1-git-send-email-dong.ho@wdc.com>
Message-ID: <1548718347-29874-2-git-send-email-dong.ho@wdc.com>

In addition, updated checks for supported log pages and capabilities
---
 Documentation/nvme-wdc-get-drive-status.txt |  60 +++
 plugins/wdc/wdc-nvme.c                      | 701 ++++++++++++++++++++++++++--
 plugins/wdc/wdc-nvme.h                      |   1 +
 3 files changed, 714 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/nvme-wdc-get-drive-status.txt

diff --git a/Documentation/nvme-wdc-get-drive-status.txt b/Documentation/nvme-wdc-get-drive-status.txt
new file mode 100644
index 0000000..f8a37d6
--- /dev/null
+++ b/Documentation/nvme-wdc-get-drive-status.txt
@@ -0,0 +1,60 @@
+nvme-wdc-get-drive-status(1)
+============================
+
+NAME
+----
+nvme-wdc-get-drive-status - Send the NVMe WDC get-drive-status command, return result
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc get-drive-status' <device>
+
+DESCRIPTION
+-----------
+For the NVMe device given, send the unique WDC get-drive-status command and
+provide the additional drive status information.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+On success it returns 0, error code otherwise.
+
+Output Explanation
+------------------
+[cols="2*", frame="topbot", align="center", options="header"]
+|===
+|Field |Description
+
+|*Percent Life Used.*
+|The percentage of drive function used.
+
+|*EOL (End of Life) Status*
+|The 3 possible states are :  Normal, Read Only, or End of Life.
+
+|*Assert Dump Status*
+|The 2 possible states are :  Present or Not Present.
+
+|*Thermal Throttling Status*
+|The 3 possible states are :  Off, On, or Unavaiable.
+
+|*Format Corrupt Reason*
+|The 3 possible states are :  Not Corrupted, Corrupt due to FW Assert, or Corrupt for Unknown Reason.
+
+|===
+
+
+EXAMPLES
+--------
+* Has the program issue WDC get-drive-status command :
++
+------------
+# nvme wdc get-drive-status /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite.
diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index c9744a7..96e8bae 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -73,8 +73,10 @@
 #define WDC_NVME_SN730_DEV_ID_1				0x3734
 
 #define WDC_DRIVE_CAP_CAP_DIAG				0x0000000000000001
-#define WDC_DRIVE_CAP_INTERNAL_LOG			0x0000000000000002
-#define WDC_DRIVE_CAP_CA_LOG_PAGE			0x0000000000000008
+#define WDC_DRIVE_CAP_INTERNAL_LOG	 		0x0000000000000002
+#define WDC_DRIVE_CAP_C1_LOG_PAGE			0x0000000000000004
+#define WDC_DRIVE_CAP_CA_LOG_PAGE 			0x0000000000000008
+#define WDC_DRIVE_CAP_D0_LOG_PAGE 			0x0000000000000010
 #define WDC_DRIVE_CAP_DRIVE_STATUS			0x0000000000000020
 #define WDC_DRIVE_CAP_CLEAR_ASSERT			0x0000000000000040
 #define WDC_DRIVE_CAP_CLEAR_PCIE			0x0000000000000080
@@ -83,6 +85,8 @@
 #define WDC_DRIVE_CAP_DUI_DATA				0x0000000200000000
 
 #define WDC_SN730_CAP_VUC_LOG				0x0000000400000000
+#define WDC_DRIVE_CAP_SMART_LOG_MASK	(WDC_DRIVE_CAP_C1_LOG_PAGE | WDC_DRIVE_CAP_CA_LOG_PAGE | \
+					 WDC_DRIVE_CAP_D0_LOG_PAGE)
 
 /* SN730 Get Log Capabilities */
 #define SN730_NVME_GET_LOG_OPCODE			0xc2
@@ -112,7 +116,6 @@
 #define WDC_NVME_CAP_DUI_OPCODE      		0xFA
 
 /* Crash dump */
-#define WDC_NVME_CRASH_DUMP_SIZE_OPCODE		WDC_NVME_CAP_DIAG_CMD_OPCODE
 #define WDC_NVME_CRASH_DUMP_SIZE_DATA_LEN	WDC_NVME_LOG_SIZE_DATA_LEN
 #define WDC_NVME_CRASH_DUMP_SIZE_NDT		0x02
 #define WDC_NVME_CRASH_DUMP_SIZE_CMD		0x20
@@ -140,7 +143,7 @@
 #define WDC_NVME_DRIVE_LOG_SIZE_SUBCMD		0x01
 
 #define WDC_NVME_DRIVE_LOG_OPCODE			WDC_NVME_CAP_DIAG_CMD_OPCODE
-#define WDC_NVME_DRIVE_LOG_CMD				WDC_NVME_LOG_SIZE_DATA_LEN
+#define WDC_NVME_DRIVE_LOG_CMD				0x20
 #define WDC_NVME_DRIVE_LOG_SUBCMD			0x00
 
 /* Purge and Purge Monitor */
@@ -171,14 +174,39 @@
 #define WDC_NVME_GET_STAT_PERF_INTERVAL_LIFETIME	0x0F
 
 /* C2 Log Page */
-#define WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE		0xC2
+#define WDC_NVME_GET_DEV_MGMNT_LOG_PAGE_OPCODE		0xC2
 #define WDC_C2_LOG_BUF_LEN							0x1000
 #define WDC_C2_LOG_PAGES_SUPPORTED_ID				0x08
+#define WDC_C2_THERMAL_THROTTLE_STATUS_ID			0x18
+#define WDC_C2_ASSERT_DUMP_PRESENT_ID				0x19
+#define WDC_C2_USER_EOL_STATUS_ID     				0x1A
+#define WDC_C2_USER_EOL_STATE_ID      				0x1C
+#define WDC_C2_SYSTEM_EOL_STATE_ID     	    		0x1D
+#define WDC_C2_FORMAT_CORRUPT_REASON_ID  			0x1E
+#define WDC_EOL_STATUS_NORMAL                  		0x00000000
+#define WDC_EOL_STATUS_END_OF_LIFE             		0x00000001
+#define WDC_EOL_STATUS_READ_ONLY               		0x00000002
+#define WDC_ASSERT_DUMP_NOT_PRESENT      			0x00000000
+#define WDC_ASSERT_DUMP_PRESENT            			0x00000001
+#define WDC_THERMAL_THROTTLING_OFF        			0x00000000
+#define WDC_THERMAL_THROTTLING_ON          			0x00000001
+#define WDC_THERMAL_THROTTLING_UNAVAILABLE			0x00000002
+#define WDC_FORMAT_NOT_CORRUPT			 	        0x00000000
+#define WDC_FORMAT_CORRUPT_FW_ASSERT	 			0x00000001
+#define WDC_FORMAT_CORRUPT_UNKNOWN       			0x000000FF
 
 /* CA Log Page */
 #define WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE			0xCA
 #define WDC_CA_LOG_BUF_LEN							0x80
 
+/* C0 EOL Status Log Page */
+#define WDC_NVME_GET_EOL_STATUS_LOG_OPCODE			0xC0
+#define WDC_NVME_EOL_STATUS_LOG_LEN       			0x200
+
+/* D0 Smart Log Page */
+#define WDC_NVME_GET_VU_SMART_LOG_OPCODE			0xD0
+#define WDC_NVME_VU_SMART_LOG_LEN       			0x200
+
 /* Clear PCIe Correctable Errors */
 #define WDC_NVME_CLEAR_PCIE_CORR_OPCODE  	WDC_NVME_CAP_DIAG_CMD_OPCODE
 #define WDC_NVME_CLEAR_PCIE_CORR_CMD		0x22
@@ -370,12 +398,14 @@ static int wdc_purge(int argc, char **argv,
 		struct command *command, struct plugin *plugin);
 static int wdc_purge_monitor(int argc, char **argv,
 		struct command *command, struct plugin *plugin);
-static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id);
+static bool wdc_nvme_check_supported_log_page(int fd, __u8 log_id);
 static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
 static int wdc_do_drive_essentials(int fd, char *dir, char *key);
 static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
+static int wdc_drive_status(int argc, char **argv, struct command *command,
+		struct plugin *plugin);
 
 /* Drive log data size */
 struct wdc_log_size {
@@ -484,6 +514,44 @@ struct __attribute__((__packed__)) wdc_ssd_ca_perf_stats {
 	__le32	rsvd2;						/* 0x7C - Reserved							*/
 };
 
+struct __attribute__((__packed__)) wdc_ssd_d0_smart_log {
+    __le32  lifetime_wrt_amp_factor;              /* 0x00 - Lifetime write amplification factor         */
+    __le32  trailing_hr_wrt_amp_factor;           /* 0x04 - Trailing hour write amplification factor    */
+    __le32  percentage_pe_cycles_remaining;       /* 0x08 - Percentage of P/E cycles remaining          */
+    __le32  lifetime_link_rate_downgrade_count;   /* 0x0C - Lifetime link rate downgrade count          */
+    __le32  lifetime_block_erase_fail_count;      /* 0x10 - Lifetime block erase fail count             */
+    __le32  lifetime_program_fail_count;          /* 0x14 - Lifetime program fail count                 */
+    __le64  lifetime_user_writes;                 /* 0x18 - Lifetime user writes                        */
+    __le64  lifetime_nand_writes;                 /* 0x20 - Lifetime NAND writes                        */
+    __le64  lifetime_user_reads;                  /* 0x28 - Lifetime user reads                         */
+    __le32  lifetime_retired_block_count;         /* 0x30 - Lifetime retired block count                */
+    __le32  lifetime_read_disturb_realloc_events; /* 0x34 - Lifetime read disturb reallocation events   */
+    __le32  lifetime_die_failure_count;           /* 0x38 - Lifetime die failure count                  */
+    __le32  current_temp;                         /* 0x3C - Current temperature                         */
+    __le32  max_recorded_temp;                    /* 0x40 - Max recorded temperature                    */
+    __le32  lifetime_thermal_throttle_act;        /* 0x44 - Lifetime thermal throttle activations       */
+    __le32  capacitor_health;                     /* 0x48 - Capacitor health                            */
+    __le32  reserve_erase_block_count;            /* 0x4C - Reserve erase block count                   */
+    __le32  lifetime_uecc_count;                  /* 0x50 - Lifetime UECC count                         */
+    __le32  lifetime_realloc_erase_block_count;   /* 0x54 - Lifetime reallocated erase block count      */
+    __le32  lifetime_power_on_hours;              /* 0x58 - Lifetime power on hours                     */
+    __le32  power_loss_counters;                  /* 0x5C - Power loss counters                         */
+    __le32  lifetime_clean_shutdown_count;        /* 0x60 - Lifetime clean shutdown count on power loss */
+    __le32  lifetime_unclean_shutdown_count;      /* 0x64 - Lifetime unclean shutdowns on power loss    */
+    __u8    rsvd_104[0x198];                      /* 0x68-0x1FF Reserved                                */
+};
+
+static double safe_div_fp(double numerator, double denominator)
+{
+	return denominator ? numerator / denominator : 0;
+}
+
+static double calc_percent(uint64_t numerator, uint64_t denominator)
+{
+	return denominator ?
+		(uint64_t)(((double)numerator / (double)denominator) * 100) : 0;
+}
+
 static int wdc_get_pci_ids(int *device_id, int *vendor_id)
 {
 	int fd, ret = -1;
@@ -595,11 +663,18 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 	case WDC_NVME_VID:
 		switch (read_device_id) {
 		case WDC_NVME_SN100_DEV_ID:
-			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG);
+			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG | WDC_DRIVE_CAP_C1_LOG_PAGE);
 			break;
 		case WDC_NVME_SN200_DEV_ID:
-			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG |
-					WDC_DRIVE_CAP_CA_LOG_PAGE);
+			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG);
+
+			/* verify the 0xCA log page is supported */
+			if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE) == true)
+				capabilities |= WDC_DRIVE_CAP_CA_LOG_PAGE;
+
+			/* verify the 0xC1 log page is supported */
+			if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_ADD_LOG_OPCODE) == true)
+				capabilities |= WDC_DRIVE_CAP_C1_LOG_PAGE;
 			break;
 		default:
 			capabilities = 0;
@@ -619,8 +694,15 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 		/* FALLTHRU */
 		case WDC_NVME_SN840_DEV_ID:
 			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG |
-					WDC_DRIVE_CAP_CA_LOG_PAGE | WDC_DRIVE_CAP_DRIVE_STATUS |
-					WDC_DRIVE_CAP_CLEAR_ASSERT);
+					WDC_DRIVE_CAP_DRIVE_STATUS | WDC_DRIVE_CAP_CLEAR_ASSERT);
+
+			/* verify the 0xCA log page is supported */
+			if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE) == true)
+				capabilities |= WDC_DRIVE_CAP_CA_LOG_PAGE;
+
+			/* verify the 0xD0 log page is supported */
+			if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_VU_SMART_LOG_OPCODE) == true)
+				capabilities |= WDC_DRIVE_CAP_D0_LOG_PAGE;
 			break;
 		case WDC_NVME_SN730_DEV_ID:
 		/* FALLTHRU */
@@ -648,7 +730,6 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 		default:
 			capabilities = 0;
 		}
-
 		break;
 	default:
 		capabilities = 0;
@@ -736,76 +817,113 @@ static int wdc_create_log_file(char *file, __u8 *drive_log_data,
 	return 0;
 }
 
-static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
+static bool get_dev_mgment_cbs_data(int fd, __u8 log_id, void **cbs_data)
 {
-	int i;
 	int ret = -1;
-	int found = 0;
 	__u8* data;
-	__u32 length = 0;
-	struct wdc_c2_cbs_data *cbs_data;
 	struct wdc_c2_log_page_header *hdr_ptr;
 	struct wdc_c2_log_subpage_header *sph;
+	__u32 length = 0;
+	bool found = false;
+
+	*cbs_data = NULL;
 
 	if ((data = (__u8*) malloc(sizeof (__u8) * WDC_C2_LOG_BUF_LEN)) == NULL) {
 		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
-		return ret;
+		return false;
 	}
 	memset(data, 0, sizeof (__u8) * WDC_C2_LOG_BUF_LEN);
 
 	/* get the log page length */
-	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
+	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_DEV_MGMNT_LOG_PAGE_OPCODE,
 			   false, WDC_C2_LOG_BUF_LEN, data);
 	if (ret) {
-		fprintf(stderr, "ERROR : WDC : Unable to get C2 Log Page length, ret = %d\n", ret);
-		goto out;
+		fprintf(stderr, "ERROR : WDC : Unable to get C2 Log Page length, ret = 0x%x\n", ret);
+		goto end;
 	}
 
 	hdr_ptr = (struct wdc_c2_log_page_header *)data;
 
 	if (le32_to_cpu(hdr_ptr->length) > WDC_C2_LOG_BUF_LEN) {
-		fprintf(stderr, "ERROR : WDC : data length > buffer size : 0x%x\n",
-				le32_to_cpu(hdr_ptr->length));
-		goto out;
+		/* Log Page buffer too small, free and reallocate the necessary size */
+		free(data);
+		if ((data = (__u8*) calloc(hdr_ptr->length, sizeof (__u8))) == NULL) {
+			fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+			return false;
+		}
 	}
 
-	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
-			   false,  le32_to_cpu(hdr_ptr->length), data);
+	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_DEV_MGMNT_LOG_PAGE_OPCODE,
+			   false, le32_to_cpu(hdr_ptr->length), data);
 	/* parse the data until the List of log page ID's is found */
 	if (ret) {
-		fprintf(stderr, "ERROR : WDC : Unable to read C2 Log Page data, ret = %d\n", ret);
-		goto out;
+		fprintf(stderr, "ERROR : WDC : Unable to read C2 Log Page data, ret = 0x%x\n", ret);
+		goto end;
 	}
 
 	length = sizeof(struct wdc_c2_log_page_header);
+	hdr_ptr = (struct wdc_c2_log_page_header *)data;
+
 	while (length < le32_to_cpu(hdr_ptr->length)) {
 		sph = (struct wdc_c2_log_subpage_header *)(data + length);
 
-		if (le32_to_cpu(sph->entry_id) == WDC_C2_LOG_PAGES_SUPPORTED_ID) {
-			cbs_data = (struct wdc_c2_cbs_data *)&sph->data;
+		if (le32_to_cpu(sph->entry_id) == log_id) {
+			*cbs_data = (void *)&sph->data;
+			found = true;
+			break;
+		}
+		length += le32_to_cpu(sph->length);
+	}
 
+end:
+	free(data);
+	return found;
+}
+
+static bool wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
+{
+	int i;
+	bool found = false;
+	struct wdc_c2_cbs_data *cbs_data = NULL;
+
+	if (get_dev_mgment_cbs_data(fd, WDC_C2_LOG_PAGES_SUPPORTED_ID, (void *)&cbs_data)) {
+		if (cbs_data != NULL) {
 			for (i = 0; i < le32_to_cpu(cbs_data->length); i++) {
 				if (log_id == cbs_data->data[i]) {
-					found = 1;
-					ret = 0;
+					found = true;
 					break;
 				}
 			}
 
+#ifdef WDC_NVME_CLI_DEBUG
 			if (!found) {
 				fprintf(stderr, "ERROR : WDC : Log Page 0x%x not supported\n", log_id);
 				fprintf(stderr, "WDC : Supported Log Pages:\n");
 				/* print the supported pages */
-				d((__u8 *)&sph->data + 4, le32_to_cpu(sph->length) - 12, 16, 1);
-				ret = -1;
+				d((__u8 *)cbs_data->data, le32_to_cpu(cbs_data->length), 16, 1);
 			}
-			break;
+#endif
+		} else
+			fprintf(stderr, "ERROR : WDC : cbs_data ptr = NULL\n");
+	} else
+		fprintf(stderr, "ERROR : WDC : 0xC2 Log Page entry ID 0x%x not found\n", WDC_C2_LOG_PAGES_SUPPORTED_ID);
+
+	return found;
+}
+
+static bool wdc_nvme_get_dev_status_log_data(int fd, __u32 *ret_data,
+		__u8 log_id)
+{
+	__u32 *cbs_data = NULL;
+	bool found = false;
+
+	if (get_dev_mgment_cbs_data(fd, log_id, (void *)&cbs_data)) {
+		if (cbs_data != NULL) {
+			memcpy((void *)ret_data, (void *)cbs_data, 4);
+			found = true;
 		}
-		length += le32_to_cpu(sph->length);
 	}
-out:
-	free(data);
-	return ret;
+	return found;
 }
 
 static int wdc_do_clear_dump(int fd, __u8 opcode, __u32 cdw12)
@@ -1879,6 +1997,136 @@ static int wdc_purge_monitor(int argc, char **argv,
 	return ret;
 }
 
+static void wdc_print_log_normal(struct wdc_ssd_perf_stats *perf)
+{
+	printf("  C1 Log Page Performance Statistics :- \n");
+	printf("  Host Read Commands                             %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hr_cmds));
+	printf("  Host Read Blocks                               %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hr_blks));
+	printf("  Average Read Size                              %20lf\n",
+			safe_div_fp((le64_to_cpu(perf->hr_blks)), (le64_to_cpu(perf->hr_cmds))));
+	printf("  Host Read Cache Hit Commands                   %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hr_ch_cmds));
+	printf("  Host Read Cache Hit_Percentage                 %20"PRIu64"%%\n",
+			(uint64_t) calc_percent(le64_to_cpu(perf->hr_ch_cmds), le64_to_cpu(perf->hr_cmds)));
+	printf("  Host Read Cache Hit Blocks                     %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hr_ch_blks));
+	printf("  Average Read Cache Hit Size                    %20f\n",
+			safe_div_fp((le64_to_cpu(perf->hr_ch_blks)), (le64_to_cpu(perf->hr_ch_cmds))));
+	printf("  Host Read Commands Stalled                     %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hr_st_cmds));
+	printf("  Host Read Commands Stalled Percentage          %20"PRIu64"%%\n",
+			(uint64_t)calc_percent((le64_to_cpu(perf->hr_st_cmds)), le64_to_cpu(perf->hr_cmds)));
+	printf("  Host Write Commands                            %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hw_cmds));
+	printf("  Host Write Blocks                              %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hw_blks));
+	printf("  Average Write Size                             %20f\n",
+			safe_div_fp((le64_to_cpu(perf->hw_blks)), (le64_to_cpu(perf->hw_cmds))));
+	printf("  Host Write Odd Start Commands                  %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hw_os_cmds));
+	printf("  Host Write Odd Start Commands Percentage       %20"PRIu64"%%\n",
+			(uint64_t)calc_percent((le64_to_cpu(perf->hw_os_cmds)), (le64_to_cpu(perf->hw_cmds))));
+	printf("  Host Write Odd End Commands                    %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->hw_oe_cmds));
+	printf("  Host Write Odd End Commands Percentage         %20"PRIu64"%%\n",
+			(uint64_t)calc_percent((le64_to_cpu(perf->hw_oe_cmds)), (le64_to_cpu((perf->hw_cmds)))));
+	printf("  Host Write Commands Stalled                    %20"PRIu64"\n",
+		(uint64_t)le64_to_cpu(perf->hw_st_cmds));
+	printf("  Host Write Commands Stalled Percentage         %20"PRIu64"%%\n",
+		(uint64_t)calc_percent((le64_to_cpu(perf->hw_st_cmds)), (le64_to_cpu(perf->hw_cmds))));
+	printf("  NAND Read Commands                             %20"PRIu64"\n",
+		(uint64_t)le64_to_cpu(perf->nr_cmds));
+	printf("  NAND Read Blocks Commands                      %20"PRIu64"\n",
+		(uint64_t)le64_to_cpu(perf->nr_blks));
+	printf("  Average NAND Read Size                         %20f\n",
+		safe_div_fp((le64_to_cpu(perf->nr_blks)), (le64_to_cpu((perf->nr_cmds)))));
+	printf("  Nand Write Commands                            %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->nw_cmds));
+	printf("  NAND Write Blocks                              %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->nw_blks));
+	printf("  Average NAND Write Size                        %20f\n",
+			safe_div_fp((le64_to_cpu(perf->nw_blks)), (le64_to_cpu(perf->nw_cmds))));
+	printf("  NAND Read Before Write                         %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->nrbw));
+}
+
+static void wdc_print_log_json(struct wdc_ssd_perf_stats *perf)
+{
+	struct json_object *root;
+
+	root = json_create_object();
+	json_object_add_value_int(root, "Host Read Commands", le64_to_cpu(perf->hr_cmds));
+	json_object_add_value_int(root, "Host Read Blocks", le64_to_cpu(perf->hr_blks));
+	json_object_add_value_int(root, "Average Read Size",
+			safe_div_fp((le64_to_cpu(perf->hr_blks)), (le64_to_cpu(perf->hr_cmds))));
+	json_object_add_value_int(root, "Host Read Cache Hit Commands",
+			(uint64_t)le64_to_cpu(perf->hr_ch_cmds));
+	json_object_add_value_int(root, "Host Read Cache Hit Percentage",
+			(uint64_t) calc_percent(le64_to_cpu(perf->hr_ch_cmds), le64_to_cpu(perf->hr_cmds)));
+	json_object_add_value_int(root, "Host Read Cache Hit Blocks",
+			(uint64_t)le64_to_cpu(perf->hr_ch_blks));
+	json_object_add_value_int(root, "Average Read Cache Hit Size",
+			safe_div_fp((le64_to_cpu(perf->hr_ch_blks)), (le64_to_cpu(perf->hr_ch_cmds))));
+	json_object_add_value_int(root, "Host Read Commands Stalled",
+			(uint64_t)le64_to_cpu(perf->hr_st_cmds));
+	json_object_add_value_int(root, "Host Read Commands Stalled Percentage",
+			(uint64_t)calc_percent((le64_to_cpu(perf->hr_st_cmds)), le64_to_cpu(perf->hr_cmds)));
+	json_object_add_value_int(root, "Host Write Commands",
+			(uint64_t)le64_to_cpu(perf->hw_cmds));
+	json_object_add_value_int(root, "Host Write Blocks",
+			(uint64_t)le64_to_cpu(perf->hw_blks));
+	json_object_add_value_int(root, "Average Write Size",
+			safe_div_fp((le64_to_cpu(perf->hw_blks)), (le64_to_cpu(perf->hw_cmds))));
+	json_object_add_value_int(root, "Host Write Odd Start Commands",
+			(uint64_t)le64_to_cpu(perf->hw_os_cmds));
+	json_object_add_value_int(root, "Host Write Odd Start Commands Percentage",
+			(uint64_t)calc_percent((le64_to_cpu(perf->hw_os_cmds)), (le64_to_cpu(perf->hw_cmds))));
+	json_object_add_value_int(root, "Host Write Odd End Commands",
+			(uint64_t)le64_to_cpu(perf->hw_oe_cmds));
+	json_object_add_value_int(root, "Host Write Odd End Commands Percentage",
+			(uint64_t)calc_percent((le64_to_cpu(perf->hw_oe_cmds)), (le64_to_cpu((perf->hw_cmds)))));
+	json_object_add_value_int(root, "Host Write Commands Stalled",
+		(uint64_t)le64_to_cpu(perf->hw_st_cmds));
+	json_object_add_value_int(root, "Host Write Commands Stalled Percentage",
+		(uint64_t)calc_percent((le64_to_cpu(perf->hw_st_cmds)), (le64_to_cpu(perf->hw_cmds))));
+	json_object_add_value_int(root, "NAND Read Commands",
+		(uint64_t)le64_to_cpu(perf->nr_cmds));
+	json_object_add_value_int(root, "NAND Read Blocks Commands",
+		(uint64_t)le64_to_cpu(perf->nr_blks));
+	json_object_add_value_int(root, "Average NAND Read Size",
+		safe_div_fp((le64_to_cpu(perf->nr_blks)), (le64_to_cpu((perf->nr_cmds)))));
+	json_object_add_value_int(root, "Nand Write Commands",
+			(uint64_t)le64_to_cpu(perf->nw_cmds));
+	json_object_add_value_int(root, "NAND Write Blocks",
+			(uint64_t)le64_to_cpu(perf->nw_blks));
+	json_object_add_value_int(root, "Average NAND Write Size",
+			safe_div_fp((le64_to_cpu(perf->nw_blks)), (le64_to_cpu(perf->nw_cmds))));
+	json_object_add_value_int(root, "NAND Read Before Written",
+			(uint64_t)le64_to_cpu(perf->nrbw));
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
+static int wdc_print_log(struct wdc_ssd_perf_stats *perf, int fmt)
+{
+	if (!perf) {
+		fprintf(stderr, "ERROR : WDC : Invalid buffer to read perf stats\n");
+		return -1;
+	}
+	switch (fmt) {
+	case NORMAL:
+		wdc_print_log_normal(perf);
+		break;
+	case JSON:
+		wdc_print_log_json(perf);
+		break;
+	}
+	return 0;
+}
+
 static void wdc_print_ca_log_normal(struct wdc_ssd_ca_perf_stats *perf)
 {
 	uint64_t converted = 0;
@@ -1997,6 +2245,114 @@ static void wdc_print_ca_log_json(struct wdc_ssd_ca_perf_stats *perf)
 	json_free_object(root);
 }
 
+static void wdc_print_d0_log_normal(struct wdc_ssd_d0_smart_log *perf)
+{
+	printf("  D0 Smart Log Page Statistics :- \n");
+	printf("  Lifetime Write Amplification Factor	         %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_wrt_amp_factor));
+	printf("  Trailing Hour Write Amplification Factor  	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->trailing_hr_wrt_amp_factor));
+	printf("  Percentage of P/E Cycles Remaining             %20"PRIu32"%%\n",
+			(uint32_t)le32_to_cpu(perf->percentage_pe_cycles_remaining));
+	printf("  Lifetime Link Rate Downgrade Count	         %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_link_rate_downgrade_count));
+	printf("  Lifetime Block Erase Fail Count		 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_block_erase_fail_count));
+	printf("  Lifetime Program Fail Count	     	         %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_program_fail_count));
+	printf("  Lifetime User Writes	                         %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->lifetime_user_writes));
+	printf("  Lifetime NAND Writes	                         %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->lifetime_nand_writes));
+	printf("  Lifetime User Reads	                         %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->lifetime_user_reads));
+	printf("  Lifetime Retired Block Count	                 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_retired_block_count));
+	printf("  Lifetime Read Disturb Reallocation Events	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_read_disturb_realloc_events));
+	printf("  Lifetime Die Failure Count	                 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_die_failure_count));
+	printf("  Current Temperature 	                         %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->current_temp));
+	printf("  Max Recorded Temperature			 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->max_recorded_temp));
+	printf("  Lifetime Thermal Throttle Activations	         %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_thermal_throttle_act));
+	printf("  Capacitor Health			 	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->capacitor_health));
+	printf("  Reserve Erase Block Count	                 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->reserve_erase_block_count));
+	printf("  Lifetime UECC Count	                         %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_uecc_count));
+	printf("  Lifetime Reallocated Erase Block Count	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_realloc_erase_block_count));
+	printf("  Lifetime Power on Hours			 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_power_on_hours));
+	printf("  Power Loss Counters		         	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->power_loss_counters));
+	printf("  Lifetime Clean Shutdown Count on Power Loss	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_clean_shutdown_count));
+	printf("  Lifetime Unclean Shutdowns on Power Loss	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_unclean_shutdown_count));
+}
+
+static void wdc_print_d0_log_json(struct wdc_ssd_d0_smart_log *perf)
+{
+	struct json_object *root;
+
+	root = json_create_object();
+	json_object_add_value_int(root, "Lifetime Write Amplification Factor",
+			le32_to_cpu(perf->lifetime_wrt_amp_factor));
+	json_object_add_value_int(root, "Trailing Hour Write Amplification Factor",
+			le32_to_cpu(perf->trailing_hr_wrt_amp_factor));
+	json_object_add_value_int(root, "Percentage of P/E Cycles Remaining",
+			le32_to_cpu(perf->percentage_pe_cycles_remaining));
+	json_object_add_value_int(root, "Lifetime Link Rate Downgrade Count",
+			le32_to_cpu(perf->lifetime_link_rate_downgrade_count));
+	json_object_add_value_int(root, "Lifetime Block Erase Fail Count",
+			le32_to_cpu(perf->lifetime_block_erase_fail_count));
+	json_object_add_value_int(root, "Lifetime Program Fail Count",
+			le32_to_cpu(perf->lifetime_program_fail_count));
+	json_object_add_value_int(root, "Lifetime User Writes",
+			le64_to_cpu(perf->lifetime_user_writes));
+	json_object_add_value_int(root, "Lifetime NAND Writes",
+			le64_to_cpu(perf->lifetime_nand_writes));
+	json_object_add_value_int(root, "Lifetime User Reads",
+			le64_to_cpu(perf->lifetime_user_reads));
+	json_object_add_value_int(root, "Lifetime Retired Block Count",
+			le32_to_cpu(perf->lifetime_retired_block_count));
+	json_object_add_value_int(root, "Lifetime Read Disturb Reallocation Events",
+			le32_to_cpu(perf->lifetime_read_disturb_realloc_events));
+	json_object_add_value_int(root, "Lifetime Die Failure Count",
+			le32_to_cpu(perf->lifetime_die_failure_count));
+	json_object_add_value_int(root, "Current Temperature",
+			le32_to_cpu(perf->current_temp));
+	json_object_add_value_int(root, "Max Recorded Temperature",
+			le32_to_cpu(perf->max_recorded_temp));
+	json_object_add_value_int(root, "Lifetime Thermal Throttle Activations",
+			le32_to_cpu(perf->lifetime_thermal_throttle_act));
+	json_object_add_value_int(root, "Capacitor Health",
+			le32_to_cpu(perf->capacitor_health));
+	json_object_add_value_int(root, "Reserve Erase Block Count",
+			le32_to_cpu(perf->reserve_erase_block_count));
+	json_object_add_value_int(root, "Lifetime UECC Count",
+			le32_to_cpu(perf->lifetime_uecc_count));
+	json_object_add_value_int(root, "Lifetime Reallocated Erase Block Count",
+			le32_to_cpu(perf->lifetime_realloc_erase_block_count));
+	json_object_add_value_int(root, "Lifetime Power on Hours",
+			le32_to_cpu(perf->lifetime_power_on_hours));
+	json_object_add_value_int(root, "Power Loss Counters",
+			le32_to_cpu(perf->power_loss_counters));
+	json_object_add_value_int(root, "Lifetime Clean Shutdown Count on Power Loss",
+			le32_to_cpu(perf->lifetime_clean_shutdown_count));
+	json_object_add_value_int(root, "Lifetime Unclean Shutdowns on Power Loss",
+			le32_to_cpu(perf->lifetime_unclean_shutdown_count));
+
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
 static int wdc_print_ca_log(struct wdc_ssd_ca_perf_stats *perf, int fmt)
 {
 	if (!perf) {
@@ -2014,6 +2370,23 @@ static int wdc_print_ca_log(struct wdc_ssd_ca_perf_stats *perf, int fmt)
 	return 0;
 }
 
+static int wdc_print_d0_log(struct wdc_ssd_d0_smart_log *perf, int fmt)
+{
+	if (!perf) {
+		fprintf(stderr, "ERROR : WDC : Invalid buffer to read perf stats\n");
+		return -1;
+	}
+	switch (fmt) {
+	case NORMAL:
+		wdc_print_d0_log_normal(perf);
+		break;
+	case JSON:
+		wdc_print_d0_log_json(perf);
+		break;
+	}
+	return 0;
+}
+
 static int wdc_get_ca_log_page(int fd, char *format)
 {
 	int ret = 0;
@@ -2021,7 +2394,6 @@ static int wdc_get_ca_log_page(int fd, char *format)
 	__u8 *data;
 	struct wdc_ssd_ca_perf_stats *perf;
 
-
 	if (!wdc_check_device(fd))
 		return -1;
 	fmt = validate_output_format(format);
@@ -2060,13 +2432,116 @@ static int wdc_get_ca_log_page(int fd, char *format)
 	return ret;
 }
 
+static int wdc_get_c1_log_page(int fd, char *format, uint8_t interval)
+{
+	int ret = 0;
+	int fmt = -1;
+	__u8 *data;
+	__u8 *p;
+	int i;
+	int skip_cnt = 4;
+	int total_subpages;
+	struct wdc_log_page_header *l;
+	struct wdc_log_page_subpage_header *sph;
+	struct wdc_ssd_perf_stats *perf;
+
+	if (!wdc_check_device(fd))
+		return -1;
+	fmt = validate_output_format(format);
+	if (fmt < 0) {
+		fprintf(stderr, "ERROR : WDC : invalid output format\n");
+		return fmt;
+	}
+
+	if (interval < 1 || interval > 15) {
+		fprintf(stderr, "ERROR : WDC : interval out of range [1-15]\n");
+		return -1;
+	}
+
+	if ((data = (__u8*) malloc(sizeof (__u8) * WDC_ADD_LOG_BUF_LEN)) == NULL) {
+		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+		return -1;
+	}
+	memset(data, 0, sizeof (__u8) * WDC_ADD_LOG_BUF_LEN);
+
+	ret = nvme_get_log(fd, 0x01, WDC_NVME_ADD_LOG_OPCODE, false,
+			   WDC_ADD_LOG_BUF_LEN, data);
+	if (strcmp(format, "json"))
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	if (ret == 0) {
+		l = (struct wdc_log_page_header*)data;
+		total_subpages = l->num_subpages + WDC_NVME_GET_STAT_PERF_INTERVAL_LIFETIME - 1;
+		for (i = 0, p = data + skip_cnt; i < total_subpages; i++, p += skip_cnt) {
+			sph = (struct wdc_log_page_subpage_header *) p;
+			if (sph->spcode == WDC_GET_LOG_PAGE_SSD_PERFORMANCE) {
+				if (sph->pcset == interval) {
+					perf = (struct wdc_ssd_perf_stats *) (p + 4);
+					ret = wdc_print_log(perf, fmt);
+					break;
+				}
+			}
+			skip_cnt = le32_to_cpu(sph->subpage_length) + 4;
+		}
+		if (ret) {
+			fprintf(stderr, "ERROR : WDC : Unable to read data from buffer\n");
+		}
+	}
+	free(data);
+	return ret;
+}
+
+static int wdc_get_d0_log_page(int fd, char *format)
+{
+	int ret = 0;
+	int fmt = -1;
+	__u8 *data;
+	struct wdc_ssd_d0_smart_log *perf;
+
+	if (!wdc_check_device(fd))
+		return -1;
+	fmt = validate_output_format(format);
+	if (fmt < 0) {
+		fprintf(stderr, "ERROR : WDC : invalid output format\n");
+		return fmt;
+	}
+
+	/* verify the 0xD0 log page is supported */
+	if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_VU_SMART_LOG_OPCODE) == false) {
+		fprintf(stderr, "ERROR : WDC : 0xD0 Log Page not supported\n");
+		return -1;
+	}
+
+	if ((data = (__u8*) malloc(sizeof (__u8) * WDC_NVME_VU_SMART_LOG_LEN)) == NULL) {
+		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+		return -1;
+	}
+	memset(data, 0, sizeof (__u8) * WDC_NVME_VU_SMART_LOG_LEN);
+
+	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_VU_SMART_LOG_OPCODE,
+			   false, WDC_NVME_VU_SMART_LOG_LEN, data);
+	if (strcmp(format, "json"))
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+
+	if (ret == 0) {
+		/* parse the data */
+		perf = (struct wdc_ssd_d0_smart_log *)(data);
+		ret = wdc_print_d0_log(perf, fmt);
+	} else {
+		fprintf(stderr, "ERROR : WDC : Unable to read D0 Log Page data\n");
+		ret = -1;
+	}
+
+	free(data);
+	return ret;
+}
+
 static int wdc_vs_smart_add_log(int argc, char **argv, struct command *command,
 		struct plugin *plugin)
 {
 	const char *desc = "Retrieve additional performance statistics.";
 	const char *interval = "Interval to read the statistics from [1, 15].";
 	int fd;
-	int ret;
+	int ret = 0;
 	__u64 capabilities = 0;
 
 	struct config {
@@ -2091,16 +2566,33 @@ static int wdc_vs_smart_add_log(int argc, char **argv, struct command *command,
 		return fd;
 
 	capabilities = wdc_get_drive_capabilities(fd);
+
+	if ((capabilities & WDC_DRIVE_CAP_SMART_LOG_MASK) == 0) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+		goto out;
+	}
+
 	if ((capabilities & (WDC_DRIVE_CAP_CA_LOG_PAGE)) == (WDC_DRIVE_CAP_CA_LOG_PAGE)) {
 		// Get the CA Log Page
 		ret = wdc_get_ca_log_page(fd, cfg.output_format);
-		if (ret) {
-			fprintf(stderr, "ERROR : WDC : Unable to read CA Log Page\n");
-			return ret;
-		}
-	} else
-		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
-	return 0;
+		if (ret)
+			fprintf(stderr, "ERROR : WDC : Failure reading the CA Log Page, ret = %d\n", ret);
+	}
+	if ((capabilities & WDC_DRIVE_CAP_C1_LOG_PAGE) == WDC_DRIVE_CAP_C1_LOG_PAGE) {
+		// Get the C1 Log Page
+		ret = wdc_get_c1_log_page(fd, cfg.output_format, cfg.interval);
+		if (ret)
+			fprintf(stderr, "ERROR : WDC : Failure reading the C1 Log Page, ret = %d\n", ret);
+	}
+	if ((capabilities & WDC_DRIVE_CAP_D0_LOG_PAGE) == WDC_DRIVE_CAP_D0_LOG_PAGE) {
+		// Get the D0 Log Page
+		ret = wdc_get_d0_log_page(fd, cfg.output_format);
+		if (ret)
+			fprintf(stderr, "ERROR : WDC : Failure reading the D0 Log Page, ret = %d\n", ret);
+	}
+out:
+	return ret;
 }
 
 static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct command *command,
@@ -2131,6 +2623,119 @@ static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct comma
 	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	return ret;
 }
+static int wdc_drive_status(int argc, char **argv, struct command *command,
+		struct plugin *plugin)
+{
+	char *desc = "Get Drive Status.";
+	int fd;
+	int ret = -1;
+	uint32_t system_eol_state;
+	uint32_t user_eol_state;
+	uint32_t format_corrupt_reason = 0xFFFFFFFF;
+	int32_t eol_status;
+	__u32 assert_status = 0xFFFFFFFF, thermal_status = 0xFFFFFFFF;
+	__u64 capabilities = 0;
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	capabilities = wdc_get_drive_capabilities(fd);
+	if ((capabilities & WDC_DRIVE_CAP_DRIVE_STATUS) != WDC_DRIVE_CAP_DRIVE_STATUS) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+		goto out;
+	}
+
+	/* verify the 0xC2 Device Manageability log page is supported */
+	if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEV_MGMNT_LOG_PAGE_OPCODE) == false) {
+		fprintf(stderr, "ERROR : WDC : 0xC2 Log Page not supported\n");
+		ret = -1;
+		goto out;
+	}
+
+	/* Get the assert dump present status */
+	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&assert_status,
+			WDC_C2_ASSERT_DUMP_PRESENT_ID))
+		fprintf(stderr, "ERROR : WDC : Get Assert Status Failed\n");
+
+	/* Get the thermal throttling status */
+	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&thermal_status,
+			WDC_C2_THERMAL_THROTTLE_STATUS_ID))
+		fprintf(stderr, "ERROR : WDC : Get Thermal Throttling Status Failed\n");
+
+	/* Get EOL status */
+	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&eol_status,
+			WDC_C2_USER_EOL_STATUS_ID)) {
+		fprintf(stderr, "ERROR : WDC : Get User EOL Status Failed\n");
+		eol_status = -1;
+	}
+
+	/* Get Customer EOL state */
+	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&user_eol_state,
+			WDC_C2_USER_EOL_STATE_ID))
+		fprintf(stderr, "ERROR : WDC : Get User EOL State Failed\n");
+
+	/* Get System EOL state*/
+	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&system_eol_state,
+			WDC_C2_SYSTEM_EOL_STATE_ID))
+		fprintf(stderr, "ERROR : WDC : Get System EOL State Failed\n");
+
+	/* Get format corrupt reason*/
+	if (!wdc_nvme_get_dev_status_log_data(fd, (__u32 *)&format_corrupt_reason,
+			WDC_C2_FORMAT_CORRUPT_REASON_ID))
+		fprintf(stderr, "ERROR : WDC : Get Format Corrupt Reason Failed\n");
+
+	printf("  Drive Status :- \n");
+	if (eol_status >= 0) {
+		printf("  Percent Used:				%"PRIu32"%%\n",
+				le32_to_cpu(eol_status));
+	}
+	else
+		printf("  Percent Used:				Unknown\n");
+	if (system_eol_state == WDC_EOL_STATUS_NORMAL && user_eol_state == WDC_EOL_STATUS_NORMAL)
+		printf("  Drive Life Status:			Normal\n");
+	else if (system_eol_state == WDC_EOL_STATUS_END_OF_LIFE || user_eol_state == WDC_EOL_STATUS_END_OF_LIFE)
+		printf("  Drive Life Status:	  		End Of Life\n");
+	else if (system_eol_state == WDC_EOL_STATUS_READ_ONLY || user_eol_state == WDC_EOL_STATUS_READ_ONLY)
+		printf("  Drive Life Status:	  		Read Only\n");
+	else
+		printf("  Drive Life Status:			Unknown : 0x%08x/0x%08x\n",
+				le32_to_cpu(user_eol_state), le32_to_cpu(system_eol_state));
+
+	if (assert_status == WDC_ASSERT_DUMP_PRESENT)
+		printf("  Assert Dump Status:			Present\n");
+	else if (assert_status == WDC_ASSERT_DUMP_NOT_PRESENT)
+		printf("  Assert Dump Status:			Not Present\n");
+	else
+		printf("  Assert Dump Status:			Unknown : 0x%08x\n", le32_to_cpu(assert_status));
+
+	if (thermal_status == WDC_THERMAL_THROTTLING_OFF)
+		printf("  Thermal Throttling Status:		Off\n");
+	else if (thermal_status == WDC_THERMAL_THROTTLING_ON)
+		printf("  Thermal Throttling Status:		On\n");
+	else if (thermal_status == WDC_THERMAL_THROTTLING_UNAVAILABLE)
+		printf("  Thermal Throttling Status:		Unavailable\n");
+	else
+		printf("  Thermal Throttling Status:		Unknown : 0x%08x\n", le32_to_cpu(thermal_status));
+
+	if (format_corrupt_reason == WDC_FORMAT_NOT_CORRUPT)
+		printf("  Format Corrupt Reason:		Format Not Corrupted\n");
+	else if (format_corrupt_reason == WDC_FORMAT_CORRUPT_FW_ASSERT)
+		printf("  Format Corrupt Reason:	        Format Corrupt due to FW Assert\n");
+	else if (format_corrupt_reason == WDC_FORMAT_CORRUPT_UNKNOWN)
+		printf("  Format Corrupt Reason:	        Format Corrupt for Unknown Reason\n");
+	else
+		printf("  Format Corrupt Reason:	        Unknown : 0x%08x\n", le32_to_cpu(format_corrupt_reason));
+
+out:
+	return ret;
+}
 
 static int wdc_get_serial_and_fw_rev(int fd, char *sn, char *fw_rev)
 {
diff --git a/plugins/wdc/wdc-nvme.h b/plugins/wdc/wdc-nvme.h
index 4fcc33b..6f00f02 100644
--- a/plugins/wdc/wdc-nvme.h
+++ b/plugins/wdc/wdc-nvme.h
@@ -19,6 +19,7 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("vs-smart-add-log", "WDC Additional Smart Log", wdc_vs_smart_add_log)
 		ENTRY("clear-pcie-correctable-errors", "WDC Clear PCIe Correctable Error Count", wdc_clear_pcie_correctable_errors)
 		ENTRY("drive-essentials", "WDC Drive Essentials", wdc_drive_essentials)
+		ENTRY("get-drive-status", "WDC Get Drive Status", wdc_drive_status)
 	)
 );
 
-- 
2.7.4
