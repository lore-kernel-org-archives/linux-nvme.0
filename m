From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Jun 2016 15:05:59 +0300
Subject: [PATCH 0/2] Get rid of transport layer retry count config parameter
Message-ID: <1466597161-5242-1-git-send-email-sagi@grimberg.me>

This parameter was added in order to support a proper timeout for
error recovery before the spec defined a periodic keep-alive.

Now that we have periodic keep-alive, we don't need a user configurable
transport layer retry count, the keep-alive timeout is sufficient,
transports can retry for as long as they see fit.

Sagi Grimberg (2):
  nvme-rdma: Don't use tl_retry_count
  nvme-fabrics: Remove tl_retry_count

 drivers/nvme/host/fabrics.c | 14 --------------
 drivers/nvme/host/fabrics.h |  3 ---
 drivers/nvme/host/rdma.c    |  9 +++------
 3 files changed, 3 insertions(+), 23 deletions(-)

-- 
1.9.1
