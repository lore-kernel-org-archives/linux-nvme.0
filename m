From: hch@lst.de (Christoph Hellwig)
Date: Tue, 1 Mar 2016 09:49:38 +0100
Subject: [PATCH 2/4] nvme: don't poll the CQ from the kthread
In-Reply-To: <20160229205607.GC3730@linux.intel.com>
References: <1456757987-7244-1-git-send-email-hch@lst.de>
 <1456757987-7244-3-git-send-email-hch@lst.de>
 <20160229205607.GC3730@linux.intel.com>
Message-ID: <20160301084938.GA1748@lst.de>

On Mon, Feb 29, 2016@03:56:07PM -0500, Matthew Wilcox wrote:
> On Mon, Feb 29, 2016@03:59:45PM +0100, Christoph Hellwig wrote:
> > There is no reason to do unconditional polling of CQs per the NVMe
> > spec.
> 
> Sure, per the spec there isn't.  But in reality, devices ship with
> broken interrupt support.  What's your plan for dealing with the bug
> reports from users who have misconfigured MSI support or IRQ lines that
> are routed to the wrong place?  From my time maintaining SCSI drivers,
> this wasn't an uncommon bug report.

The same as for all other devices that have drivers without a dedicated
once per second polling loop?  That is: fix the irq routing if possible
and find a specific workaround if really needed and required by
a blacklist instead of papering over it just in case.
