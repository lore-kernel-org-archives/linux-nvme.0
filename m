From: Victor.Gladkov@taec.toshiba.com (Victor Gladkov)
Date: Wed, 12 Jul 2017 07:05:17 +0000
Subject: [PATCH] nvmet-rdma: prevent possible race condition for queue
 state
In-Reply-To: <99f5789f-0d6a-0166-dab6-b156200e9de5@grimberg.me>
References: <77FF42D3D537D24484F0BF5E2458C0C08506BE27@EXMAIL1.taec.toshiba.com>
 <99f5789f-0d6a-0166-dab6-b156200e9de5@grimberg.me>
Message-ID: <77FF42D3D537D24484F0BF5E2458C0C08506C036@EXMAIL1.taec.toshiba.com>

>> This patch prevents possible race condition for queue state when the state may be changed before take a lock.
>> 
>>
>> kernel v4.9.36

>Indentation doesn't look correct, did you use tab-spacing?
>Please run checkpatch before submitting v2.
>The logic looks correct to me, but it really needs documentation, maybe the below?

Hi Sagi.
Thank you for the help.
I made changes according to your recommendations.
Now the patch looks like this:

--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 005ef5d..7be6c7e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -751,14 +751,27 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
                unsigned long flags;

                spin_lock_irqsave(&queue->state_lock, flags);
-               if (queue->state == NVMET_RDMA_Q_CONNECTING)
+               switch (queue->state) {
+               case NVMET_RDMA_Q_LIVE:
+                       /*
+                        * we raced with connection establishment, go
+                        * ahead and handle the command.
+                        */
+                       spin_unlock_irqrestore(&queue->state_lock, flags);
+                       goto handle_cmd;
+               case NVMET_RDMA_Q_CONNECTING:
+                       /* defer until connection is established */
                        list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
-               else
+                       break;
+               default:
+                       /* Nothing to do with the response */
                        nvmet_rdma_put_rsp(rsp);
+               }
                spin_unlock_irqrestore(&queue->state_lock, flags);
                return;
        }

+handle_cmd;
        nvmet_rdma_handle_command(queue, rsp);
 }
