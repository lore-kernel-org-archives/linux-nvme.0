From: zhangweiping@didichuxing.com (Weiping Zhang)
Date: Sun, 1 Jul 2018 23:20:58 +0800
Subject: [PATCH 2/2] nvme-pci: release nvme_ctrl if failed to alloc memory in
 nvme_probe
In-Reply-To: <cover.1530457943.git.zhangweiping@didichuxing.com>
References: <cover.1530457943.git.zhangweiping@didichuxing.com>
Message-ID: <4c6892da67db3aada7ee4ca5087b44fcb8dde30c.1530457943.git.zhangweiping@didichuxing.com>

release nvme_ctrl if failed to alloc memory for iod_mempool, otherwise
/dev/nvmeX cann't be removed for this nvme controller, any ioctl to
this device doesn't work.

Signed-off-by: Weiping Zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index abf1885d6db6..d4f1f3b900e6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2575,7 +2575,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 						GFP_KERNEL, node);
 	if (!dev->iod_mempool) {
 		result = -ENOMEM;
-		goto release_pools;
+		goto release_ctrl;
 	}
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
@@ -2585,6 +2585,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+release_ctrl:
+	nvme_uninit_ctrl(&dev->ctrl);
+	nvme_put_ctrl(&dev->ctrl);
 release_pools:
 	nvme_release_prp_pools(dev);
 unmap:
-- 
2.14.1
