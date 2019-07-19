From: sashal@kernel.org (Sasha Levin)
Date: Fri, 19 Jul 2019 00:02:14 -0400
Subject: [PATCH AUTOSEL 5.1 109/141] nvme-pci: limit max_hw_sectors based on
 the DMA max mapping size
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
Message-ID: <20190719040246.15945-109-sashal@kernel.org>

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7637de311bd2124b298a072852448b940d8a34b9 ]

When running a NVMe device that is attached to a addressing
challenged PCIe root port that requires bounce buffering, our
request sizes can easily overflow the swiotlb bounce buffer
size.  Limit the maximum I/O size to the limit exposed by
the DMA mapping subsystem.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Atish Patra <Atish.Patra at wdc.com>
Tested-by: Atish Patra <Atish.Patra at wdc.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b97ba5ea0e61..5112983a59fb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2538,7 +2538,8 @@ static void nvme_reset_work(struct work_struct *work)
 	 * Limit the max command size to prevent iod->sg allocations going
 	 * over a single page.
 	 */
-	dev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
+	dev->ctrl.max_hw_sectors = min_t(u32,
+		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(dev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 	mutex_unlock(&dev->shutdown_lock);
 
-- 
2.20.1
