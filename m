Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815FECA0EE0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XsOLd/P3RODy7Knzd0+Ybcgm4ptMayJ32tMsQS355Oo=; b=fYIpf30tmK8ugkOYbFHhTN/0E2
	AT2Dfxi/+avGHEItORwTvga7Q+PZwXg8RYvEp/Q0S+Ufwv1RC0ITHzWe2qaz5ozpKT2J/Kkp/zNpQ
	S9MIdJJleZBY4FFff2QrLrnI4mx//D1eYAXxkOISEqwbvDAObIwY53WXAOwQj6qEWWmX8tdLxz3an
	trApeN0Mjj5pf7A/ohGskYOZA1lpjycW5XVmyQSsdUzIYUMuU6u0AqoWcqhht2p06QP/IGMgRaFk7
	0Pb/gppDsFLBZCRmMV6G4v6g8R8ZWOXRcnbmIUkOuY2q4Jrgh5wj8zJvSEroKLmR+qoEoF1FeBVjE
	pC2SDeJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulst2-0000000Bbcx-3YSt;
	Tue, 12 Aug 2025 17:34:12 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpSF-0000000Az28-19NV
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 13:54:20 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDpjkg006845
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XsOLd/P3RODy7Knzd0+Ybcgm4ptMayJ32tMsQS355Oo=; b=ZEqb600DCXiW
	+JElDwELrcWXvzo+M1pTbrLseNcY7mi31cqmcp1vo+e4TRruGnwuPrPB6NB7GK0b
	0ojHdgiPczuQk9mkxHzy5j8gZL7EbBWfEOEggkrH2Jt1oNghVv0SdbtLaj0x2NRl
	fFrE5gDvuCflYOJOt4dbOZbMDoM7gtX+i4WINM+Kx3ph0QhH2ebBCiWXXYc7ji6j
	MdGhSBaAPaS/DtaFlfpQr77Q8e1IpTWcWOFdtgW741LXtY3HtbIPk3UBJel4e8aD
	qLZjJKN6LHZCzxrPVkSLUCLCUSgzUOjZYwkmNbpEKjesH+PVpUSHMJE3b2489qbu
	Vlc5o75gZw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g120b14n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:54:18 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C0EA08D407C; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 4/8] blk-mq: remove REQ_P2PDMA flag
Date: Tue, 12 Aug 2025 06:52:06 -0700
Message-ID: <20250812135210.4172178-5-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KJdaDEFo c=1 sm=1 tr=0 ts=689b478a cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=O3ANi3fbfI-XDrvcMKkA:9
X-Proofpoint-ORIG-GUID: PsJvzk3vVmn5ph7BvRBO1mw3XNrz_j3_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX88qQpEq3cLij 203oJb6d+h2HHtwGn+m7fgjD/+uCxTq1yXnY1TvOCds2hYrioQvxdhLB9+MVgWZJOpbGm5pXmg+ Y5CRICeMdR1Hh/B1lPCKdvBEDJQSd9bBNlIXOyR4SGSisFGTeF8f5ziJd0E4wYy4K8bnEvYcEAr
 CszwsgveAbqTGWgt8LlV/LvSzZgU7zWaGBLDmMSzMAB/qtvT9HCQV5zIlKy1uTLkZ/nAIqjBEBa OotzLVX/uW6H0z3TRR2XdxCrKimv3u1wX3CAHB8jzNXSMIYWWsDH3DJMoIwDYPpF7/i8VYcw69g mRme8xI4XXyANvB9Dur0fz5cPMqQQvA8hPubFEEPkHGiTZwL9FT3p/hvcpvO6HaAucKbSwsBTUX
 Gzi8687ebSb1cfM1ADIeKgvhYuD9rbeD6t9ksyc/c2V2faRBb5kfaIC/lMqd0q3MWuz8L7+M
X-Proofpoint-GUID: PsJvzk3vVmn5ph7BvRBO1mw3XNrz_j3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_065419_431991_A902FCE8 
X-CRM114-Status: GOOD (  14.53  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


