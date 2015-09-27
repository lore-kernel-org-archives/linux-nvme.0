From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 26 Sep 2015 23:39:50 -0700
Subject: [PATCH] nvme: Add error checking in nvme_create_io_queues
In-Reply-To: <alpine.LNX.2.00.1509241920360.23840@localhost.lm.intel.com>
References: <1443118811-2153-1-git-send-email-jonathan.derrick@intel.com>
 <alpine.LNX.2.00.1509241920360.23840@localhost.lm.intel.com>
Message-ID: <20150927063950.GA18398@infradead.org>

On Thu, Sep 24, 2015@07:23:27PM +0000, Keith Busch wrote:
> On Thu, 24 Sep 2015, Jon Derrick wrote:
> >allow nvme_create_io_queues to return an error if the first io queue
> >fails to be allocated or initialized
> 
> If the driver gets far enough to attempt creating IO queues, the device
> can be managed so I don't think we want to error out and bail on the
> device in this scenario, even though it is not IO capable.

But it's left in a somewhat odd state, which is the cleaned up via
nvme_dev_resume and the odd and misnamed nvme_remove_disks.

I think nvme_create_io_queues should at least make sure any partial
created I/O queues are properly cleaned up on a failure of
nvme_alloc_queue or nvme_create_queue.

Keith, do you remember why nvme_remove_disks is called through a
workqueue?  I'd much rather do the work in line and in the proper place,
queues should never leave nvme_create_io_queues half-setup, and
namespaces should probably be removed by nvme_dev_start if we don't
have any working I/O queues after a resume or reset.

While we're at it: can we rename nvme_dev_remove to
nvme_remove_namespaces?  Also dev->namespaces seems to lack proper
synchronization.
