Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE4EC87FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xb4+qZoBZTJSN3n5c0wo7/+q+Nd7lvZO56RURKkf+ww=; b=sEhCCoSq5HmkH6Cyvz6VXy0jrX
	Fh28Ofx1RwkIeLLefRUDDBbHmThqzCd2JB7jcS3fMRmxHGmjGW7cy47GPx82oWnbNZ2qm+5fxCluj
	MtiXLBptsMtta4p38iu7wv4wFrQxBtuFp+eDjQiZL5hDQ55qzXXp1An6YRYFafDGNvyBA5zdhSdfb
	Kx2fTCZToxqa/gtPnxzIfx7ib9Cbn7gcvvPwtpK2uKKsg329aMfpyLBsQX1UUzieHzowzlsV9d/UB
	9rNnoOCJUJqa/fY95dTlB74ZMxgZ+1ea6swQxKiejmptAXEoA30+OZNMwot+qPkg/cQO6hffyMnf2
	qf1ebrSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhV5v-00000003wfM-2Zq1;
	Thu, 31 Jul 2025 15:21:23 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUqR-00000003vBJ-1jUX
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 15:05:24 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE7PuC012177
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xb4+qZoBZTJSN3n5c0wo7/+q+Nd7lvZO56RURKkf+ww=; b=GzTEliWZjpy3
	h5Mhxis4MQFPw+iQVO+iO+DKwBQzofl2PVIl8zrQOCFbgTmvvDwuL/dbp5WPRqZ6
	ieXQytYHB/oJ3jOPK7areLjcGRWA1/r6R9tJvy8M4j68EnJBDO98HUF3P4g53GPd
	A3WXYcJOXogLrUmcxgkZa9DYyeKAZRScU+TqNDJpx9zeHObG7iejEHazq//riTFy
	cmvJ3DQSdtHdVOPNbQrN2eBKp2Z7ge84GvRTLkd+US9NCNv/nltPU49nfyjLxo6l
	b2/ujdBRv4U6L4e+TEiy5+ZUkdpDlzT/0Thj8X8vVa2r92cvUTW1Ou3kGIDuXLrq
	baeOK4RItQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883mj2k8f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:22 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:22 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 09E67231DAE; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 4/8] blk-mq: remove REQ_P2PDMA flag
Date: Thu, 31 Jul 2025 08:05:09 -0700
Message-ID: <20250731150513.220395-5-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731150513.220395-1-kbusch@meta.com>
References: <20250731150513.220395-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K/giHzWI c=1 sm=1 tr=0 ts=688b8632 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=gTB_xsApw5YEP2-mlJsA:9
X-Proofpoint-ORIG-GUID: ZIL7ch89lgmTxbbXf9cWIbFOtGOEAkQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX9DDFhlbbHUzw 7jLm9q5x5U7cjc95vStrt2ufebksZWKLWWMTBrQ4LqT6TG7yGTbTjdEigesn0URB8eyqCzZvR9H 6216fAvrnyDsF7CwZNlvRO0a5rUPyEQ0Vp3GgAeUX1Q3mtEn09EN3pWDBcLfE1kH6DeIgMBmVlF
 qM4hbwGrkYAHvKiCgTtDDjaVOHx+qrzIrjtrBEAmcPJzNEe5Pq8a+KbYiBj5lhts0xutBl6KoR9 NVUOQi8TBmNxp9Q+JZx8n+zoB5XjnoLHYDCtsU5yPYGK1ZKD9/QH3TLQe79JAeduuHdT22qyKvc lMEopFj72l7zXNLdADXNxwNuzVhkjM017tCx/r7HEkDuhdXMgto1QVHt8drHtWQKD0lCCZswwEg
 0X24BOW6K+yAV6oVOhbC2dLYnDNukdJkxPv8rqMQ7nyqHbJXZJ8i43T1RRllSElqQ416Muof
X-Proofpoint-GUID: ZIL7ch89lgmTxbbXf9cWIbFOtGOEAkQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_080523_570300_9434B812 
X-CRM114-Status: GOOD (  13.14  )
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
 include/linux/blk_types.h |  1 -
 3 files changed, 15 insertions(+), 18 deletions(-)

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
index 09b99d52fd365..0a29b20939d17 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -419,7 +419,6 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
-#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
=20
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
=20
--=20
2.47.3


