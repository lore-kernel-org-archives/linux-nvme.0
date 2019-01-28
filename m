From: Martin.George@netapp.com (George, Martin)
Date: Mon, 28 Jan 2019 17:10:59 +0000
Subject: [PATCH] nvme-multipath: relax ANA state check
In-Reply-To: <20190128163036.GB12288@lst.de>
References: <20190128142446.6732-1-marting@netapp.com>
 <20190128163036.GB12288@lst.de>
Message-ID: <c1d3adb38c86382d67750748c5f7efbc1a1542e3.camel@netapp.com>

On Mon, 2019-01-28@17:30 +0100, Christoph Hellwig wrote:
> 
> On Mon, Jan 28, 2019 at 07:54:46PM +0530, martinus.gpy at gmail.com
> wrote:
> > From: Martin George <marting at netapp.com>
> > 
> > Always call nvme_mpath_set_live() when transitioning to a live
> > state, where live is defined as ANA Optimized or Non-Optimized,
> > irrespective of what the previous asymmetric access state was.
> > This removes the restriction of only permitting transitions
> > from states that were not considered live.
> 
> This still doesn't make sense.  We never prohibit a transition here.
> 
> What kind of problem do you see that triggered this patch?

We saw I/O successfully resume on a namespace that transitioned from
Inaccessible to Optimized on the ANA host. No issues there. But at the
same time, I/O hung when it transitioned from Optimized to Optimized
itself.

After applying the above patch, this problem was resolved and I/O
successfully resumed for this same state Optimized to Optimized
transition scenario. In fact with the above patch, it should also
permit I/O to successfully resume for Optimized to Non-Optimized
scenarios (& vice versa) as well, all of which are valid transition
scenarios as per the NVMe 1.3 TP4004 ANA spec.

-Martin George
