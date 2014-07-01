From: matthew_minter@xyratex.com (Matthew Minter)
Date: Tue, 1 Jul 2014 17:48:08 +0100
Subject: NVME Kernel Panic due to nvme_free_queue running from call_rcu
Message-ID: <CAFJTrDswXgoe5GR9OkryfNFyzgLmpKoVe-QhnwMCUJhA3WjmTA@mail.gmail.com>

Hi Everyone,

First I apologize if I have not sent this to the right people but I
picked those who had signed of the commit concerned and those in the
maintainers list for this driver.

I just upgraded my ARM based board to kernel 3.16-rc3 from 3.14 and am
now having the kernel panic when I connect an NVME based SSD, it
appears the problem was introduced by the following commit:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/block/nvme-core.c?id=5a92e700af2e5e0e6404988d6a7f2ed3dad3f46f

What seems to be happening is that the nvme_free_queue function is now
being called from call_rcu as changed in this part of the patch:

@@ -1075,10 +1088,13 @@ static void nvme_free_queues(struct nvme_dev
*dev, int lowest)
{
int i;
+ for (i = num_possible_cpus(); i > dev->queue_count - 1; i--)
+ rcu_assign_pointer(dev->queues[i], NULL);
for (i = dev->queue_count - 1; i >= lowest; i--) {
- nvme_free_queue(dev->queues[i]);
+ struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
+ rcu_assign_pointer(dev->queues[i], NULL);
+ call_rcu(&nvmeq->r_head, nvme_free_queue);
dev->queue_count--;
- dev->queues[i] = NULL;
}
}

This means that nvme_free_queue is now being called within a soft
interrupt context, however nvme_free_queue calls dma_free_coherent
which is implemented as arm_dma_free on ARM and that calls vunmap.
vunmap cannot be called within an interrupt context so the kernel BUGs
and ends up panicking.

I have managed to work around this issue by not using an rcu callback
and instead using synchronize_rcu(); in the nvme_free_queues function.
The patch is below.

I am not sure if it is the correct solution but it definitely seems to
work on our board. Any comments would be appreciated.


>From 7c926da62fc2c77f6e0948121938327f69d2194d Mon Sep 17 00:00:00 2001
From: matthew_minter <matthew_minter@xyratex.com>
Date: Tue, 1 Jul 2014 17:37:33 +0100
Subject: [PATCH] Prevented nvme_free_queue from being called in an
interrupt context
Fixes: 5a92e700af2e ("NVMe: RCU protected access to io queues")

Signed-off-by: matthew_minter <matthew_minter at xyratex.com>
---
 drivers/block/nvme-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..a3755ea 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1225,7 +1225,8 @@ static void nvme_free_queues(struct nvme_dev
*dev, int lowest)
        for (i = dev->queue_count - 1; i >= lowest; i--) {
                struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
                rcu_assign_pointer(dev->queues[i], NULL);
-               call_rcu(&nvmeq->r_head, nvme_free_queue);
+               synchronize_rcu();
+               nvme_free_queue(&nvmeq->r_head);
                dev->queue_count--;
        }
 }
-- 
2.0.0

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
