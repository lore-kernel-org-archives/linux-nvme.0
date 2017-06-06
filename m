From: hch@lst.de (Christoph Hellwig)
Date: Tue,  6 Jun 2017 11:54:11 +0200
Subject: [PATCH] nvme-pci: avoid 64-bit divisions in the HMB code
Message-ID: <20170606095411.22429-1-hch@lst.de>

[to be folded into "nvme-pci: implement host memory buffer support"]

Avoid 64-bit division by using shifts instead.  All involved sizez are
powers of two.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a81833fd4b1b..380ad905acbf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1567,8 +1567,8 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 	c.features.opcode	= nvme_admin_set_features;
 	c.features.fid		= cpu_to_le32(NVME_FEAT_HOST_MEM_BUF);
 	c.features.dword11	= cpu_to_le32(bits);
-	c.features.dword12	= cpu_to_le32(dev->host_mem_size /
-					      dev->ctrl.page_size);
+	c.features.dword12	= cpu_to_le32(dev->host_mem_size >>
+					      ilog2(dev->ctrl.page_size));
 	c.features.dword13	= cpu_to_le32(lower_32_bits(dma_addr));
 	c.features.dword14	= cpu_to_le32(upper_32_bits(dma_addr));
 	c.features.dword15	= cpu_to_le32(dev->nr_host_mem_descs);
@@ -1641,7 +1641,8 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	}
 
 	dev_info(dev->ctrl.device,
-		"allocated %lld MiB host memory buffer.\n", size / SZ_1M);
+		"allocated %lld MiB host memory buffer.\n",
+		size >> ilog2(SZ_1M));
 	dev->nr_host_mem_descs = i;
 	dev->host_mem_size = size;
 	dev->host_mem_descs = descs;
@@ -1680,7 +1681,7 @@ static void nvme_setup_host_mem(struct nvme_dev *dev)
 	if (min > max) {
 		dev_warn(dev->ctrl.device,
 			"min host memory (%lld MiB) above limit (%d MiB).\n",
-			min / SZ_1M, max_host_mem_size_mb);
+			min >> ilog2(SZ_1M), max_host_mem_size_mb);
 		nvme_free_host_mem(dev);
 		return;
 	}
-- 
2.11.0
