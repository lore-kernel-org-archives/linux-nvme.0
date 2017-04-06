From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 6 Apr 2017 20:38:10 +0200
Subject: [PATCH 02/25] block: remove the blk_execute_rq return value
In-Reply-To: <20170406153944.10058-3-hch@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-3-hch@lst.de>
Message-ID: <20170406183808.GA8673@linux-x5ow.site>

On Thu, Apr 06, 2017@05:39:21PM +0200, Christoph Hellwig wrote:
> The function only returns -EIO if rq->errors is non-zero, which is not
> very useful and lets a large number of callers ignore the return value.
> 
> Just let the callers figure out their error themselves.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
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
