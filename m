From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 Mar 2016 14:46:16 +0000
Subject: guaranteed progress for NVME commands?
In-Reply-To: <20160322074531.GA32289@infradead.org>
References: <20160322074531.GA32289@infradead.org>
Message-ID: <20160322144615.GA24460@localhost.localdomain>

On Tue, Mar 22, 2016@12:45:31AM -0700, Christoph Hellwig wrote:
> in SCSI and other block drivers we go through great pains to only
> use mempool backed allocations in the I/O path, so that we can make
> guaranteed progress for swap or the writeback daemons.  But it seems
> like the NVMe driver is using plain kmalloc everywhere and seems to
> be getting away with that just for now.  Is no one using swap on
> NVMe or am I missing a secret trick somewhere?

I believe swap reads and writes single pages, right? We only kmalloc if
we're transferring more than two pages.

... well, mostly. There are caveats if the host page size is greater than
the device's, but I'm not sure why the driver is even considering that.
The transfer size doesn't matter; only nr_phys_segments should determine how
many elements the nvme_iod sgl needs to have.

Anyway, our IO path's only malloc is the nvme_iod scatter list if it
doesn't fit inline. Is that sufficient for progress, or do you think
we need to follow a different example?
