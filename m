From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Feb 2016 09:36:52 +0100
Subject: [PATCH 3/3] nvme: replace the kthread with a per-device watchdog
 timer
In-Reply-To: <1455732194-30790-4-git-send-email-hch@lst.de>
References: <1455732194-30790-1-git-send-email-hch@lst.de>
 <1455732194-30790-4-git-send-email-hch@lst.de>
Message-ID: <20160218083651.GP18134@c203.arch.suse.de>

On Wed, Feb 17, 2016@07:03:14PM +0100, Christoph Hellwig wrote:
> The only work left in the kthread is the periodic health check for each
> controller.  There is no need to run this from process context or keep
> a thread context around for it, so replace it with a simpler timer.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
