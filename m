Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B346FC6174
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 19:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p6VwkvKbI/A78E59kaxtyU9y0s+RsmIy8xFoL+H0KLU=; b=wHGgLW907I6jVes907FsrJZ8xI
	j61PXpdP7Kz2kZSpsNaQEXBxIcE0dT4bgu5X6DyTEHhPXZqP2LoHRBj5t6EvMn3w0WAJgX+AeNLa9
	qr59EQoENJwlAwh8eZw+OvmI4xOw2Vlr4CqFyH+XhQtK2kg8si1qCz5luimYFsAE5BCxJIroAdP8C
	t/iuRhFN8oL0/5uzTCVXgwdiudFi6T6f1oNarGbB/QKS4YyoGH/GKuriIF4HPLkSXvf7o7+IWnkT5
	62RuWygXSVRTZP5X3gVxLeU32cW2uXxp7HZFiM6drQUadUYDB3SJMCJlo3k0CNPYYxrSwnyfpazjk
	ee+XxNUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spC0l-0000000GwfI-11Kg;
	Fri, 13 Sep 2024 19:31:19 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2n-0000000GoOO-0nhw
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:29:52 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI2IKe032476
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=p6VwkvKbI/A78E59kaxtyU9y0s+RsmIy8xFoL+H0KLU=; b=
	RuJtQyw84XCedloXPWvzGimgpQpcoR9CRK4FZzQYbWxHnGYqxXjwncGtyfyYK55d
	mTD5910abFLEa7yqnHVtoA+aYrDWY3oUqlvp5fvze0IwH7MjYLFTBxPLPfXiqJXC
	wpPtjrA/wPHdl6WQEpf7MnnFU1z8/rbPytoeUyosjUL8eLSVakwDmwplH/FzYXzT
	WY6u+clOKRSSKVw1saNdkx6fWo3QdldFu0JJi5j8xPy01tsvxUvPC4rueMgK6CfS
	xKXgUhlgJvcWMh/YMSxAGDhntgquk4qCG7x/XY2IBfjsEVwH24inP9tKsY2ZGMcV
	GH9iqQWIL2rC0kcU/F7UyA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41mqbespa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:20 -0700 (PDT)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:07 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9C02E12F91053; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 9/9] blk-integrity: improved sg segment mapping
Date: Fri, 13 Sep 2024 11:28:54 -0700
Message-ID: <20240913182854.2445457-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aTb5ETHzgwB2I40Rgff1Dhdeuj9jO_od
X-Proofpoint-GUID: aTb5ETHzgwB2I40Rgff1Dhdeuj9jO_od
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_112921_267296_0CEDC55C 
X-CRM114-Status: GOOD (  17.42  )
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

Make the integrity mapping more like data mapping, blk_rq_map_sg. Use
the request to validate the segment count, and update the callers so
they don't have to.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c         | 15 +++++++++++----
 drivers/nvme/host/rdma.c      |  4 ++--
 drivers/scsi/scsi_lib.c       | 11 +++--------
 include/linux/blk-integrity.h |  6 ++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 1d82b18e06f8e..549480aa2a069 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -62,19 +62,20 @@ int blk_rq_count_integrity_sg(struct request_queue *q=
, struct bio *bio)
  *
  * Description: Map the integrity vectors in request into a
  * scatterlist.  The scatterlist must be big enough to hold all
- * elements.  I.e. sized using blk_rq_count_integrity_sg().
+ * elements.  I.e. sized using blk_rq_count_integrity_sg() or
+ * rq->nr_integrity_segments.
  */
-int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
-			    struct scatterlist *sglist)
+int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sgli=
st)
 {
 	struct bio_vec iv, ivprv =3D { NULL };
+	struct request_queue *q =3D rq->q;
 	struct scatterlist *sg =3D NULL;
+	struct bio *bio =3D rq->bio;
 	unsigned int segments =3D 0;
 	struct bvec_iter iter;
 	int prev =3D 0;
=20
 	bio_for_each_integrity_vec(iv, bio, iter) {
-
 		if (prev) {
 			if (!biovec_phys_mergeable(q, &ivprv, &iv))
 				goto new_segment;
@@ -102,6 +103,12 @@ int blk_rq_map_integrity_sg(struct request_queue *q,=
 struct bio *bio,
 	if (sg)
 		sg_mark_end(sg);
=20
+	/*
+	 * Something must have been wrong if the figured number of segment
+	 * is bigger than number of req's physical integrity segments
+	 */
+	BUG_ON(segments > blk_rq_nr_phys_segments(rq));
+	BUG_ON(segments > queue_max_integrity_segments(q));
 	return segments;
 }
 EXPORT_SYMBOL(blk_rq_map_integrity_sg);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 256466bdaee7c..c8fd0e8f02375 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1504,8 +1504,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *=
ibdev, struct request *rq,
 			goto out_unmap_sg;
 		}
=20
-		req->metadata_sgl->nents =3D blk_rq_map_integrity_sg(rq->q,
-				rq->bio, req->metadata_sgl->sg_table.sgl);
+		req->metadata_sgl->nents =3D blk_rq_map_integrity_sg(rq,
+				req->metadata_sgl->sg_table.sgl);
 		*pi_count =3D ib_dma_map_sg(ibdev,
 					  req->metadata_sgl->sg_table.sgl,
 					  req->metadata_sgl->nents,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c602b0af745ca..c2f6d0e1c03e7 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1163,7 +1163,6 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *=
cmd)
=20
 	if (blk_integrity_rq(rq)) {
 		struct scsi_data_buffer *prot_sdb =3D cmd->prot_sdb;
-		int ivecs;
=20
 		if (WARN_ON_ONCE(!prot_sdb)) {
 			/*
@@ -1175,19 +1174,15 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd=
 *cmd)
 			goto out_free_sgtables;
 		}
=20
-		ivecs =3D rq->nr_integrity_segments;
-		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
+		if (sg_alloc_table_chained(&prot_sdb->table,
+				rq->nr_integrity_segments,
 				prot_sdb->table.sgl,
 				SCSI_INLINE_PROT_SG_CNT)) {
 			ret =3D BLK_STS_RESOURCE;
 			goto out_free_sgtables;
 		}
=20
-		count =3D blk_rq_map_integrity_sg(rq->q, rq->bio,
-						prot_sdb->table.sgl);
-		BUG_ON(count > ivecs);
-		BUG_ON(count > queue_max_integrity_segments(rq->q));
-
+		count =3D blk_rq_map_integrity_sg(rq, prot_sdb->table.sgl);
 		cmd->prot_sdb =3D prot_sdb;
 		cmd->prot_sdb->table.nents =3D count;
 	}
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index 793dbb1e0672d..676f8f860c474 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -25,8 +25,7 @@ static inline bool queue_limits_stack_integrity_bdev(st=
ruct queue_limits *t,
 }
=20
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
-				   struct scatterlist *);
+int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes, u32 seed);
@@ -98,8 +97,7 @@ static inline int blk_rq_count_integrity_sg(struct requ=
est_queue *q,
 {
 	return 0;
 }
-static inline int blk_rq_map_integrity_sg(struct request_queue *q,
-					  struct bio *b,
+static inline int blk_rq_map_integrity_sg(struct request *q,
 					  struct scatterlist *s)
 {
 	return 0;
--=20
2.43.5


