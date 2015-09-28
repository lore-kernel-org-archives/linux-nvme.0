From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 28 Sep 2015 07:23:17 -0700
Subject: [PATCH] nvme: Add error checking in nvme_create_io_queues
In-Reply-To: <alpine.LNX.2.00.1509281345370.23840@localhost.lm.intel.com>
References: <1443118811-2153-1-git-send-email-jonathan.derrick@intel.com>
 <alpine.LNX.2.00.1509241920360.23840@localhost.lm.intel.com>
 <20150927063950.GA18398@infradead.org>
 <alpine.LNX.2.00.1509281345370.23840@localhost.lm.intel.com>
Message-ID: <20150928142317.GA29320@infradead.org>

On Mon, Sep 28, 2015@01:50:23PM +0000, Keith Busch wrote:
> On Sat, 26 Sep 2015, Christoph Hellwig wrote:
> >Keith, do you remember why nvme_remove_disks is called through a
> >workqueue?  I'd much rather do the work in line and in the proper place,
> >queues should never leave nvme_create_io_queues half-setup, and
> >namespaces should probably be removed by nvme_dev_start if we don't
> >have any working I/O queues after a resume or reset.
> 
> A resume from S3/S4 will deadlock if we try to delete inaccessible
> disks from the resume context, so using the work queue instead. There
> is probably a better way to do this now that we probe asynchronously,
> we can resume the same way.

Is this still the case with the nvme_io_incapable check in place?  What
are the symptoms?  Unfortunately I can't test PM easily on my test
systems with NVMe cards as they are all remotely managed server class
systems.

Anyway, I have some pending patches for restructuring the reset path
in the NVMe driver and I will keep this in mind, but careful testing
by someone who has PM capable hardware would be really appreciated.
