From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 26 Sep 2015 09:11:21 -0700
Subject: [PATCH] Move nvme driver source into subdirectory and move pci
 specifics from core into separate file
In-Reply-To: <CAF1ivSYwe41J+kEuna_VYQvHSLanZzx-qqOOQ3X9EzLWYK_bFQ@mail.gmail.com>
References: <1443130050.6973.125.camel@linux.intel.com>
 <20150925000251.GA25904@infradead.org>
 <CAF1ivSYwe41J+kEuna_VYQvHSLanZzx-qqOOQ3X9EzLWYK_bFQ@mail.gmail.com>
Message-ID: <20150926161121.GB30551@infradead.org>

On Fri, Sep 25, 2015@10:32:36PM -0700, Ming Lin wrote:
> >  a) move files to a new directory.  My suggestion for that would be
> >     driver/nvme/host/ as I have a software NVMe controller
> >     implementation under development which I'd like to also add under
> >     a different subdirectory of drivers/nvme.
> 
> What's the "software NVMe controller"? Is it the initiator for NVMe
> over fabrics?

It's a software implementation of the NVMe subsystem and controller
interface.  It could be frontended by a future fabrics implementation,
a virtio-nvme implementation, a nvme-loop implementation or with some
additional work maybe even a Linux-based PCIe target device.
