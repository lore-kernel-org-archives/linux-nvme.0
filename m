From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 16:59:10 +0200
Subject: [PATCH 01/23] pd: don't check blk_execute_rq return value.
In-Reply-To: <20170420140316.6546-2-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-2-hch@lst.de>
Message-ID: <20170420145910.GI13676@linux-x5ow.site>

On Thu, Apr 20, 2017@04:02:54PM +0200, Christoph Hellwig wrote:
> The driver never sets req->errors, so blk_execute_rq will always return 0.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
