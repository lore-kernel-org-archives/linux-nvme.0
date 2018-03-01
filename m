From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 1 Mar 2018 23:03:30 +0800
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <20180228164726.GB16536@lst.de>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
Message-ID: <20180301150329.GB6795@ming.t460p>

On Wed, Feb 28, 2018@05:47:26PM +0100, Christoph Hellwig wrote:
> Note that we originally allocates irqs this way, and Keith changed
> it a while ago for good reasons.  So I'd really like to see good
> reasons for moving away from this, and some heuristics to figure
> out which way to use.  E.g. if the device supports more irqs than
> I/O queues your scheme might always be fine.

If all CPUs for the 1st IRQ vector of admin queue are offline, then I
guess NVMe can't work any more.

So looks it is a good idea to make admin queue's IRQ vector assigned as
non-managed IRQs.

Thanks,
Ming
