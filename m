From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 27 Oct 2017 09:23:19 +0300
Subject: [GIT PULL] one nvme fix for 4.14
Message-ID: <20171027062319.gvxuxxffwcfh2v4q@infradead.org>

The following changes since commit f04b9cc87b5fc466b1b7231ba7b078e885956c5b:

  nvme-rdma: Fix error status return in tagset allocation failure (2017-10-19 17:13:51 +0200)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.14

for you to fetch changes up to 7db814465395f3196ee98c8bd40d214d63e4f708:

  nvme-rdma: fix possible hang when issuing commands during ctrl removal (2017-10-23 16:27:44 +0200)

----------------------------------------------------------------
Sagi Grimberg (1):
      nvme-rdma: fix possible hang when issuing commands during ctrl removal

 drivers/nvme/host/rdma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
