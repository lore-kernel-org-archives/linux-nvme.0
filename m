From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 21 Apr 2017 10:55:58 +0200
Subject: [PATCH 4/7] nvmet/fc: fix endianess annoations for
 nvmet_fc_format_rsp_hdr
In-Reply-To: <20170421085005.5945-5-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
 <20170421085005.5945-5-hch@lst.de>
Message-ID: <20170421085558.GH26346@linux-x5ow.site>

On Fri, Apr 21, 2017@10:50:02AM +0200, Christoph Hellwig wrote:
> The passed in desc_len is a big endian value, so mark it as such.
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
