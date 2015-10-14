From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 13 Oct 2015 19:37:54 -0700
Subject: [PATCH 00/11] blk_integrity lifetime fixes
In-Reply-To: <20151014022757.34443.25800.stgit@dwillia2-desk3.jf.intel.com>
References: <20151014022757.34443.25800.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <CAPcyv4g78iBiVFVF3+dmbByH60auFLDX2n1CzkNvVUHdsf3H9Q@mail.gmail.com>

Sorry, flubbed the nvme mailing list address these patches are also in
the nvdimm patchwork and cc'd to that list if you missed them...

https://lists.01.org/pipermail/linux-nvdimm/2015-October/002430.html
https://patchwork.kernel.org/project/linux-nvdimm/list/

On Tue, Oct 13, 2015@7:27 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> The recent "Block integrity registration update" caused a failing
> signature that had been triggering intermittently in the libnvdimm unit
> tests to start failing reliably every run.  These tests run through all
> several blk_integrity configurations and ends up stressing the block
> device setup/teardown path.  These are incremental fixes to "Block
> integrity registration update".
>
> Patch 1: makes the failing occurrence much lower and should be folded
> into "[PATCH 2/5] block: Consolidate static integrity profile
> properties" of the "Block integrity registration update" series.
>
> Patches 2 - 6: drop now unnecessary calls to blk_integrity_unregister()
> at driver shutdown time.
>
> Patches 7 - 8: quiesce i/o while disabling blk_integrity
>
> Patch 9: pre-cursor for patches 10, 11 extends queue lifetime guarantees
> to bio-based drivers.
>
> Patch 10: move blk_integrity to the request_queue since the usage has
> more similar lifetime to the queue than the disk
>
> Patch 11: stop-gap fix to guarantee that synchronous bio-based drivers
> wait for queued bio integrity work at shutdown.
>
> ---
>
> Dan Williams (11):
>       libnvdimm: fix blk_integrity profile allocation
>       nvme: drop blk_integrity_unregister() at shutdown
>       libnvdimm, btt: drop blk_integrity_unregister() at shutdown
>       dm: drop blk_integrity_unregister() at shutdown
>       md: drop blk_integrity_unregister() at shutdown
>       scsi: drop blk_integrity_unregister() at shutdown
>       md: suspend i/o during runtime blk_integrity_unregister
>       nvme: suspend i/o during runtime blk_integrity_unregister
>       block: generic request_queue reference counting
>       block: move blk_integrity to request_queue
>       block: blk_flush_integrity() for bio-based drivers
>
>
>  block/bio-integrity.c     |    5 +++
>  block/blk-core.c          |   74 +++++++++++++++++++++++++++++++++++++-----
>  block/blk-integrity.c     |   63 ++++++++++++++++++-----------------
>  block/blk-mq-sysfs.c      |    6 ---
>  block/blk-mq.c            |   80 ++++++++++++++-------------------------------
>  block/blk-sysfs.c         |    7 +++-
>  block/blk.h               |   16 +++++++++
>  block/genhd.c             |    2 -
>  block/partition-generic.c |    2 +
>  drivers/md/dm-table.c     |    4 +-
>  drivers/md/dm.c           |    2 -
>  drivers/md/md.c           |    6 ++-
>  drivers/md/multipath.c    |    2 +
>  drivers/md/raid1.c        |    2 +
>  drivers/md/raid10.c       |    2 +
>  drivers/nvdimm/btt.c      |    1 -
>  drivers/nvdimm/core.c     |    4 +-
>  drivers/nvme/host/pci.c   |   18 ++++++----
>  drivers/scsi/sd.c         |    1 -
>  drivers/scsi/sd_dif.c     |    2 +
>  fs/block_dev.c            |    2 +
>  include/linux/blk-mq.h    |    1 -
>  include/linux/blkdev.h    |   13 +++++--
>  include/linux/genhd.h     |   16 +++------
>  24 files changed, 188 insertions(+), 143 deletions(-)
