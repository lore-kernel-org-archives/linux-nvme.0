From: alan.mikhak@sifive.com (Alan Mikhak)
Date: Mon,  8 Jul 2019 10:24:12 -0700
Subject: [PATCH] nvme-pci: No IRQ map for read if no read queue allocated
Message-ID: <1562606652-7618-1-git-send-email-alan.mikhak@sifive.com>

From: Alan Mikhak <alan.mikhak@sifive.com>

nvme_dev_add() assumes a read queue is always allocated.
That may not be the case on single-interrupt systems for
which pci_assign_irq() would report runtime IRQ mapping
not provided by arch.

This patch makes sure nvme_dev_add() only requests an
IRQ mapping for read queues if at least one read queue
is being allocted.

nvme_pci_map_queues() will later on ignore the unnecessary
mapping request should nvme_dev_add() request such an IRQ
mapping even though no read queues are being allocated.
However, nvme_dev_add() can avoid making the request by
checking the number of read queues without assuming. This
would bring it more in line with nvme_setup_irqs() and
nvme_calc_irq_sets().

Signed-off-by: Alan Mikhak <alan.mikhak at sifive.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 524d6bd6d095..86262ebe6fff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2263,7 +2263,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
-		dev->tagset.nr_maps = 2; /* default + read */
+		dev->tagset.nr_maps = 1; /* default */
+		if (dev->io_queues[HCTX_TYPE_READ])
+			dev->tagset.nr_maps++;
 		if (dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.nr_maps++;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
-- 
2.7.4
