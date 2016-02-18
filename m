From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Feb 2016 10:42:36 +0100
Subject: [PATCH-4.5-v3 4/5] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <1455734215-20396-5-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-5-git-send-email-keith.busch@intel.com>
Message-ID: <20160218094236.GT18134@c203.arch.suse.de>

On Wed, Feb 17, 2016@11:36:54AM -0700, Keith Busch wrote:
> This moves failed queue handling out of the namespace removal path and
> into the reset failure path, fixing a hanging condition if the controller
> fails or link down during del_gendisk. Previously the driver had to see
> the controller as degraded prior to calling del_gendisk to setup the
> queues to fail. If the controller happened to fail after this though,
> there was no task to end the request_queue.
> 
> On failure, all namespace states are set to dead. This has capacity
> revalidate to 0, and ends all new requests with error status.
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
