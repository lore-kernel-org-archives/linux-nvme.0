From: keith.busch@intel.com (Keith Busch)
Date: Wed, 31 Jan 2018 17:01:58 -0700
Subject: [PATCH] nvme: Fix discard buffer overrun
Message-ID: <20180201000158.23012-1-keith.busch@intel.com>

This patch checks the discard range array bounds before setting it in
case the driver gets a badly formed request.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at kernel.dk>
---
 drivers/nvme/host/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4bfb4ba6cd14..d02906a6dabe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -518,9 +518,11 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
 		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
 
-		range[n].cattr = cpu_to_le32(0);
-		range[n].nlb = cpu_to_le32(nlb);
-		range[n].slba = cpu_to_le64(slba);
+		if (n < segments) {
+			range[n].cattr = cpu_to_le32(0);
+			range[n].nlb = cpu_to_le32(nlb);
+			range[n].slba = cpu_to_le64(slba);
+		}
 		n++;
 	}
 
-- 
2.14.3
