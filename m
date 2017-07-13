From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 13 Jul 2017 12:16:51 -0600
Subject: [PATCH v2] nvme: Add support for NVMe 1.3 Timestamp Feature
Message-ID: <20170713181651.1887-1-jonathan.derrick@intel.com>

NVME's Timestamp feature allows controllers to be aware of the epoch
time in milliseconds. This patch adds the set features hook for various
transports through the identify path, so that resets and resumes can
update the controller as necessary.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
v1->2:
Moved to core code in identify path because all callers use this in their reset
path.
Removed 1.3 version check.
Changed put_unaligned_le64 to cpu_to_le64.
Changed the warning to output status instead of result.

To commemerate the upcoming 1500000000 rollover :)

 drivers/nvme/host/core.c | 17 +++++++++++++++++
 include/linux/nvme.h     |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da58d35..644b5a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1514,6 +1514,22 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
+static void nvme_configure_timestamp(struct nvme_ctrl *ctrl)
+{
+	__le64 ts;
+	int status;
+
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_TIMESTAMP))
+		return;
+
+	ts = cpu_to_le64(ktime_to_ms(ktime_get_real()));
+	status = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP,
+				   0, &ts, 8, NULL);
+	if (status != 0)
+		dev_warn_once(ctrl->device,
+			"could not set timestamp (%d)\n", status);
+}
+
 static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 {
 	/*
@@ -1862,6 +1878,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
 
 	nvme_configure_apst(ctrl);
+	nvme_configure_timestamp(ctrl);
 	nvme_configure_directives(ctrl);
 
 	ctrl->identified = true;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 983975b..b7185ae 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -254,6 +254,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
+	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
@@ -688,6 +689,7 @@ enum {
 	NVME_FEAT_ASYNC_EVENT	= 0x0b,
 	NVME_FEAT_AUTO_PST	= 0x0c,
 	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
+	NVME_FEAT_TIMESTAMP	= 0x0e,
 	NVME_FEAT_KATO		= 0x0f,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
-- 
2.9.3
