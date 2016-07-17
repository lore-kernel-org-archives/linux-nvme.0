From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 17 Jul 2016 09:01:31 +0300
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
 nvme_rdma_free_ctrl
In-Reply-To: <0a9b01d1deb0$d46ba5d0$7d42f170$@opengridcomputing.com>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
 <1468445196-6915-3-git-send-email-mlin@kernel.org>
 <57875835.5050001@grimberg.me>
 <011301d1dde0$4450e4e0$ccf2aea0$@opengridcomputing.com>
 <011c01d1dde0$cc2f74d0$648e5e70$@opengridcomputing.com>
 <014a01d1dde4$10663230$31329690$@opengridcomputing.com>
 <03c001d1de16$856e7330$904b5990$@opengridcomputing.com>
 <0a9b01d1deb0$d46ba5d0$7d42f170$@opengridcomputing.com>
Message-ID: <578B1F3B.3020100@grimberg.me>


> Hey Sagi, here is some lite reading for you. :)
>
> Prelude:  As part of disconnecting an iwarp connection, the iwarp provider needs
> to post an IW_CM_EVENT_CLOSE event to iw_cm, which is scheduled onto the
> singlethread workq thread for iw_cm.
>
> Here is what happens with Sagi's patch:
>
> nvme_rdma_device_unplug() calls nvme_rdma_stop_queue() which calls
> rdma_disconnect().  This triggers the disconnect.  iw_cxgb4 posts the
> IW_CM_EVENT_CLOSE to iw_cm, which ends up calling cm_close_handler() in the
> iw_cm workq thread context.  cm_close_handler() calls the rdma_cm event handler
> for this cm_id, function cm_iw_handler(), which blocks until any currently
> running event handler for this cm_id finishes.  It does this by calling
> cm_disable_callback().  However since this whole unplug process is running in
> the event handler function for this same cm_id, the iw_cm workq thread is now
> stuck in a deadlock.   nvme_rdma_device_unplug() however, continues on and
> schedules the controller delete worker thread and waits for it to complete.  The
> delete controller worker thread tries to disconnect and destroy all the
> remaining IO queues, but gets stuck in the destroy() path on the first IO queue
> because the iw_cm workq thread is already stuck, and processing the CLOSE event
> is required to release a reference the iw_cm has on the iwarp providers qp.  So
> everything comes to a grinding halt....
>
> Now: Ming's 2 patches avoid this deadlock because the cm_id that received the
> device removal event is disconnected/destroyed _only after_ all the controller
> queues are disconnected/destroyed.  So nvme_rdma_device_unplug() doesn't get
> stuck waiting for the controller to delete the io queues, and only after that
> completes, does it delete the cm_id/qp that got the device removal event.  It
> then returns thus causing the rdma_cm to release the cm_id's callback mutex.
> This causes the iw_cm workq thread to now unblock and we continue on.  (can you
> say house of cards?)
>
> So the net is:  the cm_id that received the device remove event _must_ be
> disconnect/destroyed _last_.

Hey Steve, thanks for the detailed description.

IMHO, this really looks like a buggy design in iWARP connection
management implementation. The fact that a rdma_disconnect forward
progress is dependent on other cm_id execution looks wrong and
backwards to me.

Given that the device is being removed altogether I don't think that
calling rdma_disconnect is important at all. Given the fact that
ib_drain_qp makes sure that the queue-pair is in error state does
this incremental patch resolve the iwarp-deadlock you are seeing?

--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index fd90b5c00aae..e7eec7d8c705 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1342,8 +1342,12 @@ static int nvme_rdma_device_unplug(struct 
nvme_rdma_queue *queue)
                 goto queue_delete;
         }

+       /*
+        * iwcm does not handle rdma_disconnect within DEVICE_REMOVAL
+        * event very well, so we settle with qp drain
+        */
+       ib_drain_qp(queue->qp);
         /* Free this queue ourselves */
-       nvme_rdma_stop_queue(queue);
         nvme_rdma_destroy_queue_ib(queue);

         /* Return non-zero so the cm_id will destroy implicitly */
--
