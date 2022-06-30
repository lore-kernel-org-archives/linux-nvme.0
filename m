Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BCCC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LVMgK7DArspWjjYk5Pf3yLv7JuoIp2oNJy7AUsJ+42M=; b=udu139T6T2kWIhJ5QyU9e0c/nR
	fqhWlo2wV/dkrQ1SqmUJdiqoihiAo2Y/JsNBb45Nu+0dH0qJHTYT6yG7aXEYBRLkHd0k2K5ntwDPh
	AfXc4ZIb3UIRIeDVa4r0rM1GeJhRhtm9w6eeQpS6w0FdkMw8XPLelGIRJQDjCcU/DMy6umyTMK+hZ
	w1SS9iEBH5ce2Sobyv5NgtvOCBvqFc2h2bgfkwR5zUms2OT5yBem6gqN9o1ZdLPh9mgSSRByePHPt
	/t8VjSZ/s4GZ0g6oC8LbtbODMv56doCwTHxOLVAEsUZZsD93BldBSuOSUXWDxluOlI9xAdfeYla84
	Vu74Oegw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7129-001U7F-1J; Thu, 30 Jun 2022 20:45:05 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7108-001T8k-07
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:43:03 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UHF2YH008879
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LVMgK7DArspWjjYk5Pf3yLv7JuoIp2oNJy7AUsJ+42M=;
 b=FoltLSOGm4BNovgtzoBvkP56ruLvhjjiqVjNo8z4CnFZ2ZRbtgI9L/JTsS2aS4k+JZZR
 LSr1E8ixLDovKqPKh+waGA8L5Z+wtZiqoFFmFAfYlZmI82fH95M0F9FDty3UQudUzB3q
 6wScXWNzY/QV/zJ6+z0UPMKIav/Duu0MSVA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h17gewyn9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:59 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:55 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id CD6965932DBE; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 06/12] nvme: add support for bit buckets
Date: Thu, 30 Jun 2022 13:42:06 -0700
Message-ID: <20220630204212.1265638-7-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hRwxv3ejlCAJgUq_cdV7ff0tMe7wBQIe
X-Proofpoint-GUID: hRwxv3ejlCAJgUq_cdV7ff0tMe7wBQIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134300_172232_453AAEEE 
X-CRM114-Status: GOOD (  23.17  )
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
index b5b24998a5ab..211bc30bb707 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3999,6 +3999,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
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
index 0da94b233fed..7401f58fe534 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -496,6 +496,7 @@ struct nvme_ctrl_ops {
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
 #define NVME_F_PCI_P2PDMA		(1 << 2)
+#define NVME_F_BB			(1 << 3)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
@@ -991,6 +992,11 @@ static inline bool nvme_ctrl_sgl_supported(struct nv=
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
index 247a74aba336..32894e392142 100644
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
@@ -3003,7 +3015,8 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
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
index e3934003f239..1fae005715fc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -835,6 +835,7 @@ enum {
  *
  * For struct nvme_sgl_desc:
  *   @NVME_SGL_FMT_DATA_DESC:		data block descriptor
+ *   @NVME_SGL_FMT_BB_DESC:		bit buckect descriptor
  *   @NVME_SGL_FMT_SEG_DESC:		sgl segment descriptor
  *   @NVME_SGL_FMT_LAST_SEG_DESC:	last sgl segment descriptor
  *
@@ -846,6 +847,7 @@ enum {
  */
 enum {
 	NVME_SGL_FMT_DATA_DESC		=3D 0x00,
+	NVME_SGL_FMT_BB_DESC		=3D 0x01,
 	NVME_SGL_FMT_SEG_DESC		=3D 0x02,
 	NVME_SGL_FMT_LAST_SEG_DESC	=3D 0x03,
 	NVME_KEY_SGL_FMT_DATA_DESC	=3D 0x04,
--=20
2.30.2


