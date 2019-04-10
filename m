From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Wed, 10 Apr 2019 15:15:21 +0000
Subject: [PATCH] [NVMe-CLI] Fix Failure to read 0xCA Log Page on SN200 Device
 [NVMe-CLI] Fix Incorrect Data Formats with the 0xCA and 0xD0 Log Pages
Message-ID: <1554909267-30735-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 239 +++++++++++++++++++++++++------------------------
 1 file changed, 121 insertions(+), 118 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 984154e..f3744ce 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -526,54 +526,55 @@ struct wdc_c2_cbs_data {
 };
 
 struct __attribute__((__packed__)) wdc_ssd_ca_perf_stats {
-	__le64	nand_bytes_wr_lo;			/* 0x00 - NAND Bytes Written lo				*/
-	__le64	nand_bytes_wr_hi;			/* 0x08 - NAND Bytes Written hi				*/
-	__le64	nand_bytes_rd_lo;			/* 0x10 - NAND Bytes Read lo				*/
-	__le64	nand_bytes_rd_hi;			/* 0x18 - NAND Bytes Read hi				*/
-	__le64	nand_bad_block;				/* 0x20 - NAND Bad Block Count				*/
-	__le64	uncorr_read_count;			/* 0x28 - Uncorrectable Read Count			*/
-	__le64	ecc_error_count;			/* 0x30 - Soft ECC Error Count				*/
-	__le32	ssd_detect_count;			/* 0x38 - SSD End to End Detection Count	*/
-	__le32	ssd_correct_count;			/* 0x3C - SSD End to End Correction Count	*/
-	__le32	data_percent_used;			/* 0x40 - System Data Percent Used			*/
-	__le32	data_erase_max;				/* 0x44 - User Data Erase Counts			*/
-	__le32	data_erase_min;				/* 0x48 - User Data Erase Counts			*/
-	__le64	refresh_count;				/* 0x4c - Refresh Count						*/
-	__le64	program_fail;				/* 0x54 - Program Fail Count				*/
-	__le64	user_erase_fail;			/* 0x5C - User Data Erase Fail Count		*/
-	__le64	system_erase_fail;			/* 0x64 - System Area Erase Fail Count		*/
-	__le16	thermal_throttle_status;	/* 0x6C - Thermal Throttling Status			*/
-	__le16	thermal_throttle_count;		/* 0x6E - Thermal Throttling Count			*/
-	__le64	pcie_corr_error;			/* 0x70 - pcie Correctable Error Count		*/
-	__le32	rsvd1;						/* 0x78 - Reserved							*/
-	__le32	rsvd2;						/* 0x7C - Reserved							*/
+	__le64  nand_bytes_wr_lo;                       /* 0x00 - NAND Bytes Written lo             */
+	__le64  nand_bytes_wr_hi;                       /* 0x08 - NAND Bytes Written hi             */
+	__le64  nand_bytes_rd_lo;                       /* 0x10 - NAND Bytes Read lo                */
+	__le64  nand_bytes_rd_hi;                       /* 0x18 - NAND Bytes Read hi                */
+	__le64  nand_bad_block;                         /* 0x20 - NAND Bad Block Count              */
+	__le64  uncorr_read_count;                      /* 0x28 - Uncorrectable Read Count          */
+	__le64  ecc_error_count;                        /* 0x30 - Soft ECC Error Count              */
+	__le32  ssd_detect_count;                       /* 0x38 - SSD End to End Detection Count    */
+	__le32  ssd_correct_count;                      /* 0x3C - SSD End to End Correction Count   */
+	__u8    data_percent_used;                      /* 0x40 - System Data Percent Used          */
+	__le32  data_erase_max;                         /* 0x41 - User Data Erase Counts            */
+	__le32  data_erase_min;                         /* 0x45 - User Data Erase Counts            */
+	__le64  refresh_count;                          /* 0x49 - Refresh Count                     */
+	__le64  program_fail;                           /* 0x51 - Program Fail Count                */
+	__le64  user_erase_fail;                        /* 0x59 - User Data Erase Fail Count        */
+	__le64  system_erase_fail;                      /* 0x61 - System Area Erase Fail Count      */
+	__u8    thermal_throttle_status;                /* 0x69 - Thermal Throttling Status         */
+	__u8    thermal_throttle_count;                 /* 0x6A - Thermal Throttling Count          */
+	__le64  pcie_corr_error;                        /* 0x6B - pcie Correctable Error Count      */
+	__le32  incomplete_shutdown_count;              /* 0x73 - Incomplete Shutdown Count         */
+	__u8    percent_free_blocks;                    /* 0x77 - Percent Free Blocks               */
+	__u8    rsvd[392];                              /* 0x78 - Reserved bytes 120-511            */
 };
 
 struct __attribute__((__packed__)) wdc_ssd_d0_smart_log {
-    __le32  lifetime_wrt_amp_factor;              /* 0x00 - Lifetime write amplification factor         */
-    __le32  trailing_hr_wrt_amp_factor;           /* 0x04 - Trailing hour write amplification factor    */
-    __le32  percentage_pe_cycles_remaining;       /* 0x08 - Percentage of P/E cycles remaining          */
-    __le32  lifetime_link_rate_downgrade_count;   /* 0x0C - Lifetime link rate downgrade count          */
-    __le32  lifetime_block_erase_fail_count;      /* 0x10 - Lifetime block erase fail count             */
-    __le32  lifetime_program_fail_count;          /* 0x14 - Lifetime program fail count                 */
-    __le64  lifetime_user_writes;                 /* 0x18 - Lifetime user writes                        */
-    __le64  lifetime_nand_writes;                 /* 0x20 - Lifetime NAND writes                        */
-    __le64  lifetime_user_reads;                  /* 0x28 - Lifetime user reads                         */
-    __le32  lifetime_retired_block_count;         /* 0x30 - Lifetime retired block count                */
-    __le32  lifetime_read_disturb_realloc_events; /* 0x34 - Lifetime read disturb reallocation events   */
-    __le32  lifetime_die_failure_count;           /* 0x38 - Lifetime die failure count                  */
-    __le32  current_temp;                         /* 0x3C - Current temperature                         */
-    __le32  max_recorded_temp;                    /* 0x40 - Max recorded temperature                    */
-    __le32  lifetime_thermal_throttle_act;        /* 0x44 - Lifetime thermal throttle activations       */
-    __le32  capacitor_health;                     /* 0x48 - Capacitor health                            */
-    __le32  reserve_erase_block_count;            /* 0x4C - Reserve erase block count                   */
-    __le32  lifetime_uecc_count;                  /* 0x50 - Lifetime UECC count                         */
-    __le32  lifetime_realloc_erase_block_count;   /* 0x54 - Lifetime reallocated erase block count      */
-    __le32  lifetime_power_on_hours;              /* 0x58 - Lifetime power on hours                     */
-    __le32  power_loss_counters;                  /* 0x5C - Power loss counters                         */
-    __le32  lifetime_clean_shutdown_count;        /* 0x60 - Lifetime clean shutdown count on power loss */
-    __le32  lifetime_unclean_shutdown_count;      /* 0x64 - Lifetime unclean shutdowns on power loss    */
-    __u8    rsvd_104[0x198];                      /* 0x68-0x1FF Reserved                                */
+    __le32  smart_log_page_header;                 /* 0x00 - Smart Log Page Header                       */
+    __le32  lifetime_realloc_erase_block_count;    /* 0x04 - Lifetime reallocated erase block count      */
+    __le32  lifetime_power_on_hours;               /* 0x08 - Lifetime power on hours                     */
+    __le32  lifetime_uecc_count;                   /* 0x0C - Lifetime UECC count                         */
+    __le32  lifetime_wrt_amp_factor;               /* 0x10 - Lifetime write amplification factor         */
+    __le32  trailing_hr_wrt_amp_factor;            /* 0x14 - Trailing hour write amplification factor    */
+    __le32  reserve_erase_block_count;             /* 0x18 - Reserve erase block count                   */
+    __le32  lifetime_program_fail_count;           /* 0x1C - Lifetime program fail count                 */
+    __le32  lifetime_block_erase_fail_count;       /* 0x20 - Lifetime block erase fail count             */
+    __le32  lifetime_die_failure_count;            /* 0x24 - Lifetime die failure count                  */
+    __le32  lifetime_link_rate_downgrade_count;    /* 0x28 - Lifetime link rate downgrade count          */
+    __le32  lifetime_clean_shutdown_count;         /* 0x2C - Lifetime clean shutdown count on power loss */
+    __le32  lifetime_unclean_shutdown_count;       /* 0x30 - Lifetime unclean shutdowns on power loss    */
+    __le32  current_temp;                          /* 0x34 - Current temperature                         */
+    __le32  max_recorded_temp;                     /* 0x38 - Max recorded temperature                    */
+    __le32  lifetime_retired_block_count;          /* 0x3C - Lifetime retired block count                */
+    __le32  lifetime_read_disturb_realloc_events;  /* 0x40 - Lifetime read disturb reallocation events   */
+    __le64  lifetime_nand_writes;                  /* 0x44 - Lifetime NAND write Lpages                  */
+    __le32  capacitor_health;                      /* 0x4C - Capacitor health                            */
+    __le64  lifetime_user_writes;                  /* 0x50 - Lifetime user writes                        */
+    __le64  lifetime_user_reads;                   /* 0x58 - Lifetime user reads                         */
+    __le32  lifetime_thermal_throttle_act;         /* 0x60 - Lifetime thermal throttle activations       */
+    __le32  percentage_pe_cycles_remaining;        /* 0x64 - Percentage of P/E cycles remaining          */
+    __u8    rsvd[408];                             /* 0x68 - 408 Reserved bytes                          */
 };
 
 /* NAND Stats */
@@ -2265,7 +2266,7 @@ static void wdc_print_ca_log_normal(struct wdc_ssd_ca_perf_stats *perf)
 	printf("  SSD End to End Corrected Correction Count      %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->ssd_correct_count));
 	printf("  System Data Percent Used                       %20"PRIu32"%%\n",
-			(uint32_t)le32_to_cpu(perf->data_percent_used));
+			perf->data_percent_used);
 	printf("  User Data Erase Counts Max                     %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->data_erase_max));
 	printf("  User Data Erase Counts Min                     %20"PRIu32"\n",
@@ -2291,12 +2292,16 @@ static void wdc_print_ca_log_normal(struct wdc_ssd_ca_perf_stats *perf)
 	printf("  System Area Erase Fail Count (Raw)             %20"PRIu64"\n",
 			converted >> 16);
 
-	printf("  Thermal Throttling Status                      %20"PRIu16"\n",
-			(uint16_t)le16_to_cpu(perf->thermal_throttle_status));
-	printf("  Thermal Throttling Count                       %20"PRIu16"\n",
-			(uint16_t)le16_to_cpu(perf->thermal_throttle_count));
+	printf("  Thermal Throttling Status                      %20"PRIu8"\n",
+			perf->thermal_throttle_status);
+	printf("  Thermal Throttling Count                       %20"PRIu8"\n",
+			perf->thermal_throttle_count);
 	printf("  PCIe Correctable Error Count                   %20"PRIu64"\n",
 			(uint64_t)le64_to_cpu(perf->pcie_corr_error));
+	printf("  Incomplete Shutdown Count                      %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->incomplete_shutdown_count));
+	printf("  Percent Free Blocks                            %20"PRIu32"%%\n",
+			perf->percent_free_blocks);
 }
 
 static void wdc_print_ca_log_json(struct wdc_ssd_ca_perf_stats *perf)
@@ -2323,7 +2328,7 @@ static void wdc_print_ca_log_json(struct wdc_ssd_ca_perf_stats *perf)
 	json_object_add_value_int(root, "SSD End to End Corrected Correction Count",
 			le32_to_cpu(perf->ssd_correct_count));
 	json_object_add_value_int(root, "System Data Percent Used",
-			le32_to_cpu(perf->data_percent_used));
+			perf->data_percent_used);
 	json_object_add_value_int(root, "User Data Erase Counts Max",
 			le32_to_cpu(perf->data_erase_max));
 	json_object_add_value_int(root, "User Data Erase Counts Min",
@@ -2349,10 +2354,12 @@ static void wdc_print_ca_log_json(struct wdc_ssd_ca_perf_stats *perf)
 			converted >> 16);
 
 	json_object_add_value_int(root, "Thermal Throttling Status",
-			le16_to_cpu(perf->thermal_throttle_status));
+			perf->thermal_throttle_status);
 	json_object_add_value_int(root, "Thermal Throttling Count",
-			le16_to_cpu(perf->thermal_throttle_count));
+			perf->thermal_throttle_count);
 	json_object_add_value_int(root, "PCIe Correctable Error", le64_to_cpu(perf->pcie_corr_error));
+	json_object_add_value_int(root, "Incomplete Shutdown Counte", le32_to_cpu(perf->incomplete_shutdown_count));
+	json_object_add_value_int(root, "Percent Free Blocks", perf->percent_free_blocks);
 	json_print_object(root, NULL);
 	printf("\n");
 	json_free_object(root);
@@ -2361,52 +2368,50 @@ static void wdc_print_ca_log_json(struct wdc_ssd_ca_perf_stats *perf)
 static void wdc_print_d0_log_normal(struct wdc_ssd_d0_smart_log *perf)
 {
 	printf("  D0 Smart Log Page Statistics :- \n");
+	printf("  Lifetime Reallocated Erase Block Count	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_realloc_erase_block_count));
+	printf("  Lifetime Power on Hours			 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_power_on_hours));
+	printf("  Lifetime UECC Count	                         %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_uecc_count));
 	printf("  Lifetime Write Amplification Factor	         %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->lifetime_wrt_amp_factor));
 	printf("  Trailing Hour Write Amplification Factor  	 %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->trailing_hr_wrt_amp_factor));
-	printf("  Percentage of P/E Cycles Remaining             %20"PRIu32"%%\n",
-			(uint32_t)le32_to_cpu(perf->percentage_pe_cycles_remaining));
-	printf("  Lifetime Link Rate Downgrade Count	         %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_link_rate_downgrade_count));
-	printf("  Lifetime Block Erase Fail Count		 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_block_erase_fail_count));
+	printf("  Reserve Erase Block Count	                 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->reserve_erase_block_count));
 	printf("  Lifetime Program Fail Count	     	         %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->lifetime_program_fail_count));
-	printf("  Lifetime User Writes	                         %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->lifetime_user_writes));
-	printf("  Lifetime NAND Writes	                         %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->lifetime_nand_writes));
-	printf("  Lifetime User Reads	                         %20"PRIu64"\n",
-			(uint64_t)le64_to_cpu(perf->lifetime_user_reads));
-	printf("  Lifetime Retired Block Count	                 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_retired_block_count));
-	printf("  Lifetime Read Disturb Reallocation Events	 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_read_disturb_realloc_events));
+	printf("  Lifetime Block Erase Fail Count		 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_block_erase_fail_count));
 	printf("  Lifetime Die Failure Count	                 %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->lifetime_die_failure_count));
+	printf("  Lifetime Link Rate Downgrade Count	         %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_link_rate_downgrade_count));
+	printf("  Lifetime Clean Shutdown Count on Power Loss	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_clean_shutdown_count));
+	printf("  Lifetime Unclean Shutdowns on Power Loss	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_unclean_shutdown_count));
 	printf("  Current Temperature 	                         %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->current_temp));
 	printf("  Max Recorded Temperature			 %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->max_recorded_temp));
+	printf("  Lifetime Retired Block Count	                 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_retired_block_count));
+	printf("  Lifetime Read Disturb Reallocation Events	 %20"PRIu32"\n",
+			(uint32_t)le32_to_cpu(perf->lifetime_read_disturb_realloc_events));
+	printf("  Lifetime NAND Writes	                         %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->lifetime_nand_writes));
+	printf("  Capacitor Health			 	 %20"PRIu32"%%\n",
+			(uint32_t)le32_to_cpu(perf->capacitor_health));
+	printf("  Lifetime User Writes	                         %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->lifetime_user_writes));
+	printf("  Lifetime User Reads	                         %20"PRIu64"\n",
+			(uint64_t)le64_to_cpu(perf->lifetime_user_reads));
 	printf("  Lifetime Thermal Throttle Activations	         %20"PRIu32"\n",
 			(uint32_t)le32_to_cpu(perf->lifetime_thermal_throttle_act));
-	printf("  Capacitor Health			 	 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->capacitor_health));
-	printf("  Reserve Erase Block Count	                 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->reserve_erase_block_count));
-	printf("  Lifetime UECC Count	                         %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_uecc_count));
-	printf("  Lifetime Reallocated Erase Block Count	 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_realloc_erase_block_count));
-	printf("  Lifetime Power on Hours			 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_power_on_hours));
-	printf("  Power Loss Counters		         	 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->power_loss_counters));
-	printf("  Lifetime Clean Shutdown Count on Power Loss	 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_clean_shutdown_count));
-	printf("  Lifetime Unclean Shutdowns on Power Loss	 %20"PRIu32"\n",
-			(uint32_t)le32_to_cpu(perf->lifetime_unclean_shutdown_count));
+	printf("  Percentage of P/E Cycles Remaining             %20"PRIu32"%%\n",
+			(uint32_t)le32_to_cpu(perf->percentage_pe_cycles_remaining));
 }
 
 static void wdc_print_d0_log_json(struct wdc_ssd_d0_smart_log *perf)
@@ -2414,52 +2419,50 @@ static void wdc_print_d0_log_json(struct wdc_ssd_d0_smart_log *perf)
 	struct json_object *root;
 
 	root = json_create_object();
+	json_object_add_value_int(root, "Lifetime Reallocated Erase Block Count",
+			le32_to_cpu(perf->lifetime_realloc_erase_block_count));
+	json_object_add_value_int(root, "Lifetime Power on Hours",
+			le32_to_cpu(perf->lifetime_power_on_hours));
+	json_object_add_value_int(root, "Lifetime UECC Count",
+			le32_to_cpu(perf->lifetime_uecc_count));
 	json_object_add_value_int(root, "Lifetime Write Amplification Factor",
 			le32_to_cpu(perf->lifetime_wrt_amp_factor));
 	json_object_add_value_int(root, "Trailing Hour Write Amplification Factor",
 			le32_to_cpu(perf->trailing_hr_wrt_amp_factor));
-	json_object_add_value_int(root, "Percentage of P/E Cycles Remaining",
-			le32_to_cpu(perf->percentage_pe_cycles_remaining));
-	json_object_add_value_int(root, "Lifetime Link Rate Downgrade Count",
-			le32_to_cpu(perf->lifetime_link_rate_downgrade_count));
-	json_object_add_value_int(root, "Lifetime Block Erase Fail Count",
-			le32_to_cpu(perf->lifetime_block_erase_fail_count));
+	json_object_add_value_int(root, "Reserve Erase Block Count",
+			le32_to_cpu(perf->reserve_erase_block_count));
 	json_object_add_value_int(root, "Lifetime Program Fail Count",
 			le32_to_cpu(perf->lifetime_program_fail_count));
-	json_object_add_value_int(root, "Lifetime User Writes",
-			le64_to_cpu(perf->lifetime_user_writes));
-	json_object_add_value_int(root, "Lifetime NAND Writes",
-			le64_to_cpu(perf->lifetime_nand_writes));
-	json_object_add_value_int(root, "Lifetime User Reads",
-			le64_to_cpu(perf->lifetime_user_reads));
-	json_object_add_value_int(root, "Lifetime Retired Block Count",
-			le32_to_cpu(perf->lifetime_retired_block_count));
-	json_object_add_value_int(root, "Lifetime Read Disturb Reallocation Events",
-			le32_to_cpu(perf->lifetime_read_disturb_realloc_events));
+	json_object_add_value_int(root, "Lifetime Block Erase Fail Count",
+			le32_to_cpu(perf->lifetime_block_erase_fail_count));
 	json_object_add_value_int(root, "Lifetime Die Failure Count",
 			le32_to_cpu(perf->lifetime_die_failure_count));
+	json_object_add_value_int(root, "Lifetime Link Rate Downgrade Count",
+			le32_to_cpu(perf->lifetime_link_rate_downgrade_count));
+	json_object_add_value_int(root, "Lifetime Clean Shutdown Count on Power Loss",
+			le32_to_cpu(perf->lifetime_clean_shutdown_count));
+	json_object_add_value_int(root, "Lifetime Unclean Shutdowns on Power Loss",
+			le32_to_cpu(perf->lifetime_unclean_shutdown_count));
 	json_object_add_value_int(root, "Current Temperature",
 			le32_to_cpu(perf->current_temp));
 	json_object_add_value_int(root, "Max Recorded Temperature",
 			le32_to_cpu(perf->max_recorded_temp));
-	json_object_add_value_int(root, "Lifetime Thermal Throttle Activations",
-			le32_to_cpu(perf->lifetime_thermal_throttle_act));
+	json_object_add_value_int(root, "Lifetime Retired Block Count",
+			le32_to_cpu(perf->lifetime_retired_block_count));
+	json_object_add_value_int(root, "Lifetime Read Disturb Reallocation Events",
+			le32_to_cpu(perf->lifetime_read_disturb_realloc_events));
+	json_object_add_value_int(root, "Lifetime NAND Writes",
+			le64_to_cpu(perf->lifetime_nand_writes));
 	json_object_add_value_int(root, "Capacitor Health",
 			le32_to_cpu(perf->capacitor_health));
-	json_object_add_value_int(root, "Reserve Erase Block Count",
-			le32_to_cpu(perf->reserve_erase_block_count));
-	json_object_add_value_int(root, "Lifetime UECC Count",
-			le32_to_cpu(perf->lifetime_uecc_count));
-	json_object_add_value_int(root, "Lifetime Reallocated Erase Block Count",
-			le32_to_cpu(perf->lifetime_realloc_erase_block_count));
-	json_object_add_value_int(root, "Lifetime Power on Hours",
-			le32_to_cpu(perf->lifetime_power_on_hours));
-	json_object_add_value_int(root, "Power Loss Counters",
-			le32_to_cpu(perf->power_loss_counters));
-	json_object_add_value_int(root, "Lifetime Clean Shutdown Count on Power Loss",
-			le32_to_cpu(perf->lifetime_clean_shutdown_count));
-	json_object_add_value_int(root, "Lifetime Unclean Shutdowns on Power Loss",
-			le32_to_cpu(perf->lifetime_unclean_shutdown_count));
+	json_object_add_value_int(root, "Lifetime User Writes",
+			le64_to_cpu(perf->lifetime_user_writes));
+	json_object_add_value_int(root, "Lifetime User Reads",
+			le64_to_cpu(perf->lifetime_user_reads));
+	json_object_add_value_int(root, "Lifetime Thermal Throttle Activations",
+			le32_to_cpu(perf->lifetime_thermal_throttle_act));
+	json_object_add_value_int(root, "Percentage of P/E Cycles Remaining",
+			le32_to_cpu(perf->percentage_pe_cycles_remaining));
 
 	json_print_object(root, NULL);
 	printf("\n");
@@ -2516,7 +2519,7 @@ static int wdc_get_ca_log_page(int fd, char *format)
 	}
 
 	/* verify the 0xCA log page is supported */
-	if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE)) {
+	if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE) == false) {
 		fprintf(stderr, "ERROR : WDC : 0xCA Log Page not supported\n");
 		return -1;
 	}
-- 
1.8.3.1
