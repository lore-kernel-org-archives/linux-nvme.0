From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Nov 2015 18:47:23 +0000
Subject: [PATCH 03/12] nvme: factor out a nvme_unmap_data helper
In-Reply-To: <1446885906-20967-4-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-4-git-send-email-hch@lst.de>
Message-ID: <20151109184723.GA5386@localhost.localdomain>

On Sat, Nov 07, 2015@09:44:57AM +0100, Christoph Hellwig wrote:
> This is the counter part to nvme_map_data.  The forward declaration will
> go away later in the series.

Generally, the whole series looks great, but we must be missing one or
more patches here. I don't see the "nvme_map_data" part, which I suspect
is why this patch and others fail to apply using linux-block/for-next.
Once I clear up which patches to apply to which tree, I'd like to run
this through a few test systems to make sure there won't be any surprises.
