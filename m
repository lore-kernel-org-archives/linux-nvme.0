From: zhangweiping@didichuxing.com (Weiping Zhang)
Date: Sun, 1 Jul 2018 23:20:33 +0800
Subject: [PATCH 1/2] nvme-pci: remove whitespace
In-Reply-To: <cover.1530457943.git.zhangweiping@didichuxing.com>
References: <cover.1530457943.git.zhangweiping@didichuxing.com>
Message-ID: <aaa460e43cb43efbfb902d0aa844a1da9ed270dc.1530457943.git.zhangweiping@didichuxing.com>

Signed-off-by: Weiping Zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..abf1885d6db6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2585,13 +2585,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
- release_pools:
+release_pools:
 	nvme_release_prp_pools(dev);
- unmap:
+unmap:
 	nvme_dev_unmap(dev);
- put_pci:
+put_pci:
 	put_device(dev->dev);
- free:
+free:
 	kfree(dev->queues);
 	kfree(dev);
 	return result;
-- 
2.14.1
