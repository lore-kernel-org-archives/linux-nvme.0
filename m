From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:32 +0200
Subject: [PATCH 21/21] null_blk: Do not limit # of hardware queues to # of CPUs
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <396c32323faf66b39dd5f162452056b5dfd5db75.1474014910.git.agordeev@redhat.com>

It is not responsibility of device driver to assume number of
hardware queues used. Let the block layer decide instead.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 drivers/block/null_blk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 1747040..8c5cf88 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -793,9 +793,7 @@ static int __init null_init(void)
 							nr_online_nodes);
 			submit_queues = nr_online_nodes;
 		}
-	} else if (submit_queues > nr_cpu_ids)
-		submit_queues = nr_cpu_ids;
-	else if (!submit_queues)
+	} else if (!submit_queues)
 		submit_queues = 1;
 
 	mutex_init(&lock);
-- 
1.8.3.1
