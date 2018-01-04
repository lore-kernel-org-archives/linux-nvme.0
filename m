From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Jan 2018 11:20:33 +0100
Subject: [PATCH V2] nvme-pci: fix NULL pointer reference in nvme_alloc_ns
In-Reply-To: <1515112799-1678-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1515112799-1678-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180104102033.GA4834@lst.de>

This looks generally fine to me, ut a few nitpicks below:

>  - Based on Sagi's suggestion, add new state NVME_CTRL_ADMIN_LIVE.

Maybe call this NVME_CTRL_ADMIN_ONLY ?

> -	if (ctrl->state != NVME_CTRL_LIVE)
> +	if ((ctrl->state != NVME_CTRL_LIVE) &&
> +		(ctrl->state != NVME_CTRL_ADMIN_LIVE))

No need for the inner braces, and odd indentation.  Also in general
I'm tempted to just use switch statements for things like this, e.g.

	switch (ctrl->state) {
	case NVME_CTRL_ADMIN_LIVE:
	case NVME_CTRL_LIVE:
		break;
	default:
		return -EWOULDBLOCK;
	}

> @@ -3074,6 +3087,8 @@ static void nvme_scan_work(struct work_struct *work)
>  	if (ctrl->state != NVME_CTRL_LIVE)
>  		return;
>  
> +	BUG_ON(!ctrl->tagset);

WARN_ON_ONCE() please.

> +	bool only_adminq = false;

How about a new_state variable instead that holds the new state value?
