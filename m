Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BAACA0EE0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fu775ERXyyhMSnUAZLp53PfqsKVY+yKYmm/lA44sjjo=; b=49up3pa6R7cbrAE7ou6yBLEup9
	BctUD2uCUgdCH8XTzHhpIZCKMIB64lvNSNkBy41UTIry4MTOeW0NCEddtoIo5qmODREFAUhzV+J7p
	SrrkZvCzS/hwk+QQtLHpxJO4I9/HDplrbkabSX2wR4IUEK3Cj5asoHlp5+w9e3u5RKk70E3JqDQSm
	ScCq8Iai3WTlKSSQPNhLh9RJdiuNNd0uIPOFEgMzsZPLQx7+VgQfUq3pHNAQjA4HLYNFLFJ+yaF5t
	0wd4cAZ+gGaWdLyWLmVFckVorD732z6ZDPxMh+abBR03KBYUpBOcKudQygcASq+EMzSX4GVkLZ71k
	l3wwGMyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEO7-0000000EOrm-2wwu;
	Wed, 13 Aug 2025 16:31:43 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDSU-0000000ECL1-1RrD
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:32:11 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 57DF1ZMQ032629
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fu775ERXyyhMSnUAZLp53PfqsKVY+yKYmm/lA44sjjo=; b=kWIFd/jdvT5o
	yXH5h6lZovxhLWKoT8GNFfy78QHcwYltsFHSlYwR1p9JrAfku05G1EcT83fFKXVY
	+tbEWGQvvCwMmSSP/yzaOGkPc/F/ADU6fb5odYEtV9psWKta77lWrVUZ12o5LykF
	y66C4aWp/05WDul/OlmIY6iBQaMOrGn4TTvTF0O6jOPjd/Slx7DqoS+Gjhsovffd
	bjRSRAxEBDcXAXL7IjNqNIEZSlq10qEq4DwZ8kLhPqjD8/KR7YNZiNnwPhyEa531
	X2vDuZ5Kze++bXb5mqKWz7tE9EI1kXVTfBian7nJnSZUSks3egrUHm8jFHL6fTBt
	lVEHm9pnMg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 48gqmwte1f-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:09 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 7EF1F97CD84; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 5/9] blk-mq-dma: move common dma start code to a helper
Date: Wed, 13 Aug 2025 08:31:49 -0700
Message-ID: <20250813153153.3260897-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BaTY0qt2 c=1 sm=1 tr=0 ts=689caff9 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-GUID: VCDUGZ-glZ5HH1zQ_Loo_Q_XKDadURbQ
X-Proofpoint-ORIG-GUID: VCDUGZ-glZ5HH1zQ_Loo_Q_XKDadURbQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX+1zBD/h6qwvY bmkxzTUW/0HLUSPKzlY37PseB7E8ZXC6p2O7LmToAl+H4TnSqvVqTo2VyDv5gIyQozQKhPuKEP0 hyfr5lKLQmCPulRSJRhYgg3tL16x2q74skH1ZemxVozApc7Bfl44+EnYhvdWFbi/zYoGldE7XYd
 s9JyYQQlzPpnqivQbBm3cTH4bXUtmcAgH4HfViS9YeJBxaFnV9ixHWkRUlGTEZeEcisgU88hDnL +DEEEV3vgaM+K9LEPKmn1pxa7SMnIklARJvrs2n1wVrnD5HiTFqetjwXv/pb346XSKtDacIcxig 93dv4CCHGkCWj/XpEurgYAIPzXOrkQHQwWiMGi8+GJyJ45i46i2YV+XS9xo/aQ6xjcSsWlU6hhM
 G2vXwuv/NQJtT5uzF3qn5fe1kRvFNBy8JZYrnUxHddjmMENLj0rB9jhaJD4qlbxpBXseR1Y5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083210_505348_5B2ACD94 
X-CRM114-Status: GOOD (  17.35  )
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
 block/blk-mq-dma.c | 59 ++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 58defab218823..31dd8f58f0811 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -141,35 +141,12 @@ static inline void blk_rq_map_iter_init(struct requ=
est *rq,
 	}
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
-	blk_rq_map_iter_init(req, &iter->iter);
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
@@ -201,6 +178,36 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
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
+	blk_rq_map_iter_init(req, &iter->iter);
+	return blk_dma_map_iter_start(req, dma_dev, state, iter,
+				      blk_rq_payload_bytes(req));
+}
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
 /**
--=20
2.47.3


