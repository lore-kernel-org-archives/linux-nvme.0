From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 22 Jun 2016 13:14:59 -0700
Subject: [PATCH 0/1] Fix for nvme-rdma host crash in nvmf-all.3
Message-ID: <cover.1466626499.git.swise@opengridcomputing.com>

This patch fixes a touch-after-free bug I discovered.  It is against
nvmf-all.3 branch of git://git.infradead.org/nvme-fabrics.git.  The patch
is kind of ugly, so any ideas on a cleaner solution are welcome.

Steve Wise (1):
  nvme-rdma: correctly unwind on bad subsystemnqn error

 drivers/nvme/host/rdma.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.7.0
