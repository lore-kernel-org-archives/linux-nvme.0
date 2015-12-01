From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 1 Dec 2015 04:36:22 -0800
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151130214209.GB25958@localhost.localdomain>
References: <20151125160544.GA2587@localhost.localdomain>
 <20151125164257.GB4321@infradead.org>
 <20151125165703.GC2587@localhost.localdomain>
 <20151125170842.GA29291@infradead.org>
 <20151125172845.GD2587@localhost.localdomain>
 <20151125175512.GA23638@infradead.org>
 <20151125182439.GE2587@localhost.localdomain>
 <20151125193851.GA16415@infradead.org>
 <20151130084718.GA12727@infradead.org>
 <20151130214209.GB25958@localhost.localdomain>
Message-ID: <20151201123622.GA6370@infradead.org>

On Mon, Nov 30, 2015@09:42:10PM +0000, Keith Busch wrote:
> > Can you review the code in
> > http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-req.11
> > and see if this fits your intention?
> 
> Looking good so far, passing all tests.

Thanks.  I'll send it out once I got your Ack and Jens has picked up
the currently posted batch.

> For something new not related to this work, I was recently copied on an
> issue and wanted to check with you for your opinion on how to fix.
> 
> We probe in a workqueue to improve startup time, but not blocking probe
> messes up some user space software looking for expected mount
> points. I was comparing how SCSI works, and it looks like it relies on
> async_schedule and wait_for_device_probe.
> 
> We didn't use async_shedule in nvme because nvme_remove can't synchronize
> its own work. It doesn't look like much trouble to make "remove" not require
> flushing startup, so I'm thinking we can just remove all the work queues
> and just use the async API instead. Does that sound reasonable, or any
> other ideas?

The async mechnisms are a huge nightmare in SCSI and I would strongly
suggest not to introduce any new users.  Code mounting file systems
must wait for the device node to appear and not rely on the modprobe
return anyway.
