From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 20 Jun 2016 08:13:27 +0200
Subject: [PATCH 2/2] nvme: Make indentation consistent
In-Reply-To: <09e593eb-9787-cba6-ef35-cc6412fd20b4@sandisk.com>
References: <09e593eb-9787-cba6-ef35-cc6412fd20b4@sandisk.com>
Message-ID: <1ddfff0b-7047-9710-1779-80721d990b45@sandisk.com>

This patch avoids that smatch complains about inconsistent indentation
and also that checkpatch complains about trailing whitespace. This patch
does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagig at grimberg.me>
---
 drivers/nvme/host/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index befac5b..20b5c5c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -49,7 +49,7 @@
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
-		
+
 /*
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
@@ -1927,10 +1927,11 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (!dev->bar)
 		goto release;
 
-       return 0;
-  release:
-       pci_release_selected_regions(pdev, bars);
-       return -ENODEV;
+	return 0;
+
+release:
+	pci_release_selected_regions(pdev, bars);
+	return -ENODEV;
 }
 
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.8.4
