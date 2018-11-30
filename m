From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Nov 2018 07:45:06 -0700
Subject: [PATCH 07/13] nvme-pci: don't poll from irq context when
 deleting queues
In-Reply-To: <20181130080809.GC18936@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-8-hch@lst.de>
 <20181129203632.GE9377@localhost.localdomain>
 <20181130080809.GC18936@lst.de>
Message-ID: <20181130144506.GI9377@localhost.localdomain>

On Fri, Nov 30, 2018@12:08:09AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018@01:36:32PM -0700, Keith Busch wrote:
> > On Thu, Nov 29, 2018@08:13:04PM +0100, Christoph Hellwig wrote:
> > > +
> > > +		/* handle any remaining CQEs */
> > > +		if (opcode == nvme_admin_delete_cq &&
> > > +		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
> > > +			nvme_poll_irqdisable(nvmeq, -1);
> > 
> > We're dispatchig lots of queue deletions in parallel, and they may
> > complete in any order. I don't see how you can guarantee that the
> > wait_for_completion() will return for the nvmeq that you're polling.
> 
> True.  I thought about moving the completion to the queue so that
> we have one completion per queue, and I should have done that after
> all.  Note sure how I got the idea that not doing it is fine.

You may also move the completion polling in its own loop outside the
deletion loop.
