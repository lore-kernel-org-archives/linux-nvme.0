From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 10 Aug 2016 13:59:34 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
Message-ID: <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>


> The nvme_rdma_ctrl queue associated with the request is in RECONNECTING state:
> 
>   ctrl = {
>     state = NVME_CTRL_RECONNECTING,
>     lock = {
> 
> So it should not be posting SQ WRs...

kato kicks error recovery, nvme_rdma_error_recovery_work(), which calls
nvme_cancel_request() on each request.  nvme_cancel_request() sets req->errors
to NVME_SC_ABORT_REQ.  It then completes the request which ends up at
nvme_rdma_complete_rq() which queues it for retry:
...
        if (unlikely(rq->errors)) {
                if (nvme_req_needs_retry(rq, rq->errors)) {
                        nvme_requeue_req(rq);
                        return;
                }

                if (rq->cmd_type == REQ_TYPE_DRV_PRIV)
                        error = rq->errors;
                else
                        error = nvme_error_status(rq->errors);
        }
...

The retry will end up at nvme_rdma_queue_rq() which will try and post a send wr
to a freed qp...

Should the canceled requests actually OR in bit NVME_SC_DNR?  That is only done
in nvme_cancel_request() if the blk queue is dying:

...
        status = NVME_SC_ABORT_REQ;
        if (blk_queue_dying(req->q))
                status |= NVME_SC_DNR;
...


Sagi, please put on your KATO hat and help! :)

Thanks,

Steve.
