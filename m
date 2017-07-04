From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  4 Jul 2017 10:57:31 +0300
Subject: [PATCH v2 3/8] nvme-pci: rename to nvme_pci_configure_admin_queue
In-Reply-To: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
References: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499155056-11241-4-git-send-email-sagi@grimberg.me>

we are going to need the name for the core routine...

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fe3907a082ba..eb729ff70e7d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1383,7 +1383,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 	return 0;
 }
 
-static int nvme_configure_admin_queue(struct nvme_dev *dev)
+static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
 	u32 aqa;
@@ -2096,7 +2096,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	result = nvme_configure_admin_queue(dev);
+	result = nvme_pci_configure_admin_queue(dev);
 	if (result)
 		goto out;
 
-- 
2.7.4
