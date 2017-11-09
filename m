From: ming.lei@redhat.com (Ming Lei)
Date: Thu,  9 Nov 2017 19:32:07 +0800
Subject: [PATCH V2] nvme-pci: avoid dereference of symbol from unloaded module
Message-ID: <20171109113207.24286-1-ming.lei@redhat.com>

The 'remove_work' may be scheduled to run after nvme_remove()
returns since we can't simply cancel it in nvme_remove() for
avoiding deadlock. Once nvme_remove() returns, this module(nvme)
can be unloaded.

On the other hand, nvme_put_ctrl() calls ctr->ops->free_ctrl
which may point to nvme_pci_free_ctrl() in unloaded module.

This patch avoids this issue by queuing 'remove_work' via 'nvme_wq',
and flush this worqueue in nvme_exit() as suggested by Sagi.

Suggested-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32c413ec818c..be2ea99684ff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2290,7 +2290,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
-	if (!schedule_work(&dev->remove_work))
+	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
 
@@ -2713,6 +2713,7 @@ static int __init nvme_init(void)
 static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
+	flush_workqueue(nvme_wq);
 	_nvme_check_size();
 }
 
-- 
2.9.5
