From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 8 May 2018 09:15:56 +0200
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <20180507225558.5009-1-jsmart2021@gmail.com>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
Message-ID: <20180508071556.455kfgioocke47ju@linux-x5ow.site>

On Mon, May 07, 2018@03:55:58PM -0700, James Smart wrote:
> Rather than allow ioctl-based admin cmds to get intermixed on the admin
> queue with commands being used to initialize a controller or io commands
> to go to a controller in reconnect thus possibly hanging, reject them
> if the controller isn't in the LIVE state. Reject with an -EAGAIN status
> so that the app knows it could retry.

Shouldn't the nvmf_check_if_read() calls in the transport drivers'
->queue_rq() callouts handle this?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
