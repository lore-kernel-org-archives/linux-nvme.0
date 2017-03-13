From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Mar 2017 17:10:51 -0600
Subject: [PATCH 1/4] move show_intel_smart_log to intel-nvme.c
In-Reply-To: <20170313231054.30400-1-hch@lst.de>
References: <20170313231054.30400-1-hch@lst.de>
Message-ID: <20170313231054.30400-2-hch@lst.de>

To fit in with the rest of the plugin infrastructure.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 intel-nvme.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 nvme-print.c | 48 ------------------------------------------------
 nvme-print.h |  1 -
 3 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index df0155a..dc13475 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -48,6 +48,56 @@ static int id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *pl
 	return __id_ctrl(argc, argv, cmd, plugin, intel_id_ctrl);
 }
 
+static void show_intel_smart_log(struct nvme_additional_smart_log *smart,
+		unsigned int nsid, const char *devname)
+{
+	printf("Additional Smart Log for NVME device:%s namespace-id:%x\n",
+		devname, nsid);
+	printf("key                               normalized raw\n");
+	printf("program_fail_count              : %3d%%       %"PRIu64"\n",
+		smart->program_fail_cnt.norm,
+		int48_to_long(smart->program_fail_cnt.raw));
+	printf("erase_fail_count                : %3d%%       %"PRIu64"\n",
+		smart->erase_fail_cnt.norm,
+		int48_to_long(smart->erase_fail_cnt.raw));
+	printf("wear_leveling                   : %3d%%       min: %u, max: %u, avg: %u\n",
+		smart->wear_leveling_cnt.norm,
+		le16_to_cpu(smart->wear_leveling_cnt.wear_level.min),
+		le16_to_cpu(smart->wear_leveling_cnt.wear_level.max),
+		le16_to_cpu(smart->wear_leveling_cnt.wear_level.avg));
+	printf("end_to_end_error_detection_count: %3d%%       %"PRIu64"\n",
+		smart->e2e_err_cnt.norm,
+		int48_to_long(smart->e2e_err_cnt.raw));
+	printf("crc_error_count                 : %3d%%       %"PRIu64"\n",
+		smart->crc_err_cnt.norm,
+		int48_to_long(smart->crc_err_cnt.raw));
+	printf("timed_workload_media_wear       : %3d%%       %.3f%%\n",
+		smart->timed_workload_media_wear.norm,
+		((float)int48_to_long(smart->timed_workload_media_wear.raw)) / 1024);
+	printf("timed_workload_host_reads       : %3d%%       %"PRIu64"%%\n",
+		smart->timed_workload_host_reads.norm,
+		int48_to_long(smart->timed_workload_host_reads.raw));
+	printf("timed_workload_timer            : %3d%%       %"PRIu64" min\n",
+		smart->timed_workload_timer.norm,
+		int48_to_long(smart->timed_workload_timer.raw));
+	printf("thermal_throttle_status         : %3d%%       %u%%, cnt: %u\n",
+		smart->thermal_throttle_status.norm,
+		smart->thermal_throttle_status.thermal_throttle.pct,
+		smart->thermal_throttle_status.thermal_throttle.count);
+	printf("retry_buffer_overflow_count     : %3d%%       %"PRIu64"\n",
+		smart->retry_buffer_overflow_cnt.norm,
+		int48_to_long(smart->retry_buffer_overflow_cnt.raw));
+	printf("pll_lock_loss_count             : %3d%%       %"PRIu64"\n",
+		smart->pll_lock_loss_cnt.norm,
+		int48_to_long(smart->pll_lock_loss_cnt.raw));
+	printf("nand_bytes_written              : %3d%%       sectors: %"PRIu64"\n",
+		smart->nand_bytes_written.norm,
+		int48_to_long(smart->nand_bytes_written.raw));
+	printf("host_bytes_written              : %3d%%       sectors: %"PRIu64"\n",
+		smart->host_bytes_written.norm,
+		int48_to_long(smart->host_bytes_written.raw));
+}
+
 static int get_additional_smart_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	struct nvme_additional_smart_log smart_log;
diff --git a/nvme-print.c b/nvme-print.c
index 6f40303..4eddbd4 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -814,54 +814,6 @@ void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 	}
 }
 
-void show_intel_smart_log(struct nvme_additional_smart_log *smart, unsigned int nsid, const char *devname)
-{
-	printf("Additional Smart Log for NVME device:%s namespace-id:%x\n", devname, nsid);
-	printf("key                               normalized raw\n");
-	printf("program_fail_count              : %3d%%       %"PRIu64"\n",
-		smart->program_fail_cnt.norm,
-		int48_to_long(smart->program_fail_cnt.raw));
-	printf("erase_fail_count                : %3d%%       %"PRIu64"\n",
-		smart->erase_fail_cnt.norm,
-		int48_to_long(smart->erase_fail_cnt.raw));
-	printf("wear_leveling                   : %3d%%       min: %u, max: %u, avg: %u\n",
-		smart->wear_leveling_cnt.norm,
-		le16_to_cpu(smart->wear_leveling_cnt.wear_level.min),
-		le16_to_cpu(smart->wear_leveling_cnt.wear_level.max),
-		le16_to_cpu(smart->wear_leveling_cnt.wear_level.avg));
-	printf("end_to_end_error_detection_count: %3d%%       %"PRIu64"\n",
-		smart->e2e_err_cnt.norm,
-		int48_to_long(smart->e2e_err_cnt.raw));
-	printf("crc_error_count                 : %3d%%       %"PRIu64"\n",
-		smart->crc_err_cnt.norm,
-		int48_to_long(smart->crc_err_cnt.raw));
-	printf("timed_workload_media_wear       : %3d%%       %.3f%%\n",
-		smart->timed_workload_media_wear.norm,
-		((float)int48_to_long(smart->timed_workload_media_wear.raw)) / 1024);
-	printf("timed_workload_host_reads       : %3d%%       %"PRIu64"%%\n",
-		smart->timed_workload_host_reads.norm,
-		int48_to_long(smart->timed_workload_host_reads.raw));
-	printf("timed_workload_timer            : %3d%%       %"PRIu64" min\n",
-		smart->timed_workload_timer.norm,
-		int48_to_long(smart->timed_workload_timer.raw));
-	printf("thermal_throttle_status         : %3d%%       %u%%, cnt: %u\n",
-		smart->thermal_throttle_status.norm,
-		smart->thermal_throttle_status.thermal_throttle.pct,
-		smart->thermal_throttle_status.thermal_throttle.count);
-	printf("retry_buffer_overflow_count     : %3d%%       %"PRIu64"\n",
-		smart->retry_buffer_overflow_cnt.norm,
-		int48_to_long(smart->retry_buffer_overflow_cnt.raw));
-	printf("pll_lock_loss_count             : %3d%%       %"PRIu64"\n",
-		smart->pll_lock_loss_cnt.norm,
-		int48_to_long(smart->pll_lock_loss_cnt.raw));
-	printf("nand_bytes_written              : %3d%%       sectors: %"PRIu64"\n",
-		smart->nand_bytes_written.norm,
-		int48_to_long(smart->nand_bytes_written.raw));
-	printf("host_bytes_written              : %3d%%       sectors: %"PRIu64"\n",
-		smart->host_bytes_written.norm,
-		int48_to_long(smart->host_bytes_written.raw));
-}
-
 char *nvme_feature_to_string(int feature)
 {
 	switch (feature) {
diff --git a/nvme-print.h b/nvme-print.h
index f5e4c8f..cd1c9e7 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -23,7 +23,6 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
 void show_nvme_resv_report(struct nvme_reservation_status *status);
 void show_lba_range(struct nvme_lba_range_type *lbrt, int nr_ranges);
 void show_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
-void show_intel_smart_log(struct nvme_additional_smart_log *smart, unsigned int nsid, const char *devname);
 void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
 void show_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void show_ctrl_registers(void *bar, unsigned int mode);
-- 
2.11.0
