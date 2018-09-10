From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 10 Sep 2018 08:02:30 +0200
Subject: [GIT PULL] nvme fix for 4.19
Message-ID: <20180910060230.GA27071@infradead.org>

The following changes since commit bc811f05d77f47059c197a98b6ad242eb03999cb:

  nbd: don't allow invalid blocksize settings (2018-09-04 11:54:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to 8407879c4e0d7731f6e7e905893cecf61a7762c7:

  nvmet-rdma: fix possible bogus dereference under heavy load (2018-09-05 12:18:01 -0700)

----------------------------------------------------------------
Sagi Grimberg (1):
      nvmet-rdma: fix possible bogus dereference under heavy load

 drivers/nvme/target/rdma.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)
