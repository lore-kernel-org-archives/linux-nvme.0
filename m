Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B71C87FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kb4ack9vXfOSkVGDHJdpxKswW0fz+d5LtDVd0jctGeE=; b=tbvmjC0Xyw7fgt/dZ6oE+kecSa
	Kh6sM05YE7LvW92UJTjK7u5O6+HamIej+1/zQzBM4ylt3J8p6Y1XHd11bh/TxqSfVyt96A7JW8cU9
	xNAUnt+SY3xyL5vSITVuJaHIo1Ka5pd2MJikmPOrO67sadPZ7/aE0z2CBeyOCCoW1EIHNmr/vobL0
	6MMSuiYuaB9VXACMKPtPfs2hLnPzebS9KXyF3+RN8MC99GnSSrhfiaftt+9K06Y9noJbbtELwZrXD
	HrR0DgD6Z89r6L+wExMJVNaXfqIeO/dcNz1OREfAsmNSBT6vdMtMkQdJ/t1Nte5mPvPyZh+FPvThk
	xDf93aqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhV5y-00000003wiL-2kd5;
	Thu, 31 Jul 2025 15:21:26 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUqT-00000003vCI-45E9
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 15:05:27 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE7YRp012833
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Kb4ack9vXfOSkVGDHJdpxKswW0fz+d5LtDVd0jctGeE=; b=AETYhNTPO/l2
	ft8xzgYghlqh7x/2pgKhJztIn8gNAwBx+Eg1khhKsbQK1xJQLJwlS4V6FnI0bffG
	EkfEyeMbEV/GnU8z3+/jKN/FN1HfNVeGPEIbyWnw1yC8Tx2TRHzaAWm8gqnfrZyt
	QWXZYjQ3CFnur7Of5Xev8xYcAfVMNHu04vr/WQWflOZeMJ5AwOC3UIkpq0dq0CdU
	kl6v7ar7BagiE09u0ot4mBwqBlk+RTsHdShvkvwYwE/fzAPpze2ajbvcPKD5fq8O
	K5m1Zbpi+qxOEl/eSsd9U2Z4dpRE+IA/wgf7twbj8l0FVaFOjZRAsLsYY2CqYM5G
	zmZbFYIuTw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883mj2k8v-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:25 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1428C231DB0; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 5/8] blk-mq-dma: move common dma start code to a helper
Date: Thu, 31 Jul 2025 08:05:10 -0700
Message-ID: <20250731150513.220395-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731150513.220395-1-kbusch@meta.com>
References: <20250731150513.220395-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K/giHzWI c=1 sm=1 tr=0 ts=688b8635 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-ORIG-GUID: RG24ausgLIObxFWrGDn-RIEdw4TKkzIA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX6qDrahBhPYfd poLREOkb6obnYo8Zmu2g4jCyCPF6mjCxdeIJ9jyeLIRHanh7zqGjnHibE4CzDj04BXkNbFKniEm 4fiOjVNxdA98UR0UIuNTuTzlfLmA9TO2d0GUEBg4f4EqQXMZ/bCGFQFKpmiKsvmV98o8P2VEV2P
 /L4/PnzunwBZo/HEpfPqWZ6nC4ah0XWSbj9F60L8vfH6ikhH+IyeLwiaMxo4ClEfzr6MFFz6ky7 XpL4Hd/NqmpZ69FBIH7arnX2Q6oYkN3SJ+Fa1tI5st6vg/BxKJrrJYPwoK09I8fvFHgkXG+6KfF deIhZXl72WC7bpQrd77GGU5xrHaouCbF7mKTEZvwwq1V+BsCtZtgL4zJesI5v7V9VxX6DLqE0w1
 x41MeT01KjqAD6vh3ozDCKbqnp7LFCqBylZdD8wS9bkft3j6HEWh9njG5QiQKGwYvXVDKa5D
X-Proofpoint-GUID: RG24ausgLIObxFWrGDn-RIEdw4TKkzIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_080526_134872_B68D35CE 
X-CRM114-Status: GOOD (  17.86  )
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
 block/blk-mq-dma.c | 60 +++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 988c27667df67..bc694fecb39dc 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -135,36 +135,12 @@ static struct blk_map_iter blk_rq_map_iter(struct r=
equest *rq)
 	};
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
-
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
-	iter->iter =3D blk_rq_map_iter(req);
=20
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
@@ -194,6 +170,36 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 		return blk_rq_dma_map_iova(req, dma_dev, state, iter);
 	return blk_dma_map_direct(req, dma_dev, iter);
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
+	iter->iter =3D blk_rq_map_iter(req);
+	return blk_dma_map_iter_start(req, dma_dev, state, iter,
+				      blk_rq_payload_bytes(req));
+}
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
 /**
--=20
2.47.3


