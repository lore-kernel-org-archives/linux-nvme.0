From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Feb 2018 17:37:01 +0100
Subject: [RFC PATCH] nvme-pci: Bounce buffer for interleaved metadata
In-Reply-To: <20180228163510.GC16002@localhost.localdomain>
References: <20180224000547.7252-1-keith.busch@intel.com>
 <yq17eqx4w64.fsf@oracle.com> <20180228163510.GC16002@localhost.localdomain>
Message-ID: <20180228163701.GA16363@lst.de>

On Wed, Feb 28, 2018@09:35:11AM -0700, Keith Busch wrote:
> Right, this RFC is just about enabling formats that don't subscribe to
> the DIX format. It turns out some people believe those extended LBAs
> are useful for something.
> 
> I still think this LBA format is not a good fit for this driver, but
> I'd like to not push people to use out-of-tree or user space drivers
> if there is a reasonable way to accommodate here. The driver's existing
> NVMe IO passthrough makes this format reachable already, but there is
> resistance to use the ioctl over more standard read/write paths.

For a good reason.  I think these formats are completely bogus for
something pretending to be a block device, and your patch just shows
how bogus they are.

What is the use case for this silly game?
