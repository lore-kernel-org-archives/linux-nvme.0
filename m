From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Jul 2017 17:41:34 +0200
Subject: [PATCH] nvme-pci: fix HMB size calculation
Message-ID: <20170725154134.23338-1-hch@lst.de>

It's possible the preferred HMB size may not be a multiple of the
chunk_size. This patch moves len to function scope and uses that in
the for loop increment so the last iteration doesn't cause the total
size to exceed the allocated HMB size.

Based on an earlier patch from Keith Busch.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
Fixes: 87ad72a59a38 ("nvme-pci: implement host memory buffer support")
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8569ee771269..cd888a47d0fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1619,7 +1619,7 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 {
 	struct nvme_host_mem_buf_desc *descs;
-	u32 chunk_size, max_entries;
+	u32 chunk_size, max_entries, len;
 	int i = 0;
 	void **bufs;
 	u64 size = 0, tmp;
@@ -1638,10 +1638,10 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	if (!bufs)
 		goto out_free_descs;
 
-	for (size = 0; size < preferred; size += chunk_size) {
-		u32 len = min_t(u64, chunk_size, preferred - size);
+	for (size = 0; size < preferred; size += len) {
 		dma_addr_t dma_addr;
 
+		len = min_t(u64, chunk_size, preferred - size);
 		bufs[i] = dma_alloc_attrs(dev->dev, len, &dma_addr, GFP_KERNEL,
 				DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 		if (!bufs[i])
-- 
2.11.0
