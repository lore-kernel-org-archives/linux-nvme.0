From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 17 Nov 2018 10:06:20 -0700
Subject: [PATCH] nvme: default to 0 poll queues
Message-ID: <a2d999c8-135a-745f-07c2-e6c2dc52fff1@kernel.dk>

We need a better way of configuring this, and given that
polling is (still) a bit niche, let's default to using
0 poll queues. That way we'll have the same read/write/poll
behavior as 4.20, and users that want to test/use polling
are required to do manual configuration of the number of
poll queues.

Signed-off-by: Jens Axboe <axboe at kernel.dk>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 89874e23e422..57e790391b82 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -86,7 +86,7 @@ MODULE_PARM_DESC(write_queues,
 	"Number of queues to use for writes. If not set, reads and writes "
 	"will share a queue set.");
 
-static int poll_queues = 1;
+static int poll_queues = 0;
 module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
-- 
Jens Axboe
