From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 4 Mar 2014 16:22:00 +0100
Subject: [PATCH v2 3/2] nvme: Use pci_enable_msi_range() and
 pci_enable_msix_range()
In-Reply-To: <cover.1393404496.git.agordeev@redhat.com>
References: <cover.1393404496.git.agordeev@redhat.com>
Message-ID: <20140304152200.GA18364@dhcp-26-207.brq.redhat.com>

As result of deprecation of MSI-X/MSI enablement functions
pci_enable_msix() and pci_enable_msi_block() all drivers
using these two interfaces need to be updated to use the
new pci_enable_msi_range()  or pci_enable_msi_exact()
and pci_enable_msix_range() or pci_enable_msix_exact()
interfaces.

Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Matthew Wilcox <willy at linux.intel.com>
Cc: Jens Axboe <axboe at kernel.dk>
Cc: linux-nvme at lists.infradead.org
Cc: linux-pci at vger.kernel.org
Reviewed-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   33 +++++++++------------------------
 1 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 51824d1..eca2b3e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1837,31 +1837,16 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	/* Deregister the admin queue's interrupt */
 	free_irq(dev->entry[0].vector, adminq);
 
-	vecs = nr_io_queues;
-	for (i = 0; i < vecs; i++)
+	for (i = 0; i < nr_io_queues; i++)
 		dev->entry[i].entry = i;
-	for (;;) {
-		result = pci_enable_msix(pdev, dev->entry, vecs);
-		if (result <= 0)
-			break;
-		vecs = result;
-	}
-
-	if (result < 0) {
-		vecs = nr_io_queues;
-		if (vecs > 32)
-			vecs = 32;
-		for (;;) {
-			result = pci_enable_msi_block(pdev, vecs);
-			if (result == 0) {
-				for (i = 0; i < vecs; i++)
-					dev->entry[i].vector = i + pdev->irq;
-				break;
-			} else if (result < 0) {
-				vecs = 1;
-				break;
-			}
-			vecs = result;
+	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues);
+	if (vecs < 0) {
+		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues, 32));
+		if (vecs < 0) {
+			vecs = 1;
+		} else {
+			for (i = 0; i < vecs; i++)
+				dev->entry[i].vector = i + pdev->irq;
 		}
 	}
 
-- 
1.7.7.6

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
