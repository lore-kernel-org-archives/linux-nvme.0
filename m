From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 21 Jan 2017 14:19:14 +0200
Subject: [GIT PULL] nvme patches for 4.10-rc5
Message-ID: <1485001154-30024-1-git-send-email-sagi@grimberg.me>

Hey Jens,

This includes some fixes and cleanups:
- nvmet-fc fixes from James
- spelling fix from Colin
- nvmet-rdma dma sync fix from Parav
- Some more nvmet fixes
- Expose ctrl state in sysfs (useful for debugging)

This is rebased on top of your for-linus.

please pull from:

	git://git.infradead.org/nvme.git nvme-4.10-fixes

----------------------------------------------------------------
Colin Ian King (1):
      nvme: admin-cmd: fix spelling mistake: "Counld" -> "Could"

James Smart (2):
      nvmet_fc: cleanup of abort flag processing in fcp_op_done
      nvmet_fc: correct logic in disconnect queue LS handling

Parav Pandit (1):
      nvmet-rdma: Fix missing dma sync to nvme data structures

Sagi Grimberg (5):
      nvmet: delete controllers deletion upon subsystem release
      nvmet: Make cntlid globally unique
      nvme: Make controller state visible via sysfs
      nvmet: cancel fatal error and flush async work before free controller
      nvmet: Call fatal_error from keep-alive timout expiration

 drivers/nvme/host/core.c          | 24 +++++++++++++++++++++
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/configfs.c    |  1 +
 drivers/nvme/target/core.c        | 25 +++++++++++++++-------
 drivers/nvme/target/fabrics-cmd.c |  4 ++--
 drivers/nvme/target/fc.c          | 44 ++++++++++++++++++++++-----------------
 drivers/nvme/target/nvmet.h       |  2 +-
 drivers/nvme/target/rdma.c        | 17 +++++++++++++++
 8 files changed, 89 insertions(+), 30 deletions(-)
