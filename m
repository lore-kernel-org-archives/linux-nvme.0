From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 16 Aug 2017 15:55:52 -0400
Subject: [PATCH] nvme: Honor RTD3 Entry Latency for shutdowns
Message-ID: <20170816195552.22492-1-martin.petersen@oracle.com>

If an NVMe controller reports RTD3 Entry Latency bigger than
shutdown_timeout, use that value to set the shutdown timer. Otherwise
fall back to the module parameter which defaults to 5 seconds.

Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
---
 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b7dfbbeccb47..ed8f286f24bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1465,7 +1465,7 @@ EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
-	unsigned long timeout = jiffies + (shutdown_timeout * HZ);
+	unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);
 	u32 csts;
 	int ret;
 
@@ -1833,6 +1833,22 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
 
+	if (ctrl->vs >= NVME_VS(1, 2, 0)) {
+		u32 transition_time = le32_to_cpu(id->rtd3e);
+
+		do_div(transition_time, 1000000); /* us -> s */
+
+		if (transition_time > shutdown_timeout) {
+			ctrl->shutdown_timeout = transition_time;
+			dev_warn(ctrl->device,
+				 "Shutdown timeout set to %u seconds\n",
+				 ctrl->shutdown_timeout);
+		}
+	}
+
+	if (!ctrl->shutdown_timeout)
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
2.13.0
