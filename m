From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Oct 2016 15:47:25 +0200
Subject: [PATCH rfc 6/6] nvme-pci: Get rid of threaded interrupts
In-Reply-To: <1475660534-16681-7-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-7-git-send-email-sagi@grimberg.me>
Message-ID: <20161005134725.2llhwa3fkmj6ghld@linux-x5ow.site>

On Wed, Oct 05, 2016@12:42:14PM +0300, Sagi Grimberg wrote:
> Now that we use irq-poll and will never call bio_endio
> from hard irq context we don't need it.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
