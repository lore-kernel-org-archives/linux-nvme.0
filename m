From: Tomita.Haruo@toshiba-sol.co.jp (Tomita.Haruo@toshiba-sol.co.jp)
Date: Fri, 25 Nov 2016 05:00:26 +0000
Subject: [PATCH] Use rsps_lock in nvmet_rdma_free_rsp
In-Reply-To: <20161122074153.GC5497@infradead.org>
References: <781668ff60b040b3a56e104f489c3ea9@TGXML382.toshiba.local>
 <20161122074153.GC5497@infradead.org>
Message-ID: <923efced268f42a19eb96d593894d141@TGXML382.toshiba.local>

Hi Christoph,

Thank you for your reply.

> what are you trying to protect against during device teardown?

I'm trying to protect nvmet_rdma_get_rsp and nvmet_rdma_put_rsp.
In these functions, queue->free_rsps is protected by rsps_lock.
rsp->free_list is also protected at the same time.

I am investigating whether there is a race issue on the target of nvme.
For another function, I also think of the following patch.

--- linux-4.9-rc6/drivers/nvme/target/rdma.c.orig       2016-11-25 06:51:06.000000000 +0900
+++ linux-4.9-rc6/drivers/nvme/target/rdma.c    2016-11-25 06:55:53.000000000 +0900
@@ -724,6 +724,7 @@ static void nvmet_rdma_recv_done(struct
                container_of(wc->wr_cqe, struct nvmet_rdma_cmd, cqe);
        struct nvmet_rdma_queue *queue = cq->cq_context;
        struct nvmet_rdma_rsp *rsp;
+       unsigned long flags;

        if (unlikely(wc->status != IB_WC_SUCCESS)) {
                if (wc->status != IB_WC_WR_FLUSH_ERR) {
@@ -747,10 +748,9 @@ static void nvmet_rdma_recv_done(struct
        rsp->flags = 0;
        rsp->req.cmd = cmd->nvme_cmd;

+       spin_lock_irqsave(&queue->state_lock, flags);
        if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
-               unsigned long flags;

-               spin_lock_irqsave(&queue->state_lock, flags);
                if (queue->state == NVMET_RDMA_Q_CONNECTING)
                        list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
                else
@@ -758,6 +758,7 @@ static void nvmet_rdma_recv_done(struct
                spin_unlock_irqrestore(&queue->state_lock, flags);
                return;
        }
+       spin_unlock_irqrestore(&queue->state_lock, flags);

        nvmet_rdma_handle_command(queue, rsp);
 }

--
Haruo
