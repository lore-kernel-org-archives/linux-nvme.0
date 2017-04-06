From: emilne@redhat.com (Ewan D. Milne)
Date: Thu,  6 Apr 2017 10:16:30 -0400
Subject: [PATCH] nvme_fc: avoid double kfree(),
 don't call nvme_cleanup_cmd() in nvme_unmap_data()
Message-ID: <1491488190-5564-1-git-send-email-emilne@redhat.com>

nvme_cleanup_cmd() is already called by callers of nvme_unmap_data().
Don't call it twice to avoid double-free on completion of discard commands.

Signed-off-by: Ewan D. Milne <emilne at redhat.com>
---
 drivers/nvme/host/fc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fc42172..b5f92cc 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1700,8 +1700,6 @@ enum blk_eh_timer_return
 				((rq_data_dir(rq) == WRITE) ?
 					DMA_TO_DEVICE : DMA_FROM_DEVICE));
 
-	nvme_cleanup_cmd(rq);
-
 	sg_free_table_chained(&freq->sg_table, true);
 
 	freq->sg_cnt = 0;
-- 
1.7.1
