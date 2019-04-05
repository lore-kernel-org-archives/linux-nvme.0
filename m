From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 5 Apr 2019 08:20:43 +0200
Subject: [GIT PULL] early nvme updates for 5.2
Message-ID: <20190405062043.GA26688@infradead.org>

Hi Jens,

below is the first batch of nvme updates for 5.2.  This includes the
performance improvements for single segment I/O on PCIe, which introduce
new block helpers, so it might be a good idea to get them in early.

 - various performance optimizations in the PCIe code (Keith and me)
 - new block helpers to support the above (me)
 - nvmet error conversion cleanup (me)
 - nvmet-fc variable sized array cleanup (Gustavo)
 - passthrough ioctl error printk cleanup (Kenneth)
 - small nvmet fixes (Max)
 - endianess conversion cleanup (Max)
 - nvmet-tcp faspath completion optimization (Sagi)


The following changes since commit 2b24e6f63ac9e817630424c6d8f008256348dfc4:

  block: bio: ensure newly added bio flags don't override BVEC_POOL_IDX (2019-04-04 09:30:37 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2

for you to fetch changes up to d0de579c043c3a2ab60ce75eb6cf4d414becc676:

  nvme: log the error status on Identify Namespace failure (2019-04-05 08:07:58 +0200)

----------------------------------------------------------------
Christoph Hellwig (15):
      nvmet: avoid double errno conversions
      block: add a req_bvec helper
      block: add a rq_integrity_vec helper
      block: add a rq_dma_dir helper
      block: add dma_map_bvec helper
      nvme-pci: remove nvme_init_iod
      nvme-pci: move the call to nvme_cleanup_cmd out of nvme_unmap_data
      nvme-pci: merge nvme_free_iod into nvme_unmap_data
      nvme-pci: only call nvme_unmap_data for requests transferring data
      nvme-pci: do not build a scatterlist to map metadata
      nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data
      nvme-pci: remove the inline scatterlist optimization
      nvme-pci: optimize mapping of small single segment requests
      nvme-pci: optimize mapping single segment requests using SGLs
      nvme-pci: tidy up nvme_map_data

Gustavo A. R. Silva (1):
      nvmet-fc: use zero-sized array and struct_size() in kzalloc()

Keith Busch (3):
      nvme-pci: use a flag for polled queues
      nvme-pci: remove q_dmadev from nvme_queue
      nvme-pci: remove unused nvme_iod member

Kenneth Heitke (1):
      nvme: log the error status on Identify Namespace failure

Max Gurtovoy (3):
      nvme: avoid double dereference to convert le to cpu
      nvmet: never fail double namespace enablement
      nvmet: add safety check for subsystem lock during nvmet_ns_changed

Sagi Grimberg (1):
      nvmet-tcp: implement C2HData SUCCESS optimization

 drivers/nvme/host/core.c          |   6 +-
 drivers/nvme/host/pci.c           | 263 +++++++++++++++++++-------------------
 drivers/nvme/target/core.c        |   9 +-
 drivers/nvme/target/fc.c          |   7 +-
 drivers/nvme/target/io-cmd-bdev.c |   6 +-
 drivers/nvme/target/tcp.c         |  24 +++-
 include/linux/blkdev.h            |  34 +++++
 7 files changed, 197 insertions(+), 152 deletions(-)
