From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Dec 2018 15:20:15 +0100
Subject: [GIT PULL] third batch of nvme updates for 4.21
Message-ID: <20181219142015.GA960@infradead.org>

Hi Jens,

the remaining nvme updates for this merge window below.  This contains
a series from Sagi to restore poll support for nvme-rdma, a new
tracepoint from yupeng and various fixes.


The following changes since commit cd19181bf9ad4b7f40f2a4e0355d052109c76529:

  blk-mq: enable IO poll if .nr_queues of type poll > 0 (2018-12-17 21:35:07 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.21

for you to fetch changes up to 604c01d567cb9ee7d19dc598272cb90ab6229a8a:

  nvme-pci: trace SQ status on completions (2018-12-19 08:35:36 +0100)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: use a macro for default error location

Christoph Hellwig (4):
      nvme-pci: only set nr_maps to 2 if poll queues are supported
      nvme-pci: refactor nvme_poll_irqdisable to make sparse happy
      nvmet-tcp: fix endianess annotations
      nvme-tcp: fix endianess annotations

Colin Ian King (2):
      nvmet: fix comparison of a u16 with -1
      nvme-tcp: fix spelling mistake "attepmpt" -> "attempt"

Sagi Grimberg (5):
      block: make request_to_qc_t public
      nvme-core: optionally poll sync commands
      nvme-fabrics: allow nvmf_connect_io_queue to poll
      nvme-fabrics: allow user to pass in nr_poll_queues
      nvme-rdma: implement polling queue map

yupeng (1):
      nvme-pci: trace SQ status on completions

 block/blk-mq.c              |  8 --------
 drivers/nvme/host/core.c    | 38 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/fabrics.c | 25 +++++++++++++++++------
 drivers/nvme/host/fabrics.h |  5 ++++-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     | 17 ++++++++++------
 drivers/nvme/host/rdma.c    | 49 +++++++++++++++++++++++++++++++++++++++------
 drivers/nvme/host/tcp.c     | 13 ++++++------
 drivers/nvme/host/trace.c   |  3 +++
 drivers/nvme/host/trace.h   | 23 +++++++++++++++++++++
 drivers/nvme/target/core.c  |  4 ++--
 drivers/nvme/target/loop.c  |  2 +-
 drivers/nvme/target/nvmet.h |  1 +
 drivers/nvme/target/tcp.c   |  4 ++--
 include/linux/blk-mq.h      | 10 +++++++++
 include/linux/blk_types.h   | 11 ----------
 17 files changed, 161 insertions(+), 56 deletions(-)
