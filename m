From: emilgoode@gmail.com (Emil Goode)
Date: Fri, 17 May 2013 17:37:16 +0200
Subject: [PATCH Resend] NVMe: Fix incompatible pointer type warnings
Message-ID: <1368805036-3444-1-git-send-email-emilgoode@gmail.com>

Commit 6a4d55146334 ("block: prep work for batch completion")
added a struct batch_complete * as a third argument to bi_end_io.
This patch adds the missing third argument to the nvme_bio_pair_endio
function.

Sparse output:

drivers/block/nvme-core.c: In function ?nvme_bio_split?:
drivers/block/nvme-core.c:483:19: warning:
	assignment from incompatible pointer type [enabled by default]
drivers/block/nvme-core.c:484:19: warning:
	assignment from incompatible pointer type [enabled by default]

Signed-off-by: Emil Goode <emilgoode at gmail.com>
---
This patch applies to the -mm tree. 

 drivers/block/nvme-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 8efdfaa..9380133 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -413,7 +413,8 @@ struct nvme_bio_pair {
 	atomic_t cnt;
 };
 
-static void nvme_bio_pair_endio(struct bio *bio, int err)
+static void nvme_bio_pair_endio(struct bio *bio, int err,
+						struct batch_complete *batch)
 {
 	struct nvme_bio_pair *bp = bio->bi_private;
 
-- 
1.7.10.4
