From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 23:56:26 -0800
Subject: [PATCH 2/2] nvme-rdma: Handle completions if error_recovery fails
In-Reply-To: <20181212065501.21580-2-nitzanc@mellanox.com>
References: <20181212065501.21580-1-nitzanc@mellanox.com>
 <20181212065501.21580-2-nitzanc@mellanox.com>
Message-ID: <24f0d05c-b309-a00d-ddd3-f13f0ac74268@grimberg.me>

> Error recovery might not be executed, in case ctrl.state
> cannot be moved to RESETTING state. This might happen in:
>   - state CONNECTING - during nvmf_connect command failure.
>   - state DELETING - during nvmf_set_features command failure
>                      (in nvme_shutdown_ctrl).
> 
> We need to complete these hanging requests with DNR error.

There is quite a lot going on than what you describe. In fact
you don't even describe what you are doing here, just the problem
which is only a part of the story..


> -static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
> +static int nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>   {
> -	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> -		return;
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
> +		if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
> +			return 0;
> +		else
> +			return -EAGAIN;
> +	}
>   
>   	queue_work(nvme_wq, &ctrl->err_work);
> +	return 0;
>   }
>   

> @@ -1679,16 +1725,21 @@ static enum blk_eh_timer_return
>   nvme_rdma_timeout(struct request *rq, bool reserved)
>   {
>   	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_rdma_ctrl *ctrl = req->queue->ctrl;
>   
> -	dev_warn(req->queue->ctrl->ctrl.device,
> +	dev_warn(ctrl->ctrl.device,
>   		 "I/O %d QID %d timeout, reset controller\n",
>   		 rq->tag, nvme_rdma_queue_idx(req->queue));
>   
> -	/* queue error recovery */
> -	nvme_rdma_error_recovery(req->queue->ctrl);
> -
> -	/* fail with DNR on cmd timeout */
> -	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
> +	/*
> +	 * if error recovery succeed it will end the request,
> +	 * otherwise we have to manually end it
> +	 */
> +	if (nvme_rdma_error_recovery(ctrl)) {
> +		req->status = cpu_to_le16((NVME_SC_ABORT_REQ |
> +					   NVME_SC_DNR) << 1);
> +		nvme_end_request(rq, req->status, req->result);
> +	}
>   
>   	return BLK_EH_DONE;
>   }
> 

Can't you live with just the two hunks above? and in the timeout
handler you need to stop the queue before you complete the I/O to
barrier against competing completions.

Also, lets get rid of DNR while we're at it.

I don't see why you need the others... I need further explanation for
that.
