From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 22 Apr 2019 17:55:05 +0800
Subject: [PATCH] nvmet: loop: kill timeout handler
In-Reply-To: <20190415015146.22580-1-ming.lei@redhat.com>
References: <20190415015146.22580-1-ming.lei@redhat.com>
Message-ID: <CACVXFVM2__FMFJMTD9kMTqTDSgbQRo9wu-OdUA2XFFyKEcBuUA@mail.gmail.com>

On Mon, Apr 15, 2019@9:52 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Firstly it doesn't make sense to handle timeout for loop: 1) for admin
> queue, the request is always completed in code path of queuing IO. 2)
> for normal IO request, the timeout on these IOs have been handled by
> underlying queue already.
>
> Secondly nvme-loop's timeout handler is simply broken, and easy to
> cause issue: 1) no any sync/protection between timeout and normal
> completion, and now it is driver's responsibility to deal with
> that; 2) bad reset implementation, blk_mq_update_nr_hw_queues()
> is called after all NSs's queue is stopped(quiesced), and easy
> to trigger deadlock.
>
> So kill the timeout handler.
>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: James Smart <jsmart2021 at gmail.com>
> Cc: Hannes Reinecke <hare at suse.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  drivers/nvme/target/loop.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index b9f623ab01f3..c44b425848fb 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -129,20 +129,6 @@ static void nvme_loop_execute_work(struct work_struct *work)
>         nvmet_req_execute(&iod->req);
>  }
>
> -static enum blk_eh_timer_return
> -nvme_loop_timeout(struct request *rq, bool reserved)
> -{
> -       struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(rq);
> -
> -       /* queue error recovery */
> -       nvme_reset_ctrl(&iod->queue->ctrl->ctrl);
> -
> -       /* fail with DNR on admin cmd timeout */
> -       nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
> -
> -       return BLK_EH_DONE;
> -}
> -
>  static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>                 const struct blk_mq_queue_data *bd)
>  {
> @@ -253,7 +239,6 @@ static const struct blk_mq_ops nvme_loop_mq_ops = {
>         .complete       = nvme_loop_complete_rq,
>         .init_request   = nvme_loop_init_request,
>         .init_hctx      = nvme_loop_init_hctx,
> -       .timeout        = nvme_loop_timeout,
>  };
>
>  static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
> @@ -261,7 +246,6 @@ static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
>         .complete       = nvme_loop_complete_rq,
>         .init_request   = nvme_loop_init_request,
>         .init_hctx      = nvme_loop_init_admin_hctx,
> -       .timeout        = nvme_loop_timeout,
>  };
>
>  static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
> --
> 2.9.5
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Ping...

Thanks,
Ming Lei
