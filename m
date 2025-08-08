Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70292C87FD3
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kb4ack9vXfOSkVGDHJdpxKswW0fz+d5LtDVd0jctGeE=; b=bZu3b2fuOdjrCXQS25eHmGQky1
	5Qa60txJQ8dA5Y4TekwF/l23rm3KOCn+aPB8d3XBi9Poc/6+EBmh6jdCK3kDIEtvOLOHfHyHiqZze
	gaNY4UTSiFhqOjM4XOCxz6vjDMEpA8KvCc5rjjxVjTCBSCxjB6ME41xvdobxDZxWvLD+tT90YNeuC
	Q4O3rpNOynS8kfZg9nzazRh4p4X+Wd1UsjPE3tj1A+SqXm0SRaMKyvEY/58ZZ54YE5pBNbrVBAfi+
	d4g1ZMAxPgJ1b3vKB0cT0WEgRbP7DwmtnNzBhEtdp5vXE75lidEbJCp+L7DWJst13WvmInKh5sxA/
	tRJ5asoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPWc-00000003G7O-1oFo;
	Fri, 08 Aug 2025 16:00:58 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPUJ-00000003Fcv-3eGa
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 15:58:37 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FKBbA021638
	for <linux-nvme@lists.infradead.org>; Fri, 8 Aug 2025 08:58:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Kb4ack9vXfOSkVGDHJdpxKswW0fz+d5LtDVd0jctGeE=; b=csFkBI1+fT9S
	jT8enHvgiuYhvaFkvQpOj1qbFEAWWd6Fqr7jxTGHp9qp3sbuUkUbKZXYFDqSmSsd
	i7BhPLh9pVZssE/ufcA6oOi4ROTLQMds00piI10+VMXByFclowA6FwqzdUhsU0Mw
	QOs6Zh/m5/pHDb8GW0O7Oac8NzzFTG1vaoUFL4n+bOWamdy9hKCi2Z6wLGch7Kuh
	ofLoL1UWy8vb1E053t4f4DrskD0bZo4gdMu6IxKQpmHDGXPXyvqqtou3hntgKYh/
	ADnD5SXyiOaOQX1YNlQBcMPp57KS/A7Nw6W1XMiNbtycjS/l6n8RmxKicKGR5nVH
	U2CBgWdsRQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48dbwck3f3-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Aug 2025 08:58:35 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:31 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DB4976C76C5; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 5/8] blk-mq-dma: move common dma start code to a helper
Date: Fri, 8 Aug 2025 08:58:23 -0700
Message-ID: <20250808155826.1864803-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808155826.1864803-1-kbusch@meta.com>
References: <20250808155826.1864803-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX/Z7TceQgYRSV CxP18DIHbOuexthYeblihG5a5xJhgjwTLcEEpBD7E3hlwcuO0t3d6Hs8kLoaJEBDn7N/kV6UmDG V45Zb0qf9+ByeUrntFM//yl9qRC9+MIAMe1y2kI0TNgHBSe9xJjuSB0SAmKRX+Km6p2MroXGBC+
 0twc5nEcVVuS1Hq/5va7H4kHNcSlUY5WDrVo21mjJ+F3b/KejjfAd/8zxO0bLnIENTMFDp4n58r zY8xiBzDn9eGJf2RmGxs+gqDiXLMIZF8xb+4zMVFmwtgqTA8hk/aaog/au+/x013cNDjquLvnZ2 usZ+93CW/X4Q7IufL1nLMFwTbcBddXgs4M0YABlKpFNB4ne9cjDcH5EBJcTXyL9miGSD+PR/xO2
 5kQN+7BBaLidLI7rPOPI1KF1BDo8qymZkmpUt1DpPCjUEMQne7zO3QAm1RBjYX2g1K0tjCzI
X-Proofpoint-GUID: mXHHBg97_Bgv5nf-My5iNjJ5PvLcUwxh
X-Authority-Analysis: v=2.4 cv=DthW+H/+ c=1 sm=1 tr=0 ts=68961eab cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-ORIG-GUID: mXHHBg97_Bgv5nf-My5iNjJ5PvLcUwxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_085835_917907_DE012B24 
X-CRM114-Status: GOOD (  17.66  )
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


