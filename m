From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 20 Oct 2016 15:41:44 -0500
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <015201d22b0b$4f526440$edf72cc0$@opengridcomputing.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
 <00bf01d22adf$43370ac0$c9a52040$@opengridcomputing.com>
 <0b3c125a-cdb8-7a28-deca-0ccad3d1ca22@sandisk.com>
 <010801d22af9$c202c370$46084a50$@opengridcomputing.com>
 <31822981-0032-98aa-6570-450351020463@sandisk.com>
 <012601d22afd$5a310460$0e930d20$@opengridcomputing.com>
 <015201d22b0b$4f526440$edf72cc0$@opengridcomputing.com>
Message-ID: <015c01d22b12$5e9f4e70$1bddeb50$@opengridcomputing.com>



> -----Original Message-----
> From: Steve Wise [mailto:swise at opengridcomputing.com]
> Sent: Thursday, October 20, 2016 2:51 PM
> To: 'Bart Van Assche'; 'Keith Busch'
> Cc: 'Jens Axboe'; 'Christoph Hellwig'; linux-nvme at lists.infradead.org; 'Sagi
> Grimberg'
> Subject: RE: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
> informative
> 
> >
> > > On 10/20/2016 10:45 AM, Steve Wise wrote:
> > > > I agree.  What if we add a helper function in the core to map the
> > >  > event->status value to something human readable?  That would at
> > >  > least push this into the core.   The nvme host really doesn't do
> > >  > anything other than display a different message...
> > > >
> > > > Something like rdma_event_msg(), but using event->status.
> > >
> > > Hello Steve,
> > >
> > > It won't be possible to let rdma_event_msg() decode the NVME_RDMA_CM_*
> > > status unless a callback function that performs such decoding is passed
> > > to rdma_event_msg(). Since such an approach would work for translating a
> > > status into a message but not for any more advanced CM status handling
> > > my preference is to unify the calling conventions for IB/RoCE and iWARP
> > > CM reject callbacks.
> >
> > I think for this particular case, mapping event->status to a string is all
> > that nvme needs.  And having a status to string mapping would be easy to
> > do
> > in the core.  I agree though, that unifying the status codes is a "good
> > thing".
> 
> What about something along these lines? (untested and mangled by my emailer,
> but you get the point)

And here is a proposed change to nvme_rdma to use rdma_reject_msg().  If you like this idea, I'll send out these two patches, or send them to you to include in your series.



diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 601aecf..41a2d4c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1237,18 +1237,19 @@ out_destroy_queue_ib:
 static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
                struct rdma_cm_event *ev)
 {
+       short nvme_status = -1;
+
        if (ev->param.conn.private_data_len) {
                struct nvme_rdma_cm_rej *rej =
                        (struct nvme_rdma_cm_rej *)ev->param.conn.private_data;

-               dev_err(queue->ctrl->ctrl.device,
-                       "Connect rejected, status %d.", le16_to_cpu(rej->sts));
-               /* XXX: Think of something clever to do here... */
-       } else {
-               dev_err(queue->ctrl->ctrl.device,
-                       "Connect rejected, no private data.\n");
+               nvme_status = le16_to_cpu(rej->sts);
        }

+       dev_err(queue->ctrl->ctrl.device, "Connect rejected: status %d (%s) "
+               "nvme status %d.\n", ev->status,
+               rdma_reject_msg(queue->cm_id, ev->status), nvme_status);
+
        return -ECONNRESET;
 }
