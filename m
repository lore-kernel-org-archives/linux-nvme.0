From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Mon, 26 Feb 2018 14:17:12 +0100
Subject: [PATCH 13/19] lightnvm: make address conversions depend on generic
 device
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519651038-16845-14-git-send-email-javier@cnexlabs.com>

On address conversions, use the generic device, instead of the target
device. This allows to use conversions outside of the target's realm.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/lightnvm/core.c  |  4 ++--
 include/linux/lightnvm.h | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 92ea6e39dd64..fae5e8c6fcd0 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -588,7 +588,7 @@ static void nvm_ppa_tgt_to_dev(struct nvm_tgt_dev *tgt_dev,
 
 	for (i = 0; i < nr_ppas; i++) {
 		nvm_map_to_dev(tgt_dev, &ppa_list[i]);
-		ppa_list[i] = generic_to_dev_addr(tgt_dev, ppa_list[i]);
+		ppa_list[i] = generic_to_dev_addr(tgt_dev->parent, ppa_list[i]);
 	}
 }
 
@@ -598,7 +598,7 @@ static void nvm_ppa_dev_to_tgt(struct nvm_tgt_dev *tgt_dev,
 	int i;
 
 	for (i = 0; i < nr_ppas; i++) {
-		ppa_list[i] = dev_to_generic_addr(tgt_dev, ppa_list[i]);
+		ppa_list[i] = dev_to_generic_addr(tgt_dev->parent, ppa_list[i]);
 		nvm_map_to_tgt(tgt_dev, &ppa_list[i]);
 	}
 }
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 8cda1125c34a..2b909592568a 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -405,15 +405,15 @@ struct nvm_dev {
 	struct list_head targets;
 };
 
-static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
+static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
 						  struct ppa_addr r)
 {
-	struct nvm_geo *geo = &tgt_dev->geo;
+	struct nvm_geo *dev_geo = &dev->geo;
 	struct ppa_addr l;
 
-	if (geo->c.version == NVM_OCSSD_SPEC_12) {
+	if (dev_geo->c.version == NVM_OCSSD_SPEC_12) {
 		struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&geo->c.addrf;
+				(struct nvm_addr_format_12 *)&dev_geo->c.addrf;
 
 		l.ppa = ((u64)r.g.ch) << ppaf->ch_offset;
 		l.ppa |= ((u64)r.g.lun) << ppaf->lun_offset;
@@ -422,7 +422,7 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
 		l.ppa |= ((u64)r.g.pl) << ppaf->pln_offset;
 		l.ppa |= ((u64)r.g.sec) << ppaf->sec_offset;
 	} else {
-		struct nvm_addr_format *lbaf = &geo->c.addrf;
+		struct nvm_addr_format *lbaf = &dev_geo->c.addrf;
 
 		l.ppa = ((u64)r.m.grp) << lbaf->ch_offset;
 		l.ppa |= ((u64)r.m.pu) << lbaf->lun_offset;
@@ -433,17 +433,17 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
 	return l;
 }
 
-static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
+static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 						  struct ppa_addr r)
 {
-	struct nvm_geo *geo = &tgt_dev->geo;
+	struct nvm_geo *dev_geo = &dev->geo;
 	struct ppa_addr l;
 
 	l.ppa = 0;
 
-	if (geo->c.version == NVM_OCSSD_SPEC_12) {
+	if (dev_geo->c.version == NVM_OCSSD_SPEC_12) {
 		struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&geo->c.addrf;
+				(struct nvm_addr_format_12 *)&dev_geo->c.addrf;
 
 		l.g.ch = (r.ppa & ppaf->ch_mask) >> ppaf->ch_offset;
 		l.g.lun = (r.ppa & ppaf->lun_mask) >> ppaf->lun_offset;
@@ -452,7 +452,7 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
 		l.g.pl = (r.ppa & ppaf->pln_mask) >> ppaf->pln_offset;
 		l.g.sec = (r.ppa & ppaf->sec_mask) >> ppaf->sec_offset;
 	} else {
-		struct nvm_addr_format *lbaf = &geo->c.addrf;
+		struct nvm_addr_format *lbaf = &dev_geo->c.addrf;
 
 		l.m.grp = (r.ppa & lbaf->ch_mask) >> lbaf->ch_offset;
 		l.m.pu = (r.ppa & lbaf->lun_mask) >> lbaf->lun_offset;
-- 
2.7.4
