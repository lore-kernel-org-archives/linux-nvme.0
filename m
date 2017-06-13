From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 13 Jun 2017 09:39:51 +0200
Subject: [PATCH] nvme: mark shutdown_timeout static
In-Reply-To: <20170612163051.21795-1-hch@lst.de>
References: <20170612163051.21795-1-hch@lst.de>
Message-ID: <dd103108-2311-552e-e71f-d9dfb9bd6046@suse.de>

On 06/12/2017 06:30 PM, Christoph Hellwig wrote:
> And open code the SHUTDOWN_TIMEOUT macro.
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
