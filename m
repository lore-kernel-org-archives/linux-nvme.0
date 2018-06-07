From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 10:38:47 +0200
Subject: [PATCH 3/3] nvme: bio remapping tracepoint
In-Reply-To: <20180607083847.51019-1-hare@suse.de>
References: <20180607083847.51019-1-hare@suse.de>
Message-ID: <20180607083847.51019-4-hare@suse.de>

Adding a tracepoint to trace bio remapping for native nvme multipath.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 87bd60b49bbc..620bcd749912 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/moduleparam.h>
+#include <trace/events/block.h>
 #include "nvme.h"
 
 static bool multipath = true;
@@ -181,6 +182,9 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 	if (likely(ns)) {
 		bio->bi_disk = ns->disk;
 		bio->bi_opf |= REQ_NVME_MPATH;
+		trace_block_bio_remap(bio->bi_disk->queue, bio,
+				      disk_devt(ns->head->disk),
+				      bio->bi_iter.bi_sector);
 		ret = direct_make_request(bio);
 	} else if (!list_empty_careful(&head->list)) {
 		dev_warn_ratelimited(dev, "no path available - requeuing I/O\n");
-- 
2.12.3
