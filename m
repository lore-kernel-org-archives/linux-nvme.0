From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 11 Aug 2016 08:58:38 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
Message-ID: <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>

> >> The nvme_rdma_ctrl queue associated with the request is in RECONNECTING
> state:
> >>
> >>   ctrl = {
> >>     state = NVME_CTRL_RECONNECTING,
> >>     lock = {
> >>
> >> So it should not be posting SQ WRs...
> >
> > kato kicks error recovery, nvme_rdma_error_recovery_work(), which calls
> > nvme_cancel_request() on each request.  nvme_cancel_request() sets
req->errors
> > to NVME_SC_ABORT_REQ.  It then completes the request which ends up at
> > nvme_rdma_complete_rq() which queues it for retry:
> > ...
> >         if (unlikely(rq->errors)) {
> >                 if (nvme_req_needs_retry(rq, rq->errors)) {
> >                         nvme_requeue_req(rq);
> >                         return;
> >                 }
> >
> >                 if (rq->cmd_type == REQ_TYPE_DRV_PRIV)
> >                         error = rq->errors;
> >                 else
> >                         error = nvme_error_status(rq->errors);
> >         }
> > ...
> >
> > The retry will end up at nvme_rdma_queue_rq() which will try and post a send
wr
> > to a freed qp...
> >
> > Should the canceled requests actually OR in bit NVME_SC_DNR?  That is only
> done
> > in nvme_cancel_request() if the blk queue is dying:
> 
> the DNR bit should not be set normally, only when we either don't want
> to requeue or we can't.
> 
> >
> > ...
> >         status = NVME_SC_ABORT_REQ;
> >         if (blk_queue_dying(req->q))
> >                 status |= NVME_SC_DNR;
> > ...
> >
> 
> couple of questions:
> 
> 1. bringing down the interface means generating DEVICE_REMOVAL
> event?
> 

No.  Just ifconfig ethX down; sleep 10; ifconfig ethX up.  This simply causes
the pending work requests to take longer to complete and kicks in the kato
logic.


> 2. keep-alive timeout expires means that nvme_rdma_timeout() invokes
> kicks error_recovery and set:
> rq->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR
> 
> So I'm not at all convinced that the keep-alive is the request that
> being re-issued. Did you verify that?

The request that caused the crash had rq->errors == NVME_SC_ABORT_REQ.  I'm not
sure that is always the case though.  But this is very easy to reproduce, so I
should be able to drill down and add any debug code you think might help.
