From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 19 Jun 2017 13:44:44 +0200
Subject: [PATCH 2/6] nvme: read the subsystem NQN from Identify Controller
In-Reply-To: <20170619095754.4602-3-hch@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-3-hch@lst.de>
Message-ID: <20170619114444.GF19417@linux-x5ow.site>

On Mon, Jun 19, 2017@11:57:50AM +0200, Christoph Hellwig wrote:
> NVMe 1.2.1 or later requires controllers to provide a subsystem NQN in the
> Identify controller data structures.  Use this NQN for the subsysnqn
> sysfs attribute by storing it in the nvme_ctrl structure after verifying
> it.  For older controllers we generate a "fake" NQN per non-normative
> text in the NVMe 1.3 spec.
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
