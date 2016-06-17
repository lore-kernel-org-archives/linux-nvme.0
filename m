From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 17 Jun 2016 13:27:16 +0200
Subject: [PATCH v3 2/6] NVMe: Use pci_(request|release)_mem_regions
In-Reply-To: <5c9932602e6d43ef8ad77856c686765f9e63aa9c.1465200424.git.jthumshirn@suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
 <5c9932602e6d43ef8ad77856c686765f9e63aa9c.1465200424.git.jthumshirn@suse.de>
Message-ID: <20160617112716.74e4hgy5bhkkgmi6@c203.arch.suse.de>

On Tue, Jun 07, 2016@09:44:02AM +0200, Johannes Thumshirn wrote:
> Now that we do have pci_request_mem_regions() and pci_release_mem_regions() at
> hand, use it in the NVMe driver.
> 
> Suggested-by: Christoph Hellwig <hch at infradead.org>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Cc: Christoph Hellwig <hch at infradead.org>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: linux-nvme at lists.infradead.org

Bjorn, 

Jens merged a band aid here which conflicts with the patch. Shall I send you
this patch re-based or the entire series?

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
