From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Sep 2016 12:17:34 +0300
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
 <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>
 <69c0e819-76d9-286b-c4fb-22f087f36ff1@grimberg.me>
 <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
 <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com>
Message-ID: <0c159abb-24ee-21bf-09d2-9fe7d269a2eb@grimberg.me>

Hey Steve,

> Ok, back to this issue. :)
>
> The same crash happens with mlx4_ib, so this isn't related to cxgb4.  To sum up:
>
> With pending NVME IO on the nvme-rdma host, and in the presence of kato
> recovery/reconnect due to the target going away, some NVME requests get
> restarted that are referencing nvmf controllers that have freed queues.  I see
> this also with my recent v4 series that corrects the recovery problems with
> nvme-rdma when the target is down, but without pending IO.
>
> So the crash in this email is yet another issue that we see when the nvme host
> has lots of pending IO requests during kato recovery/reconnect...
>
> My findings to date:  the IO is not an admin queue IO.  It is not the kato
> messages.  The io queue has been stopped, yet the request is attempted and
> causes the crash.
>
> Any help is appreciated...

So in the current state, my impression is that we are seeing a request
queued when we shouldn't (or at least assume we won't).

Given that you run heavy load to reproduce this, I can only suspect that
this is a race condition.

Does this happen if you change the reconnect delay to be something
different than 10 seconds? (say 30?)

Can you also give patch [1] a try? It's not a solution, but I want
to see if it hides the problem...

Now, given that you already verified that the queues are stopped with
BLK_MQ_S_STOPPED, I'm looking at blk-mq now.

I see that blk_mq_run_hw_queue() and __blk_mq_run_hw_queue() indeed take
BLK_MQ_S_STOPPED into account. Theoretically  if we free the queue
pairs after we passed these checks while the rq_list is being processed
then we can end-up with this condition, but given that it takes
essentially forever (10 seconds) I tend to doubt this is the case.

HCH, Jens, Keith, any useful pointers for us?

To summarize we see a stray request being queued long after we set
BLK_MQ_S_STOPPED (and by long I mean 10 seconds).



[1]:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d2f891efb27b..38ea5dab4524 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -701,20 +701,13 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)
         bool changed;
         int ret;

-       if (ctrl->queue_count > 1) {
-               nvme_rdma_free_io_queues(ctrl);
-
-               ret = blk_mq_reinit_tagset(&ctrl->tag_set);
-               if (ret)
-                       goto requeue;
-       }
-
-       nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);

         ret = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
         if (ret)
                 goto requeue;

+       nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
+
         ret = nvme_rdma_init_queue(ctrl, 0, NVMF_AQ_DEPTH);
         if (ret)
                 goto requeue;
@@ -732,6 +725,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)
         nvme_start_keep_alive(&ctrl->ctrl);

         if (ctrl->queue_count > 1) {
+               ret = blk_mq_reinit_tagset(&ctrl->tag_set);
+               if (ret)
+                       goto stop_admin_q;
+
+               nvme_rdma_free_io_queues(ctrl);
+
                 ret = nvme_rdma_init_io_queues(ctrl);
                 if (ret)
                         goto stop_admin_q;
--
