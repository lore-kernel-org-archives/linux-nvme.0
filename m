From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 13:36:28 +0300
Subject: [PATCH] nvme: Fix error flow at nvme_rdma_configure_admin_queue()
In-Reply-To: <20180619054157.GC23184@lst.de>
References: <1528979864-3109-1-git-send-email-israelr@mellanox.com>
 <20180615080154.GA19525@lst.de>
 <a760d739-f88b-99bf-27ca-4dee113b5b49@mellanox.com>
 <20180619054157.GC23184@lst.de>
Message-ID: <b26fe840-8521-82f6-39c4-e5976e37c4a8@grimberg.me>


>>> back instead and have a different double free protection.  E.g.
>>> in nvme_rdma_free_qe just check if qe->data is set first,
>>> and the NULL it out when freeing.
>>>
>>
>> I guess we can but this is not enough since we'll need to move the call to
>> nvme_rdma_free_qe to be after stopping the queue. I actually think that
>> making it symetrical is the right way to go (we also have a flag
>> NVME_RDMA_Q_ALLOCATED that helps here) but I guess reverting Sagi's commit
>> + some fix will work too.

I don't think this is the way to go. And I don't think that reverting it
is either the way to go.

The commit message said:
--
     nvme-rdma: Fix possible double free in reconnect flow

     The fact that we free the async event buffer in
     nvme_rdma_destroy_admin_queue can cause us to free it
     more than once because this happens in every reconnect
     attempt since commit 31fdf1840170. we rely on the queue
     state flags DELETING to avoid this for other resources.

     A more complete fix is to not destroy the admin/io queues
     unconditionally on every reconnect attempt, but its a bit
     more extensive and will go in the next release.
--

Today, we don't destroy the admin queue on every reconnect so
I think we are OK with restoring it back, but looking at the code
some more is needed.

I think that the async buffer needs to be allocated right after
nvme_alloc_rdma_queue and to be free right before nvme_rdma_free_queue.

Israel, does something like something like [1] work?

> Yes, it should be symetrical either way.  What is the story with
> NVME_RDMA_Q_ALLOCATED?

This was just to flip the logic to check positive vs. !negative like
we do for LIVE.. (done in 5013e98b5e8db50144e8f1ca5a96aed95d4d48a0)



[1]:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c9424da0d23e..787917963137 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -560,12 +560,6 @@ static void nvme_rdma_free_queue(struct 
nvme_rdma_queue *queue)
         if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
                 return;

-       if (nvme_rdma_queue_idx(queue) == 0) {
-               nvme_rdma_free_qe(queue->device->dev,
-                       &queue->ctrl->async_event_sqe,
-                       sizeof(struct nvme_command), DMA_TO_DEVICE);
-       }
-
         nvme_rdma_destroy_queue_ib(queue);
         rdma_destroy_id(queue->cm_id);
  }
@@ -739,6 +733,8 @@ static void nvme_rdma_destroy_admin_queue(struct 
nvme_rdma_ctrl *ctrl,
                 blk_cleanup_queue(ctrl->ctrl.admin_q);
                 nvme_rdma_free_tagset(&ctrl->ctrl, 
ctrl->ctrl.admin_tagset);
         }
+       nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+               sizeof(struct nvme_command), DMA_TO_DEVICE);
         nvme_rdma_free_queue(&ctrl->queues[0]);
  }

@@ -755,11 +751,16 @@ static int nvme_rdma_configure_admin_queue(struct 
nvme_rdma_ctrl *ctrl,

         ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);

+       error = nvme_rdma_alloc_qe(ctrl->device->dev, 
&ctrl->async_event_sqe,
+                       sizeof(struct nvme_command), DMA_TO_DEVICE);
+       if (error)
+               goto out_free_queue;
+
         if (new) {
                 ctrl->ctrl.admin_tagset = 
nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
                 if (IS_ERR(ctrl->ctrl.admin_tagset)) {
                         error = PTR_ERR(ctrl->ctrl.admin_tagset);
-                       goto out_free_queue;
+                       goto out_free_async_qe;
                 }

                 ctrl->ctrl.admin_q = 
blk_mq_init_queue(&ctrl->admin_tag_set);
@@ -795,12 +796,6 @@ static int nvme_rdma_configure_admin_queue(struct 
nvme_rdma_ctrl *ctrl,
         if (error)
                 goto out_stop_queue;

-       error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
-                       &ctrl->async_event_sqe, sizeof(struct nvme_command),
-                       DMA_TO_DEVICE);
-       if (error)
-               goto out_stop_queue;
-
         return 0;

  out_stop_queue:
@@ -811,6 +806,9 @@ static int nvme_rdma_configure_admin_queue(struct 
nvme_rdma_ctrl *ctrl,
  out_free_tagset:
         if (new)
                 nvme_rdma_free_tagset(&ctrl->ctrl, 
ctrl->ctrl.admin_tagset);
+out_free_async_qe:
+       nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+               sizeof(struct nvme_command), DMA_TO_DEVICE);
  out_free_queue:
         nvme_rdma_free_queue(&ctrl->queues[0]);
         return error;
--
