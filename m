From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Sep 2014 13:46:19 -0600
Subject: [PATCH] NVMe: Fix device probe waiting on kthread
Message-ID: <1411415179-4224-1-git-send-email-keith.busch@intel.com>

If we ever do parallel device probing, we need to wake up all processes
waiting for nvme kthread to start, not just one. This is currently
serialized so the bug is not reachable today, but fixing this anyway in
the hopes we implement parallel or asynchronous probe in the future.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 65f6711..49ac8714 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2765,7 +2765,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 
 	if (start_thread) {
 		nvme_thread = kthread_run(nvme_kthread, NULL, "nvme");
-		wake_up(&nvme_kthread_wait);
+		wake_up_all(&nvme_kthread_wait);
 	} else
 		wait_event_killable(nvme_kthread_wait, nvme_thread);
 
-- 
1.7.10.4
