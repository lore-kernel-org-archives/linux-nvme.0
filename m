From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  8 Aug 2016 15:14:39 +0300
Subject: [GIT PULL] fabrics fixes for the next 4.8-rc
Message-ID: <1470658479-7861-1-git-send-email-sagi@grimberg.me>

Hey Jens,

Mostly stability fixes for nvmet, rdma:
- fix uninitialized rdma_cm private data from Roland.
- rdma device removal handling (host and target).
- fix controller disconnect during active mounts.
- fix namespaces lost after fabric reconnects.
- remove redundant calls to namespace removal (rdma, loop).
- actually send controller shutdown when disconnecting.
- reconnect fixes (ns rescan and aen requeue)
- nvmet controller serial number inconsistency fix.


please pull from:

  git://git.infradead.org/nvme-fabrics.git nvmf-4.8-rc


----------------------------------------------------------------

Roland Dreier (1):
      nvme-rdma: Don't leak uninitialized memory in connect request private data

Sagi Grimberg (11):
      nvme-rdma: Queue ns scanning after a sucessful reconnection
      nvme-rdma: Fix device removal handling
      nvme-rdma: Remove duplicate call to nvme_remove_namespaces
      nvme-rdma: Free the I/O tags when we delete the controller
      nvme-loop: Remove duplicate call to nvme_remove_namespaces
      nvme-rdma: Make sure to shutdown the controller if we can
      nvmet-rdma: Correctly handle RDMA device hot removal
      nvmet-rdma: Don't use the inline buffer in order to avoid allocation for small reads
      nvmet: Fix controller serial number inconsistency
      nvme-rdma: start async event handler after reconnecting to a controller
      nvme-rdma: Remove unused includes

 drivers/nvme/host/rdma.c        |  83 +++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
 drivers/nvme/target/admin-cmd.c |   6 +-----
 drivers/nvme/target/core.c      |   4 ++++
 drivers/nvme/target/loop.c      |   4 +---
 drivers/nvme/target/nvmet.h     |   1 +
 drivers/nvme/target/rdma.c      | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 6 files changed, 126 insertions(+), 72 deletions(-)
