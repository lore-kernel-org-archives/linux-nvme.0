From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Fri, 21 Nov 2014 17:36:12 +0000
Subject: [PATCH] NVMe: Reduce divide operations
In-Reply-To: <alpine.LNX.2.00.1411202312020.4225@localhost.lm.intel.com>
References: <546E6784.6000609@micron.com>
 <alpine.LNX.2.00.1411202312020.4225@localhost.lm.intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9945CE623@NTXBOIMBX02.micron.com>



> > Patch is against Jens' for-3.19/drivers branch.
> >
> > Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
> > ---
> > diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> > index 9310fe5..a5e2ebc 100644
> > --- a/drivers/block/nvme-core.c
> > +++ b/drivers/block/nvme-core.c
> > @@ -360,8 +360,14 @@ static __le64 **iod_list(struct nvme_iod *iod)
> > */ static int nvme_npages(unsigned size, struct nvme_dev *dev) {
> > -	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev-
> >page_size);
> > -	return DIV_ROUND_UP(8 * nprps, dev->page_size - 8);
> > +	unsigned page_size = (1 << dev->page_shift);
> > +	unsigned nprps = (size >> dev->page_shift) + 1;
> > +
> > +	if (size & (page_size - 1))
> > +		nprps++;
> > +	if ((nprps << 3) < (page_size - 8))
> > +		return 1;
> 
> You actually don't need to subtract 8 here. That's for reserving a
> place for chaining a PRP list, but we don't need to reserve a place if
> all the entries fit in page.

Yes, you're right.  Missed that.

> > +	return DIV_ROUND_UP(nprps << 3, page_size - 8);
> 
> Can we get rid of this divide too?!

I was thinking of another comparison for ((nprps << 3) < (page_size * 2)) 
would eliminate the div for 99% of IO sizes.  I see Matthew already had 
the same thought.
