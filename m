From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 26 Sep 2015 09:09:33 -0700
Subject: [PATCH] Move nvme driver source into subdirectory and move pci
 specifics from core into separate file
In-Reply-To: <1443193953.3304.18.camel@linux.intel.com>
References: <1443130050.6973.125.camel@linux.intel.com>
 <20150925000251.GA25904@infradead.org>
 <1443193953.3304.18.camel@linux.intel.com>
Message-ID: <20150926160933.GA30551@infradead.org>

On Fri, Sep 25, 2015@08:12:33AM -0700, J Freyensee wrote:
> > My suggestion would be:
> > 
> >  a) move files to a new directory.  My suggestion for that would be
> >     driver/nvme/host/ as I have a software NVMe controller
> >     implementation under development which I'd like to also add under
> >     a different subdirectory of drivers/nvme.
> 
> Would that directory be slightly confusing name as the split
> implementation in this patch can still be used as the NVMe PCIe driver
> for SSD devices inside a given computer (laptop, PC, etc)?  I have no
> issue with the name, just posing a question.

Host is what the NVMe spec uses when referring to the computer housing
the NVMe card, that's why I came up with it.  But I'm open for alternate
suggestions.

> I can see that.  However we started with the split we had just out of
> the concern for backwards compatibility and worry of breaking something
> with the initial split.  There was the thought we can optimize some of
> the operations and remove them on future patches on operations that we
> know are safe to remove.

If you look at the NVMe spec we're basically down to two sort of
operations: NVMe commands, and MMIO read/write access to the main
BAR, so those seem the most important abstraction.  My nvme_command
passthrough through struct request takes care of the first, so some
{read,write}_bar_{32,64} ops seem to be most important ops.  Depending
on how exactly the initialization path is structured there might be a
frw more, but I'd tend towards duplicating a bit more in doubt there
initially.

Note that I've done a pre-"NVMe over Fabrics" RDMA transport and a
nvme-loop driver that directy injects commands from a front end
driver into a virtual controller about a year ago, and both fit this
scheme pretty well, as does the virtio-nvme code from Ming.
