Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51E9CA0EE7
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mgnoOARiNTC7jutPr3dcY658KZdCotdvQFnm+wB+bU4=; b=XxC6BbG6IXDTSgBnUFgzySc8LV
	GHt8tARdvwdyF9G+F/ufDqOXfHcXKJbDCPGFEz6yGwGg95oJccZ4dokbyEkYu4xAt5hkbmHpPpquR
	Zo+uUnOXAdC/t0AFDfT+I5Mxrd69bfslsfTVicKm/o4Hek7kLt1oXmnG/JVu6jKhICustco0hCk4v
	iOIJRGiFDlxTtFUsGcG+hMaNckSpHtjacsKwkFWd6TxqaUF0KThgscvmggswSx1id4uC7Z2e+tlw3
	5zHk9Qhgu/qoggugyipBprMqnBWOsPWW9scX3iF/94ZzP61bxwrVAYmIDIQTa6OPgFBLuUGO4lNyc
	VSCR61jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEO9-0000000EOtU-08ee;
	Wed, 13 Aug 2025 16:31:45 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDSd-0000000ECMp-2xDj
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:32:20 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFB979031008
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mgnoOARiNTC7jutPr3dcY658KZdCotdvQFnm+wB+bU4=; b=EcjqUTS9r+79
	kiSLGlyf5An2KyT9RZWPpHNcZFeTT2kJyJmCXr4zhJ14OHkMTmHl/eyx9h6Ev1Hs
	eZSaJDVZB3LI4iueNpW6316HisopkEQsLhQG3LUbY22BW5qYdCHGZDXbGaVSALvQ
	TpW2fzJ1ZI5mQmXgPI6nrKoZ3REzqMomGIG/FJ1RtNUxZ5IWODfwCveRrIdT2g1L
	YDzpAYdUd7sXhowqIyDQVZJET8FJcifysYC1+W8bkONLPDj+jBhDApumlD1zblzU
	yRw6V91vz9oWYtWdsdciMKRDtplWLk9FclBd9zXgJMpujPRxCbvkWyDisvWn0P18
	gpc2j17ceA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gpru2kss-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:19 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 7C6D197CD82; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 4/9] blk-mq: remove REQ_P2PDMA flag
Date: Wed, 13 Aug 2025 08:31:48 -0700
Message-ID: <20250813153153.3260897-5-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dhHn3tYPGxffdLbquKlnn30Ohtys_UiG
X-Authority-Analysis: v=2.4 cv=JKM7s9Kb c=1 sm=1 tr=0 ts=689cb003 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=O3ANi3fbfI-XDrvcMKkA:9
X-Proofpoint-GUID: dhHn3tYPGxffdLbquKlnn30Ohtys_UiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX27qcRtSmzKdM pvXSOZCdwvd+VwCYb1VRDLMRyOzRiGg8Z77QY58UiCH74TT4XRVWDKK9oDWsS8PxlTy3i0Vi5wQ oOcqeTgIwAW6oudiJvO2d2Mh4EeyLHV3+vtGcnPzNigY3Q03rRlMBVDHw+AvWZ0Pawe7qBNndYY
 qrQPsuygZRgpTITqAUzisbr4zsMdEUjEl474D6ThzUO3mbfhi9N6HYbkQ7Iaehrcr249N2LwEsS SuDmtuthd2ScYc0DU3tj+Jfl9I6jFB7+11ObG2XY2Nz2LDg8GO/p4O2Vzy9Lv3xt+LE/MMtUUR1 RaLyM8ma6pP7UIc9CCBS/rB/sVYAe31IqPxm5eB8x0nA7Gu6B/40bsqLu0+/86cI2jNd8COWNr8
 uv15lmy6pXcAQQijGQVAPk97E/JhvIicMVF4/N19mm//g8Hmqn17JcUn67+sSixuthLP1mqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083219_749843_133F9296 
X-CRM114-Status: GOOD (  13.95  )
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
index 3b371a5da159e..44c43b9703875 100644
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
index 8f41fe740b465..58defab218823 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -180,22 +180,20 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	if (!blk_map_iter_next(req, &iter->iter, &vec))
 		return false;
=20
-	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
-		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
-					 phys_to_page(vec.paddr))) {
-		case PCI_P2PDMA_MAP_BUS_ADDR:
-			return blk_dma_map_bus(iter, &vec);
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
+				 phys_to_page(vec.paddr))) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return blk_dma_map_bus(iter, &vec);
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


