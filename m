From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 17:04:21 +0200
Subject: [PATCH 11/23] dm rq: don't pass irrelevant error code to
 blk_mq_complete_request
In-Reply-To: <20170420140316.6546-12-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-12-hch@lst.de>
Message-ID: <20170420150421.GK13676@linux-x5ow.site>

On Thu, Apr 20, 2017@04:03:04PM +0200, Christoph Hellwig wrote:
> dm never uses rq->errors, so there is no need to pass an error argument
> to blk_mq_complete_request.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
