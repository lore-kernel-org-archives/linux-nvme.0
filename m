From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 23 Nov 2016 11:38:46 +0200
Subject: [PATCH v3 0/2] align to generic ib_event logging helper
Message-ID: <1479893928-32445-1-git-send-email-maxg@mellanox.com>

Changes since V2:
  - keep log prints inside the default case for nvmet-rdma

Max Gurtovoy (2):
  nvmet-rdma: align to generic ib_event logging helper
  nvme-rdma: align to generic ib_event logging helper

 drivers/nvme/host/rdma.c   |    4 +++-
 drivers/nvme/target/rdma.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)
