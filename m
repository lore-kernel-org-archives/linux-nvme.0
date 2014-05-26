From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 May 2014 01:52:37 -0600
Subject: [PATCH] NVMe: Fix hot cpu registration deadlock
Message-ID: <1401090757-10067-1-git-send-email-keith.busch@intel.com>

The pci-driver calls "get_online_cpus()", which grabs a reference, prior
to the device driver's probe. This can deadlock the system if a cpu hot
event occurs during the device driver's probe if it registers with cpu
hotplug notification using the locked method. Use the lockless version
instead to register the cpu notification.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc7..fa14deb 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2163,7 +2163,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	nvme_assign_io_queues(dev);
 
 	dev->nb.notifier_call = &nvme_cpu_notify;
-	result = register_hotcpu_notifier(&dev->nb);
+	result = __register_hotcpu_notifier(&dev->nb);
 	if (result)
 		goto free_queues;
 
-- 
1.7.10.4
