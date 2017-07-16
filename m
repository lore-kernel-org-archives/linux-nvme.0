From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 16 Jul 2017 10:39:03 +0200
Subject: [PATCH] nvme-pci: Fix an error handling path in 'nvme_probe()'
Message-ID: <20170716083903.7108-1-christophe.jaillet@wanadoo.fr>

Release resources in the correct order in order not to miss a
'put_device()' if 'nvme_dev_map()' fails.

Fixes: b00a726a9fd8 ("NVMe: Don't unmap controller registers on reset")
Signed-off-by: Christophe JAILLET <christophe.jaillet at wanadoo.fr>
---
 drivers/nvme/host/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d10d2f279d19..005beffd005d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2282,7 +2282,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	result = nvme_dev_map(dev);
 	if (result)
-		goto free;
+		goto put_pci;
 
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
@@ -2291,7 +2291,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-		goto put_pci;
+		goto unmap;
 
 	quirks |= check_dell_samsung_bug(pdev);
 
@@ -2308,9 +2308,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
  release_pools:
 	nvme_release_prp_pools(dev);
+ unmap:
+	nvme_dev_unmap(dev);
  put_pci:
 	put_device(dev->dev);
-	nvme_dev_unmap(dev);
  free:
 	kfree(dev->queues);
 	kfree(dev);
-- 
2.11.0
