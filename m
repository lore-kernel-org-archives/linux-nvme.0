From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 26 Jan 2017 18:43:18 +0200
Subject: [GIT PULL] nvme patches for 4.10-rc5
Message-ID: <1485448998-29832-1-git-send-email-sagi@grimberg.me>

Hey Jens,

Given that its -rc6, I removed anything that is not
bug fix.

- nvmet-fc discard fix from Christoph
- queue disconnect fix from James
- nvmet-rdma dma sync fix from Parav
- Some more nvmet fixes

please pull from:

	git://git.infradead.org/nvme.git nvme-4.10-fixes

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-fc: use blk_rq_nr_phys_segments

James Smart (1):
      nvmet_fc: correct logic in disconnect queue LS handling

Parav Pandit (1):
      nvmet-rdma: Fix missing dma sync to nvme data structures

Sagi Grimberg (3):
      nvmet: delete controllers deletion upon subsystem release
      nvmet: cancel fatal error and flush async work before free controller
      nvmet: Call fatal_error from keep-alive timout expiration

 drivers/nvme/host/fc.c         |  6 +++---
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 15 ++++++++++++++-
 drivers/nvme/target/fc.c       | 36 ++++++++++++++++++++++--------------
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/rdma.c     | 17 +++++++++++++++++
 6 files changed, 58 insertions(+), 18 deletions(-)
