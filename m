From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 17 May 2016 09:36:22 +0200
Subject: [PATCH] NVMe: Allocate queues only for online cpus
In-Reply-To: <1463162991-31653-1-git-send-email-keith.busch@intel.com>
References: <1463162991-31653-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160517073622.GF17154@c203.arch.suse.de>

On Fri, May 13, 2016@12:09:51PM -0600, Keith Busch wrote:
> The driver previously requested allocating queues for the total possible
> number of CPUs so that blk-mq could rebalance these if CPUs were added
> after initialization. The number of hardware contexts can now be changed
> at runtime, so we only need to allocate the number of online queues
> since we can add more later.
> 
> Suggested-by: Jeff Lien <jeff.lien at hgst.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
