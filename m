From: wangyijing@huawei.com (Yijing Wang)
Date: Sat, 7 Feb 2015 12:00:01 +0800
Subject: [PATCH] NVMe: Use pci_dev->msix_enabled instead of pci_dev->irq
Message-ID: <1423281601-5132-1-git-send-email-wangyijing@huawei.com>

We should use msi_enabled flag to check whether MSI-X
was enabled, it's better than rough use pci_dev->irq.

Signed-off-by: Yijing Wang <wangyijing at huawei.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b3cb67d..646da30 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2099,7 +2099,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * If we enable msix early due to not intx, disable it again before
 	 * setting up the full range we need.
 	 */
-	if (!pdev->irq)
+	if (pdev->msix_enabled)
 		pci_disable_msix(pdev);
 
 	for (i = 0; i < nr_io_queues; i++)
-- 
1.7.1
