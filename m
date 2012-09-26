From: keith.busch@intel.com (Keith Busch)
Date: Wed, 26 Sep 2012 12:49:27 -0600
Subject: [PATCH] NVMe: Define SMART log
Message-ID: <1348685367-29949-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    1 +
 include/linux/nvme.h |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f9ad514..5aa1cf4 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -134,6 +134,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 }
 
 typedef void (*nvme_completion_fn)(struct nvme_dev *, void *,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c25ccca..1837611 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -137,6 +137,34 @@ enum {
 	NVME_LBAF_RP_DEGRADED	= 3,
 };
 
+struct nvme_smart_log {
+	__u8			critical_warning;
+	__u8			temperature[2];
+	__u8			avail_spare;
+	__u8			spare_thresh;
+	__u8			percent_used;
+	__u8			rsvd6[26];
+	__u8			data_units_read[16];
+	__u8			data_units_written[16];
+	__u8			host_reads[16];
+	__u8			host_writes[16];
+	__u8			ctrl_busy_time[16];
+	__u8			power_cycles[16];
+	__u8			power_on_hours[16];
+	__u8			unsafe_shutdowns[16];
+	__u8			media_errors[16];
+	__u8			num_err_log_entries[16];
+	__u8			rsvd192[320];
+};
+
+enum {
+	NVME_SMART_CRIT_SPARE		= 1 << 0,
+	NVME_SMART_CRIT_TEMPERATURE	= 1 << 1,
+	NVME_SMART_CRIT_RELIABILITY	= 1 << 2,
+	NVME_SMART_CRIT_MEDIA		= 1 << 3,
+	NVME_SMART_CRIT_VOLITILE_MEMORY	= 1 << 4,
+};
+
 struct nvme_lba_range_type {
 	__u8			type;
 	__u8			attributes;
-- 
1.7.0.4
