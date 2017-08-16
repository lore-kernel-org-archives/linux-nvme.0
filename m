From: jsmart2021@gmail.com (James Smart)
Date: Wed, 16 Aug 2017 10:47:03 -0700
Subject: [PATCH] nvmet_fc: eliminate static local variables
Message-ID: <20170816174703.25072-1-jsmart2021@gmail.com>

There were 2 statics introduced that were bogus. Removed the static
designations.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 6a7a4730e48c..421e43bf1dd7 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -394,7 +394,7 @@ nvmet_fc_free_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 static struct nvmet_fc_ls_iod *
 nvmet_fc_alloc_ls_iod(struct nvmet_fc_tgtport *tgtport)
 {
-	static struct nvmet_fc_ls_iod *iod;
+	struct nvmet_fc_ls_iod *iod;
 	unsigned long flags;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
@@ -471,7 +471,7 @@ nvmet_fc_destroy_fcp_iodlist(struct nvmet_fc_tgtport *tgtport,
 static struct nvmet_fc_fcp_iod *
 nvmet_fc_alloc_fcp_iod(struct nvmet_fc_tgt_queue *queue)
 {
-	static struct nvmet_fc_fcp_iod *fod;
+	struct nvmet_fc_fcp_iod *fod;
 
 	lockdep_assert_held(&queue->qlock);
 
-- 
2.13.1
