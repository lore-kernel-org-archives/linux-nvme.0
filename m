From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Wed,  3 Jan 2018 07:56:09 +0800
Subject: [PATCH 2/3] nvme-pci: change the name of functions corresponding to
 setup adminq
In-Reply-To: <1514937370-4805-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1514937370-4805-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1514937370-4805-3-git-send-email-jianchao.w.wang@oracle.com>

No functional change. Just change name of functions corresponding
to setup adminq to make it more readable.
nvme_pci_configure_admin_queue -> nvme_pci_setup_adminq
nvme_alloc_admin_tags          -> nvme_pci_start_adminq

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 365dd05..1a63835 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1517,7 +1517,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 	}
 }
 
-static int nvme_alloc_admin_tags(struct nvme_dev *dev)
+static int nvme_pci_start_adminq(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.admin_q) {
 		dev->admin_tagset.ops = &nvme_mq_admin_ops;
@@ -1576,7 +1576,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 	return 0;
 }
 
-static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
+static int nvme_pci_setup_adminq(struct nvme_dev *dev)
 {
 	int result;
 	u32 aqa;
@@ -2321,11 +2321,11 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	result = nvme_pci_configure_admin_queue(dev);
+	result = nvme_pci_setup_adminq(dev);
 	if (result)
 		goto out;
 
-	result = nvme_alloc_admin_tags(dev);
+	result = nvme_pci_start_adminq(dev);
 	if (result)
 		goto out;
 
-- 
2.7.4
