From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Feb 2018 12:15:04 -0700
Subject: [GIT PULL] nvme fixes for 4.16-rc4
Message-ID: <20180228191503.GI16002@localhost.localdomain>

The following changes since commit af27d9403f5b80685b79c88425086edccecaf711:

  mm: hide a #warning for COMPILE_TEST (2018-02-16 09:41:36 -0800)

are available in the Git repository at:

  git://git.infradead.org/nvme.git for-jens

for you to fetch changes up to bffd2b61670feef18d2535e9b53364d270a1c991:

  nvmet: fix PSDT field check in command format (2018-02-28 10:10:22 -0700)

----------------------------------------------------------------
Baegjae Sung (1):
      nvme-multipath: fix sysfs dangerously created links

Christoph Hellwig (3):
      nvme-fabrics: don't check for non-NULL module in nvmf_register_transport
      nvme-rdma: use blk_rq_payload_bytes instead of blk_rq_bytes
      nvmet-loop: use blk_rq_payload_bytes for sgl selection

Jianchao Wang (1):
      nvme-pci: Fix nvme queue cleanup if IRQ setup fails

Max Gurtovoy (1):
      nvmet: fix PSDT field check in command format

 drivers/nvme/host/core.c      | 12 +++---------
 drivers/nvme/host/fabrics.c   |  2 +-
 drivers/nvme/host/multipath.c | 15 ++++++++++-----
 drivers/nvme/host/pci.c       |  5 ++++-
 drivers/nvme/host/rdma.c      |  4 ++--
 drivers/nvme/target/core.c    |  9 ++++++---
 drivers/nvme/target/loop.c    |  4 ++--
 7 files changed, 28 insertions(+), 23 deletions(-)
