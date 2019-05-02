From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 2 May 2019 17:58:25 -0400
Subject: [GIT PULL] last round of nvme updates for 5.2
Message-ID: <20190502215825.GA27894@infradead.org>

A couple more fixes and small cleanups for this merge window.

The following changes since commit 2d5abb9a1e8e92b25e781f0c3537a5b3b4b2f033:

  bcache: make is_discard_enabled() static (2019-05-01 06:34:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2

for you to fetch changes up to 6f53e73b9ec5b3cd097077c5ffcb76df708ce3f8:

  nvmet: protect discovery change log event list iteration (2019-05-01 09:18:47 -0400)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: move command size checks to the core
      nvme: mark nvme_core_init and nvme_core_exit static

Hannes Reinecke (2):
      nvme-multipath: split bios with the ns_head bio_set before submitting
      nvme-multipath: don't print ANA group state by default

Keith Busch (2):
      nvme-pci: shutdown on timeout during deletion
      nvme-pci: unquiesce admin queue on shutdown

Klaus Birkelund Jensen (1):
      nvme-pci: fix psdt field for single segment sgls

Minwoo Im (3):
      nvme-pci: remove an unneeded variable initialization
      nvme-pci: check more command sizes
      nvme-fabrics: check more command sizes

Sagi Grimberg (2):
      nvme-tcp: fix possible null deref on a timed out io queue connect
      nvmet: protect discovery change log event list iteration

 drivers/nvme/host/core.c        | 31 +++++++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.c     |  1 +
 drivers/nvme/host/multipath.c   | 10 +++++++++-
 drivers/nvme/host/nvme.h        |  3 ---
 drivers/nvme/host/pci.c         | 37 +++++++++++++------------------------
 drivers/nvme/host/tcp.c         |  3 ++-
 drivers/nvme/target/discovery.c |  5 +++++
 7 files changed, 59 insertions(+), 31 deletions(-)
