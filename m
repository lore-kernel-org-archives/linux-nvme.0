From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Feb 2019 08:49:19 -0700
Subject: [GIT PULL] nvme updates for 5.1
Message-ID: <20190221154919.GA19128@infradead.org>

The following changes since commit 49b1f22b567ba1d7d8174950be4398a69d0effb7:

  block: avoid to READ fields of null bio (2019-02-19 09:19:06 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.1

for you to fetch changes up to 34e08191b146a363d72be1a488d55ecdc01a5c7d:

  nvme-rdma: use nr_phys_segments when map rq to sgl (2019-02-21 06:39:20 -0700)

----------------------------------------------------------------
Bart Van Assche (6):
      nvmet: fix indentation
      nvme-fabrics: document the poll function argument
      nvme-pci: check kstrtoint() return value in queue_count_set()
      nvme: unexport nvme_delete_ctrl_sync()
      nvme: introduce a helper function for controller deletion
      nvme: avoid that deleting a controller triggers a circular locking complaint

Chaitanya Kulkarni (1):
      nvme-rdma: use nr_phys_segments when map rq to sgl

Christoph Hellwig (13):
      nvme_ioctl.h: remove duplicate GPL boilerplate
      nvme-tcp.h: fix SPDX header
      nvme-fabrics: convert to SPDX identifiers
      nvme-fc: convert to SPDX identifiers
      nvme-rdma: convert to SPDX identifiers
      nvme-lightnvm: convert to SPDX identifiers
      nvme-pci: convert to SPDX identifiers
      nvme: convert to SPDX identifiers
      nvmet-fc: convert to SPDX identifiers
      nvmet-fcloop: convert to SPDX identifiers
      nvme-loop: convert to SPDX identifiers
      nvmet-rdma: convert to SPDX identifiers
      nvmet: convert to SPDX identifiers

Hannes Reinecke (2):
      nvme-multipath: round-robin I/O policy
      nvme: return error from nvme_alloc_ns()

 drivers/nvme/host/core.c          | 68 ++++++++++++++++-----------
 drivers/nvme/host/fabrics.c       | 11 +----
 drivers/nvme/host/fabrics.h       | 10 +---
 drivers/nvme/host/fault_inject.c  |  2 +-
 drivers/nvme/host/fc.c            | 14 +-----
 drivers/nvme/host/lightnvm.c      | 16 +------
 drivers/nvme/host/multipath.c     | 96 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h          | 20 ++++----
 drivers/nvme/host/pci.c           | 12 ++---
 drivers/nvme/host/rdma.c          | 14 ++----
 drivers/nvme/host/trace.c         | 10 +---
 drivers/nvme/host/trace.h         | 10 +---
 drivers/nvme/target/admin-cmd.c   | 10 +---
 drivers/nvme/target/configfs.c    | 10 +---
 drivers/nvme/target/core.c        | 10 +---
 drivers/nvme/target/discovery.c   | 12 +----
 drivers/nvme/target/fabrics-cmd.c | 10 +---
 drivers/nvme/target/fc.c          | 14 +-----
 drivers/nvme/target/fcloop.c      | 13 +-----
 drivers/nvme/target/io-cmd-bdev.c | 10 +---
 drivers/nvme/target/loop.c        | 10 +---
 drivers/nvme/target/nvmet.h       | 10 +---
 drivers/nvme/target/rdma.c        | 10 +---
 include/linux/nvme-fc-driver.h    | 10 +---
 include/linux/nvme-fc.h           | 14 +-----
 include/linux/nvme-rdma.h         | 10 +---
 include/linux/nvme-tcp.h          |  2 +-
 include/linux/nvme.h              | 10 +---
 include/uapi/linux/nvme_ioctl.h   |  9 ----
 29 files changed, 168 insertions(+), 289 deletions(-)
