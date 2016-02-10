From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 11:17:29 -0700
Subject: [PATCH for-4.5 12/13] NVMe: Mark queues as dead on degraded controller
In-Reply-To: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455128250-5984-13-git-send-email-keith.busch@intel.com>

If a previously optimal controller goes degraded, the IO queues will
stop working, but the controller is still managable. Prior to removing
namespace, we need to fail the queues so queued and new IO will fail
and allow namespace removal to progress.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7fd8a54..18c14f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1989,6 +1989,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (dev->online_queues < 2) {
 		dev_warn(dev->dev, "IO queues not created\n");
+		nvme_kill_ns_queues(dev);
 		nvme_remove_namespaces(&dev->ctrl);
 	} else {
 		nvme_start_queues(&dev->ctrl);
-- 
2.6.2.307.g37023ba
