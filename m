From: alan.mikhak@sifive.com (Alan Mikhak)
Date: Mon,  8 Jul 2019 10:05:11 -0700
Subject: [PATCH v2] nvme-pci: Check for null on pci_alloc_p2pmem()
Message-ID: <1562605511-6564-1-git-send-email-alan.mikhak@sifive.com>

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
to free the memory it allocated using pci_alloc_p2pmem()
in case pci_p2pmem_virt_to_bus() returns null.

Makes sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
returned null which can happen if CONFIG_PCI_P2PDMA is not
configured.

Current implementation is not expected to leak since
pci_p2pmem_virt_to_bus() is expected to fail only if
pci_alloc_p2pmem() returns null. However, checking
the return value of pci_alloc_p2pmem() is more explicit.

Signed-off-by: Alan Mikhak <alan.mikhak at sifive.com>
---
 drivers/nvme/host/pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 524d6bd6d095..5dfa067f6506 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1456,11 +1456,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 
 	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
 		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
-		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
-						nvmeq->sq_cmds);
-		if (nvmeq->sq_dma_addr) {
-			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
-			return 0; 
+		if (nvmeq->sq_cmds) {
+			nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
+							nvmeq->sq_cmds);
+			if (nvmeq->sq_dma_addr) {
+				set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
+				return 0;
+			}
+
+			pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));
 		}
 	}
 
-- 
2.7.4
