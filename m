From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 6 Apr 2017 20:55:42 +0200
Subject: [PATCH 07/25] virtio_blk: don't use req->errors
In-Reply-To: <20170406153944.10058-8-hch@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-8-hch@lst.de>
Message-ID: <20170406185541.GE8673@linux-x5ow.site>

On Thu, Apr 06, 2017@05:39:26PM +0200, Christoph Hellwig wrote:
> Remove passing req->errors (which at that point is always 0) to
> blk_mq_complete_requestq, and rely on the virtio status code for the
blk_mq_complete_request ^

> serial number passthrough request.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---

Otherwise looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
