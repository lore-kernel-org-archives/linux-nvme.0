From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 11 May 2018 07:13:54 +0200
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <71188ad3-d815-d24f-2af7-11036806d847@gmail.com>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
 <20180508071556.455kfgioocke47ju@linux-x5ow.site>
 <71188ad3-d815-d24f-2af7-11036806d847@gmail.com>
Message-ID: <20180511051354.kraedlqcoyitwtts@linux-x5ow.site>

On Wed, May 09, 2018@04:20:19PM -0700, James Smart wrote:
> yes - but if things reach that layer, the return status for the ioctl can be
> quite different.  (if I read things right) The core routines are coded so
> that if there's a hard error, a -Exxx status will be returned. Otherwise, it
> returns the nvme_req(req)->status value (assumed positive big value). Which
> means, if the if_ready checks reject it, it'll go back with an
> NVME_SC_ABORT_REQ status. Which means the cli gets a convoluted error
> response. For the cases where it would be blocked by controller state, I
> want an -EAGAIN status so that the app knows it can retry and it should
> succeed sometime in the future.  Any other status - the app gives up and
> accepts the status value.

Ah OK, thanks for the clarification.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
