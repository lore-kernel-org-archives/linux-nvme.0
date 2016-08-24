From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Aug 2016 14:20:41 +0300
Subject: nvmf host shutdown hangs when nvmf controllers are in
 recovery/reconnect
In-Reply-To: <b93e8bc6-1fd1-3191-d811-1503cc2e4499@grimberg.me>
References: <00de01d1fd4d$10e44700$32acd500$@opengridcomputing.com>
 <b93e8bc6-1fd1-3191-d811-1503cc2e4499@grimberg.me>
Message-ID: <a004bd27-6efd-98aa-6430-da7aeafd46b0@grimberg.me>


> Hey Steve,
>
> For some reason I can't reproduce this on my setup...
>
> So I'm wandering where is nvme_rdma_del_ctrl() thread stuck?
> Probably a dump of all the kworkers would be helpful here:
>
> $ pids=`ps -ef | grep kworker | grep -v grep | awk {'print $2'}`
> $ for p in $pids; do echo "$p:" ;cat /proc/$p/stack; done
>
> The fact that nvme1 keeps reconnecting forever, means that
> del_ctrl() never changes the controller state. Is there an
> nvme0 on the system that is also being removed and you don't
> see the reconnecting thread keeps on going?
>
> My expectation would be that del_ctrl() would move the ctrl state
> to DELETING and reconnect thread would bail-out, then the delete_work
> should fire and delete the controller. Obviously something is not
> happening like it should.

I think I suspect what is going on...

When we get a surprise disconnect from the target we queue
a periodic reconnect (which is the sane thing to do...).

We only move the queues out of CONNECTED when we retry
to reconnect (after 10 seconds in the default case) but we stop
the blk queues immediately so we are not bothered with traffic from
now on. If delete() is kicking off in this period the queues are still
in CONNECTED state.

Part of the delete sequence is trying to issue ctrl shutdown if the
admin queue is CONNECTED (which it is!). This request is issued but
stuck in blk-mq waiting for the queues to start again. This might
be the one preventing us from forward progress...

Steve, care to check if the below patch makes things better?

The patch tries to separate the queue flags to CONNECTED and
DELETING. Now we will move out of CONNECTED as soon as error recovery
kicks in (before stopping the queues) and DELETING is on when
we start the queue deletion.

--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 23297c5f85ed..75b49c29b890 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -86,6 +86,7 @@ struct nvme_rdma_request {

  enum nvme_rdma_queue_flags {
         NVME_RDMA_Q_CONNECTED = (1 << 0),
+       NVME_RDMA_Q_DELETING  = (1 << 1),
  };

  struct nvme_rdma_queue {
@@ -612,7 +613,7 @@ static void nvme_rdma_free_queue(struct 
nvme_rdma_queue *queue)

  static void nvme_rdma_stop_and_free_queue(struct nvme_rdma_queue *queue)
  {
-       if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags))
+       if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
                 return;
         nvme_rdma_stop_queue(queue);
         nvme_rdma_free_queue(queue);
@@ -764,8 +765,13 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)
  {
         struct nvme_rdma_ctrl *ctrl = container_of(work,
                         struct nvme_rdma_ctrl, err_work);
+       int i;

         nvme_stop_keep_alive(&ctrl->ctrl);
+
+       for (i = 0; i < ctrl->queue_count; i++)
+               clear_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[i].flags);
+
         if (ctrl->queue_count > 1)
                 nvme_stop_queues(&ctrl->ctrl);
         blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
@@ -1331,7 +1337,7 @@ static int nvme_rdma_device_unplug(struct 
nvme_rdma_queue *queue)
         cancel_delayed_work_sync(&ctrl->reconnect_work);

         /* Disable the queue so ctrl delete won't free it */
-       if (test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags)) {
+       if (!test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags)) {
                 /* Free this queue ourselves */
                 nvme_rdma_stop_queue(queue);
                 nvme_rdma_destroy_queue_ib(queue);
--
