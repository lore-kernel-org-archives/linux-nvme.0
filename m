From: keith.busch@intel.com (Keith Busch)
Date: Fri, 13 May 2016 12:09:51 -0600
Subject: [PATCH] NVMe: Allocate queues only for online cpus
Message-ID: <1463162991-31653-1-git-send-email-keith.busch@intel.com>

The driver previously requested allocating queues for the total possible
number of CPUs so that blk-mq could rebalance these if CPUs were added
after initialization. The number of hardware contexts can now be changed
at runtime, so we only need to allocate the number of online queues
since we can add more later.

Suggested-by: Jeff Lien <jeff.lien at hgst.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9bc0c19..ac84711 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1394,7 +1394,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, i, vecs, nr_io_queues, size;
 
-	nr_io_queues = num_possible_cpus();
+	nr_io_queues = num_online_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
2.7.2
