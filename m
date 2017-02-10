From: keith.busch@intel.com (Keith Busch)
Date: Fri, 10 Feb 2017 18:15:51 -0500
Subject: [PATCH 3/5] nvme/core: Fix race kicking freed request_queue
In-Reply-To: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
Message-ID: <1486768553-13738-4-git-send-email-keith.busch@intel.com>

If a namespace has already been marked dead, we don't want to kick the
request_queue again since we may have just freed it from another thread.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index de80a84..c302270 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2114,9 +2114,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		 * Revalidating a dead namespace sets capacity to 0. This will
 		 * end buffered writers dirtying pages that can't be synced.
 		 */
-		if (ns->disk && !test_and_set_bit(NVME_NS_DEAD, &ns->flags))
-			revalidate_disk(ns->disk);
-
+		if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+			continue;
+		revalidate_disk(ns->disk);
 		blk_set_queue_dying(ns->queue);
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
-- 
1.8.3.1
