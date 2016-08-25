From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Aug 2016 00:52:09 +0300
Subject: nvme_rdma - leaves provider resources allocated
In-Reply-To: <006501d1fe11$2c3e6200$84bb2600$@opengridcomputing.com>
References: <014301d1fd5f$a2da7000$e88f5000$@opengridcomputing.com>
 <98396d58-4a16-0e1f-e42b-912edb8a7cf6@grimberg.me>
 <006501d1fe11$2c3e6200$84bb2600$@opengridcomputing.com>
Message-ID: <ef285ffd-a176-b86d-beb3-2cfe9e10c5ea@grimberg.me>


> Hey Sagi,
>
> I'm finalizing a WIP series that provides a different approach.  (we can
> certainly reconsider my ib_client patch too).  But my WIP adds the concept of an
> "unplug" cm_id for each nvme_rdma_ctrl controller.  When the controller is first
> created and the admin qp is connected to the target, the unplug_cm_id is created
> and address resolution is done on it to bind it to the same device that the
> admin QP is bound to.   This unplug_cm_id remains across any/all kato recovery
> and thus will always be available for DEVICE_REMOVAL events.  This simplifies
> the unplug handler because the cm_id isn't associated with any of the IO queues
> nor the admin queue.

OK, let's wait for the patches...

> I also found another bug:  if the reconnect worker times out waiting for rdma
> connection setup on an IO or admin QP, a QP is leaked.   I'm looking into this
> as well.

Hmm, I think you're right. If we passed address resolution but failed
route (or got a general CONNECT/UNREACHABLE errors) we won't free the
queue...

I think this should fix this:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ab545fb347a0..452727c5ea13 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1382,10 +1382,12 @@ static int nvme_rdma_cm_handler(struct 
rdma_cm_id *cm_id,
         case RDMA_CM_EVENT_REJECTED:
                 cm_error = nvme_rdma_conn_rejected(queue, ev);
                 break;
-       case RDMA_CM_EVENT_ADDR_ERROR:
         case RDMA_CM_EVENT_ROUTE_ERROR:
         case RDMA_CM_EVENT_CONNECT_ERROR:
         case RDMA_CM_EVENT_UNREACHABLE:
+               nvme_rdma_destroy_queue_ib(queue);
+       case RDMA_CM_EVENT_ADDR_ERROR:
+               /* FALLTHRU */
                 dev_dbg(queue->ctrl->ctrl.device,
                         "CM error event %d\n", ev->event);
                 cm_error = -ECONNRESET;
--

>
> Do you have any thoughts on the controller reference around deletion issue I
> posted?
>
> http://lists.infradead.org/pipermail/linux-nvme/2016-August/005919.html

Looks fine, but you need to use kref_get_unless_zero.
