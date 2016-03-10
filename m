From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 10 Mar 2016 10:06:46 +0100
Subject: [PATCH 4/4] NVMe: don't allocate unused nvme_major
In-Reply-To: <20160309215928.20904.24799.stgit@noble>
References: <20160309215702.20904.61407.stgit@noble>
 <20160309215928.20904.24799.stgit@noble>
Message-ID: <20160310090646.GQ3464@c203.arch.suse.de>

On Thu, Mar 10, 2016@08:59:28AM +1100, NeilBrown wrote:
> When alloc_disk(0) is used, the ->major number is ignored.  All device
> numbers are allocated with a major of BLOCK_EXT_MAJOR.
> 
> So remove all references to nvme_major.
> 
> Signed-off-by: NeilBrown <neilb at suse.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
