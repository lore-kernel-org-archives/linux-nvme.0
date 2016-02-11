From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 11 Feb 2016 13:22:05 +0100
Subject: [PATCH for-4.5 07/13] NVMe: Requeue requests on suspended queues
In-Reply-To: <1455128250-5984-8-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-8-git-send-email-keith.busch@intel.com>
Message-ID: <20160211122205.GG27969@c203.arch.suse.de>

On Wed, Feb 10, 2016@11:17:24AM -0700, Keith Busch wrote:
> It's possible a request may get to the driver after the nvme queue was
> disabled. This has the request requeue if that happens.
> 
> Note the request is still "started" by the driver, but requeuing will
> clear the start state for timeout handling.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
