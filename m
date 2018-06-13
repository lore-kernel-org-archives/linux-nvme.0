From: james.smart@broadcom.com (James Smart)
Date: Wed, 13 Jun 2018 12:48:10 -0700
Subject: [PATCH 1/4] nvme-fabrics: refactor queue ready check
In-Reply-To: <20180611154647.32558-2-hch@lst.de>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-2-hch@lst.de>
Message-ID: <7362f54b-e4c8-0040-f7de-9ed7845216a8@broadcom.com>



On 6/11/2018 8:46 AM, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0bad65803271..7a4afbd22b8a 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2279,14 +2279,13 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
>   	struct nvme_command *sqe = &cmdiu->sqe;
>   	enum nvmefc_fcp_datadir	io_dir;
> +	bool queue_ready = test_bit(NVME_FC_Q_LIVE, &queue->flags);
>   	u32 data_len;
>   	blk_status_t ret;
>   
> -	ret = nvmf_check_if_ready(&queue->ctrl->ctrl, rq,
> -		test_bit(NVME_FC_Q_LIVE, &queue->flags),
> -		ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE);
> -	if (unlikely(ret))
> -		return ret;
> +	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
> +	    nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
> +		return nvmf_fail_nonready_command(rq);
>   
>   	ret = nvme_setup_cmd(ns, rq, sqe);
>   	if (ret)
>

This is missing the ! on the nvmf_check_ready() call. Should be:

+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
+	    !nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
+		return nvmf_fail_nonready_command(rq);


other transports had it right.


-- james
