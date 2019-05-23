From: kbusch@kernel.org (Keith Busch)
Date: Thu, 23 May 2019 10:14:23 -0600
Subject: [GIT PULL] nvme fixes for 5.2-rc2
Message-ID: <20190523161423.GD14943@localhost.localdomain>

Mostly fixes we'd like included ahead of the next rc.

The only non-fix is an update to the MAINTAINERS file to point to my
kernel.org account. This is preferred to receive communication as most
nvme development/maintenance is on my own time anyway. I will also be
starting extended vacation after tomorrow, but would like to still keep
a finger on the nvme pulse.

The following changes since commit a6a4b66bd8f41922c543f7a820c66ed59c25995e:

  Merge tag 'for-linus-20190516' of git://git.kernel.dk/linux-block (2019-05-16 19:10:37 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2-rc2

for you to fetch changes up to cb9e0e5006064a807b5d722c7e3c42f307193792:

  nvme-pci: use blk-mq mapping for unmanaged irqs (2019-05-22 10:11:36 -0600)

----------------------------------------------------------------
Christoph Hellwig (4):
      nvme: fix srcu locking on error return in nvme_get_ns_from_disk
      nvme: remove the ifdef around nvme_nvm_ioctl
      nvme: merge nvme_ns_ioctl into nvme_ioctl
      nvme: release namespace SRCU protection before performing controller ioctls

Keith Busch (7):
      nvme-pci: Fix controller freeze wait disabling
      nvme-pci: Don't disable on timeout in reset state
      nvme-pci: Unblock reset_work on IO failure
      nvme-pci: Sync queues on reset
      nvme: Fix known effects
      nvme: update MAINTAINERS
      nvme-pci: use blk-mq mapping for unmanaged irqs

Laine Walker-Avina (1):
      nvme: copy MTFA field from identify controller

Yufen Yu (1):
      nvme: fix memory leak for power latency tolerance

 MAINTAINERS              |  2 +-
 drivers/nvme/host/core.c | 89 +++++++++++++++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 27 ++++++++-------
 4 files changed, 77 insertions(+), 42 deletions(-)
