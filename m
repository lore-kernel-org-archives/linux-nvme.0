From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Apr 2017 16:46:56 +0200
Subject: [PATCH 5/5] block, scsi: move the retries field to struct
 scsi_request
In-Reply-To: <20170405141856.1862-6-hch@lst.de>
References: <20170405141856.1862-1-hch@lst.de>
 <20170405141856.1862-6-hch@lst.de>
Message-ID: <20170405144656.GR3941@linux-x5ow.site>

On Wed, Apr 05, 2017@04:18:56PM +0200, Christoph Hellwig wrote:
> Instead of bloating the generic struct request with it.
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
