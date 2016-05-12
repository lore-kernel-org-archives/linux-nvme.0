From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 12 May 2016 00:00:01 -0700
Subject: [PATCH] NVMe: User initiated rescan
In-Reply-To: <1462919010-2569-1-git-send-email-keith.busch@intel.com>
References: <1462919010-2569-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160512070001.GA20802@infradead.org>

Looks fine in general, but a little nitpick below:

> -void nvme_queue_scan(struct nvme_ctrl *ctrl)
> +int nvme_queue_scan(struct nvme_ctrl *ctrl)
>  {
>  	/*
>  	 * Do not queue new scan work when a controller is reset during
>  	 * removal.
>  	 */
>  	if (ctrl->state == NVME_CTRL_LIVE)
> -		schedule_work(&ctrl->scan_work);
> +		return schedule_work(&ctrl->scan_work);
> +	return -EBUSY;

Do we really care about that EBUSY?  If the controller is being
reset it will be rescanned after that reset has completed, and if
it's removed there is no point in the error either.

Also returning schedule_work returns 1 if it successfully queue the
job, and false if it's already queued up, so you'll return something
bogus for the normal case.

I'd suggest to not return an error at all here, but if you really want to
keep the EBUSY we should at least ignore the schedule_work return
value, and write the conditional the natural way around:

	if (ctrl->state != NVME_CTRL_LIVE)
		return -EBUSY;
	schedule_work(&ctrl->scan_work);
	return 0;
