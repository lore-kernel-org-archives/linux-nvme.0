From: ross.zwisler@linux.intel.com (Ross Zwisler)
Date: Mon, 14 Mar 2016 16:50:17 -0600
Subject: [PATCH 0/4] Remove un-needed 'major' registration when
 alloc_disk(0) is used.
In-Reply-To: <20160309215702.20904.61407.stgit@noble>
References: <20160309215702.20904.61407.stgit@noble>
Message-ID: <20160314225017.GC19926@linux.intel.com>

On Thu, Mar 10, 2016@08:59:28AM +1100, NeilBrown wrote:
> When alloc_disk(0) is used, the ->major number is ignored and
> irrelevant.  Yet several drivers register a major number anyway.
> 
> This series of patches removes the pointless registrations.  The pmem
> driver also does this, but a patch has already been sent for that
> driver.
> 
> Note that I am not in a position to test these beyond simple compile
> testing.
> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (4):
>       nvdimm/blk: don't allocate unused major device number
>       nvdimm/btt: don't allocate unused major device number
>       memstick: don't allocate unused major for ms_block
>       NVMe: don't allocate unused nvme_major
> 
> 
>  drivers/memstick/core/ms_block.c |   17 ++---------------
>  drivers/nvdimm/blk.c             |   18 +-----------------
>  drivers/nvdimm/btt.c             |   19 ++-----------------
>  drivers/nvme/host/core.c         |   16 +---------------
>  4 files changed, 6 insertions(+), 64 deletions(-)

There are several other drivers that allocate a major, but then use it for
some small number of minors (1 for null_blk.c and 16 for virtio_blk.c).  They
both have GENHD_FL_EXT_DEVT set, so I think what happens is that after we
exhaust the allocated minors they hop over to having BLOCK_EXT_MAJOR as a
major and a dynamically assigned minor.

It seems like these could easily be converted in the same way so they'd use
BLOCK_EXT_MAJOR for their major and have a bunch of dynamically assigned
minors.

Does this break something I'm not seeing?

Yay for this series, by the way. :) 
