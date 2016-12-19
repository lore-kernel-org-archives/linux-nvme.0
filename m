From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 19 Dec 2016 16:18:24 +0200
Subject: [PATCH 1/1] nvme: Fix whitespace problem
Message-ID: <1482157104-24266-1-git-send-email-maxg@mellanox.com>

Convert to tabs and remove unneeded whitespaces.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/pci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5e52034..e25bbb5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -50,7 +50,7 @@
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
-		
+
 /*
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
@@ -1892,10 +1892,10 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (!dev->bar)
 		goto release;
 
-       return 0;
+	return 0;
   release:
-       pci_release_mem_regions(pdev);
-       return -ENODEV;
+	pci_release_mem_regions(pdev);
+	return -ENODEV;
 }
 
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
1.7.8.2
