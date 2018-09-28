From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 28 Sep 2018 15:43:58 -0700
Subject: [PATCH v2] nvme: call nvme_complete_rq on NVME_MPATH failures
In-Reply-To: <20180927235854.12386-1-jsmart2021@gmail.com>
References: <20180927235854.12386-1-jsmart2021@gmail.com>
Message-ID: <413ca359-b482-8638-46bb-b6e0515bae0a@grimberg.me>


> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 206d63cb1afc..bcd09d3a44da 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -552,8 +552,11 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>   	    ctrl->state != NVME_CTRL_DEAD &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
> -	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
> -	return BLK_STS_IOERR;
> +
> +	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
> +	blk_mq_start_request(rq);

Might be worth a comment here on why we don't call
nvme_end_request

> +	nvme_complete_rq(rq);
> +	return BLK_STS_OK;
>   }
>   EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
>   

Other than than, looks good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
