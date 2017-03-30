From: hch@lst.de (Christoph Hellwig)
Date: Thu, 30 Mar 2017 10:36:09 +0200
Subject: [RFC PATCH] nvme: Submit uevents for log page notification
In-Reply-To: <1490388582-10237-1-git-send-email-keith.busch@intel.com>
References: <1490388582-10237-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170330083609.GD11540@lst.de>

The uevent itself looks fine to me, but we really need to figure out
how we can clear log pages in kernel space where needed.

We should already be doing this for the namespace changed one, and
it will be very important at least for ANA as well.


A few more mechanical code comments below:


> +void nvme_uevent_work(struct nvme_ctrl *ctrl, int log)

static?

>  {
>  	u32 result = le32_to_cpu(res->u32);
> +	u8 log_page = (result >> 16) & 8;
> +	u8 event_type = result & 7;
>  	bool done = true;
>  
>  	switch (le16_to_cpu(status) >> 1) {
> @@ -2173,7 +2202,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		/*FALLTHRU*/
>  	case NVME_SC_ABORT_REQ:
>  		++ctrl->event_limit;
> -		schedule_work(&ctrl->async_event_work);

This seems to disable any action on AERs in the kernel..

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 9690beb..3930a12 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1936,6 +1936,8 @@ nvme_fc_complete_rq(struct request *rq)
>  			nvme_requeue_req(rq);
>  			return;
>  		}
> +		if (req->errors & NVME_SC_MORE)
> +			nvme_uevent(&dev->ctrl, NVME_LOG_ERROR);
>  
>  		if (blk_rq_is_passthrough(rq))
>  			error = rq->errors;

We'll really need to factor the common request completion code
into a helper in common code first..

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index c43d435..e711de6 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -16,6 +16,7 @@
>  #define _LINUX_NVME_H
>  
>  #include <linux/types.h>
> +#include <linux/kfifo.h>

This should move to drivers/nvme/host/nvme.h instead.
