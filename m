From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 16 May 2019 10:25:42 +0200
Subject: [GIT PULL] nvme fixes for 5.2
Message-ID: <20190516082541.GA19383@infradead.org>

The following changes since commit 936b33f7243fa1e54c8f4f2febd3472cc00e66fd:

  brd: add cond_resched to brd_free_pages (2019-05-09 12:51:27 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2

for you to fetch changes up to 1b1031ca63b2ce1d3b664b35b77ec94e458693e9:

  nvme: validate cntlid during controller initialisation (2019-05-14 17:19:50 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme: trace all async notice events

Christoph Hellwig (2):
      nvme: change locking for the per-subsystem controller list
      nvme: validate cntlid during controller initialisation

Gustavo A. R. Silva (1):
      nvme-pci: mark expected switch fall-through

Hannes Reinecke (2):
      nvme-fc: use separate work queue to avoid warning
      nvme-multipath: avoid crash on invalid subsystem cntlid enumeration

Max Gurtovoy (1):
      nvme-rdma: remove redundant reference between ib_device and tagset

Maxim Levitsky (2):
      nvme-pci: init shadow doorbell after each reset
      nvme-pci: add known admin effects to augument admin effects log page

Minwoo Im (2):
      nvme-fabrics: remove unused argument
      nvme: fix typos in nvme status code values

 drivers/nvme/host/core.c      | 79 ++++++++++++++++++++++---------------------
 drivers/nvme/host/fabrics.c   |  4 +--
 drivers/nvme/host/fc.c        | 14 ++++++--
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/pci.c       |  4 +--
 drivers/nvme/host/rdma.c      | 34 +++----------------
 drivers/nvme/host/trace.h     |  1 +
 include/linux/nvme.h          |  4 +--
 8 files changed, 64 insertions(+), 78 deletions(-)
