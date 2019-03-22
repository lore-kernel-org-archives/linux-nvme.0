From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 22 Mar 2019 14:06:43 +0100
Subject: [PATCH 03/15] block: add a rq_dma_dir helper
In-Reply-To: <20190321231037.25104-4-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-4-hch@lst.de>
Message-ID: <80ffa084-e1fb-4c5c-da92-7d9486084cb6@suse.de>

On 22/03/2019 00:10, Christoph Hellwig wrote:
> In a lot of places we want to know the DMA direction for a given
> struct request.  Add a little helper to make it a littler easier.

You introuduce the helper here but you're using it in 8/15 for the 1st time.

Could you convert the possible users to use the new helper in this patch
as well?



-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
