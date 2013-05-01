From: keith.busch@intel.com (Keith Busch)
Date: Wed,  1 May 2013 13:07:48 -0600
Subject: [PATCH] NVMe: Check for NULL memory in nvme_dev_add
In-Reply-To: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
References: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367435271-15784-2-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e78faf1..e7d68e3 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1523,6 +1523,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 
 	mem = dma_alloc_coherent(&dev->pci_dev->dev, 8192, &dma_addr,
 								GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
 
 	res = nvme_identify(dev, 0, 1, dma_addr);
 	if (res) {
-- 
1.7.0.4
