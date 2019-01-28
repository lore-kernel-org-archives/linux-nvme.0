From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 Jan 2019 17:30:36 +0100
Subject: [PATCH] nvme-multipath: relax ANA state check
In-Reply-To: <20190128142446.6732-1-marting@netapp.com>
References: <20190128142446.6732-1-marting@netapp.com>
Message-ID: <20190128163036.GB12288@lst.de>

On Mon, Jan 28, 2019@07:54:46PM +0530, martinus.gpy@gmail.com wrote:
> From: Martin George <marting at netapp.com>
> 
> Always call nvme_mpath_set_live() when transitioning to a live
> state, where live is defined as ANA Optimized or Non-Optimized,
> irrespective of what the previous asymmetric access state was.
> This removes the restriction of only permitting transitions
> from states that were not considered live.

This still doesn't make sense.  We never prohibit a transition here.

What kind of problem do you see that triggered this patch?
