From: neilb@suse.com (NeilBrown)
Date: Thu, 10 Mar 2016 08:59:28 +1100
Subject: [PATCH 0/4] Remove un-needed 'major' registration when
 alloc_disk(0) is used.
Message-ID: <20160309215702.20904.61407.stgit@noble>

When alloc_disk(0) is used, the ->major number is ignored and
irrelevant.  Yet several drivers register a major number anyway.

This series of patches removes the pointless registrations.  The pmem
driver also does this, but a patch has already been sent for that
driver.

Note that I am not in a position to test these beyond simple compile
testing.

Thanks,
NeilBrown


---

NeilBrown (4):
      nvdimm/blk: don't allocate unused major device number
      nvdimm/btt: don't allocate unused major device number
      memstick: don't allocate unused major for ms_block
      NVMe: don't allocate unused nvme_major


 drivers/memstick/core/ms_block.c |   17 ++---------------
 drivers/nvdimm/blk.c             |   18 +-----------------
 drivers/nvdimm/btt.c             |   19 ++-----------------
 drivers/nvme/host/core.c         |   16 +---------------
 4 files changed, 6 insertions(+), 64 deletions(-)

--
Signature
