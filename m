From: hare@suse.de (Hannes Reinecke)
Date: Wed, 30 May 2018 13:16:37 +0200
Subject: [PATCH] nvme: avoid hang on inaccessible paths
Message-ID: <20180530111637.22223-1-hare@suse.de>

If all discovered paths are inaccessible we need to terminate the I/O,
otherwise we'll have in revalidate_disk() and the connect call will
never succeed.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74bb5b737879..fa3a4efe288e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -150,7 +150,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	ns = __nvme_find_path(head, NVME_ANA_OPTIMIZED);
 	if (!ns)
 		ns = __nvme_find_path(head, NVME_ANA_NONOPTIMIZED);
-	/* XXX: try an inaccessible path as last resort per 8.18.3.3 */
+	if (!ns)
+		ns = __nvme_find_path(head, NVME_ANA_INACCESSIBLE);
 	return ns;
 }
 
@@ -165,10 +166,14 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
-	if (likely(ns)) {
+	if (likely(ns && nvme_ns_ana_state(ns) != NVME_ANA_INACCESSIBLE)) {
 		bio->bi_disk = ns->disk;
 		bio->bi_opf |= REQ_NVME_MPATH;
 		ret = direct_make_request(bio);
+	} else if (ns) {
+		bio->bi_status = BLK_STS_TRANSPORT;
+		bio_set_flag(bio, BIO_QUIET);
+		bio_endio(bio);
 	} else if (!list_empty_careful(&head->list)) {
 		dev_warn_ratelimited(dev, "no path available - requeuing I/O\n");
 
-- 
2.12.3
