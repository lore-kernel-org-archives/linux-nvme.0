From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  8 Nov 2017 12:00:27 +0200
Subject: [PATCH 0/3] few small nvmet fixes/cleanups
Message-ID: <20171108100030.25745-1-sagi@grimberg.me>

Just some useful patches for 4.15

Sagi Grimberg (3):
  nvmet-rdma: removed queues cleanup from module exit
  nvmet: remove redundant memset if failed to get_smart_log failed
  nvmet: remove redundant local variable

 drivers/nvme/target/admin-cmd.c | 17 +++++------------
 drivers/nvme/target/rdma.c      | 17 -----------------
 2 files changed, 5 insertions(+), 29 deletions(-)

-- 
2.14.1
