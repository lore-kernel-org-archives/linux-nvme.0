From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 17 May 2018 09:32:52 -0600
Subject: [PATCH] nvme: handle completions outside of the queue lock
In-Reply-To: <20180517152909.GA19042@infradead.org>
References: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>
 <20180517034750.GA22063@localhost.localdomain>
 <20180517071651.GC30079@infradead.org>
 <20180517074732.GA24736@infradead.org>
 <20180517150351.GD22063@localhost.localdomain>
 <20180517152909.GA19042@infradead.org>
Message-ID: <20180517153251.GB23555@localhost.localdomain>

On Thu, May 17, 2018@08:29:09AM -0700, Christoph Hellwig wrote:
> On Thu, May 17, 2018@09:03:52AM -0600, Keith Busch wrote:
> > > +		if (nvme_handle_cqe(nvmeq, start, tag))
> > > +			return 1;
> > 
> > We can't return early from here anymore since the new interface moved
> > the CQ head. No one else is going to get to see those completions, so
> > the first caller owns completing everything up to the end that it claimed.
> 
> Indeed.  So either we have to complete everything, or we have to not
> do the batch processing for the poll case.  Given that when we're
> polling we have a QD approaching one on a given core I suspect not
> batching for the poll case might be the right answer, but someone
> will have to run the numbers.

Maybe the batch can take the tag and stop moving the head when it finds
a match?
