From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Feb 2018 16:52:38 -0700
Subject: [GIT PULL] nvme fixes for Linux 4.16
Message-ID: <20180214235238.GK20962@localhost.localdomain>

Hi Jens,

After syncing with Christoph and Sagi, we feel this is a good time to
send our latest fixes across most of the nvme components for 4.16:

The following changes since commit a7877390614770965a6925dfed79cbd3eeeb61e0:

  block, bfq: add requeue-request hook (2018-02-07 15:17:46 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.16-rc

for you to fetch changes up to 8000d1fdb07e365e6565c2415aefdfed15413794:

  nvme-rdma: fix sysfs invoked reset_ctrl error flow (2018-02-14 15:44:22 +0200)

----------------------------------------------------------------
Israel Rukshin (1):
      nvmet: Change return code of discard command if not supported

James Smart (2):
      nvme_fc: correct abort race condition on resets
      nvme_fc: cleanup io completion

Jianchao Wang (1):
      nvme: fix the deadlock in nvme_update_formats

Keith Busch (3):
      nvme: Fix discard buffer overrun
      nvme-pci: Remap CMB SQ entries on every controller reset
      nvme-pci: Fix timeouts in connecting state

Max Gurtovoy (3):
      nvme: rename NVME_CTRL_RECONNECTING state to NVME_CTRL_CONNECTING
      nvme-rdma: use NVME_CTRL_CONNECTING state to mark init process
      nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING transition

Nitzan Carmi (1):
      nvme-rdma: fix sysfs invoked reset_ctrl error flow

Roland Dreier (1):
      nvme: Don't use a stack buffer for keep-alive command

 drivers/nvme/host/core.c     |  45 ++++++++-----
 drivers/nvme/host/fabrics.h  |   9 +--
 drivers/nvme/host/fc.c       | 157 ++++++++++---------------------------------
 drivers/nvme/host/nvme.h     |   3 +-
 drivers/nvme/host/pci.c      |  39 ++++++-----
 drivers/nvme/host/rdma.c     |  16 ++---
 drivers/nvme/target/io-cmd.c |   7 +-
 7 files changed, 106 insertions(+), 170 deletions(-)
