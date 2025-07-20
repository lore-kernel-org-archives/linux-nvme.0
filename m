Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4A6C83F3D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZzWc5zu7T+7csqAbFubqfjaxA1/oxXM7ckMOSz1ep3U=; b=VfoSRNZgko1yg+zEdkMbqVRGcU
	sk/4m4PLp5GHmfArkbz8A/bcnCqzwvejBFpFW93v7lI9oS9TwCo8ZbCpYIOvLLFKUuTPoLTjrL5q9
	olKtzGZboTcOr3cjLpMPMWov2uNogyJM6D6uFsmhVlgot/mWj/fvnESs1yIewSzxqs4AY9WwLNPtD
	Mtm+syGh7Rnz0T8xd96TsiFdDCTHQS/K0pXGvWm4ZvjQZxz4yd45YGeroAunQuvgqGAfR5GW8xW2C
	PIVvwySGTg1YALkLgs+0J5Orie7d5kcClloaLiekMkmxASaxkU1bhGXTAd4mkHgT67XR+EqzRC/uU
	G/btCXjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ3T-0000000Fc6y-26Ts;
	Sun, 20 Jul 2025 18:46:35 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ13-0000000Fbq7-3cxS
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 18:44:07 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KEJ3Zr027207
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZzWc5zu7T+7csqAbFubqfjaxA1/oxXM7ckMOSz1ep3U=; b=nbhOEyHegD2T
	pAXLwPdsfYTGHKNX9iR8Qk0fVixN1dKtokP/3D8tfc616PszLyjSBLiPjZ4A7LkN
	N1kMHHJs8hY/jXIAwLXK/6ughSa8s9j04ns1rYwK+/c4Sfsj0xM9m/RGELQbMhY9
	ozCoNZFIr/yzNRWrFCOoRgjlMHJ54Iha4ise1PDu0plej3A6JHPgPVTttePvSP5B
	1oDEY+sbTr/cqfGK6MiqumaVVJCwClctGvWyPM4av3fFvcHD1uBmmR3oQGCe6xTq
	HGH2WnV1FKbpduVoBJLKfq3XvdgmdrwX2Mdik23qg339VDInM5x75HksPx37YnmZ
	mnajWFchGg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4808wdwe8x-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:04 -0700 (PDT)
Received: from twshared91430.14.prn3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:44:02 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 4E7A9178C796; Sun, 20 Jul 2025 11:40:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 5/7] blk-mq-dma: move common dma start code to a helper
Date: Sun, 20 Jul 2025 11:40:38 -0700
Message-ID: <20250720184040.2402790-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cuyotLZtN_wnapnDfBCEI9dv0LWcaa7u
X-Proofpoint-ORIG-GUID: cuyotLZtN_wnapnDfBCEI9dv0LWcaa7u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX6PFegccQDpY0 coPnvNlwY25i9X0E8bOShps21YPI3ZZYHkxWoLi6rAZVPSHzU5rCCyPvwVuS9BZZvS0OWEzfQv/ 259hzl02QcGwCEYSQJdu0lXAAhLtX5pvEYmuxgneoVD7olwSp56X5Xe2/YOveSlSGFUqZVkqQMx
 3vsruPioOyBohU3UNyUH0f1TGo2F50XR7+GEfIYds+FlBsmDNLTi4jhIJSYhtHiaLMc1roJnTSj F/Aq4wtXjp6dmNvgtLsAFNeo8G5jXeLfS50KXHa43T4dFIW4yGiI5RKJ789jHwDIhFnYSPbDlgQ E5m22aQDRMm27EotTQmlyEu00p5avjp/2ReX0QTYc5RKwpwRhLbY5JWSceqFbgC2Wj7HKfLTauD
 R58fkn1EiiNa7Qg559lxlV5VQ1oA1XyzE35K9x+kwatqbbTGJqUOOKbMSgUiK/EMwFyNDop8
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=687d38f4 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_114406_021537_B405FE53 
X-CRM114-Status: GOOD (  17.92  )
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

In preparing for dma mapping integrity metadata, move the common dma
setup to a helper.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c | 69 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 56158ed504747..1e2e93c1cf5e2 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -120,44 +120,16 @@ static bool blk_rq_dma_map_iova(struct request *req=
, struct device *dma_dev,
 	return true;
 }
=20
-/**
- * blk_rq_dma_map_iter_start - map the first DMA segment for a request
- * @req:	request to map
- * @dma_dev:	device to map to
- * @state:	DMA IOVA state
- * @iter:	block layer DMA iterator
- *
- * Start DMA mapping @req to @dma_dev.  @state and @iter are provided by=
 the
- * caller and don't need to be initialized.  @state needs to be stored f=
or use
- * at unmap time, @iter is only needed at map time.
- *
- * Returns %false if there is no segment to map, including due to an err=
or, or
- * %true ft it did map a segment.
- *
- * If a segment was mapped, the DMA address for it is returned in @iter.=
addr and
- * the length in @iter.len.  If no segment was mapped the status code is
- * returned in @iter.status.
- *
- * The caller can call blk_rq_dma_map_coalesce() to check if further seg=
ments
- * need to be mapped after this, or go straight to blk_rq_dma_map_iter_n=
ext()
- * to try to map the following segments.
- */
-bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_d=
ev,
-		struct dma_iova_state *state, struct blk_dma_iter *iter)
+static bool blk_dma_map_iter_start(struct request *req, struct device *d=
ma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter,
+		unsigned int total_len)
 {
-	unsigned int total_len =3D blk_rq_payload_bytes(req);
 	struct phys_vec vec;
=20
 	iter->bio =3D req->bio;
-	iter->iter =3D req->bio->bi_iter;
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
-		iter->bvec =3D &req->special_vec;
-	else
-		iter->bvec =3D req->bio->bi_io_vec;
-
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
@@ -186,6 +158,41 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
 	return blk_dma_map_direct(req, dma_dev, iter, &vec);
 }
+
+/**
+ * blk_rq_dma_map_iter_start - map the first DMA segment for a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Start DMA mapping @req to @dma_dev.  @state and @iter are provided by=
 the
+ * caller and don't need to be initialized.  @state needs to be stored f=
or use
+ * at unmap time, @iter is only needed at map time.
+ *
+ * Returns %false if there is no segment to map, including due to an err=
or, or
+ * %true ft it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.=
addr and
+ * the length in @iter.len.  If no segment was mapped the status code is
+ * returned in @iter.status.
+ *
+ * The caller can call blk_rq_dma_map_coalesce() to check if further seg=
ments
+ * need to be mapped after this, or go straight to blk_rq_dma_map_iter_n=
ext()
+ * to try to map the following segments.
+ */
+bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_d=
ev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter)
+{
+	iter->iter =3D req->bio->bi_iter;
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		iter->bvec =3D &req->special_vec;
+	else
+		iter->bvec =3D req->bio->bi_io_vec;
+
+	return blk_dma_map_iter_start(req, dma_dev, state, iter,
+				      blk_rq_payload_bytes(req));
+}
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
 /**
--=20
2.47.1


