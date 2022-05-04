Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF21C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BsS94mm+BZNwBGj1psZIy82rHM5UALpvUcvc5GioknM=; b=cn0tvUbmc/ou2UDIJ917ZQvrcP
	vjXTRMKtLMs/1XSwvZWuBg3/W9GRPbZxQQ4BY5NvQD+gXpFfHkcKI4s79e/wqvClcMBnOHN41waFH
	9HdjSaxt9ikCGJjnHjf/m2gUckAGLkwDH9UgyQYHqc/k1l3QE/7M0iyd5vxnHrZmsZbu/I2v5N0m/
	ZTRD9eZd9VVGenIICpoeVir32IDx5JjALpMyo7kNplvn7j02d0ltYjegm8gYLV1hsr1YVZQ3s8V6l
	VZJc2BDJdfERydgMlFoKgD+98yAbgUyudBCAV23jZNhv4jEbdED5fCreJaLShxFlEN+eRY449vd3g
	wweJlPvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmHvY-00Bfjh-J7; Wed, 04 May 2022 16:32:36 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmHvS-00Bfhi-D6
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 16:32:32 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 244DvaGP006416
 for <linux-nvme@lists.infradead.org>; Wed, 4 May 2022 09:32:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=BsS94mm+BZNwBGj1psZIy82rHM5UALpvUcvc5GioknM=;
 b=CbWlcDozF4x7TxeZkeHKqiK22dC7MZl9g0tkdJetzKr9lGtxDHs6ncLNXMJlYHG0VvkW
 ODZPArEaVUOYs9xTS9JlQwM2f75va11TEQH5FwZLe6gzA1j2JDxb9XPQupdDUsn/mNLj
 PNNpsMXLQxZS5E0YbHuQK+71lEGwk7WAZ0Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by m0001303.ppops.net (PPS) with ESMTPS id 3fuqp1t3vt-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 09:32:28 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 09:32:26 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
 id CEE303939686; Wed,  4 May 2022 09:32:22 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@kernel.vger.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [RFC 4/4] nvme: add bit bucket support
Date: Wed, 4 May 2022 09:32:07 -0700
Message-ID: <20220504163207.891761-5-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504163207.891761-1-kbusch@fb.com>
References: <20220504163207.891761-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MGU8ZcRAdajcmXbuKtZnCg089lcaTj-T
X-Proofpoint-GUID: MGU8ZcRAdajcmXbuKtZnCg089lcaTj-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_093230_640663_63D4E1D4 
X-CRM114-Status: GOOD (  23.39  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

Set the queue for bit bucket support if the hardware and driver support
it. The nvme pci driver will recognize the special bitbucket page for
read commands and set up an appropriate sg descriptor for it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c |  3 +++
 drivers/nvme/host/nvme.h |  6 ++++++
 drivers/nvme/host/pci.c  | 17 +++++++++++++++--
 include/linux/nvme.h     |  2 ++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e1846d04817f..bea054565eed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3928,6 +3928,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
=20
+	if (nvme_ctrl_sgl_bb_supported(ctrl) && ctrl->ops->flags & NVME_F_BB)
+		blk_queue_flag_set(QUEUE_FLAG_BIT_BUCKET, ns->queue);
+
 	ns->ctrl =3D ctrl;
 	kref_init(&ns->kref);
=20
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2b53ca63335..91d75f95fe39 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -495,6 +495,7 @@ struct nvme_ctrl_ops {
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
 #define NVME_F_PCI_P2PDMA		(1 << 2)
+#define NVME_F_BB			(1 << 3)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
@@ -957,6 +958,11 @@ static inline bool nvme_ctrl_sgl_supported(struct nv=
me_ctrl *ctrl)
 	return ctrl->sgls & ((1 << 0) | (1 << 1));
 }
=20
+static inline bool nvme_ctrl_sgl_bb_supported(struct nvme_ctrl *ctrl)
+{
+	return ctrl->sgls & (1 << 16);
+}
+
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 int nvme_execute_passthru_rq(struct request *rq);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aacf1c0d5a5..83e057f44867 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -535,6 +535,8 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev =
*dev, struct request *req)
=20
 	avg_seg_size =3D DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
=20
+	if (req->rq_flags & RQF_BIT_BUCKET)
+		return true;
 	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
 	if (!iod->nvmeq->qid)
@@ -724,6 +726,13 @@ static void nvme_pci_sgl_set_data(struct nvme_sgl_de=
sc *sge,
 	sge->type =3D NVME_SGL_FMT_DATA_DESC << 4;
 }
=20
+static void nvme_pci_sgl_set_bb(struct nvme_sgl_desc *sge,
+				struct scatterlist *sg)
+{
+	sge->length =3D cpu_to_le32(sg_dma_len(sg));
+	sge->type =3D NVME_SGL_FMT_BB_DESC << 4;
+}
+
 static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 		dma_addr_t dma_addr, int entries)
 {
@@ -789,7 +798,10 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_=
dev *dev,
 			nvme_pci_sgl_set_seg(link, sgl_dma, entries);
 		}
=20
-		nvme_pci_sgl_set_data(&sg_list[i++], sg);
+		if (rq_data_dir(req) =3D=3D READ && blk_is_bit_bucket(sg_page(sg)))
+			nvme_pci_sgl_set_bb(&sg_list[i++], sg);
+		else
+			nvme_pci_sgl_set_data(&sg_list[i++], sg);
 		sg =3D sg_next(sg);
 	} while (--entries > 0);
=20
@@ -2973,7 +2985,8 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
 =3D {
 	.name			=3D "pcie",
 	.module			=3D THIS_MODULE,
 	.flags			=3D NVME_F_METADATA_SUPPORTED |
-				  NVME_F_PCI_P2PDMA,
+				  NVME_F_PCI_P2PDMA |
+				  NVME_F_BB,
 	.reg_read32		=3D nvme_pci_reg_read32,
 	.reg_write32		=3D nvme_pci_reg_write32,
 	.reg_read64		=3D nvme_pci_reg_read64,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f626a445d1a8..27d568633e6e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -796,6 +796,7 @@ enum {
  *
  * For struct nvme_sgl_desc:
  *   @NVME_SGL_FMT_DATA_DESC:		data block descriptor
+ *   @NVME_SGL_FMT_BB_DESC:		bit buckect descriptor
  *   @NVME_SGL_FMT_SEG_DESC:		sgl segment descriptor
  *   @NVME_SGL_FMT_LAST_SEG_DESC:	last sgl segment descriptor
  *
@@ -807,6 +808,7 @@ enum {
  */
 enum {
 	NVME_SGL_FMT_DATA_DESC		=3D 0x00,
+	NVME_SGL_FMT_BB_DESC		=3D 0x01,
 	NVME_SGL_FMT_SEG_DESC		=3D 0x02,
 	NVME_SGL_FMT_LAST_SEG_DESC	=3D 0x03,
 	NVME_KEY_SGL_FMT_DATA_DESC	=3D 0x04,
--=20
2.30.2


