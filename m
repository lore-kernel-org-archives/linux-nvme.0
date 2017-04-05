From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Apr 2017 16:45:56 +0200
Subject: [PATCH 4/5] nvme: move the retries count to struct nvme_request
In-Reply-To: <20170405141856.1862-5-hch@lst.de>
References: <20170405141856.1862-1-hch@lst.de>
 <20170405141856.1862-5-hch@lst.de>
Message-ID: <20170405144556.GQ3941@linux-x5ow.site>

On Wed, Apr 05, 2017@04:18:55PM +0200, Christoph Hellwig wrote:
> The way NVMe uses this field is entirely different from the older
> SCSI/BLOCK_PC usage, so move it into struct nvme_request.
> 
> Also reduce the size of the file to a unsigned char so that we leave space
> for additional smaller fields that will appear soon.
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
