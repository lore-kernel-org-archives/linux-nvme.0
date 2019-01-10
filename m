From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Jan 2019 18:09:03 +0100
Subject: [GIT PULL] nvme fixes for 5.0
Message-ID: <20190110170903.GA8025@infradead.org>

Hi Jens,

please pull the set of small nvme fixes below:


The following changes since commit 47cb393ee4815e10ab66f981fed581afdcc7caac:

  block: doc: add slice_idle_us to bfq documentation (2019-01-09 07:38:48 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0

for you to fetch changes up to b8a38ea64dc714a64f8fb76e311a4f15a3f67861:

  nvme: don't initlialize ctrl->cntlid twice (2019-01-09 13:47:08 -0500)

----------------------------------------------------------------
Andrey Smirnov (1):
      nvme: don't initlialize ctrl->cntlid twice

Hannes Reinecke (1):
      nvme-multipath: zero out ANA log buffer

Hongbo Yao (1):
      nvme-pci: fix out of bounds access in nvme_cqe_pending

James Dingwall (1):
      nvme: introduce NVME_QUIRK_IGNORE_DEV_SUBNQN

Jianchao Wang (1):
      nvme-pci: fix the wrong setting of nr_maps

Keith Busch (2):
      nvme-pci: rerun irq setup on IO queue init errors
      nvme: pad fake subsys NQN vid and ssvid with zeros

Liviu Dudau (1):
      nvme-pci: use the same attributes when freeing host_mem_desc_bufs.

Sagi Grimberg (3):
      nvme-tcp: remove dead code
      nvme-tcp: don't ask if controller is fabrics
      nvme-fabrics: unset write/poll queues for discovery controllers

 drivers/nvme/host/core.c      | 19 ++++++------
 drivers/nvme/host/fabrics.c   |  2 ++
 drivers/nvme/host/multipath.c |  2 ++
 drivers/nvme/host/nvme.h      |  5 ++++
 drivers/nvme/host/pci.c       | 67 ++++++++++++++++++++++++++++++-------------
 drivers/nvme/host/tcp.c       | 16 ++++-------
 6 files changed, 72 insertions(+), 39 deletions(-)
