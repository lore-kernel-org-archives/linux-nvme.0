From: keith.busch@intel.com (Keith Busch)
Date: Mon, 30 Nov 2015 21:42:10 +0000
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151130084718.GA12727@infradead.org>
References: <20151125085537.GA19066@infradead.org>
 <20151125160544.GA2587@localhost.localdomain>
 <20151125164257.GB4321@infradead.org>
 <20151125165703.GC2587@localhost.localdomain>
 <20151125170842.GA29291@infradead.org>
 <20151125172845.GD2587@localhost.localdomain>
 <20151125175512.GA23638@infradead.org>
 <20151125182439.GE2587@localhost.localdomain>
 <20151125193851.GA16415@infradead.org>
 <20151130084718.GA12727@infradead.org>
Message-ID: <20151130214209.GB25958@localhost.localdomain>

On Mon, Nov 30, 2015@12:47:18AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 25, 2015@11:38:51AM -0800, Christoph Hellwig wrote:
> > I'll give this a spin the next day.  I assume you and Jns will be out
> > for a long weekend starting tomorrow, so I should have a new series
> > ready for review.  I'll fold a modified version of your patch in, as I
> > think we should get this right from the start.
> 
> Can you review the code in
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-req.11
> and see if this fits your intention?

Looking good so far, passing all tests.

For something new not related to this work, I was recently copied on an
issue and wanted to check with you for your opinion on how to fix.

We probe in a workqueue to improve startup time, but not blocking probe
messes up some user space software looking for expected mount
points. I was comparing how SCSI works, and it looks like it relies on
async_schedule and wait_for_device_probe.

We didn't use async_shedule in nvme because nvme_remove can't synchronize
its own work. It doesn't look like much trouble to make "remove" not require
flushing startup, so I'm thinking we can just remove all the work queues
and just use the async API instead. Does that sound reasonable, or any
other ideas?
 
> I've only sent out the hopefully uncontroversial first part for now
> to limit the amount of patch traffic on the list.
