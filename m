From: hch@lst.de (Christoph Hellwig)
Date: Wed,  6 Sep 2017 15:55:30 +0200
Subject: [PATCH 2/4] nvme-pci: use appropriate initial chunk size for HMB
 allocation
In-Reply-To: <20170906135532.21358-1-hch@lst.de>
References: <20170906135532.21358-1-hch@lst.de>
Message-ID: <20170906135532.21358-3-hch@lst.de>

From: Akinobu Mita <akinobu.mita@gmail.com>

The initial chunk size for host memory buffer allocation is currently
PAGE_SIZE << MAX_ORDER.  MAX_ORDER order allocation is usually failed
without CONFIG_DMA_CMA.  So the HMB allocation is retried with chunk size
PAGE_SIZE << (MAX_ORDER - 1) in general, but there is no problem if the
retry allocation works correctly.

Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch at lst.de>
Cc: stable at vger.kernel.org
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e3252bcbc58e..6d2acf06c180 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1680,7 +1680,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	u32 chunk_size;
 
 	/* start big and work our way down */
-	for (chunk_size = min_t(u64, preferred, PAGE_SIZE << MAX_ORDER);
+	for (chunk_size = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
 	     chunk_size >= PAGE_SIZE * 2;
 	     chunk_size /= 2) {
 		if (!__nvme_alloc_host_mem(dev, preferred, chunk_size)) {
-- 
2.11.0
