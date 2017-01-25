From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 25 Jan 2017 09:58:03 +0100
Subject: [PATCH] nvme-fc: use blk_rq_nr_phys_segments
In-Reply-To: <1484841357-17539-1-git-send-email-hch@lst.de>
References: <1484841357-17539-1-git-send-email-hch@lst.de>
Message-ID: <20170125085803.GB3568@linux-x5ow.site>

On Thu, Jan 19, 2017@04:55:57PM +0100, Christoph Hellwig wrote:
> Without this deallocate won't work properly due to the mismatch
> of the bio/request size and the actual payload size.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

Might be worth adding a:
Fixes: f9d03f96b ('block: improve handling of the magic discard payload')
as well.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
