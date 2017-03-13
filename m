From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Mar 2017 17:10:52 -0600
Subject: [PATCH 2/4] remove json_add_smart_log
In-Reply-To: <20170313231054.30400-1-hch@lst.de>
References: <20170313231054.30400-1-hch@lst.de>
Message-ID: <20170313231054.30400-3-hch@lst.de>

This is the json variant of the Intel additional smart log, but it
appears to be entirely unused.  If we want to bring it back it should
be moved to intel-nvme.c, though.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-print.c | 53 -----------------------------------------------------
 nvme-print.h |  2 --
 2 files changed, 55 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 4eddbd4..a86902e 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1408,59 +1408,6 @@ void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname)
 	json_free_object(root);
 }
 
-void json_add_smart_log(struct nvme_additional_smart_log *smart,
-			unsigned int nsid, const char *devname)
-{
-	struct json_object *root;
-	struct json_object *data;
-	char fmt[128];
-
-	root = json_create_object();
-	data = json_create_object();
-
-	json_object_add_value_int(data, "Program Fail Count",
-				  int48_to_long(smart->program_fail_cnt.raw));
-	json_object_add_value_int(data, "Erase Fail Count",
-				  int48_to_long(smart->erase_fail_cnt.raw));
-	json_object_add_value_int(data, "Wear Leveling Min",
-				  le16toh(smart->wear_leveling_cnt.wear_level.min));
-	json_object_add_value_int(data, "Wear Leveling Max",
-				  le16toh(smart->wear_leveling_cnt.wear_level.max));
-	json_object_add_value_int(data, "Wear Leveling Avg",
-				  le16toh(smart->wear_leveling_cnt.wear_level.avg));
-	json_object_add_value_int(data, "End-to-end Error Detection Count",
-				  int48_to_long(smart->e2e_err_cnt.raw));
-	json_object_add_value_int(data, "CRC Error Count",
-				  int48_to_long(smart->crc_err_cnt.raw));
-	json_object_add_value_float(data, "Timed Workload Media Wear",
-				    ((long double)int48_to_long(smart->timed_workload_media_wear.raw)) / 1024);
-
-	json_object_add_value_int(data, "Timed Workload Host Reads",
-				  int48_to_long(smart->timed_workload_host_reads.raw));
-	json_object_add_value_int(data, "Timed Workload Timer",
-				  int48_to_long(smart->timed_workload_timer.raw));
-	snprintf(fmt, sizeof(fmt), "%u%%",
-		 smart->thermal_throttle_status.thermal_throttle.pct);
-	json_object_add_value_string(data, "Thermal Throttle status Percentage",
-				     fmt);
-	json_object_add_value_int(data, "Thermal Throttle Status Count",
-				  smart->thermal_throttle_status.thermal_throttle.count);
-	json_object_add_value_int(data, "Retry Buffer Overflow Count",
-				  int48_to_long(smart->retry_buffer_overflow_cnt.raw));
-	json_object_add_value_int(data, "PLL Lock Loss Count",
-				  int48_to_long(smart->pll_lock_loss_cnt.raw));
-	json_object_add_value_int(data, "Nand Bytes Written",
-				  int48_to_long(smart->nand_bytes_written.raw));
-	json_object_add_value_int(data, "Host Bytes Written",
-				  int48_to_long(smart->host_bytes_written.raw));
-
-	snprintf(fmt, sizeof(fmt), "Additional Smart Log for %s", devname);
-	json_object_add_value_object(root, fmt, data);
-	json_print_object(root, NULL);
-	json_free_object(data);
-	json_free_object(root);
-}
-
 void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname)
 {
 	struct json_object *root;
diff --git a/nvme-print.h b/nvme-print.h
index cd1c9e7..0502d0d 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -37,8 +37,6 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
 void json_nvme_resv_report(struct nvme_reservation_status *status);
 void json_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
 void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
-void json_add_smart_log(struct nvme_additional_smart_log *smart,
-			unsigned int nsid, const char *devname);
 void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void json_print_list_items(struct list_item *items, unsigned amnt);
 
-- 
2.11.0
