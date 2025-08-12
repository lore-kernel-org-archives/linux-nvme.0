Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B808CA0EDC
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M44hiLMtWYhlTX/r/GleBQm9MkDD2iT6ChaUSd5oMeY=; b=cYPOLx2acmSwlydIY/l1a0z6U4
	eci21SPcIdt4hwqYXd6LdMr3is+HMZDNKIheFFfMzBF2xHlDF/q8dZNbORE+EBvDQRAo09Mf5bm/T
	OXREzO5FwTPDTdByB9BjWr+M6Mz9lto47B6kSCzWMfNeeLEF0iRj4i+Uvjv2jzRwEppJ2FT+z/BQ4
	JsMUApjQOZ5CzpT9554kmfg8x5U8IbKGMLk1GruHLSHAiwHvjpde9sVgCgBHZ4VZeH6qba/I0zpt5
	qdG1tDRJLtiAmI9GHSdX2ML2MTiI9DK35dz19KwS2J/YYtRumgCsu+FCtiLbERbxIQYHTCS9E1cgj
	WphRaQ5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulst2-0000000Bbbq-0Emg;
	Tue, 12 Aug 2025 17:34:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpSD-0000000Az1o-2klI
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 13:54:18 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDnmfN012032
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:54:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=M44hiLMtWYhlTX/r/GleBQm9MkDD2iT6ChaUSd5oMeY=; b=GRiOEGLlokbJ
	WmAIsK2zlQ3ClvETvtK+apfAeK+rTxS5xrjKKm+/yGrEaTffJGFTYuxzpO6ifgKV
	cEVUrWkWdSYhBu3IZZw2+hECep7K5Qzg8pviiIU8WT5uKprBjQZa4Fbt56roDauX
	EOwzILzZxYvdeeKIg37WZKj+myVy4ndB8YP8LrkAlTUFS8XY8Xw+a7yZfmTZb98O
	xX2oGs3pm3dh5/h2iC/EBzYYUOZURsMH6CZt1kbG4q/HILGBbz131dHziD3wD/OP
	X8KNpKHKWgOdmQkyA9pzzsuDyNdmkqoI/GL2NFBAMZjovnkZupJI1OIoaJ275CLa
	lN887HVZsQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g5s6rt6x-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:54:16 -0700 (PDT)
Received: from twshared51809.40.frc1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D4D6E8D407E; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 5/8] blk-mq-dma: move common dma start code to a helper
Date: Tue, 12 Aug 2025 06:52:07 -0700
Message-ID: <20250812135210.4172178-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Pm2hz1kpEhB7LWTa6IW-q1t0qPYU6I78
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfXz1js1GRbfSeh Tax4lROIbVNSMM3bzbzS+MwgHe4/i0hZGIKbUJntl/6wTd6ZNB21+1DMH9H2H1xsr7JeEAj5Q0n 6F5iLgmqqG2JtFCEJN5kjN7itwvt5yhdIuhQmcQdlDYY+D5ZJBz+3FlvJJ98Z5i7sKixOgFfWP8
 xw/twKmwZstU6/mJ7pm0fMwQO2ISw+B32bQYzCJ95G6Qk0+F2EMPDnvyjPXJLflVm5AiEStLFpI 1+6clHC46iyMnwKaQa/XW3Vk82TjIjfmDaqgP1dLkbtf2RX9PsdSP/jKF+7f+LwiQa5U96kIjnv ERGDqjpONoieulYXwD1pr2j3A6ZhMzwV7foG7YMuKDHPiOW/+nxK30RFFgWfug/UNZ7fRMm/1EN
 TMvkJI6abWpCxBmP7NZvndseW5cu6XxR+OhvyboMlneTYpAJLc9HMyomRxGk2KCzJsxMlkl4
X-Proofpoint-ORIG-GUID: Pm2hz1kpEhB7LWTa6IW-q1t0qPYU6I78
X-Authority-Analysis: v=2.4 cv=H4vbw/Yi c=1 sm=1 tr=0 ts=689b4788 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_065417_702598_3BC5D7C1 
X-CRM114-Status: GOOD (  17.74  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


