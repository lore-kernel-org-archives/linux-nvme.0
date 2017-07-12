From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 12 Jul 2017 16:11:01 -0600
Subject: [PATCH] nvme: Add support for NVMe 1.3 Timestamp Feature
Message-ID: <20170712221101.1715-1-jonathan.derrick@intel.com>

NVME's Timestamp feature allows controllers to be aware of the epoch
time in milliseconds. This patch adds the set features hook for various
transports. It also wires it up to the pci reset path, so that resets
and resumes can update the controller as necessary.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/nvme/host/core.c | 18 ++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  4 ++++
 include/linux/nvme.h     |  2 ++
 4 files changed, 25 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4a07a98..aa4e765 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1735,6 +1735,24 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memset(ctrl->subnqn + off, 0, sizeof(ctrl->subnqn) - off);
 }
 
+void nvme_set_timestamp(struct nvme_ctrl *ctrl)
+{
+	u64 cur_ms;
+	u8 ts[8] = { 0, };
+	int status;
+	u32 result;
+
+	cur_ms = ktime_to_ms(ktime_get_real());
+	put_unaligned_le64(cur_ms, &ts[0]);
+
+	status = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP, 0, ts, 8,
+			&result);
+	if (status < 0)
+		dev_warn_once(ctrl->device,
+			"could not set timestamp (%08x)\n", result);
+}
+EXPORT_SYMBOL_GPL(nvme_set_timestamp);
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b40b9af..3ef1a07 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -286,6 +286,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
+void nvme_set_timestamp(struct nvme_ctrl *ctrl);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5d5aa7f..82ce677 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2156,6 +2156,10 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	if (dev->ctrl.vs >= NVME_VS(1, 3, 0) &&
+	    dev->ctrl.oncs & NVME_CTRL_ONCS_TIMESTAMP)
+		nvme_set_timestamp(&dev->ctrl);
+
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
 	 * any working I/O queue.
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
