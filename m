From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Fri, 17 Jun 2016 14:21:14 -0300
Subject: [PATCH 1/2] nvme: introduce asynchronous events textual output
In-Reply-To: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <1466184075-10471-2-git-send-email-gpiccoli@linux.vnet.ibm.com>

Currently the nvme driver prints asynchronous events as numbers,
based on NVMe specification codes. This patch introduces the
textual output for such events, keeping the codes too.

This is useful for error reporting purposes in human readable
format.

Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
 drivers/nvme/host/core.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  9 ++++++
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a51584..8f95947 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -58,6 +58,79 @@ static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
 
+/* NVMe Async Events descriptive messages:
+ * Error status messages - Type 0x0
+ */
+static const struct nvme_ae_info nvme_ae_error_status[] = {
+	{ 0x0, "Write to invalid doorbell register"	},
+	{ 0x1, "Invalid doorbell write value"		},
+	{ 0x2, "Diagnostic failure"			},
+	{ 0x3, "Persistent internal error"		},
+	{ 0x4, "Transient internal error"		},
+	{ 0x5, "Firmware image load error"		},
+};
+
+/* SMART/Health status messages - Type 0x1 */
+static const struct nvme_ae_info nvme_ae_health_status[] = {
+	{ 0x0, "NVM subsystem reliability"		},
+	{ 0x1, "Temperature threshold"			},
+	{ 0x2, "Spare below threshold"			},
+};
+
+/* Notice messages - Type 0x2
+ * Event 0x0 in the below table is referred as NVME_AER_NOTICE_NS_CHANGED on
+ * nvme.h and is not just reported; the driver perform a queue rescan too.
+ */
+static const struct nvme_ae_info nvme_ae_notice[] = {
+	{ 0x0, "Namespace attribute changed"		},
+	{ 0x1, "Firmware activation starting"		},
+};
+
+/* NVM/IO Command Set Specific Status messages - Type 0x6 */
+static const struct nvme_ae_info nvme_ae_io_command_set[] = {
+	{ 0x0, "Reservation log page available"		},
+};
+
+static const char *nvme_get_ae_info(u32 result)
+{
+	const struct nvme_ae_info *tbl;
+	u8 evnt, size, type, i;
+
+	type = result & NVME_AE_TYPE_MASK;
+	evnt = (result & NVME_AE_INFO_MASK) >> 8;
+
+	switch (type) {
+	case 0x0: /* Error status */
+		tbl = nvme_ae_error_status;
+		size = ARRAY_SIZE(nvme_ae_error_status);
+		break;
+	case 0x1: /* SMART/Health status */
+		tbl = nvme_ae_health_status;
+		size = ARRAY_SIZE(nvme_ae_health_status);
+		break;
+	case 0x2: /* Notice */
+		tbl = nvme_ae_notice;
+		size = ARRAY_SIZE(nvme_ae_notice);
+		break;
+	case 0x6: /* NVM/IO Command Set Specific Status */
+		tbl = nvme_ae_io_command_set;
+		size = ARRAY_SIZE(nvme_ae_io_command_set);
+		break;
+	default: /* Reserved types/Vendor specific */
+		return NULL;
+	}
+
+	/* Try first a direct lookup to avoid full table search */
+	if (evnt < size && tbl[evnt].event == evnt)
+		return tbl[evnt].desc;
+
+	for (i = 0; i < size; i++)
+		if (tbl[i].event == evnt)
+			return tbl[i].desc;
+
+	return NULL;
+}
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -1656,11 +1729,13 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl,
 
 	switch (result & 0xff07) {
 	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(ctrl->device, "rescanning\n");
+		dev_info(ctrl->device,
+			"rescanning (Namespace attribute change detected)\n");
 		nvme_queue_scan(ctrl);
 		break;
 	default:
-		dev_warn(ctrl->device, "async event result %08x\n", result);
+		dev_warn(ctrl->device, "async event result: %s (%08x)\n",
+					nvme_get_ae_info(result), result);
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1daa048..a075eb1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -154,6 +154,15 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
 };
 
+/* NVMe Asynchronous Events (AE) textual parsing helpers */
+#define NVME_AE_TYPE_MASK	0x7
+#define NVME_AE_INFO_MASK	0xFF00
+
+struct nvme_ae_info {
+	u8 event;
+	const char *desc;
+};
+
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
 {
 	u32 val = 0;
-- 
2.1.0
