From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 10 Mar 2016 10:05:13 +0100
Subject: [PATCH 2/4] nvdimm/btt: don't allocate unused major device number
In-Reply-To: <20160309215928.20904.21111.stgit@noble>
References: <20160309215702.20904.61407.stgit@noble>
 <20160309215928.20904.21111.stgit@noble>
Message-ID: <20160310090513.GO3464@c203.arch.suse.de>

On Thu, Mar 10, 2016@08:59:28AM +1100, NeilBrown wrote:
> alloc_disk(0) does not require or use a ->major number,
> all devices are allocated with a major of BLOCK_EXT_MAJOR.
> 
> So don't allocate btt_major.
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
