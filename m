From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 18:21:58 +0300
Subject: [PATCH rfc 24/30] nvme-pci: rename to nvme_pci_configure_admin_queue
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497799324-19598-25-git-send-email-sagi@grimberg.me>

we are going to need the name for the core routine...

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32a98e2740ad..628f1edb0acd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1385,7 +1385,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 	return 0;
 }
 
-static int nvme_configure_admin_queue(struct nvme_dev *dev)
+static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
 	u32 aqa;
@@ -2093,7 +2093,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	result = nvme_configure_admin_queue(dev);
+	result = nvme_pci_configure_admin_queue(dev);
 	if (result)
 		goto out;
 
-- 
2.7.4
