From: huhaiyan@huawei.com (Huhaiyan (haiyan))
Date: Mon, 2 Sep 2013 06:49:34 +0000
Subject: [PATCH] NVMe: Avoid caculate cq head doorbel in nvme_process_cq()
In-Reply-To: <mailman.3257.1377730793.1059.linux-nvme@lists.infradead.org>
References: <mailman.3257.1377730793.1059.linux-nvme@lists.infradead.org>
Message-ID: <A103C806EC8D6E46A0D950DAA4D118D1400E0096@szxeml558-mbx.china.huawei.com>

We use 2 pointers, one for sq tail doorbell, the other for cq head doorbell in struct nvme_queue, to avoid calculate cq head doorbell in nvme_process_cq(). 
This change can reduce latency for the admin/io command.

Signed-off-by: Haiyan Hu <huhaiyan at huawei.com >

---
drivers/block/nvme-core.c |   19 +++++++++++--------
1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c index 7de80bb..80cf07c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -74,7 +74,8 @@ struct nvme_queue {
       wait_queue_head_t sq_full;
       wait_queue_t sq_cong_wait;
       struct bio_list sq_cong;
-        u32 __iomem *q_db;
+       u32 __iomem *sq_tail_db;
+       u32 __iomem *cq_head_db;
       u16 q_depth;
       u16 cq_vector;
       u16 sq_head;
@@ -252,7 +253,7 @@ static int nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
       memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
       if (++tail == nvmeq->q_depth)
                tail = 0;
-        writel(tail, nvmeq->q_db);
+       writel(tail, nvmeq->sq_tail_db);
       nvmeq->sq_tail = tail;
       spin_unlock_irqrestore(&nvmeq->q_lock, flags);

@@ -618,7 +619,7 @@ static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,

        if (++nvmeq->sq_tail == nvmeq->q_depth)
                nvmeq->sq_tail = 0;
-        writel(nvmeq->sq_tail, nvmeq->q_db);
+       writel(nvmeq->sq_tail, nvmeq->sq_tail_db);

        return 0;
}
@@ -635,7 +636,7 @@ static int nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,

        if (++nvmeq->sq_tail == nvmeq->q_depth)
                nvmeq->sq_tail = 0;
-        writel(nvmeq->sq_tail, nvmeq->q_db);
+       writel(nvmeq->sq_tail, nvmeq->sq_tail_db);

        return 0;
}
@@ -728,7 +729,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
       nvme_start_io_acct(bio);
       if (++nvmeq->sq_tail == nvmeq->q_depth)
                nvmeq->sq_tail = 0;
-        writel(nvmeq->sq_tail, nvmeq->q_db);
+       writel(nvmeq->sq_tail, nvmeq->sq_tail_db);

        return 0;

@@ -772,7 +773,7 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
       if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
                return 0;

-        writel(head, nvmeq->q_db + (1 << nvmeq->dev->db_stride));
+       writel(head, nvmeq->cq_head_db);
       nvmeq->cq_head = head;
       nvmeq->cq_phase = phase;

@@ -1084,7 +1085,8 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
       init_waitqueue_head(&nvmeq->sq_full);
       init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
       bio_list_init(&nvmeq->sq_cong);
-        nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
+       nvmeq->sq_tail_db = &dev->dbs[qid << (dev->db_stride + 1)];
+       nvmeq->cq_head_db = nvmeq->sq_tail_db + (1 << dev->db_stride);
       nvmeq->q_depth = depth;
       nvmeq->cq_vector = vector;

@@ -1690,7 +1692,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
                iounmap(dev->bar);
                dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
                dev->dbs = ((void __iomem *)dev->bar) + 4096;
-                 dev->queues[0]->q_db = dev->dbs;
+                dev->queues[0]->sq_tail_db = dev->dbs;
+               dev->queues[0]->cq_head_db = dev->dbs + (1 << dev->db_stride);
       }

        vecs = nr_io_queues;
--
1.7.6
