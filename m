From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 11:17:23 -0700
Subject: [PATCH for-4.5 06/13] NVMe: Remove WQ_MEM_RECLAIM from nvme work queue
In-Reply-To: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455128250-5984-7-git-send-email-keith.busch@intel.com>

This isn't used for work in the memory reclaim path, and we may need
to sync with work queues that also are not flagged memory relaim. This
fixes a kernel warning if we ever do sync with such a work queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72ef832..5bea054 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2227,7 +2227,7 @@ static int __init nvme_init(void)
 
 	init_waitqueue_head(&nvme_kthread_wait);
 
-	nvme_workq = alloc_workqueue("nvme", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	nvme_workq = alloc_workqueue("nvme", WQ_UNBOUND, 0);
 	if (!nvme_workq)
 		return -ENOMEM;
 
-- 
2.6.2.307.g37023ba
