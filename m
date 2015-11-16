From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:44 +0100
Subject: [PATCH 10/13] lightnvm: remove linear and device addr modes
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-11-git-send-email-m@bjorling.me>

The linear and device specific address modes can be replaced with a
simple offset and bit length conversion that is generic across all
devices.

This both simplifies the specification and removes the special case for
qemu nvme, that previously relied on the linear address mapping.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/lightnvm/core.c      |   3 +-
 drivers/lightnvm/gennvm.c    |  12 ++--
 drivers/lightnvm/rrpc.c      |  32 ++++++++-
 drivers/nvme/host/lightnvm.c |   3 +-
 include/linux/lightnvm.h     | 154 ++++++++++---------------------------------
 5 files changed, 73 insertions(+), 131 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 899f6b9..790b1d7 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -174,8 +174,7 @@ static int nvm_core_init(struct nvm_dev *dev)
 	dev->sec_size = grp->csecs;
 	dev->oob_size = grp->sos;
 	dev->sec_per_pg = grp->fpg_sz / grp->csecs;
-	dev->addr_mode = id->ppat;
-	dev->addr_format = id->ppaf;
+	memcpy(&dev->ppaf, &id->ppaf, sizeof(struct nvm_addr_format));
 
 	dev->plane_mode = NVM_PLANE_SINGLE;
 	dev->max_rq_size = dev->ops->max_phys_sect * dev->sec_size;
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 8cfc011..c0d0eb2 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -73,7 +73,7 @@ static int gennvm_block_bb(struct ppa_addr ppa, int nr_blocks, u8 *blks,
 	struct nvm_block *blk;
 	int i;
 
-	ppa = addr_to_generic_mode(gn->dev, ppa);
+	ppa = dev_to_generic_addr(gn->dev, ppa);
 	lun = &gn->luns[(dev->nr_luns * ppa.g.ch) + ppa.g.lun];
 
 	for (i = 0; i < nr_blocks; i++) {
@@ -179,7 +179,7 @@ static int gennvm_blocks_init(struct nvm_dev *dev, struct gen_nvm *gn)
 			ppa.ppa = 0;
 			ppa.g.ch = lun->vlun.chnl_id;
 			ppa.g.lun = lun->vlun.id;
-			ppa = generic_to_addr_mode(dev, ppa);
+			ppa = generic_to_dev_addr(dev, ppa);
 
 			ret = dev->ops->get_bb_tbl(dev->q, ppa,
 						dev->blks_per_lun,
@@ -304,10 +304,10 @@ static void gennvm_addr_to_generic_mode(struct nvm_dev *dev, struct nvm_rq *rqd)
 
 	if (rqd->nr_pages > 1) {
 		for (i = 0; i < rqd->nr_pages; i++)
-			rqd->ppa_list[i] = addr_to_generic_mode(dev,
+			rqd->ppa_list[i] = dev_to_generic_addr(dev,
 							rqd->ppa_list[i]);
 	} else {
-		rqd->ppa_addr = addr_to_generic_mode(dev, rqd->ppa_addr);
+		rqd->ppa_addr = dev_to_generic_addr(dev, rqd->ppa_addr);
 	}
 }
 
@@ -317,10 +317,10 @@ static void gennvm_generic_to_addr_mode(struct nvm_dev *dev, struct nvm_rq *rqd)
 
 	if (rqd->nr_pages > 1) {
 		for (i = 0; i < rqd->nr_pages; i++)
-			rqd->ppa_list[i] = generic_to_addr_mode(dev,
+			rqd->ppa_list[i] = generic_to_dev_addr(dev,
 							rqd->ppa_list[i]);
 	} else {
-		rqd->ppa_addr = generic_to_addr_mode(dev, rqd->ppa_addr);
+		rqd->ppa_addr = generic_to_dev_addr(dev, rqd->ppa_addr);
 	}
 }
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 7ba64c8..75e59c3 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -123,12 +123,42 @@ static u64 block_to_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
 	return blk->id * rrpc->dev->pgs_per_blk;
 }
 
+static struct ppa_addr linear_to_generic_addr(struct nvm_dev *dev,
+							struct ppa_addr r)
+{
+	struct ppa_addr l;
+	int secs, pgs, blks, luns;
+	sector_t ppa = r.ppa;
+
+	l.ppa = 0;
+
+	div_u64_rem(ppa, dev->sec_per_pg, &secs);
+	l.g.sec = secs;
+
+	sector_div(ppa, dev->sec_per_pg);
+	div_u64_rem(ppa, dev->sec_per_blk, &pgs);
+	l.g.pg = pgs;
+
+	sector_div(ppa, dev->pgs_per_blk);
+	div_u64_rem(ppa, dev->blks_per_lun, &blks);
+	l.g.blk = blks;
+
+	sector_div(ppa, dev->blks_per_lun);
+	div_u64_rem(ppa, dev->luns_per_chnl, &luns);
+	l.g.lun = luns;
+
+	sector_div(ppa, dev->luns_per_chnl);
+	l.g.ch = ppa;
+
+	return l;
+}
+
 static struct ppa_addr rrpc_ppa_to_gaddr(struct nvm_dev *dev, u64 addr)
 {
 	struct ppa_addr paddr;
 
 	paddr.ppa = addr;
-	return __linear_to_generic_addr(dev, paddr);
+	return linear_to_generic_addr(dev, paddr);
 }
 
 /* requires lun->lock taken */
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 52b311c..9069be8 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -198,8 +198,7 @@ struct nvme_nvm_id {
 	__le32			cap;
 	__le32			dom;
 	struct nvme_nvm_addr_format ppaf;
-	__u8			ppat;
-	__u8			resv[223];
+	__u8			resv[224];
 	struct nvme_nvm_id_group groups[4];
 } __packed;
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e6ef8aa..cbe288a 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -99,7 +99,6 @@ struct nvm_id {
 	u32	cap;
 	u32	dom;
 	struct nvm_addr_format ppaf;
-	u8	ppat;
 	struct nvm_id_group groups[4];
 } __packed;
 
@@ -119,39 +118,28 @@ struct nvm_tgt_instance {
 #define NVM_VERSION_MINOR 0
 #define NVM_VERSION_PATCH 0
 
-#define NVM_SEC_BITS (8)
-#define NVM_PL_BITS  (6)
-#define NVM_PG_BITS  (16)
 #define NVM_BLK_BITS (16)
-#define NVM_LUN_BITS (10)
+#define NVM_PG_BITS  (16)
+#define NVM_SEC_BITS (8)
+#define NVM_PL_BITS  (8)
+#define NVM_LUN_BITS (8)
 #define NVM_CH_BITS  (8)
 
 struct ppa_addr {
+	/* Generic structure for all addresses */
 	union {
-		/* Channel-based PPA format in nand 4x2x2x2x8x10 */
-		struct {
-			u64 ch		: 4;
-			u64 sec		: 2; /* 4 sectors per page */
-			u64 pl		: 2; /* 4 planes per LUN */
-			u64 lun		: 2; /* 4 LUNs per channel */
-			u64 pg		: 8; /* 256 pages per block */
-			u64 blk		: 10;/* 1024 blocks per plane */
-			u64 resved		: 36;
-		} chnl;
-
-		/* Generic structure for all addresses */
 		struct {
+			u64 blk		: NVM_BLK_BITS;
+			u64 pg		: NVM_PG_BITS;
 			u64 sec		: NVM_SEC_BITS;
 			u64 pl		: NVM_PL_BITS;
-			u64 pg		: NVM_PG_BITS;
-			u64 blk		: NVM_BLK_BITS;
 			u64 lun		: NVM_LUN_BITS;
 			u64 ch		: NVM_CH_BITS;
 		} g;
 
 		u64 ppa;
 	};
-} __packed;
+};
 
 struct nvm_rq {
 	struct nvm_tgt_instance *ins;
@@ -259,8 +247,7 @@ struct nvm_dev {
 	int blks_per_lun;
 	int sec_size;
 	int oob_size;
-	int addr_mode;
-	struct nvm_addr_format addr_format;
+	struct nvm_addr_format ppaf;
 
 	/* Calculated/Cached values. These do not reflect the actual usable
 	 * blocks at run-time.
@@ -286,118 +273,45 @@ struct nvm_dev {
 	char name[DISK_NAME_LEN];
 };
 
-/* fallback conversion */
-static struct ppa_addr __generic_to_linear_addr(struct nvm_dev *dev,
-							struct ppa_addr r)
+static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
+						struct ppa_addr r)
 {
 	struct ppa_addr l;
 
-	l.ppa = r.g.sec +
-		r.g.pg  * dev->sec_per_pg +
-		r.g.blk * (dev->pgs_per_blk *
-				dev->sec_per_pg) +
-		r.g.lun * (dev->blks_per_lun *
-				dev->pgs_per_blk *
-				dev->sec_per_pg) +
-		r.g.ch * (dev->blks_per_lun *
-				dev->pgs_per_blk *
-				dev->luns_per_chnl *
-				dev->sec_per_pg);
+	l.ppa = ((u64)r.g.blk) << dev->ppaf.blk_offset;
+	l.ppa |= ((u64)r.g.pg) << dev->ppaf.pg_offset;
+	l.ppa |= ((u64)r.g.sec) << dev->ppaf.sect_offset;
+	l.ppa |= ((u64)r.g.pl) << dev->ppaf.pln_offset;
+	l.ppa |= ((u64)r.g.lun) << dev->ppaf.lun_offset;
+	l.ppa |= ((u64)r.g.ch) << dev->ppaf.ch_offset;
 
 	return l;
 }
 
-/* fallback conversion */
-static struct ppa_addr __linear_to_generic_addr(struct nvm_dev *dev,
-							struct ppa_addr r)
+static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
+						struct ppa_addr r)
 {
 	struct ppa_addr l;
-	int secs, pgs, blks, luns;
-	sector_t ppa = r.ppa;
 
-	l.ppa = 0;
-
-	div_u64_rem(ppa, dev->sec_per_pg, &secs);
-	l.g.sec = secs;
-
-	sector_div(ppa, dev->sec_per_pg);
-	div_u64_rem(ppa, dev->sec_per_blk, &pgs);
-	l.g.pg = pgs;
-
-	sector_div(ppa, dev->pgs_per_blk);
-	div_u64_rem(ppa, dev->blks_per_lun, &blks);
-	l.g.blk = blks;
-
-	sector_div(ppa, dev->blks_per_lun);
-	div_u64_rem(ppa, dev->luns_per_chnl, &luns);
-	l.g.lun = luns;
-
-	sector_div(ppa, dev->luns_per_chnl);
-	l.g.ch = ppa;
-
-	return l;
-}
-
-static struct ppa_addr __generic_to_chnl_addr(struct ppa_addr r)
-{
-	struct ppa_addr l;
-
-	l.ppa = 0;
-
-	l.chnl.sec = r.g.sec;
-	l.chnl.pl = r.g.pl;
-	l.chnl.pg = r.g.pg;
-	l.chnl.blk = r.g.blk;
-	l.chnl.lun = r.g.lun;
-	l.chnl.ch = r.g.ch;
+	/*
+	 * (r.ppa << X offset) & X len bitmask. X eq. blk, pg, etc.
+	 */
+	l.g.blk = (r.ppa >> dev->ppaf.blk_offset) &
+					(((1 << dev->ppaf.blk_len) - 1));
+	l.g.pg |= (r.ppa >> dev->ppaf.pg_offset) &
+					(((1 << dev->ppaf.pg_len) - 1));
+	l.g.sec |= (r.ppa >> dev->ppaf.sect_offset) &
+					(((1 << dev->ppaf.sect_len) - 1));
+	l.g.pl |= (r.ppa >> dev->ppaf.pln_offset) &
+					(((1 << dev->ppaf.pln_len) - 1));
+	l.g.lun |= (r.ppa >> dev->ppaf.lun_offset) &
+					(((1 << dev->ppaf.lun_len) - 1));
+	l.g.ch |= (r.ppa >> dev->ppaf.ch_offset) &
+					(((1 << dev->ppaf.ch_len) - 1));
 
 	return l;
 }
 
-static struct ppa_addr __chnl_to_generic_addr(struct ppa_addr r)
-{
-	struct ppa_addr l;
-
-	l.ppa = 0;
-
-	l.g.sec = r.chnl.sec;
-	l.g.pl = r.chnl.pl;
-	l.g.pg = r.chnl.pg;
-	l.g.blk = r.chnl.blk;
-	l.g.lun = r.chnl.lun;
-	l.g.ch = r.chnl.ch;
-
-	return l;
-}
-
-static inline struct ppa_addr addr_to_generic_mode(struct nvm_dev *dev,
-						struct ppa_addr gppa)
-{
-	switch (dev->addr_mode) {
-	case NVM_ADDRMODE_LINEAR:
-		return __linear_to_generic_addr(dev, gppa);
-	case NVM_ADDRMODE_CHANNEL:
-		return __chnl_to_generic_addr(gppa);
-	default:
-		BUG();
-	}
-	return gppa;
-}
-
-static inline struct ppa_addr generic_to_addr_mode(struct nvm_dev *dev,
-						struct ppa_addr gppa)
-{
-	switch (dev->addr_mode) {
-	case NVM_ADDRMODE_LINEAR:
-		return __generic_to_linear_addr(dev, gppa);
-	case NVM_ADDRMODE_CHANNEL:
-		return __generic_to_chnl_addr(gppa);
-	default:
-		BUG();
-	}
-	return gppa;
-}
-
 static inline int ppa_empty(struct ppa_addr ppa_addr)
 {
 	return (ppa_addr.ppa == ADDR_EMPTY);
-- 
2.1.4
