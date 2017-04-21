From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 21 Apr 2017 10:56:22 +0200
Subject: [PATCH 5/7] nvmet/fc: mark the sqhd field as __le16
In-Reply-To: <20170421085005.5945-6-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
 <20170421085005.5945-6-hch@lst.de>
Message-ID: <20170421085622.GI26346@linux-x5ow.site>

On Fri, Apr 21, 2017@10:50:03AM +0200, Christoph Hellwig wrote:
> That's what it's used as.
> 
> Found by sparse.
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
