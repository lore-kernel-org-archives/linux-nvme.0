From: keith.busch@intel.com (Keith Busch)
Date: Thu,  4 Jan 2018 15:46:23 -0700
Subject: [PATCH 5/5] dm mpath: Use blk_retryable
In-Reply-To: <20180104224623.8944-1-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
Message-ID: <20180104224623.8944-6-keith.busch@intel.com>

Uses common code for determining if an error should be retried on
alternate path.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/md/dm-mpath.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index f7810cc869ac..3eb9500db1b3 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1475,21 +1475,6 @@ static void activate_path_work(struct work_struct *work)
 	activate_or_offline_path(pgpath);
 }
 
-static int noretry_error(blk_status_t error)
-{
-	switch (error) {
-	case BLK_STS_NOTSUPP:
-	case BLK_STS_NOSPC:
-	case BLK_STS_TARGET:
-	case BLK_STS_NEXUS:
-	case BLK_STS_MEDIUM:
-		return 1;
-	}
-
-	/* Anything else could be a path failure, so should be retried */
-	return 0;
-}
-
 static int multipath_end_io(struct dm_target *ti, struct request *clone,
 			    blk_status_t error, union map_info *map_context)
 {
@@ -1508,7 +1493,7 @@ static int multipath_end_io(struct dm_target *ti, struct request *clone,
 	 * request into dm core, which will remake a clone request and
 	 * clone bios for it and resubmit it later.
 	 */
-	if (error && !noretry_error(error)) {
+	if (error && blk_retryable(error)) {
 		struct multipath *m = ti->private;
 
 		r = DM_ENDIO_REQUEUE;
@@ -1544,7 +1529,7 @@ static int multipath_end_io_bio(struct dm_target *ti, struct bio *clone,
 	unsigned long flags;
 	int r = DM_ENDIO_DONE;
 
-	if (!*error || noretry_error(*error))
+	if (!*error || !blk_retryable(*error))
 		goto done;
 
 	if (pgpath)
-- 
2.13.6
