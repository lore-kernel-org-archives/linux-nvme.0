From: m@bjorling.me (Matias Bjorling)
Date: Thu, 10 Oct 2013 20:29:45 +0200
Subject: [PATCH 0/2] NVMe: Refactoring
Message-ID: <1381429787-4146-1-git-send-email-m@bjorling.me>

Two refactor patches that increases the code clarity.

The to-be blk-mq proposal patchset utilizes these as part of its transformation.
They are also useful for the current codebase and therefore submitted upfront.

Matias Bjorling (2):
  NVMe: Refactor doorbell
  NVMe: Extract admin queue size

 drivers/block/nvme-core.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

-- 
1.8.1.2
