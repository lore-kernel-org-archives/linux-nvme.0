From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 28 Mar 2019 11:26:43 +0100
Subject: [PATCH 03/15] block: add a rq_dma_dir helper
In-Reply-To: <20190327142049.GC26200@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-4-hch@lst.de>
 <80ffa084-e1fb-4c5c-da92-7d9486084cb6@suse.de>
 <20190327142049.GC26200@lst.de>
Message-ID: <b694b0e4-4c93-16d8-01c3-c6a75a0998f0@suse.de>

On 27/03/2019 15:20, Christoph Hellwig wrote:
[...]
> 
> I'd rather not throw that into a nvme series.  Those are easily cleanups
> for later.  Maybe we can even encourage people that would otherwise
> do whitespace cleanups or incorrect refcount_t conversions to take care
> of it :)

Fair enough.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
