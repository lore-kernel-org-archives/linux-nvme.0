From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 22 Nov 2016 16:36:29 +0200
Subject: [PATCH v2 0/2] align to generic ib_event logging helper
Message-ID: <1479825391-10389-1-git-send-email-maxg@mellanox.com>

Changes since V1:
  - updated debug level to pr_debug

Max Gurtovoy (2):
  nvmet-rdma: align to generic ib_event logging helper
  nvme-rdma: align to generic ib_event logging helper

 drivers/nvme/host/rdma.c   |    4 +++-
 drivers/nvme/target/rdma.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)
