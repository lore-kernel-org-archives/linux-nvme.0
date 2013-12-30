From: santoshsy@gmail.com (Santosh Y)
Date: Mon, 30 Dec 2013 15:57:16 +0530
Subject: [PATCH RFC 1/5] NVMe: Code cleanup and minor checkpatch correction
In-Reply-To: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
Message-ID: <1388399240-13828-2-git-send-email-santoshsy@gmail.com>

Remove redunduant 'dev->node' deletion which is being
handled in nvme_dev_shutdown() and a minor checkpatch error.

Signed-off-by: Ravi Kumar <ravi.android at gmail.com>
Signed-off-by: Santosh Y <santoshsy at gmail.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b59a93a..a523296 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2120,7 +2120,7 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 
 struct nvme_delq_ctx {
 	struct task_struct *waiter;
-	struct kthread_worker* worker;
+	struct kthread_worker *worker;
 	atomic_t refcount;
 };
 
@@ -2556,10 +2556,6 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	spin_lock(&dev_list_lock);
-	list_del_init(&dev->node);
-	spin_unlock(&dev_list_lock);
-
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
 	misc_deregister(&dev->miscdev);
-- 
1.8.3.2
