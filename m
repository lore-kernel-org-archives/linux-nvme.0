From: emilne@redhat.com (Ewan D. Milne)
Date: Thu,  6 Apr 2017 12:47:56 -0400
Subject: [PATCH v2] nvme_fc: avoid double kfree(),
 don't call nvme_cleanup_cmd() in nvme_fc_unmap_data()
Message-ID: <1491497276-15944-1-git-send-email-emilne@redhat.com>

nvme_cleanup_cmd() is already called by callers of nvme_fc_unmap_data().
Don't call it twice to avoid double-free on completion of discard commands.

v2:
Move nvme_cleanup_cmd() call *after* nvme_fc_unmap_data() for consistency.

Signed-off-by: Ewan D. Milne <emilne at redhat.com>
---
 drivers/nvme/host/fc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fc42172..5ff8674 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1700,8 +1700,6 @@ enum blk_eh_timer_return
 				((rq_data_dir(rq) == WRITE) ?
 					DMA_TO_DEVICE : DMA_FROM_DEVICE));
 
-	nvme_cleanup_cmd(rq);
-
 	sg_free_table_chained(&freq->sg_table, true);
 
 	freq->sg_cnt = 0;
@@ -1929,8 +1927,8 @@ enum blk_eh_timer_return
 
 	state = atomic_xchg(&op->state, FCPOP_STATE_IDLE);
 
-	nvme_cleanup_cmd(rq);
 	nvme_fc_unmap_data(ctrl, rq, op);
+	nvme_cleanup_cmd(rq);
 	nvme_complete_rq(rq);
 	nvme_fc_ctrl_put(ctrl);
 
-- 
1.7.1
