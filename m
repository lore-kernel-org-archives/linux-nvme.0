From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Jun 2017 16:00:26 -0400
Subject: [PATCH] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170601140629.15313-2-hch@lst.de>
References: <20170601140629.15313-1-hch@lst.de>
 <20170601140629.15313-2-hch@lst.de>
Message-ID: <20170601200026.GA3487@localhost.localdomain>

On Thu, Jun 01, 2017@04:06:29PM +0200, Christoph Hellwig wrote:
> index a60926410438..0935dc08f46e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -161,7 +161,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  			break;
>  		}
>  		break;
> -	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_SCHED_RESET:
>  		switch (old_state) {
>  		case NVME_CTRL_NEW:
>  		case NVME_CTRL_LIVE:
> @@ -172,6 +172,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  			break;
>  		}
>  		break;
> +	case NVME_CTRL_RESETTING:
> +		switch (old_state) {
> +		case NVME_CTRL_SCHED_RESET:
> +			changed = true;
> +			/* FALLTHRU */
> +		default:
> +			break;
> +		}
> +		break;
>  	case NVME_CTRL_RECONNECTING:
>  		switch (old_state) {
>  		case NVME_CTRL_LIVE:

We also need to add the new NVME_SCHED_RESET state as a valid old_state
transition to NVME_CTRL_DELETING.

> @@ -2009,8 +2014,8 @@ static int nvme_reset(struct nvme_dev *dev)
>  {
>  	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
>  		return -ENODEV;
> -	if (work_busy(&dev->reset_work))
> -		return -ENODEV;
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_SCHED_RESET))
> +		return -EBUSY;
>  	if (!queue_work(nvme_workq, &dev->reset_work))
>  		return -EBUSY;
>  	return 0;

Just going through a hypothetical scenario: let's say a user requests
an orderly removal of a device through sysfs. The the controller happens
to fail after del_gendisk is called, and commands timeout, triggering a
reset.

Today, the reset work will consider the controller dead and kill the
nvme queues to force all new IO to fail immediately.

With this change, the reset work won't get to run, so nothing will get
to kill the queues. The driver will be stuck at del_gendisk.

Something like the following will fix that for pci:

---
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -993,7 +993,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
-		nvme_reset(dev);
+		if (nvme_reset(dev) != 0) {
+			if (nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD))
+				nvme_kill_queues(&dev->ctrl);
+		}
 
 		/*
 		 * Mark the request as handled, since the inline shutdown
--
