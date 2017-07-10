From: Victor.Gladkov@taec.toshiba.com (Victor Gladkov)
Date: Mon, 10 Jul 2017 08:24:37 +0000
Subject: [PATCH] nvmet-rdma: prevent possible race condition for queue state
Message-ID: <77FF42D3D537D24484F0BF5E2458C0C08506BE27@EXMAIL1.taec.toshiba.com>

This patch prevents possible race condition for queue state when the state may be changed before take a lock.
 

kernel v4.9.36
--- a/drivers/nvme/target/rdma.c     2017-07-10 10:11:02.003751067 +0300
+++ b/drivers/nvme/target/rdma.c    2017-07-10 10:09:42.137755664 +0300
@@ -767,7 +767,11 @@
        if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
                unsigned long flags;

                spin_lock_irqsave(&queue->state_lock, flags);
+               if (queue->state == NVMET_RDMA_Q_LIVE){
+                      spin_unlock_irqrestore(&queue->state_lock, flags);
+                       goto handle_command;
+               }
                if (queue->state == NVMET_RDMA_Q_CONNECTING)
                        list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
                else
@@ -776,5 +780,6 @@
                return;
        }

+handle_command;
        nvmet_rdma_handle_command(queue, rsp);
 }


Best Regards,
Victor
