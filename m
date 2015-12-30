From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 10:27:47 -0700
Subject: [PATCH 1/5] NVMe: Fix admin queue ring wrap
In-Reply-To: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451496471-29370-2-git-send-email-keith.busch@intel.com>

The tag set queue depth needs to be one less than the h/w queue depth
so we don't wrap the circular buffer. This conforms to the specification
defined "Full Queue" condition.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82bbea..2e6e665 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1271,7 +1271,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 	if (!dev->ctrl.admin_q) {
 		dev->admin_tagset.ops = &nvme_mq_admin_ops;
 		dev->admin_tagset.nr_hw_queues = 1;
-		dev->admin_tagset.queue_depth = NVME_AQ_BLKMQ_DEPTH;
+		dev->admin_tagset.queue_depth = NVME_AQ_BLKMQ_DEPTH - 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
-- 
2.6.2.307.g37023ba
