From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 19 Jun 2017 13:47:10 +0200
Subject: [PATCH 5/6] nvme: track subsystems
In-Reply-To: <20170619095754.4602-6-hch@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-6-hch@lst.de>
Message-ID: <20170619114710.GG19417@linux-x5ow.site>

On Mon, Jun 19, 2017@11:57:53AM +0200, Christoph Hellwig wrote:
> This adds a new nvme_subsystem structure so that we can track multiple
> controllers that belong to a single subsystem.  For now we only use it
> to store the NQN, and to check that we don't have duplicate NQNs unless
> the involved subsystems support multiple controllers.
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
