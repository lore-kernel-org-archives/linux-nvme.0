From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 13:05:46 -0700
Subject: [PATCHv2-4.5 09/10] NVMe: Mark queues as dead on degraded controller
In-Reply-To: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455221147-24228-10-git-send-email-keith.busch@intel.com>

If a previously optimal controller goes degraded, the IO queues will
stop working, but the controller is still managable. Prior to removing
namespace, we need to fail the queues so queued and new IO will fail
and allow namespace removal to progress.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32286e9..4de17ae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1960,6 +1960,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (dev->online_queues < 2) {
 		dev_warn(dev->dev, "IO queues not created\n");
+		nvme_kill_ns_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 	} else {
 		nvme_start_queues(&dev->ctrl);
-- 
2.6.2.307.g37023ba
