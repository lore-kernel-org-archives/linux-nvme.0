From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  6 Apr 2017 09:15:49 +0300
Subject: [PATCH for-4.11-rc 0/3] Fix wrong sqsize settings in fabrics
Message-ID: <1491459352-28200-1-git-send-email-sagi@grimberg.me>

This should have been fixed by now, but apparently it wasn't.

Sagi Grimberg (3):
  nvme-loop: Fix sqsize wrong assignment based on ctrl MQES capability
  nvme-rdma: Fix sqsize wrong assignment based on ctrl MQES capability
  nvme-fc: Fix sqsize wrong assignment based on ctrl MQES capability

 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
