From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:37 +0100
Subject: [PATCH 03/13] lightnvm: update bad block table format
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-4-git-send-email-m@bjorling.me>

The specification was changed to reflect a multi-value bad block table.
Instead of bit-based bad block table, the bad block table now allows
eight bad block categories. Currently four are defined:

 * Factory bad blocks
 * Grown bad blocks
 * Device-side reserved blocks
 * Host-side reserved blocks

The factory and grown bad blocks are the regular bad blocks. The
reserved blocks are either for internal use or external use. In
particular, the device-side reserved blocks allows the host to
bootstrap from a limited number of flash blocks. Reducing the flash
blocks to scan upon super block initialization.

Support for both get bad block table and set bad block table is added.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/lightnvm/gennvm.c    |  32 ++++++++----
 drivers/lightnvm/gennvm.h    |   2 +
 drivers/nvme/host/lightnvm.c | 113 ++++++++++++++++++++++++++++++++++---------
 include/linux/lightnvm.h     |   6 +--
 4 files changed, 117 insertions(+), 36 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index ae1fb2b..8cfc011 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -64,19 +64,22 @@ static int gennvm_luns_init(struct nvm_dev *dev, struct gen_nvm *gn)
 	return 0;
 }
 
-static int gennvm_block_bb(u32 lun_id, void *bb_bitmap, unsigned int nr_blocks,
+static int gennvm_block_bb(struct ppa_addr ppa, int nr_blocks, u8 *blks,
 								void *private)
 {
 	struct gen_nvm *gn = private;
-	struct gen_lun *lun = &gn->luns[lun_id];
+	struct nvm_dev *dev = gn->dev;
+	struct gen_lun *lun;
 	struct nvm_block *blk;
 	int i;
 
-	if (unlikely(bitmap_empty(bb_bitmap, nr_blocks)))
-		return 0;
+	ppa = addr_to_generic_mode(gn->dev, ppa);
+	lun = &gn->luns[(dev->nr_luns * ppa.g.ch) + ppa.g.lun];
+
+	for (i = 0; i < nr_blocks; i++) {
+		if (blks[i] == 0)
+			continue;
 
-	i = -1;
-	while ((i = find_next_bit(bb_bitmap, nr_blocks, i + 1)) < nr_blocks) {
 		blk = &lun->vlun.blocks[i];
 		if (!blk) {
 			pr_err("gennvm: BB data is out of bounds.\n");
@@ -171,8 +174,16 @@ static int gennvm_blocks_init(struct nvm_dev *dev, struct gen_nvm *gn)
 		}
 
 		if (dev->ops->get_bb_tbl) {
-			ret = dev->ops->get_bb_tbl(dev->q, lun->vlun.id,
-					dev->blks_per_lun, gennvm_block_bb, gn);
+			struct ppa_addr ppa;
+
+			ppa.ppa = 0;
+			ppa.g.ch = lun->vlun.chnl_id;
+			ppa.g.lun = lun->vlun.id;
+			ppa = generic_to_addr_mode(dev, ppa);
+
+			ret = dev->ops->get_bb_tbl(dev->q, ppa,
+						dev->blks_per_lun,
+						gennvm_block_bb, gn);
 			if (ret)
 				pr_err("gennvm: could not read BB table\n");
 		}
@@ -199,6 +210,7 @@ static int gennvm_register(struct nvm_dev *dev)
 	if (!gn)
 		return -ENOMEM;
 
+	gn->dev = dev;
 	gn->nr_luns = dev->nr_luns;
 	dev->mp = gn;
 
@@ -354,10 +366,10 @@ static void gennvm_mark_blk_bad(struct nvm_dev *dev, struct nvm_rq *rqd)
 {
 	int i;
 
-	if (!dev->ops->set_bb)
+	if (!dev->ops->set_bb_tbl)
 		return;
 
-	if (dev->ops->set_bb(dev->q, rqd, 1))
+	if (dev->ops->set_bb_tbl(dev->q, rqd, 1))
 		return;
 
 	gennvm_addr_to_generic_mode(dev, rqd);
diff --git a/drivers/lightnvm/gennvm.h b/drivers/lightnvm/gennvm.h
index d23bd35..9c24b5b 100644
--- a/drivers/lightnvm/gennvm.h
+++ b/drivers/lightnvm/gennvm.h
@@ -35,6 +35,8 @@ struct gen_lun {
 };
 
 struct gen_nvm {
+	struct nvm_dev *dev;
+
 	int nr_luns;
 	struct gen_lun *luns;
 };
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e0b7b95..2c35465 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -93,7 +93,7 @@ struct nvme_nvm_l2ptbl {
 	__le16			cdw14[6];
 };
 
-struct nvme_nvm_bbtbl {
+struct nvme_nvm_getbbtbl {
 	__u8			opcode;
 	__u8			flags;
 	__u16			command_id;
@@ -101,10 +101,23 @@ struct nvme_nvm_bbtbl {
 	__u64			rsvd[2];
 	__le64			prp1;
 	__le64			prp2;
-	__le32			prp1_len;
-	__le32			prp2_len;
-	__le32			lbb;
-	__u32			rsvd11[3];
+	__le64			spba;
+	__u32			rsvd4[4];
+};
+
+struct nvme_nvm_setbbtbl {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd[2];
+	__le64			prp1;
+	__le64			prp2;
+	__le64			spba;
+	__le16			nlb;
+	__u8			value;
+	__u8			rsvd3;
+	__u32			rsvd4[3];
 };
 
 struct nvme_nvm_erase_blk {
@@ -129,8 +142,8 @@ struct nvme_nvm_command {
 		struct nvme_nvm_hb_rw hb_rw;
 		struct nvme_nvm_ph_rw ph_rw;
 		struct nvme_nvm_l2ptbl l2p;
-		struct nvme_nvm_bbtbl get_bb;
-		struct nvme_nvm_bbtbl set_bb;
+		struct nvme_nvm_getbbtbl get_bb;
+		struct nvme_nvm_setbbtbl set_bb;
 		struct nvme_nvm_erase_blk erase;
 	};
 };
@@ -187,6 +200,20 @@ struct nvme_nvm_id {
 	struct nvme_nvm_id_group groups[4];
 } __packed;
 
+struct nvme_nvm_bb_tbl {
+	__u8	tblid[4];
+	__le16	verid;
+	__le16	revid;
+	__le32	rvsd1;
+	__le32	tblks;
+	__le32	tfact;
+	__le32	tgrown;
+	__le32	tdresv;
+	__le32	thresv;
+	__le32	rsvd2[8];
+	__u8	blk[0];
+};
+
 /*
  * Check we didn't inadvertently grow the command struct
  */
@@ -195,12 +222,14 @@ static inline void _nvme_nvm_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_identity) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_hb_rw) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_ph_rw) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_nvm_bbtbl) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_getbbtbl) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_setbbtbl) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_l2ptbl) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_erase_blk) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_id_group) != 960);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_addr_format) != 128);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_id) != 4096);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) != 512);
 }
 
 static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
@@ -322,43 +351,80 @@ out:
 	return ret;
 }
 
-static int nvme_nvm_get_bb_tbl(struct request_queue *q, int lunid,
-				unsigned int nr_blocks,
-				nvm_bb_update_fn *update_bbtbl, void *priv)
+static int nvme_nvm_get_bb_tbl(struct request_queue *q, struct ppa_addr ppa,
+				int nr_blocks, nvm_bb_update_fn *update_bbtbl,
+				void *priv)
 {
 	struct nvme_ns *ns = q->queuedata;
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_nvm_command c = {};
-	void *bb_bitmap;
-	u16 bb_bitmap_size;
+	struct nvme_nvm_bb_tbl *bb_tbl;
+	int tblsz = sizeof(struct nvme_nvm_bb_tbl) + nr_blocks;
 	int ret = 0;
 
 	c.get_bb.opcode = nvme_nvm_admin_get_bb_tbl;
 	c.get_bb.nsid = cpu_to_le32(ns->ns_id);
-	c.get_bb.lbb = cpu_to_le32(lunid);
-	bb_bitmap_size = ((nr_blocks >> 15) + 1) * PAGE_SIZE;
-	bb_bitmap = kmalloc(bb_bitmap_size, GFP_KERNEL);
-	if (!bb_bitmap)
+	c.get_bb.spba = cpu_to_le64(ppa.ppa);
+
+	bb_tbl = kzalloc(tblsz, GFP_KERNEL);
+	if (!bb_tbl)
 		return -ENOMEM;
 
-	bitmap_zero(bb_bitmap, nr_blocks);
-
-	ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c, bb_bitmap,
-								bb_bitmap_size);
+	ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c, bb_tbl, tblsz);
 	if (ret) {
 		dev_err(dev->dev, "get bad block table failed (%d)\n", ret);
 		ret = -EIO;
 		goto out;
 	}
 
-	ret = update_bbtbl(lunid, bb_bitmap, nr_blocks, priv);
+	if (bb_tbl->tblid[0] != 'B' || bb_tbl->tblid[1] != 'B' ||
+		bb_tbl->tblid[2] != 'L' || bb_tbl->tblid[3] != 'T') {
+		dev_err(dev->dev, "bbt format mismatch\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (le16_to_cpu(bb_tbl->verid) != 1) {
+		ret = -EINVAL;
+		dev_err(dev->dev, "bbt version not supported\n");
+		goto out;
+	}
+
+	if (le32_to_cpu(bb_tbl->tblks) != nr_blocks) {
+		ret = -EINVAL;
+		dev_err(dev->dev, "bbt unsuspected blocks returned (%u!=%u)",
+					le32_to_cpu(bb_tbl->tblks), nr_blocks);
+		goto out;
+	}
+
+	ret = update_bbtbl(ppa, nr_blocks, bb_tbl->blk, priv);
 	if (ret) {
 		ret = -EINTR;
 		goto out;
 	}
 
 out:
-	kfree(bb_bitmap);
+	kfree(bb_tbl);
+	return ret;
+}
+
+static int nvme_nvm_set_bb_tbl(struct request_queue *q, struct nvm_rq *rqd,
+								int type)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_nvm_command c = {};
+	int ret = 0;
+
+	c.set_bb.opcode = nvme_nvm_admin_set_bb_tbl;
+	c.set_bb.nsid = cpu_to_le32(ns->ns_id);
+	c.set_bb.spba = cpu_to_le64(rqd->ppa_addr.ppa);
+	c.set_bb.nlb = cpu_to_le16(rqd->nr_pages - 1);
+	c.set_bb.value = type;
+
+	ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c, NULL, 0);
+	if (ret)
+		dev_err(dev->dev, "set bad block table failed (%d)\n", ret);
 	return ret;
 }
 
@@ -474,6 +540,7 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.get_l2p_tbl		= nvme_nvm_get_l2p_tbl,
 
 	.get_bb_tbl		= nvme_nvm_get_bb_tbl,
+	.set_bb_tbl		= nvme_nvm_set_bb_tbl,
 
 	.submit_io		= nvme_nvm_submit_io,
 	.erase_block		= nvme_nvm_erase_block,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 32b5369..9b3dc1b 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -191,11 +191,11 @@ static inline void *nvm_rq_to_pdu(struct nvm_rq *rqdata)
 struct nvm_block;
 
 typedef int (nvm_l2p_update_fn)(u64, u32, __le64 *, void *);
-typedef int (nvm_bb_update_fn)(u32, void *, unsigned int, void *);
+typedef int (nvm_bb_update_fn)(struct ppa_addr, int, u8 *, void *);
 typedef int (nvm_id_fn)(struct request_queue *, struct nvm_id *);
 typedef int (nvm_get_l2p_tbl_fn)(struct request_queue *, u64, u32,
 				nvm_l2p_update_fn *, void *);
-typedef int (nvm_op_bb_tbl_fn)(struct request_queue *, int, unsigned int,
+typedef int (nvm_op_bb_tbl_fn)(struct request_queue *, struct ppa_addr, int,
 				nvm_bb_update_fn *, void *);
 typedef int (nvm_op_set_bb_fn)(struct request_queue *, struct nvm_rq *, int);
 typedef int (nvm_submit_io_fn)(struct request_queue *, struct nvm_rq *);
@@ -210,7 +210,7 @@ struct nvm_dev_ops {
 	nvm_id_fn		*identity;
 	nvm_get_l2p_tbl_fn	*get_l2p_tbl;
 	nvm_op_bb_tbl_fn	*get_bb_tbl;
-	nvm_op_set_bb_fn	*set_bb;
+	nvm_op_set_bb_fn	*set_bb_tbl;
 
 	nvm_submit_io_fn	*submit_io;
 	nvm_erase_blk_fn	*erase_block;
-- 
2.1.4
