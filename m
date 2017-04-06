From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 6 Apr 2017 20:50:53 +0200
Subject: [PATCH 03/25] nvme-fc: fix status code handling in
 nvme_fc_fcpio_done
In-Reply-To: <20170406153944.10058-4-hch@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-4-hch@lst.de>
Message-ID: <20170406185053.GC8673@linux-x5ow.site>

On Thu, Apr 06, 2017@05:39:22PM +0200, Christoph Hellwig wrote:
> nvme_complete_async_event expects the little endian status code
> including the phase bit, and a new completion handler I plan to
> introduce will do so as well.
> 
> Change the status variable into the little endian format with the
> phase bit used in the NVMe CQE to fix / enable this.
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
