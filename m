From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Jan 2018 21:59:45 -0700
Subject: [PATCH V5 2/2] nvme-pci: fixup the timeout case when reset is
 ongoing
In-Reply-To: <1516270202-8051-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
 <1516270202-8051-3-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180119045944.GC12043@localhost.localdomain>

On Thu, Jan 18, 2018@06:10:02PM +0800, Jianchao Wang wrote:
> +	 * - When the ctrl.state is NVME_CTRL_RESETTING, the expired
> +	 *   request should come from the previous work and we handle
> +	 *   it as nvme_cancel_request.
> +	 * - When the ctrl.state is NVME_CTRL_RECONNECTING, the expired
> +	 *   request should come from the initializing procedure such as
> +	 *   setup io queues, because all the previous outstanding
> +	 *   requests should have been cancelled.
>  	 */
> -	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
> -		dev_warn(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, disable controller\n",
> -			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, false);
> +	switch (dev->ctrl.state) {
> +	case NVME_CTRL_RESETTING:
> +		nvme_req(req)->status = NVME_SC_ABORT_REQ;
> +		return BLK_EH_HANDLED;
> +	case NVME_CTRL_RECONNECTING:
> +		WARN_ON_ONCE(nvmeq->qid);
>  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>  		return BLK_EH_HANDLED;
> +	default:
> +		break;
>  	}

The driver may be giving up on the command here, but that doesn't mean
the controller has. We can't just end the request like this because that
will release the memory the controller still owns. We must wait until
after nvme_dev_disable clears bus master because we can't say for sure
the controller isn't going to write to that address right after we end
the request.
