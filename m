From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 29 Jun 2018 14:40:40 +0200
Subject: [GIT PULL] nvme fix for 4.18
Message-ID: <20180629124040.GA3573@infradead.org>

The following changes since commit 15bfd21fbc5d35834b9ea383dc458a1f0c9e3434:

  block: Fix transfer when chunk sectors exceeds max (2018-06-26 12:18:27 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.18

for you to fetch changes up to 682630f00a219a1b0696abe9c0967e660068187b:

  nvme-rdma: fix possible double free of controller async event buffer (2018-06-28 16:29:54 +0200)

----------------------------------------------------------------
Sagi Grimberg (1):
      nvme-rdma: fix possible double free of controller async event buffer

 drivers/nvme/host/rdma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
