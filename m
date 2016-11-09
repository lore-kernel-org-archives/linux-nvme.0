From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  9 Nov 2016 10:02:00 +0200
Subject: [GIT PULL] nvme fabrics patches for the next round of 4.9 rc
Message-ID: <1478678520-26697-1-git-send-email-sagi@grimberg.me>

Hey Jens,

Mostly some stability fixes for fabrics:
- some memleaks, correctness and verbosity fixes from Bart
- fix command delivery during queue reconnect from Christoph
- nvme rdma reconnect vs io race fix from Christoph and steve
- nvme rdma queue cleanup on connection failure fix from Steve
- nvme rdma target error flow and queue teardown fixes
- nvme rdma queue size fix from Samuel
- nvmet namespace rcu race fix from Sasha

please pull from:

  git://git.infradead.org/nvme-fabrics.git nvmf-4.9-rc

----------------------------------------------------------------
Bart Van Assche (6):
      nvmet-rdma: Fix REJ status code
      nvme/scsi: Remove set-but-not-used variables
      nvme-fabrics: Adjust source code indentation
      nvme-fabrics: Fix memory leaks in nvmf_parse_options()
      nvme-fabrics: Fix a memory leak in an nvmf_create_ctrl() error path
      nvmet-rdma: Fix possible NULL deref when handling rdma cm events

Christoph Hellwig (1):
      nvme-rdma: reject non-connect commands before the queue is live

Sagi Grimberg (4):
      nvme-rdma: remove redundant define
      nvmet: Don't queue fatal error work if csts.cfs is set
      nvmet-rdma: don't forget to delete a queue from the list of connection failed
      nvmet-rdma: drain the queue-pair just before freeing it

Samuel Jones (1):
      nvme-rdma: force queue size to respect controller capability

Solganik Alexander (1):
      nvmet: Fix possible infinite loop triggered on hot namespace removal

Steve Wise (1):
      nvme-rdma: stop and free io queues on connect failure

 drivers/nvme/host/fabrics.c    |  9 ++++----
 drivers/nvme/host/rdma.c       | 51 ++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/scsi.c       | 11 ++-------
 drivers/nvme/target/configfs.c |  6 ++---
 drivers/nvme/target/core.c     | 24 ++++++++++++--------
 drivers/nvme/target/nvmet.h    |  6 +----
 drivers/nvme/target/rdma.c     | 23 +++++++++++++++----
 7 files changed, 92 insertions(+), 38 deletions(-)
