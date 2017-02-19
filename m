From: hch@lst.de (Christoph Hellwig)
Date: Sun, 19 Feb 2017 20:46:57 +0100
Subject: [PATCH] nvmet-rdma: Fix error handling
In-Reply-To: <20170219190438.19371-1-christophe.jaillet@wanadoo.fr>
References: <20170219190438.19371-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20170219194657.GA6591@lst.de>

On Sun, Feb 19, 2017@08:04:38PM +0100, Christophe JAILLET wrote:
> According to the surrounding goto, it is likely that 'out_destroy_sq' was
> expected here.

s/surrounding/preceeding/ ?

But the patch itself looks good, thanks.

Reviewed-by: Christoph Hellwig <hch at lst.de>
