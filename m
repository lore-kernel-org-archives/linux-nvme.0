From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 16 Jan 2019 17:37:24 +0100
Subject: [GIT PULL] two nvme fixes for 5.0-rc3
Message-ID: <20190116163724.GA24217@infradead.org>

The following changes since commit 8218a55b6b911d396565da4ed5ca8b18bf0d38fb:

  sbitmap: Protect swap_lock from hardirq (2019-01-14 21:30:32 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0

for you to fetch changes up to eda14f8977df052dce3a9c54a6bf8d8f76c96eb1:

  nvme-pci: fix nvme_setup_irqs() (2019-01-15 06:50:52 +0100)

----------------------------------------------------------------
Ming Lei (1):
      nvme-pci: fix nvme_setup_irqs()

Sagi Grimberg (1):
      nvmet-tcp: fix uninitialized variable access

 drivers/nvme/host/pci.c   | 21 +++++++++++++--------
 drivers/nvme/target/tcp.c |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)
