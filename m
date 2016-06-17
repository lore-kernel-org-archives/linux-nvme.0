From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Fri, 17 Jun 2016 14:21:15 -0300
Subject: [PATCH 2/2] [RFC] nvme: enable asynchronous events notification by
 default
In-Reply-To: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <1466184075-10471-3-git-send-email-gpiccoli@linux.vnet.ibm.com>

Asynchronous events notification currently is disabled by default;
to enable it, one should issue a set-feature command through
nvme-cli userspace application. The tool also allows disabling
these events once they're enable, as per user desire.

This patch makes the asynchronous events notification enabled by
default; to do so, we submit the set-feature command from the
driver, in the end of nvme_reset_work() routine. This way, the
feature is enabled on the driver initialization and after resets,
in case they happen.

Enabling the asynchronous events notification feature by default
is interesting as an error report feature.

Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
 drivers/nvme/host/pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index befac5b..3a82390 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1779,6 +1779,18 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
+static int nvme_enable_async_events(struct nvme_dev *dev)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_admin_set_features;
+	c.common.cdw10[0] = 0xB; /* Feature: Async Event Configuration */
+	c.common.cdw10[1] = 0x3FF; /* Enable all available events */
+
+	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
+}
+
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
@@ -1849,6 +1861,10 @@ static void nvme_reset_work(struct work_struct *work)
 
 	if (dev->online_queues > 1)
 		nvme_queue_scan(&dev->ctrl);
+
+	if (nvme_enable_async_events(dev))
+		dev_info(dev->ctrl.device,
+			"failed to enable async events notification\n");
 	return;
 
  out:
-- 
2.1.0
