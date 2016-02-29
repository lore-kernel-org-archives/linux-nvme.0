From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 29 Feb 2016 15:56:07 -0500
Subject: [PATCH 2/4] nvme: don't poll the CQ from the kthread
In-Reply-To: <1456757987-7244-3-git-send-email-hch@lst.de>
References: <1456757987-7244-1-git-send-email-hch@lst.de>
 <1456757987-7244-3-git-send-email-hch@lst.de>
Message-ID: <20160229205607.GC3730@linux.intel.com>

On Mon, Feb 29, 2016@03:59:45PM +0100, Christoph Hellwig wrote:
> There is no reason to do unconditional polling of CQs per the NVMe
> spec.

Sure, per the spec there isn't.  But in reality, devices ship with
broken interrupt support.  What's your plan for dealing with the bug
reports from users who have misconfigured MSI support or IRQ lines that
are routed to the wrong place?  From my time maintaining SCSI drivers,
this wasn't an uncommon bug report.
