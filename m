From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 25 Aug 2016 17:03:12 -0500
Subject: nvme_rdma - leaves provider resources allocated
In-Reply-To: <ef285ffd-a176-b86d-beb3-2cfe9e10c5ea@grimberg.me>
References: <014301d1fd5f$a2da7000$e88f5000$@opengridcomputing.com>
 <98396d58-4a16-0e1f-e42b-912edb8a7cf6@grimberg.me>
 <006501d1fe11$2c3e6200$84bb2600$@opengridcomputing.com>
 <ef285ffd-a176-b86d-beb3-2cfe9e10c5ea@grimberg.me>
Message-ID: <023301d1ff1c$79333020$6b999060$@opengridcomputing.com>


> > Hey Sagi,
> >
> > I'm finalizing a WIP series that provides a different approach.  (we can
> > certainly reconsider my ib_client patch too).  But my WIP adds the concept
of an
> > "unplug" cm_id for each nvme_rdma_ctrl controller.  When the controller is
first
> > created and the admin qp is connected to the target, the unplug_cm_id is
created
> > and address resolution is done on it to bind it to the same device that the
> > admin QP is bound to.   This unplug_cm_id remains across any/all kato
recovery
> > and thus will always be available for DEVICE_REMOVAL events.  This
simplifies
> > the unplug handler because the cm_id isn't associated with any of the IO
queues
> > nor the admin queue.
> 
> OK, let's wait for the patches...

I'll send them tomorrow.  They're still Work In Progress (WIP) though.  There is
at least one other bug I'm chasing.

> 
> > I also found another bug:  if the reconnect worker times out waiting for
rdma
> > connection setup on an IO or admin QP, a QP is leaked.   I'm looking into
this
> > as well.
> 
> Hmm, I think you're right. If we passed address resolution but failed
> route (or got a general CONNECT/UNREACHABLE errors) we won't free the
> queue...
> 
> I think this should fix this:
> --
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index ab545fb347a0..452727c5ea13 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1382,10 +1382,12 @@ static int nvme_rdma_cm_handler(struct
> rdma_cm_id *cm_id,
>          case RDMA_CM_EVENT_REJECTED:
>                  cm_error = nvme_rdma_conn_rejected(queue, ev);
>                  break;
> -       case RDMA_CM_EVENT_ADDR_ERROR:
>          case RDMA_CM_EVENT_ROUTE_ERROR:
>          case RDMA_CM_EVENT_CONNECT_ERROR:
>          case RDMA_CM_EVENT_UNREACHABLE:
> +               nvme_rdma_destroy_queue_ib(queue);
> +       case RDMA_CM_EVENT_ADDR_ERROR:
> +               /* FALLTHRU */
>                  dev_dbg(queue->ctrl->ctrl.device,
>                          "CM error event %d\n", ev->event);
>                  cm_error = -ECONNRESET;
> --

This won't quite do it.  The reconnect thread can timeout and give up before any
event arrives, and that path also needs to destroy the queue resources if it was
allocated.  This is my current patch.  I appreciate any comments.  (but I'll
resend this formally tomorrow with other changes)...

---

nvme-rdma: destroy nvme queue rdma resources on connect failure

From: Steve Wise <swise@opengridcomputing.com>

After address resolution, the nvme_rdma_queue rdma resources are
allocated.  If rdma route resolution or the connect fails, or the
controller reconnect times out and gives up, then the rdma resources
need to be freed.  Otherwise, rdma resources are leaked.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---

 drivers/nvme/host/rdma.c |    5 +++++
 1 file changed, 5 insertions(+)


diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6198eaa..ea271df 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -87,6 +87,7 @@ struct nvme_rdma_request {

 enum nvme_rdma_queue_flags {
        NVME_RDMA_Q_CONNECTED = (1 << 0),
+       NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
 };

 struct nvme_rdma_queue {
@@ -488,6 +489,7 @@ static void nvme_rdma_destroy_queue_ib(struct
nvme_rdma_queue *queue)
        struct nvme_rdma_device *dev = queue->device;
        struct ib_device *ibdev = dev->dev;

+       clear_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);
        rdma_destroy_qp(queue->cm_id);
        ib_free_cq(queue->ib_cq);

@@ -538,6 +540,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue
*queue,
                ret = -ENOMEM;
                goto out_destroy_qp;
        }
+       set_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);

        return 0;

@@ -595,6 +598,8 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
        return 0;

 out_destroy_cm_id:
+       if (test_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &ctrl->queues[0].flags))
+               nvme_rdma_destroy_queue_ib(queue);
        rdma_destroy_id(queue->cm_id);
        return ret;
 }
