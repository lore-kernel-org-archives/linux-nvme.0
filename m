From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 15 Nov 2016 12:00:30 +0200
Subject: [GIT PULL] nvme fabrics patches for 4.9-rc6
Message-ID: <1479204030-20590-1-git-send-email-sagi@grimberg.me>

Hey Jens,

These are the relevant fixes for rc6
- fix possible crash in nvmet-rdma cm_handler from Bart
- fix possible memory leak in nvmet-rdma for connection failures
- fix possible use-after-free conditions in nvmet-rdma
- fix possible IO errors during reconnect stage from Christoph
- fix possible memory leak in nvme-rdma during IO queues connect
  failures from Steve

The rest of the less critical fixes are queued for 4.10.

please pull from:

  git://git.infradead.org/nvme-fabrics.git nvmf-4.9-rc

----------------------------------------------------------------
Bart Van Assche (1):
      nvmet-rdma: Fix possible NULL deref when handling rdma cm events

Christoph Hellwig (1):
      nvme-rdma: reject non-connect commands before the queue is live

Sagi Grimberg (3):
      nvmet: Don't queue fatal error work if csts.cfs is set
      nvmet-rdma: don't forget to delete a queue from the list of connection failed
      nvmet-rdma: drain the queue-pair just before freeing it

Steve Wise (1):
      nvme-rdma: stop and free io queues on connect failure

 drivers/nvme/host/rdma.c   | 42 +++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/target/core.c | 10 +++++++---
 drivers/nvme/target/rdma.c | 18 +++++++++++++++---
 3 files changed, 61 insertions(+), 9 deletions(-)
