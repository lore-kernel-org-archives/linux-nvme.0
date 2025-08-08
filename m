Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71614C87FDA
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 16:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnVEN0Qg5E3J9URYGA3KFwVlmgiUbfXOh2icZeBfBt4=; b=M+jwFRv4cyMArW8TtNyCseyLS2
	ds5N0e+s3OzMhpaYlLz8q26HO4sfXZSViS/lEFjmKbvh0Ca5j+Agli8iaya7KelBItPQW3tK7zD1q
	EYVTa2iKd3GXpjEUclsEpt0Cft81yINQMW1sDpEzCeqW/S8o5qIwZ2iZeXgMi5yNZk5ovDECxBHra
	+nzkC757iH2SqSCr9O+mOJNGkBonNu6IEwBI+2pR+4Zf4KNn20/2STg8/yH7Tbk3t8CMBkfTBa+DW
	2SNefLMkWNZFZPCJqMTo9PLeouQPPL/ue/HkJyVuqpz+gVbs9eJCuiv4TGAX6FdrmBFmwvQzdRyYb
	4vftmG6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPWf-00000003G9f-0aDE;
	Fri, 08 Aug 2025 16:01:01 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPUR-00000003FfZ-2Zhf
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 15:58:44 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FKBbM021638
	for <linux-nvme@lists.infradead.org>; Fri, 8 Aug 2025 08:58:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OnVEN0Qg5E3J9URYGA3KFwVlmgiUbfXOh2icZeBfBt4=; b=LvCP1wKq0z1G
	AXnWtDALY6omIsU12Vd1mfg3b/fJRNTwnm5i8C+ItGw2DpdhSbfA0Lg6+T8T0UDh
	ugHrtXlXNn3afwPNnvNa4nRqzGKEiuXVo6TbIkkc2G2R9wOe0POWjQ27FmMi9+hC
	3XkccIx8Ve+gruLy/l+NCUnp/ylyYc+NSnwOKF/ZXqjGC90hwSueEV+oMCLgm9ki
	0GNNURsEP0VqaaiPMA1MQpTSIJ/AEg76zHyQlKmvzUF4H4HaKduVLOidGhDijSpE
	WkT4hAelCUXp0oglkEbFaOBWFLR0TBguSD5HU4DMJxL1PkxPUNEBYlJv2Ux9zJjU
	MNL4Civn0Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48dbwck3f3-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Aug 2025 08:58:43 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:34 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C22056C76C4; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 4/8] blk-mq: remove REQ_P2PDMA flag
Date: Fri, 8 Aug 2025 08:58:22 -0700
Message-ID: <20250808155826.1864803-5-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808155826.1864803-1-kbusch@meta.com>
References: <20250808155826.1864803-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX14l9Zwnor/7m svfuJEjgXYtJlLKmjLvBiNemxyeQtZgTthtUHUk1obeZIVUdLX8+BuFdaR2ifqVV8D5VPyuk0G3 Kc/C4OjUkOgsQA2a0kiyatu6VsEwCq42CAmsAbfMfIqr4g7hgNsmIdfxpNK9re2hIwLSa7VaZMl
 6wt2ovOfa6yNoV1eqrUrGe4uA7MDfSdnCvH+fHZVLG1lz6zRoofZ8rLfNi0uZ5gGRkzme52Wfkg 0Dn5M/vIJmXtld1XDn27EPEDejs23KQDG/A7Bnx8iI+PczawN/Ece0TZTNy4Fp3DXEi+DGS/G/D qPqj7DQq8/fzx8EywzFAoUPedkqm+hyE4K51YsMsTkkSt2+whgMzFIUTEo6+EWpMdWvHUINf0YP
 GDq44b+ctY+jPmE8O85f1Pm0en3ZA1YJamgFQfkmVyXrUn9rIxg5H9wjeb3zUuvaj5GFuoqf
X-Proofpoint-GUID: 5QPaSDwAwvNntIcAZpbK42cxvDMZQQFA
X-Authority-Analysis: v=2.4 cv=DthW+H/+ c=1 sm=1 tr=0 ts=68961eb3 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=gKVTuvNHKxM_LcN8e1sA:9
X-Proofpoint-ORIG-GUID: 5QPaSDwAwvNntIcAZpbK42cxvDMZQQFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_085843_657705_09027C95 
X-CRM114-Status: GOOD (  13.49  )
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

It's not serving any particular purpose. pci_p2pdma_state() already has
all the appropriate checks, so the config and flag checks are not
guarding anything.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               |  2 +-
 block/blk-mq-dma.c        | 30 ++++++++++++++----------------
 include/linux/blk_types.h |  2 --
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 92c512e876c8d..f56d285e6958e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -981,7 +981,7 @@ void __bio_add_page(struct bio *bio, struct page *pag=
e,
 	WARN_ON_ONCE(bio_full(bio, len));
=20
 	if (is_pci_p2pdma_page(page))
-		bio->bi_opf |=3D REQ_P2PDMA | REQ_NOMERGE;
+		bio->bi_opf |=3D REQ_NOMERGE;
=20
 	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
 	bio->bi_iter.bi_size +=3D len;
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 4a013703bcba5..988c27667df67 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -173,22 +173,20 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	if (!blk_map_iter_next(req, &iter->iter))
 		return false;
=20
-	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
-		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
-					 phys_to_page(iter->iter.paddr))) {
-		case PCI_P2PDMA_MAP_BUS_ADDR:
-			return blk_dma_map_bus(iter);
-		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-			/*
-			 * P2P transfers through the host bridge are treated the
-			 * same as non-P2P transfers below and during unmap.
-			 */
-			req->cmd_flags &=3D ~REQ_P2PDMA;
-			break;
-		default:
-			iter->status =3D BLK_STS_INVAL;
-			return false;
-		}
+	switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
+				 phys_to_page(iter->iter.paddr))) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return blk_dma_map_bus(iter);
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		/*
+		 * P2P transfers through the host bridge are treated the
+		 * same as non-P2P transfers below and during unmap.
+		 */
+	case PCI_P2PDMA_MAP_NONE:
+		break;
+	default:
+		iter->status =3D BLK_STS_INVAL;
+		return false;
 	}
=20
 	if (blk_can_dma_map_iova(req, dma_dev) &&
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 09b99d52fd365..930daff207df2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -386,7 +386,6 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
-	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -419,7 +418,6 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
-#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
=20
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
=20
--=20
2.47.3


