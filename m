From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jan 2018 16:14:27 +0900
Subject: [PATCH] nvme: fix comment typos in nvme_create_io_queues
Message-ID: <1515914067-12653-1-git-send-email-minwoo.im.dev@gmail.com>

fix comment typos in nvme_create_io_queues() like below.
  _aount_ to _amount_
  _an_    to _can_

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d53550e..7c52141 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1643,8 +1643,8 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 
 	/*
 	 * Ignore failing Create SQ/CQ commands, we can continue with less
-	 * than the desired aount of queues, and even a controller without
-	 * I/O queues an still be used to issue admin commands.  This might
+	 * than the desired amount of queues, and even a controller without
+	 * I/O queues can still be used to issue admin commands.  This might
 	 * be useful to upgrade a buggy firmware for example.
 	 */
 	return ret >= 0 ? 0 : ret;
-- 
2.7.4
