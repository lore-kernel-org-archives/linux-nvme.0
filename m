From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 23 Sep 2016 16:47:31 -0700
Subject: [GIT PULL] nvme fabrics patches for 4.9
Message-ID: <1474674451-23213-1-git-send-email-sagi@grimberg.me>

Hey Jens,

On the nvme target end we have:
- direct IO writes in nvmet to avoid an extra context switch
- dsm fix from Sasha
- smart log stats support from Chaitanya

On the fabrics end we have a few cleanups and preps for
fc transport from James

please pull from:

  git://git.infradead.org/nvme-fabrics.git nvmf-4.9


----------------------------------------------------------------

Alexander Solganik (1):
      nvmet: Make dsm number of ranges zero based

Chaitanya Kulkarni (1):
      admin-cmd: Added smart-log command support.

James Smart (3):
      nvme-fabrics: rework nvmf_get_address() for variable options
      nvme-fabrics: revise host transport option descriptions
      nvme-fabrics: Add host_traddr options field to host infrastructure

Sagi Grimberg (1):
      nvmet: Use direct IO for writes

 drivers/nvme/host/fabrics.c     | 25 +++++++++++-
 drivers/nvme/host/fabrics.h     | 11 ++++--
 drivers/nvme/target/admin-cmd.c | 88 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd.c    |  3 +-
 4 files changed, 121 insertions(+), 6 deletions(-)
