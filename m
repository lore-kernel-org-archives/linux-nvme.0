From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  3 Dec 2017 14:37:10 +0900
Subject: [PATCH] nvme-pci: remove an unnecessary variable initialization in
 HMB code
Message-ID: <1512279430-2806-1-git-send-email-minwoo.im.dev@gmail.com>

The local variable __size__ will be set a bit later in a for-loop.
Remove the explicit initialization at the beginning of this function.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5800c3..9f7993b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1770,7 +1770,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	dma_addr_t descs_dma;
 	int i = 0;
 	void **bufs;
-	u64 size = 0, tmp;
+	u64 size, tmp;
 
 	tmp = (preferred + chunk_size - 1);
 	do_div(tmp, chunk_size);
-- 
2.7.4
