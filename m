From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 25 Aug 2017 19:14:50 -0400
Subject: [PATCH v4] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170825195605.GC1207@localhost.localdomain>
References: <20170825195605.GC1207@localhost.localdomain>
Message-ID: <20170825231450.32637-1-martin.petersen@oracle.com>

If an NVMe controller reports RTD3 Entry Latency larger than
shutdown_timeout, up to a maximum of 60 seconds, use that value to set
the shutdown timer. Otherwise fall back to the module parameter which
defaults to 5 seconds.

Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
---
 drivers/nvme/host/core.c | 16 +++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b7dfbbeccb47..ea7bf12b563c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1465,7 +1465,7 @@ EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
-	unsigned long timeout = jiffies + (shutdown_timeout * HZ);
+	unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);
 	u32 csts;
 	int ret;
 
@@ -1765,6 +1765,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	int ret, page_shift;
 	u32 max_hw_sectors;
 	bool prev_apst_enabled;
+	u32 transition_time;
 
 	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
 	if (ret) {
@@ -1833,6 +1834,19 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
 
+	transition_time = le32_to_cpu(id->rtd3e);
+	if (transition_time) {
+		do_div(transition_time, 1000000); /* us -> s */
+		ctrl->shutdown_timeout = clamp_t(unsigned int, transition_time,
+						 shutdown_timeout, 60);
+
+		if (ctrl->shutdown_timeout != shutdown_timeout)
+			dev_warn(ctrl->device,
+				 "Shutdown timeout set to %u seconds\n",
+				 ctrl->shutdown_timeout);
+	} else
+		ctrl->shutdown_timeout = shutdown_timeout;
+
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
 	prev_apst_enabled = ctrl->apst_enabled;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2c8a02be46fd..9b959ee18cb6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -162,6 +162,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
 	unsigned long quirks;
-- 
2.14.1
