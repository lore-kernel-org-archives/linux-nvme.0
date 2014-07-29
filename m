From: sbradshaw@micron.com (Sam Bradshaw)
Date: Tue, 29 Jul 2014 13:31:36 -0700
Subject: [PATCH v2] NVMe: Correctly handle IOCTL_SUBMIT_IO when cpus > online
 queues
Message-ID: <53D804A8.5070503@micron.com>

nvme_submit_io_cmd() uses smp_processor_id() to pick an IO queue index.
This patch fixes the case where there are more cpus from which the ioctl 
call can originate than online queues, which can happen when a device 
supports or was allocated fewer interrupt vectors than exist cpu cores.

Thanks to Keith Busch for the implementation suggestion.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..e18b67b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -979,8 +979,8 @@ int nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
 int nvme_submit_io_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
 								u32 *result)
 {
-	return nvme_submit_sync_cmd(dev, smp_processor_id() + 1, cmd, result,
-							NVME_IO_TIMEOUT);
+	return nvme_submit_sync_cmd(dev, this_cpu_read(*dev->io_queue), cmd,
+						result,	NVME_IO_TIMEOUT);
 }
 
 static int nvme_submit_admin_cmd_async(struct nvme_dev *dev,
