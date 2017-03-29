From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 21:00:24 +0300
Subject: [PATCH 0/3] update request retries (loop, rdma, fc)
Message-ID: <1490810427-27776-1-git-send-email-sagi@grimberg.me>

Keep a consistent behavior with what's checked in the core which
does not requeue if we exhausted nvme_max_retries.

Sagi Grimberg (3):
  nvme-rdma: increment request retries counter before requeuing
  nvme-loop:  increment request retries counter before requeuing
  nvme-fc:  increment request retries counter before requeuing

 drivers/nvme/host/fc.c     | 1 +
 drivers/nvme/host/rdma.c   | 1 +
 drivers/nvme/target/loop.c | 1 +
 3 files changed, 3 insertions(+)

-- 
2.7.4
