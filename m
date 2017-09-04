From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue,  5 Sep 2017 00:23:30 +0900
Subject: [PATCH 2/2] nvme-pci: use appropriate initial chunk size for HMB
 allocation
In-Reply-To: <1504538610-15670-1-git-send-email-akinobu.mita@gmail.com>
References: <1504538610-15670-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1504538610-15670-3-git-send-email-akinobu.mita@gmail.com>

The initial chunk size for host memory buffer allocation is currently
PAGE_SIZE << MAX_ORDER.  MAX_ORDER order allocation is usually failed
without CONFIG_DMA_CMA.  So the HMB allocation is retried with
chunk size PAGE_SIZE << (MAX_ORDER - 1) in general, but there is no
problem if the retry allocation works correctly.

This change just avoids the retry and "failed to allocate host memory
buffer." warning in the most common case.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7e71cc9..49e2e7f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1619,7 +1619,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	u64 size, tmp;
 
 	/* start big and work our way down */
-	chunk_size = min(preferred, (u64)PAGE_SIZE << MAX_ORDER);
+	chunk_size = min(preferred, (u64)PAGE_SIZE * MAX_ORDER_NR_PAGES);
 retry:
 	i = 0;
 	size = 0;
-- 
2.7.4
