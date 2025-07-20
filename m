Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AC7C87FC3
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 18:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XrEUUXG/DV7XdFOpiNyMcNXqkL3TMsWCbPvu6QUhyIc=; b=hRUvAF39jZk7mNNTZaVSYTdAJC
	FbZOuZ6e4AtOheHj7fEJuYMOX2VBVXWs9iRnsvF+uSbh73EZfAZmCbWjzyUfQjEVxYd8WKR/GkTp3
	R4tjhtaby011b8V50eE0Ykj2KinrXGUQHuCKCHsVnwBnPa0atZJPR8ZyIMBVrpFxjRiLRCQyH/jhB
	ooP1N14M/z0Ew5UarXAChCFof0qWIxYb73Y//SwdCvhP0dnSpTGpU5gKHuEqdFBWS3eqgaUfhBs9d
	8IdVNnkHr2jxcUL+/rLmRcbL64MKZcNNf1XKncNi9EHIplb0flJ7jzcNL9UxnYG9Ad+mX1bpr8+tO
	PeCe/22g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ3U-0000000Fc7s-2qAD;
	Sun, 20 Jul 2025 18:46:36 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ14-0000000Fbqk-453R
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 18:44:08 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56K90DG3022250
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XrEUUXG/DV7XdFOpiNyMcNXqkL3TMsWCbPvu6QUhyIc=; b=uwbzKkaqeSKu
	97mSAOHJvJ8XBZf5E4LVaVzAqgthg8YCLtxikQNECrfoEuIMa9T+NKX5pWJyIOoO
	YRI3rUF1jny+Jwlqmt7JhUOAujwCHeXzi1TKVCGZEMebrCTC2lYmlKGEfrfLHhsE
	6W5RY6gIlJEPdwLpK2eccH73v0hGgINdvnby8vIo/ChoZFepMVIT4ScQyrn2+ZDw
	J+I8NXxuf8wtSo+NQbX71tTLjnWCgaivpRKmy6YYRIhj0Z28Hii6xOdRTswYl223
	yFNfYuTTT1YLeMCqzwJUPyRyJe43l+PzznD28BxpAPkjAT8tUzTuKuhrssYWc0Vg
	UOlNCXLEaA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4806vk5u5m-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:06 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:43:59 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 485B0178C794; Sun, 20 Jul 2025 11:40:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/7] blk-mq: remove REQ_P2PDMA flag
Date: Sun, 20 Jul 2025 11:40:37 -0700
Message-ID: <20250720184040.2402790-5-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=demA3WXe c=1 sm=1 tr=0 ts=687d38f6 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=gTB_xsApw5YEP2-mlJsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfXxA5sjAwl3jNa 5en/0vSaFfH+twojqSGe5AdVgo/5TSsnouceCPeMH1Ft8TbEYZB9POSLij0kjSkOdIhq054ptbl G8gG1U/G7U5okr6KENbATbJ9R0xBNcEsXU0GdocAY/M93bEOX03z5beFDkPzWgn1T8ssrHIZP0u
 RNBqT3K1lOSP083KqFbg6VzMBQCKX5o4wIRDXXOucDSIkOSUiWrbWkJedtgpP0Zp9j2Z1eoiiYT ydY6ENXxOHDGsRMXSWo7hrOVqCp0+s6MQH7vcCiiQWtFPx6ZGBBe0m/8a3aAYyLbYAEi3/dTnOu AlGA+JPDbMm+s7u2GjA4PGHWjP1truP0v6y+ZlJcCTRSMx7TKagW4iwhuaq2co/rariVNu/eLXj
 4Eso9CBqbpX8w2IrRarSdrQ1te7kknq7juhXESS7sI3/ZFd+NoGsU0gkIErZuFtBqe6Gy7IQ
X-Proofpoint-ORIG-GUID: fARExUbvPpeeOElXyGb6EcbpyN2ZPQ9o
X-Proofpoint-GUID: fARExUbvPpeeOElXyGb6EcbpyN2ZPQ9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_114407_138959_A5000AE1 
X-CRM114-Status: GOOD (  12.44  )
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

It's not serving any particular purpose anymore. pci_p2pdma_state()
already has all the appropriate checks, so the flag isn't guarding
anything.

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
index 7f3ad162b8ff2..56158ed504747 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -165,22 +165,20 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	if (!blk_map_iter_next(req, iter, &vec))
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
2.47.1


