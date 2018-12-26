From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 26 Dec 2018 18:37:55 +0800
Subject: [PATCH 2/2] nvme pci: try to allocate multiple irq vectors again in
 case of -EINVAL
In-Reply-To: <20181226103755.2101-1-ming.lei@redhat.com>
References: <20181226103755.2101-1-ming.lei@redhat.com>
Message-ID: <20181226103755.2101-3-ming.lei@redhat.com>

It is observed on QEMU that pci_alloc_irq_vectors_affinity() may
returns -EINVAL when the requested number is too big(such as 64).

However, the allocation can be done successfully if we ask for
a smaller number, such as 63.

So reduce queue number and reallocate again in case of -EINVAL.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 584ea7a57122..d839bbe408c3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2121,14 +2121,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		 * to decrease our ask. If we get EINVAL, the platform
 		 * likely does not. Back down to ask for just one vector.
 		 */
-		if (result == -ENOSPC) {
+		if (result == -ENOSPC || result == -EINVAL) {
 			irq_queues--;
 			if (!irq_queues)
 				return result;
 			continue;
-		} else if (result == -EINVAL) {
-			irq_queues = 1;
-			continue;
 		} else if (result <= 0)
 			return -EIO;
 		break;
-- 
2.9.5
