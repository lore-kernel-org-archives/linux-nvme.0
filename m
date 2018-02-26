From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Mon, 26 Feb 2018 14:18:49 +0100
Subject: [PATCH] lightnvm: pblk: remove unused variable
Message-ID: <1519651129-17897-1-git-send-email-javier@cnexlabs.com>

Remove unused variable after a previous cleanup (a8112b631adb)

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ce6a7cfdba66..e6cb4317bb50 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1071,7 +1071,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	int nr_bb = 0;
 	u64 off;
 	int bit = -1;
 	int emeta_secs;
@@ -1087,8 +1086,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 		bitmap_or(line->map_bitmap, line->map_bitmap, l_mg->bb_aux,
 							lm->sec_per_line);
 		line->sec_in_line -= geo->c.clba;
-		if (bit >= lm->emeta_bb)
-			nr_bb++;
 	}
 
 	/* Mark smeta metadata sectors as bad sectors */
-- 
2.7.4
