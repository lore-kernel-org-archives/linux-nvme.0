From: keith.busch@intel.com (Keith Busch)
Date: Mon, 17 Jul 2017 19:45:39 -0400
Subject: [PATCH] nvme/pci: Fix HMB size calculation
Message-ID: <1500335139-6338-1-git-send-email-keith.busch@intel.com>

It's possible the preferred HMB size may not be a multiple of the
chunk_size. This patch will set the chunk_size to the descriptor's actual
length so the last iteration doesn't cause the total size to exceed the
allocated HMB size.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d321597..e22ffda 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1641,6 +1641,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 		if (!bufs[i])
 			break;
 
+		chunk_size = len;
 		descs[i].addr = cpu_to_le64(dma_addr);
 		descs[i].size = cpu_to_le32(len / dev->ctrl.page_size);
 		i++;
-- 
2.5.5
