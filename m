From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 19 Mar 2017 00:42:18 +0200
Subject: [PATCH 0/3] Introduce fabrics controller loss timeout
Message-ID: <1489876941-6401-1-git-send-email-sagi@grimberg.me>

In case a host realize that it's controller session is
damaged it schedules periodic reconnects. In case the controller
is gone and will never return, we need a stop condition to give
up on this controller simply remove it.

We allow the user to configure a suitable ctrl_loss_tmo and
set a reasonable default of 10 minutes.

We'll need a complementary nvme-cli exposure that will follow.

Sagi Grimberg (3):
  nvme-rdma: get rid of local reconnect_delay
  nvme-fabrics: Allow ctrl loss timeout configuration
  nvme-rdma: Support ctrl_loss_tmo

 drivers/nvme/host/fabrics.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h | 10 ++++++++++
 drivers/nvme/host/rdma.c    | 43 ++++++++++++++++++++++++++++---------------
 3 files changed, 66 insertions(+), 15 deletions(-)

-- 
2.7.4
