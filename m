From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Mar 2017 17:10:54 -0600
Subject: [PATCH 4/4] move struct nvme_additional_smart_log to intel-nvme.c
In-Reply-To: <20170313231054.30400-1-hch@lst.de>
References: <20170313231054.30400-1-hch@lst.de>
Message-ID: <20170313231054.30400-5-hch@lst.de>

It's a vendor-specific structure only used by the intel plugin, so
move it there.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 intel-nvme.c | 38 ++++++++++++++++++++++++++++++++++++++
 nvme.h       | 38 --------------------------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index 3446115..8ff506c 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -21,6 +21,44 @@
 #define CREATE_CMD
 #include "intel-nvme.h"
 
+#pragma pack(push,1)
+struct nvme_additional_smart_log_item {
+	__u8			key;
+	__u8			_kp[2];
+	__u8			norm;
+	__u8			_np;
+	union {
+		__u8		raw[6];
+		struct wear_level {
+			__le16	min;
+			__le16	max;
+			__le16	avg;
+		} wear_level ;
+		struct thermal_throttle {
+			__u8	pct;
+			__u32	count;
+		} thermal_throttle;
+	};
+	__u8			_rp;
+};
+#pragma pack(pop)
+
+struct nvme_additional_smart_log {
+	struct nvme_additional_smart_log_item	program_fail_cnt;
+	struct nvme_additional_smart_log_item	erase_fail_cnt;
+	struct nvme_additional_smart_log_item	wear_leveling_cnt;
+	struct nvme_additional_smart_log_item	e2e_err_cnt;
+	struct nvme_additional_smart_log_item	crc_err_cnt;
+	struct nvme_additional_smart_log_item	timed_workload_media_wear;
+	struct nvme_additional_smart_log_item	timed_workload_host_reads;
+	struct nvme_additional_smart_log_item	timed_workload_timer;
+	struct nvme_additional_smart_log_item	thermal_throttle_status;
+	struct nvme_additional_smart_log_item	retry_buffer_overflow_cnt;
+	struct nvme_additional_smart_log_item	pll_lock_loss_cnt;
+	struct nvme_additional_smart_log_item	nand_bytes_written;
+	struct nvme_additional_smart_log_item	host_bytes_written;
+};
+
 static void intel_id_ctrl(__u8 *vs, struct json_object *root)
 {
 	char bl[9];
diff --git a/nvme.h b/nvme.h
index fb2a3a3..397a1a5 100644
--- a/nvme.h
+++ b/nvme.h
@@ -55,44 +55,6 @@ enum {
 	NVME_ID_CNS_CTRL_LIST		= 0x13,
 };
 
-#pragma pack(push,1)
-struct nvme_additional_smart_log_item {
-	__u8			key;
-	__u8			_kp[2];
-	__u8			norm;
-	__u8			_np;
-	union {
-		__u8		raw[6];
-		struct wear_level {
-			__le16	min;
-			__le16	max;
-			__le16	avg;
-		} wear_level ;
-		struct thermal_throttle {
-			__u8	pct;
-			__u32	count;
-		} thermal_throttle;
-	};
-	__u8			_rp;
-};
-#pragma pack(pop)
-
-struct nvme_additional_smart_log {
-	struct nvme_additional_smart_log_item	program_fail_cnt;
-	struct nvme_additional_smart_log_item	erase_fail_cnt;
-	struct nvme_additional_smart_log_item	wear_leveling_cnt;
-	struct nvme_additional_smart_log_item	e2e_err_cnt;
-	struct nvme_additional_smart_log_item	crc_err_cnt;
-	struct nvme_additional_smart_log_item	timed_workload_media_wear;
-	struct nvme_additional_smart_log_item	timed_workload_host_reads;
-	struct nvme_additional_smart_log_item	timed_workload_timer;
-	struct nvme_additional_smart_log_item	thermal_throttle_status;
-	struct nvme_additional_smart_log_item	retry_buffer_overflow_cnt;
-	struct nvme_additional_smart_log_item	pll_lock_loss_cnt;
-	struct nvme_additional_smart_log_item	nand_bytes_written;
-	struct nvme_additional_smart_log_item	host_bytes_written;
-};
-
 struct nvme_host_mem_buffer {
 	__u32			hsize;
 	__u32			hmdlal;
-- 
2.11.0
