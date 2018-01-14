From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 11:49:17 +0200
Subject: [PATCH V3 2/2] nvme-pci: fix the timeout case when reset is
 ongoing
In-Reply-To: <1515647268-1717-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1515647268-1717-1-git-send-email-jianchao.w.wang@oracle.com>
 <1515647268-1717-3-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <33e5eb7d-b731-5f13-1cdf-faf3be508c93@grimberg.me>

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e477c35..0530432 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1212,19 +1212,26 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   	}
>   
>   	/*
> -	 * Shutdown immediately if controller times out while starting. The
> -	 * reset work will see the pci device disabled when it gets the forced
> -	 * cancellation error. All outstanding requests are completed on
> -	 * shutdown, so we return BLK_EH_HANDLED.
> +	 * There could be two kinds of expired reqs when reset is ongoing.
> +	 *  - Outstanding IO or admin requests from previous work before the
> +	 *    nvme_reset_work invokes nvme_dev_disable. Handle them as the
> +	 *    nvme_cancel_request.
> +	 *  - Outstanding admin requests from the initializing procedure.
> +	 *    Set NVME_REQ_CANCELLED flag on them, then nvme_reset_work will
> +	 *    see the error, then disable the device and remove the ctrl.
>   	 */
> -	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
> -		dev_warn(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, disable controller\n",
> -			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, false);
> +	switch (dev->ctrl.state) {
> +	case NVME_CTRL_RESET_PREPARE:
> +		nvme_req(req)->status = NVME_SC_ABORT_REQ;
> +		return BLK_EH_HANDLED;
> +	case NVME_CTRL_RESETTING:
> +		WARN_ON_ONCE(nvmeq->qid);
>   		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>   		return BLK_EH_HANDLED;
> +	default:
> +		break;
>   	}
> +

Indentation is off...
