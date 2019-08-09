From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  9 Aug 2019 11:04:12 -0700
Subject: [GIT PULL] nvme fixes for the next round of 5.3-rc
Message-ID: <20190809180412.26392-1-sagi@grimberg.me>

Hey Jens,

Few nvme fixes for the next rc round.
- detect capacity changes on the mpath disk from Anthony
- probe/remove fix from Keith
- various fixes to pass blktests from Logan
- deadlock in reset/scan race fix
- nvme-rdma use-after-free fix
- deadlock fix when passthru commands race mpath disk info update

The following changes since commit 71d6c505b4d9e6f76586350450e785e3d452b346:

  libata: zpodd: Fix small read overflow in zpodd_get_mech_type() (2019-07-29 16:00:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.3-rc 

for you to fetch changes up to bd46a90634302bfe791e93ad5496f98f165f7ae0:

  nvme-pci: Fix async probe remove race (2019-07-31 18:03:36 -0700)

----------------------------------------------------------------
Anthony Iliopoulos (1):
      nvme-multipath: revalidate nvme_ns_head gendisk in nvme_validate_ns

Keith Busch (1):
      nvme-pci: Fix async probe remove race

Logan Gunthorpe (4):
      nvmet: Fix use-after-free bug when a port is removed
      nvmet-loop: Flush nvme_delete_wq when removing the port
      nvmet-file: fix nvmet_file_flush() always returning an error
      nvme-core: Fix extra device_put() call on error path

Sagi Grimberg (3):
      nvme: fix a possible deadlock when passthru commands sent to a multipath device
      nvme-rdma: fix possible use-after-free in connect error flow
      nvme: fix controller removal race with scan work

 drivers/nvme/host/core.c       | 15 ++++++++-
 drivers/nvme/host/multipath.c  | 76 ++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h       | 21 ++++++++++--
 drivers/nvme/host/pci.c        |  3 +-
 drivers/nvme/host/rdma.c       | 16 ++++++---
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 15 +++++++++
 drivers/nvme/target/loop.c     |  8 +++++
 drivers/nvme/target/nvmet.h    |  3 ++
 9 files changed, 143 insertions(+), 15 deletions(-)
