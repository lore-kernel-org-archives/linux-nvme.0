From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Sep 2014 09:18:50 -0600
Subject: [PATCH] NVMe: Clear QUEUE_FLAG_STACKABLE
Message-ID: <1411485530-4203-1-git-send-email-keith.busch@intel.com>

The nvme namespace request_queue's flags are initialized to
QUEUE_FLAG_DEFAULT, which currently sets QUEUE_FLAG_STACKABLE. The
device-mapper indicates this flag means the block driver is requset
based, though this driver is bio-based and problems will occur if an nvme
namespace is used with a request based dm device. This patch clears the
stackable flag.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 49ac8714..9aeef40 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2010,6 +2010,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	if (!ns->queue)
 		goto out_free_ns;
 	ns->queue->queue_flags = QUEUE_FLAG_DEFAULT;
+	queue_flag_clear_unlocked(QUEUE_FLAG_STACKABLE, ns->queue);
 	queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, ns->queue);
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
 	blk_queue_make_request(ns->queue, nvme_make_request);
-- 
1.7.10.4
