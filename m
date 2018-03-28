From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Mar 2018 10:07:06 +0200
Subject: [PATCH] nvme: unexport nvme_start_keep_alive
In-Reply-To: <20180326084015.9269-1-jthumshirn@suse.de>
References: <20180326084015.9269-1-jthumshirn@suse.de>
Message-ID: <20180328080706.GC20373@lst.de>

On Mon, Mar 26, 2018@10:40:15AM +0200, Johannes Thumshirn wrote:
> nvme_start_keep_alive() isn't used outside core.c so unexport it and
> make it static.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
