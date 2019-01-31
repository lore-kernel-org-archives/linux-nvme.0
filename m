From: hch@lst.de (hch@lst.de)
Date: Thu, 31 Jan 2019 11:03:46 +0100
Subject: [PATCH] nvme-multipath: relax ANA state check
In-Reply-To: <c1d3adb38c86382d67750748c5f7efbc1a1542e3.camel@netapp.com>
References: <20190128142446.6732-1-marting@netapp.com>
 <20190128163036.GB12288@lst.de>
 <c1d3adb38c86382d67750748c5f7efbc1a1542e3.camel@netapp.com>
Message-ID: <20190131100346.GA28781@lst.de>

On Mon, Jan 28, 2019@05:10:59PM +0000, George, Martin wrote:
> On Mon, 2019-01-28@17:30 +0100, Christoph Hellwig wrote:
> > 
> > On Mon, Jan 28, 2019 at 07:54:46PM +0530, martinus.gpy at gmail.com
> > wrote:
> > > From: Martin George <marting at netapp.com>
> > > 
> > > Always call nvme_mpath_set_live() when transitioning to a live
> > > state, where live is defined as ANA Optimized or Non-Optimized,
> > > irrespective of what the previous asymmetric access state was.
> > > This removes the restriction of only permitting transitions
> > > from states that were not considered live.
> > 
> > This still doesn't make sense.  We never prohibit a transition here.
> > 
> > What kind of problem do you see that triggered this patch?
> 
> We saw I/O successfully resume on a namespace that transitioned from
> Inaccessible to Optimized on the ANA host. No issues there. But at the
> same time, I/O hung when it transitioned from Optimized to Optimized
> itself.

Well, I/O should haver never stopped in that case.  Can you please
try to help debugging why it even stopped?
> 
> After applying the above patch, this problem was resolved and I/O
> successfully resumed for this same state Optimized to Optimized
> transition scenario. In fact with the above patch, it should also
> permit I/O to successfully resume for Optimized to Non-Optimized
> scenarios (& vice versa) as well, all of which are valid transition
> scenarios as per the NVMe 1.3 TP4004 ANA spec.

Again, there is nothing in the code that prohibits transitions, so this
explanation doesn't make sense.  It it obvious that you saw a problem
and that we have an issue somewhere.  But the patch description is plain
wrong, and I suspect that the problem might be elsewhere as well.
