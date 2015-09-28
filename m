From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Sep 2015 13:50:23 +0000 (UTC)
Subject: [PATCH] nvme: Add error checking in nvme_create_io_queues
In-Reply-To: <20150927063950.GA18398@infradead.org>
References: <1443118811-2153-1-git-send-email-jonathan.derrick@intel.com>
 <alpine.LNX.2.00.1509241920360.23840@localhost.lm.intel.com>
 <20150927063950.GA18398@infradead.org>
Message-ID: <alpine.LNX.2.00.1509281345370.23840@localhost.lm.intel.com>

On Sat, 26 Sep 2015, Christoph Hellwig wrote:
> Keith, do you remember why nvme_remove_disks is called through a
> workqueue?  I'd much rather do the work in line and in the proper place,
> queues should never leave nvme_create_io_queues half-setup, and
> namespaces should probably be removed by nvme_dev_start if we don't
> have any working I/O queues after a resume or reset.

A resume from S3/S4 will deadlock if we try to delete inaccessible
disks from the resume context, so using the work queue instead. There
is probably a better way to do this now that we probe asynchronously,
we can resume the same way.
