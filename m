From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Tue, 13 Feb 2018 15:06:04 +0100
Subject: [PATCH 4/8] lightnvm: convert address based on spec. version
In-Reply-To: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1518530768-20956-5-git-send-email-javier@cnexlabs.com>

Create the device ppa for both 1.2 and 2.0.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 include/linux/lightnvm.h | 52 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e035ae4c9acc..1148b3f22b27 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -412,16 +412,26 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
 						  struct ppa_addr r)
 {
 	struct nvm_geo *geo = &tgt_dev->geo;
-	struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&geo->c.addrf;
 	struct ppa_addr l;
 
-	l.ppa = ((u64)r.g.ch) << ppaf->ch_offset;
-	l.ppa |= ((u64)r.g.lun) << ppaf->lun_offset;
-	l.ppa |= ((u64)r.g.blk) << ppaf->blk_offset;
-	l.ppa |= ((u64)r.g.pg) << ppaf->pg_offset;
-	l.ppa |= ((u64)r.g.pl) << ppaf->pln_offset;
-	l.ppa |= ((u64)r.g.sec) << ppaf->sec_offset;
+	if (geo->c.version == NVM_OCSSD_SPEC_12) {
+		struct nvm_addr_format_12 *ppaf =
+				(struct nvm_addr_format_12 *)&geo->c.addrf;
+
+		l.ppa = ((u64)r.g.ch) << ppaf->ch_offset;
+		l.ppa |= ((u64)r.g.lun) << ppaf->lun_offset;
+		l.ppa |= ((u64)r.g.blk) << ppaf->blk_offset;
+		l.ppa |= ((u64)r.g.pg) << ppaf->pg_offset;
+		l.ppa |= ((u64)r.g.pl) << ppaf->pln_offset;
+		l.ppa |= ((u64)r.g.sec) << ppaf->sec_offset;
+	} else {
+		struct nvm_addr_format *lbaf = &geo->c.addrf;
+
+		l.ppa = ((u64)r.m.ch) << lbaf->ch_offset;
+		l.ppa |= ((u64)r.m.lun) << lbaf->lun_offset;
+		l.ppa |= ((u64)r.m.chk) << lbaf->chk_offset;
+		l.ppa |= ((u64)r.m.sec) << lbaf->sec_offset;
+	}
 
 	return l;
 }
@@ -430,18 +440,28 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
 						  struct ppa_addr r)
 {
 	struct nvm_geo *geo = &tgt_dev->geo;
-	struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&geo->c.addrf;
 	struct ppa_addr l;
 
 	l.ppa = 0;
 
-	l.g.ch = (r.ppa & ppaf->ch_mask) >> ppaf->ch_offset;
-	l.g.lun = (r.ppa & ppaf->lun_mask) >> ppaf->lun_offset;
-	l.g.blk = (r.ppa & ppaf->blk_mask) >> ppaf->blk_offset;
-	l.g.pg = (r.ppa & ppaf->pg_mask) >> ppaf->pg_offset;
-	l.g.pl = (r.ppa & ppaf->pln_mask) >> ppaf->pln_offset;
-	l.g.sec = (r.ppa & ppaf->sec_mask) >> ppaf->sec_offset;
+	if (geo->c.version == NVM_OCSSD_SPEC_12) {
+		struct nvm_addr_format_12 *ppaf =
+				(struct nvm_addr_format_12 *)&geo->c.addrf;
+
+		l.g.ch = (r.ppa & ppaf->ch_mask) >> ppaf->ch_offset;
+		l.g.lun = (r.ppa & ppaf->lun_mask) >> ppaf->lun_offset;
+		l.g.blk = (r.ppa & ppaf->blk_mask) >> ppaf->blk_offset;
+		l.g.pg = (r.ppa & ppaf->pg_mask) >> ppaf->pg_offset;
+		l.g.pl = (r.ppa & ppaf->pln_mask) >> ppaf->pln_offset;
+		l.g.sec = (r.ppa & ppaf->sec_mask) >> ppaf->sec_offset;
+	} else {
+		struct nvm_addr_format *lbaf = &geo->c.addrf;
+
+		l.m.ch = (r.ppa & lbaf->ch_mask) >> lbaf->ch_offset;
+		l.m.lun = (r.ppa & lbaf->lun_mask) >> lbaf->lun_offset;
+		l.m.chk = (r.ppa & lbaf->chk_mask) >> lbaf->chk_offset;
+		l.m.sec = (r.ppa & lbaf->sec_mask) >> lbaf->sec_offset;
+	}
 
 	return l;
 }
-- 
2.7.4
