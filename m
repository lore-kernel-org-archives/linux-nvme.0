From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:14:11 +0100
Subject: [GIT PULL] nvme fix for 4.20
Message-ID: <20181120161411.GA1367@infradead.org>

The following changes since commit 8dc765d438f1e42b3e8227b3b09fad7d73f4ec9a:

  SCSI: fix queue cleanup race before queue initialization is done (2018-11-14 08:19:10 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to 4cff280a5fccf6513ed9e895bb3a4e7ad8b0cedc:

  nvme-fc: resolve io failures during connect (2018-11-15 11:37:55 +0100)

----------------------------------------------------------------
James Smart (1):
      nvme-fc: resolve io failures during connect

 drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 10 deletions(-)
