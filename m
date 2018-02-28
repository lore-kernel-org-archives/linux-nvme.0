From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Wed, 28 Feb 2018 16:49:31 +0100
Subject: [PATCH 11/15] lightnvm: pblk: rename ppaf* to addrf*
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519832975-25432-12-git-send-email-javier@cnexlabs.com>

In preparation for 2.0 support in pblk, rename variables referring to
the address format to addrf and reserve ppaf for the 1.2 path.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c  |  8 ++++----
 drivers/lightnvm/pblk-sysfs.c |  4 ++--
 drivers/lightnvm/pblk.h       | 16 ++++++++--------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b67b5b11ae16..73b221c69cfd 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -80,7 +80,7 @@ static size_t pblk_trans_map_size(struct pblk *pblk)
 {
 	int entry_size = 8;
 
-	if (pblk->ppaf_bitsize < 32)
+	if (pblk->addrf_len < 32)
 		entry_size = 4;
 
 	return entry_size * pblk->rl.nr_secs;
@@ -198,7 +198,7 @@ static int pblk_set_addrf_12(struct nvm_geo *geo,
 	return dst->blk_offset + src->blk_len;
 }
 
-static int pblk_set_ppaf(struct pblk *pblk)
+static int pblk_set_addrf(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -210,7 +210,7 @@ static int pblk_set_ppaf(struct pblk *pblk)
 		return -EINVAL;
 	}
 
-	pblk->ppaf_bitsize = pblk_set_addrf_12(geo, (void *)&pblk->ppaf);
+	pblk->addrf_len = pblk_set_addrf_12(geo, (void *)&pblk->addrf);
 
 	return 0;
 }
@@ -319,7 +319,7 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->r_end_wq)
 		goto free_bb_wq;
 
-	if (pblk_set_ppaf(pblk))
+	if (pblk_set_addrf(pblk))
 		goto free_r_end_wq;
 
 	if (pblk_rwb_init(pblk))
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 462a787893d5..cbb5b6edb7bf 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -117,12 +117,12 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
 	struct nvm_addr_format_12 *geo_ppaf;
 	ssize_t sz = 0;
 
-	ppaf = (struct nvm_addr_format_12 *)&pblk->ppaf;
+	ppaf = (struct nvm_addr_format_12 *)&pblk->addrf;
 	geo_ppaf = (struct nvm_addr_format_12 *)&geo->addrf;
 
 	sz = snprintf(page, PAGE_SIZE,
 		"pblk:(s:%d)ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
-			pblk->ppaf_bitsize,
+			pblk->addrf_len,
 			ppaf->ch_offset, ppaf->ch_len,
 			ppaf->lun_offset, ppaf->lun_len,
 			ppaf->blk_offset, ppaf->blk_len,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index bae2cc758de8..dd0089fe62b9 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -570,8 +570,8 @@ struct pblk {
 	struct pblk_line_mgmt l_mg;		/* Line management */
 	struct pblk_line_meta lm;		/* Line metadata */
 
-	struct nvm_addr_format ppaf;
-	int ppaf_bitsize;
+	struct nvm_addr_format addrf;
+	int addrf_len;
 
 	struct pblk_rb rwb;
 
@@ -948,7 +948,7 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
 					      u64 line_id)
 {
 	struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&pblk->ppaf;
+				(struct nvm_addr_format_12 *)&pblk->addrf;
 	struct ppa_addr ppa;
 
 	ppa.ppa = 0;
@@ -966,7 +966,7 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 							struct ppa_addr p)
 {
 	struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&pblk->ppaf;
+				(struct nvm_addr_format_12 *)&pblk->addrf;
 	u64 paddr;
 
 	paddr = (u64)p.g.ch << ppaf->ch_offset;
@@ -991,7 +991,7 @@ static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
 		ppa64.c.is_cached = 1;
 	} else {
 		struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&pblk->ppaf;
+				(struct nvm_addr_format_12 *)&pblk->addrf;
 
 		ppa64.g.ch = (ppa32 & ppaf->ch_mask) >> ppaf->ch_offset;
 		ppa64.g.lun = (ppa32 & ppaf->lun_mask) >> ppaf->lun_offset;
@@ -1015,7 +1015,7 @@ static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
 		ppa32 |= 1U << 31;
 	} else {
 		struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&pblk->ppaf;
+				(struct nvm_addr_format_12 *)&pblk->addrf;
 
 		ppa32 |= ppa64.g.ch << ppaf->ch_offset;
 		ppa32 |= ppa64.g.lun << ppaf->lun_offset;
@@ -1033,7 +1033,7 @@ static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
 {
 	struct ppa_addr ppa;
 
-	if (pblk->ppaf_bitsize < 32) {
+	if (pblk->addrf_len < 32) {
 		u32 *map = (u32 *)pblk->trans_map;
 
 		ppa = pblk_ppa32_to_ppa64(pblk, map[lba]);
@@ -1049,7 +1049,7 @@ static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
 static inline void pblk_trans_map_set(struct pblk *pblk, sector_t lba,
 						struct ppa_addr ppa)
 {
-	if (pblk->ppaf_bitsize < 32) {
+	if (pblk->addrf_len < 32) {
 		u32 *map = (u32 *)pblk->trans_map;
 
 		map[lba] = pblk_ppa64_to_ppa32(pblk, ppa);
-- 
2.7.4
