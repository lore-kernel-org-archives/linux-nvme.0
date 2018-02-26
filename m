From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Feb 2018 09:49:00 -0700
Subject: [RFC PATCH] nvme-pci: Bounce buffer for interleaved metadata
In-Reply-To: <5662c6d9-0c87-6074-12b8-39db53ce3c7f@grimberg.me>
References: <20180224000547.7252-1-keith.busch@intel.com>
 <5662c6d9-0c87-6074-12b8-39db53ce3c7f@grimberg.me>
Message-ID: <20180226164900.GC10832@localhost.localdomain>

On Sun, Feb 25, 2018@07:30:48PM +0200, Sagi Grimberg wrote:
> > NVMe namespace formats allow the possibility for metadata as extended
> > LBAs. These require the memory interleave block and metadata in a single
> > virtually contiguous buffer.
> > 
> > The Linux block layer, however, maintains metadata and data in separate
> > buffers, which is unusable for NVMe drives using interleaved metadata
> > formats.
> 
> That's not specific for NVMe, I vaguely recall we had this discussion
> for passthru scsi devices (in scsi target context) 5 years ago...
> It makes sense for FC (and few RDMA devices) that already get
> interleaved metadata from the wire to keep it as is instead of
> scattering it if the backend nvme device supports interleaved mode...
> 
> I would say that this support for this is something that belongs in the
> block layer. IIRC mkp also expressed interest in using preadv2/pwritev2
> to for user-space to use DIF with some accounting on the iovec so maybe
> we can add a flag for interleaved metadata.

That's an interesting thought. If the buffer from userspace already
provides the metadata buffer interleaved with the block data, that would
obviate the need for copying, and significantly help performance for
such formats.
 
> > This patch will enable such formats by allocating a bounce buffer
> > interleaving the block and metadata, copying the everythign into the
> > buffer for writes, or from it for reads.
> > 
> > I dislike this feature intensely. It is incredibly slow and enough memory
> > overhead to make this not very useful for reclaim, but it's possible
> > people will leave me alone if the Linux nvme driver accomodated this
> > format.
> 
> Not only that it will be non-useful, but probably unusable. Once upon of
> time iser did bounce buffering with large contiguous atomic allocations,
> it just doesn't work... especially with nvme large number of deep queues
> that can host commands of MDTS bytes each.
> 
> If we end up keeping it private to nvme, the first comment I'd give you
> is to avoid high-order allocations, you'll see lots of bug reports
> otherwise...

Thanks for bringing up those points. If we do go a route that has nvme
double buffer everything, we could cap the max transfer size and/or
vmalloc instead of kmalloc to reduce memory pressure. I'm not sure either
would be sufficient, though.
