From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 4 Feb 2016 17:55:05 +0200
Subject: [PATCH 0/4] NVMe: Surprise removal fixes
In-Reply-To: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
Message-ID: <56B37459.3080602@dev.mellanox.co.il>

Hi Keith,

> Earlier feedback suggested this functionality be in the block layer. I
> don't have the devices to test what happens with other drivers, and
> the desired sequence seems unique to NVMe.

Umm, it actually isn't. I think this is what all the block drivers
want.

> Maybe that's an indication
> that the driver's flow could benefit from some redesign, or maybe it's
> an artifact from having the controller and storage being the same device.
>
> In any case, I would like to isolate this fix to the NVMe driver in
> the interest of time, and flush out the block layer before the next
> merge window.

I'm fine with that. But we definitely want to avoid the queue_rq
conditional in the long run...
