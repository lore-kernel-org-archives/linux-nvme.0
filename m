From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 29 Mar 2018 10:07:17 -0600
Subject: [PATCH 0/4] SGL alloc and free helper functions for requests
Message-ID: <20180329160721.4691-1-logang@deltatee.com>

Hey,

These patches are going to be part of the P2PDMA patchset I'm working
on. The change was suggested by Christoph. I just wanted to get the NVMe
community's initial feedback on them seperate from our main patchset.

That is, except for patch 0003 which I'm pretty sure is a valid bug fix
but it needs review.

I also can not test the fibre channel changes as I do not have hardware
so I'd also appreciate it if someone can test it out.

If you need more context the commit which modifies these to support
P2P is [1]. This will likely be posted as the next version of the P2PDMA
patchset in the next cycle.

Thanks,

Logan


[1] https://github.com/sbates130272/linux-p2pmem/commit/4e57ff23d5ccc4687ac8eb567df1d4d15bf50254

Logan Gunthorpe (4):
  nvmet: Introduce helper functions to allocate and free request SGLs
  nvmet-rdma: Use new SGL alloc/free helper for requests
  nvmet-fc: Don't use the count returned by the dma_map_sg call
  nvmet-fc: Use new SGL alloc/free helper for requests

 drivers/nvme/target/core.c  | 16 ++++++++++++++++
 drivers/nvme/target/fc.c    | 45 ++++++++++++++++-----------------------------
 drivers/nvme/target/nvmet.h |  2 ++
 drivers/nvme/target/rdma.c  | 20 ++++++++++++--------
 4 files changed, 46 insertions(+), 37 deletions(-)

--
2.11.0
