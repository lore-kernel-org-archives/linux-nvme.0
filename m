From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 May 2016 11:11:33 -0400
Subject: [PATCH 1/2] nvme: update nvme_cancel_io() a bit
In-Reply-To: <1463551019-16687-2-git-send-email-mlin@kernel.org>
References: <1463551019-16687-1-git-send-email-mlin@kernel.org>
 <1463551019-16687-2-git-send-email-mlin@kernel.org>
Message-ID: <20160518151133.GE19325@localhost.localdomain>

On Tue, May 17, 2016@10:56:58PM -0700, Ming Lin wrote:
>  static void nvme_cancel_io(struct request *req, void *data, bool reserved)
>  {
> +	struct nvme_ctrl *ctrl = data;
>  	int status;
>  
>  	if (!blk_mq_request_started(req))
>  		return;
>  
> -	dev_dbg_ratelimited(((struct nvme_dev *) data)->ctrl.device,
> -				"Cancelling I/O %d", req->tag);
> +	dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);

Since you're not using ctrl for anything but the debug print, you
should remove declaring it and instead do like what's currently there.
This way the driver doesn't produce an unused variable warning in some
kernel configurations. See commit 7e197930 that fixed this before.

Otherwise, looks fine.
