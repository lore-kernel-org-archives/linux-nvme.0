From: bart.vanassche@wdc.com (Bart Van Assche)
Date: Mon, 26 Feb 2018 14:20:09 -0800
Subject: nvme-rdma corrupts memory upon timeout
In-Reply-To: <9569a169-76cb-cd49-e31a-f33978fe2025@grimberg.me>
References: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>
 <65c6d928-dd82-70b6-79a7-481dc629c3db@grimberg.me>
 <9569a169-76cb-cd49-e31a-f33978fe2025@grimberg.me>
Message-ID: <ef8b9261-acac-4473-2267-b53c6c247806@wdc.com>

On 02/25/18 10:14, Sagi Grimberg wrote:
> Or maybe this should do a better job:
> -- 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 4c32518a6c81..e45801fe78c1 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -956,12 +956,14 @@ static void nvme_rdma_error_recovery_work(struct 
> work_struct *work)
> 
>  ??????? if (ctrl->ctrl.queue_count > 1) {
>  ??????????????? nvme_stop_queues(&ctrl->ctrl);
> +?????????????? nvme_rdma_stop_io_queues(ctrl);
>  ??????????????? blk_mq_tagset_busy_iter(&ctrl->tag_set,
>  ??????????????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
>  ??????????????? nvme_rdma_destroy_io_queues(ctrl, false);
>  ??????? }
> 
>  ??????? blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> +?????? nvme_rdma_stop_queue(&ctrl->queues[0]);
>  ??????? blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  ??????????????????????????????? nvme_cancel_request, &ctrl->ctrl);

Hello Sagi,

With this change applied, I think what nvme_rdma_error_recovery_work() 
does for I/O and admin queues is as follows:
- Call blk_mq_quiesce_queue() to wait concurrent .queue_rq() calls have
   finished.
- Call nvme_rdma_stop_io_queues() to change the QP state into "error"
   and to wait until all RDMA completions have been processed.
- Call blk_mq_tagset_busy_iter() to cancel any pending block layer
   requests.
- Call blk_mq_unfreeze_queue() to resume the request queues.
- Call nvme_rdma_reconnect_or_remove().

The above patch seems like an improvement to me but I don't think that 
it fixes the race between nvme_cancel_request() and 
nvme_rdma_queue_rq(). Has it been considered to modify 
nvme_rdma_error_recovery_work() as follows:
* Clear NVME_RDMA_Q_LIVE.
* Change the RDMA QP state into "error".
* Freeze and unfreeze the block layer request queue. The freeze will
   wait until all pending requests have finished.
* Call nvme_rdma_reconnect_or_remove().

That last sequence has the following advantages:
* Draining the RDMA QP explicitly is no longer necessary.
* It fixes the race with nvme_cancel_request() by not calling
   nvme_cancel_request().

Thanks,

Bart.
