Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27737EE57CF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8EfbBDn2sY/rKJtZTNRmZQB1k2PQSCWXx9V8eeGKzYM=; b=Jr669FpqTobzVj9uppyeqPxapb
	kZXsgrhS4VuUyRkVgHe4R/wBpe9xMIexdW5susXPLC2KCncxid1VjxSWeZhEY/ujxhsb6NLEtiISJ
	/9UjwBZMZa7b/87dULPRNIXFpYgcsCggSaqRbX3/z/H5Io6UI47ISH/3VxTe2/h7TRqTiVdd4gUnl
	yPvm32O7rVb8SOQWXCliuDhPW2Zaj2t6Kz36DAX+ZwTviW6Py7H7rPGuZUD1ey6zt+T9hIoJS+aOv
	L7smBvHRQTOxgDbiGcsnqSysONZVHjXhpeMJDEKReJ8nFWDMf5nY34HzNXOkoo/vk6RZUZlcB87DH
	NXNiSt+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soTi0-0000000Aqos-2PTI;
	Wed, 11 Sep 2024 20:13:00 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soTht-0000000Aqjo-1VXq
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:12:54 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BHjGDn027790
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=8EfbBDn2sY/rKJtZTNRmZQB1k2PQSCWXx9V8eeGKzYM=; b=
	hNHws+QLMxOq02r6GrX7MSQZhT077eXyXvO0ozOkLKjLvSyKOYFESuZ4IUqn61Dw
	t8ayfvFSWSXTk/f3CRhF3bOS7o5SZLYcZ6Z4ITv1rvVDJW3mFzXODvdMvai5o73A
	U/zdSDzDd1JVpq9TrvBDNDkgePtyVKRSfVlebN+ebrfe4sHzlFkbvDV8mEEsoZKT
	Sd/16/pFGRMKCM/jC0H4XE6GLd4yigJ4xSmOHk5QC1hsOfKWkpofJam++uNBMkBZ
	HJjrUMnzxnJqN3XxKkTmD28Yf9qBdgpKRUWteaXe9rknW+WB3agt6fsj/0sU3U/a
	foZ2toq67ftfFON4gi3iMg==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41k61wn0k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:52 -0700 (PDT)
Received: from twshared25838.31.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4853D12E5EDB6; Wed, 11 Sep 2024 13:12:42 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 10/10] blk-integrity: improved sg segment mapping
Date: Wed, 11 Sep 2024 13:12:40 -0700
Message-ID: <20240911201240.3982856-11-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YblUKVZ4oqQaobRMvg5ykYYnk_uPCfcQ
X-Proofpoint-GUID: YblUKVZ4oqQaobRMvg5ykYYnk_uPCfcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131253_433561_8FE40D11 
X-CRM114-Status: GOOD (  17.09  )
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
index 537844ee906b3..0d6d8431208a5 100644
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
index fa59b54a8f4c6..16e97925606b6 100644
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
-		ivecs =3D blk_rq_nr_integrity_segments(rq);
-		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
+		if (sg_alloc_table_chained(&prot_sdb->table,
+				blk_rq_nr_integrity_segments(rq),
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
index 9c7029aa9c22a..6a62885a6beab 100644
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


