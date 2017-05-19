From: hch@lst.de (Christoph Hellwig)
Date: Fri, 19 May 2017 10:57:56 +0200
Subject: [PATCH 7/7] nvme: allocate queues for all possible CPUs
In-Reply-To: <20170519085756.29742-1-hch@lst.de>
References: <20170519085756.29742-1-hch@lst.de>
Message-ID: <20170519085756.29742-8-hch@lst.de>

Unlike most dr?vers that simply pass the maximum possible vectors to
pci_alloc_irq_vectors NVMe needs to configure the device before allocting
the vectors, so it needs a manual update for the new scheme of using
all present CPUs.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fed803232edc..6580a21d1425 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1520,7 +1520,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues, size;
 
-	nr_io_queues = num_online_cpus();
+	nr_io_queues = num_present_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
2.11.0
