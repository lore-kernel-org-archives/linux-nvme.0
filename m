From: sbradshaw@micron.com (Sam Bradshaw)
Date: Fri, 25 Jul 2014 14:45:31 -0700
Subject: [PATCH] NVMe: Correctly handle IOCTL_SUBMIT_IO when cpus > online
 queues
Message-ID: <53D2CFFB.8010908@micron.com>

nvme_submit_io_cmd() use smp_processor_id() to pick an IO queue index.  This patch
fixes the case where there are more cpus from which the ioctl call can originate 
than online queues, which can happen when a device supports or was allocated fewer 
interrupt vectors than exist cpu cores.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..5171753 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -979,8 +979,9 @@ int nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
 int nvme_submit_io_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
 								u32 *result)
 {
-	return nvme_submit_sync_cmd(dev, smp_processor_id() + 1, cmd, result,
-							NVME_IO_TIMEOUT);
+	return nvme_submit_sync_cmd(dev, (smp_processor_id() %
+						(dev->online_queues - 1)) + 1,
+						 cmd, result, NVME_IO_TIMEOUT);
 }
 
 static int nvme_submit_admin_cmd_async(struct nvme_dev *dev,
