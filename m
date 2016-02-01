From: keith.busch@intel.com (Busch, Keith)
Date: Mon, 1 Feb 2016 15:27:24 +0000
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <BJXPR01MB199DDC40C3949335FD70DEBE0DE0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <BJXPR01MB199DDC40C3949335FD70DEBE0DE0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D3D7E4F@fmsmsx104.amr.corp.intel.com>

> Subject: RE: [PATCH 1/2] NVMe: Make surprise removal work again
> 
> >		blk_mq_abort_requeue_list(ns->queue);
> >+		__nvme_start_queue_locked(ns);
> 
> Why is the queue stopped? Is it due to unsuccessful device reset (since device is hot removed)?

It could be from an unsuccessful reset if that's the path we took. We also could go straight to the removal case if the pci hotplug driver notifies the driver, in which case this patch will disables the controller first to halt new IO and reap outstanding requests. This also stops queues, so needed to restart it to flush out the pending requests.

Anyway, the direction I was given was to move the request ending to the block layer when we kill it, so this won't be necessary in the next revision (will be sent out today).
