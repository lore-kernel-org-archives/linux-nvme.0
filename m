From: kaoudis@Colorado.EDU (Kelly Nicole Kaoudis)
Date: Tue, 13 Jan 2015 20:28:29 -0700
Subject: Fwd: [PATCH for 3.20] NVMe: within nvme_free_queues(), delete RCU
 sychro/deferred free
In-Reply-To: <1421112952-4602-1-git-send-email-kaoudis@colorado.edu>
References: <1421112952-4602-1-git-send-email-kaoudis@colorado.edu>
Message-ID: <CANQo-d+PFU5a6S-_Cweu=ieF3ez-HAtFtEU_X7omMNiPqteD5g@mail.gmail.com>

Converting from to blk-queue got rid of the driver's RCU
locking-on-queue, so removing unnecessary RCU locking-on-queue
artefacts.

Signed-off-by: Kelly Nicole Kaoudis <kaoudis at colorado.edu>
---
 drivers/block/nvme-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b1d5d87..4eaf28e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1108,21 +1108,14 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)

 static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 {
-       LLIST_HEAD(q_list);
-       struct nvme_queue *nvmeq, *next;
-       struct llist_node *entry;
        int i;

        for (i = dev->queue_count - 1; i >= lowest; i--) {
                struct nvme_queue *nvmeq = dev->queues[i];
-               llist_add(&nvmeq->node, &q_list);
                dev->queue_count--;
                dev->queues[i] = NULL;
-       }
-       synchronize_rcu();
-       entry = llist_del_all(&q_list);
-       llist_for_each_entry_safe(nvmeq, next, entry, node)
                nvme_free_queue(nvmeq);
+       }
 }

 /**
--
2.2.1
