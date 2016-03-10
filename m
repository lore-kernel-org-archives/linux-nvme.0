From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 10 Mar 2016 09:26:12 +0100
Subject: [PATCH] nvme: add a constant for the identify payload size
In-Reply-To: <1457542477-25191-1-git-send-email-hch@lst.de>
References: <1457542477-25191-1-git-send-email-hch@lst.de>
Message-ID: <20160310082612.GH3464@c203.arch.suse.de>

On Wed, Mar 09, 2016@05:54:37PM +0100, Christoph Hellwig wrote:
> The NVMe spec specifies a hardcoded payload length of 4k for all
> types of Identify commands.  Use a constant instead of hardcoded
> values that can be confused for the page size.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
