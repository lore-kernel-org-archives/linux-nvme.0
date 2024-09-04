Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C8ACD4847
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mx/X2bX0pns4vleyJjY1s7PAjZcF77tvDOIJw1tvmqU=; b=yevqNHrigQf+mA2z+PvGGAwQ3m
	zqsfmvrpEW4BGp4WXbH1PhsgC0/Yka4dmjXL3kUhBo469Czvp7fqQuuML0pHJsYHQuAx7BPlMXED3
	+SOfeuZXfQMjPStpH5Lv2hS2RlAzHZVEoTP4AXTQBgNRcL/WqumLn8Y07LwmK9di2hKLFs/QmdtZE
	NkCc9bclbfYyxx9F6WTIdHBROALt1tIXGfQb9fPTD5mrHCQQ9B7PtO+6+4bOLDHjkMac8SwZ65O17
	jIblm1yypu6Z37Wlq3CKQyF7fBMR2WGFFsWsZhg8fYaZMv9qTDysxx6EGnErwF7Jeb3DGljjvYioZ
	juXRCJaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slu4n-00000005VLH-2Z8o;
	Wed, 04 Sep 2024 17:45:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruV-00000004zoZ-2R3Q
	for linux-nvme@bombadil.infradead.org;
	Wed, 04 Sep 2024 15:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mx/X2bX0pns4vleyJjY1s7PAjZcF77tvDOIJw1tvmqU=; b=IBlaWyy9I5ws/PywH+U2fE5jfE
	u2LpwdESIV62CO9SGttBMs59I5Tk/IdnhUoICQQOkIam0FpHv1fJTD7xVjGISFWy8tusFoCAlDMTA
	gRTlB7pAza1MIaGn3YDmfkKkcZDSzIL3CwxPzede0hFhAlTE0O4bVj0cVbTK3K9rR89qBLf2P2r0c
	kWPPzMeYoKGJBC/5uO17ZhxLIbpGI1fZkIyfYFcNtACS2WD/ukLalAV82ir7br4hrnDjBBG1O0ui2
	Q7xL4XIehEkEQuiJo8tkWKWj92B7lkBIVFGmM+MRD1K9EKSyqmsfNWMQDOozF2N+kA2M8JwS3rNgF
	9iTuremA==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1slruR-00000000HVk-0UOI
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:27:05 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849UfQK022985
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:27:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=mx/X2bX0pns4vleyJjY1s7PAjZcF77tvDOIJw1tvmqU=; b=
	e9HKErPFSEqRS6SYxYEtI9ugoHRs6t3oU4pALUyW1xJlmj2BHRKFcBP4qm5fXSY3
	/737uAIkHJe+jJ5o6SCUfX/EPUP8ijUUSWv81aP0f1NS+XaioTE7nzqDgkY7jLIl
	Pee8NK65RncXXy2zrxyREMIniI9jnoLrIWOc3jfpOFeiAcm6V/xg5gX1qJan1QiX
	G0Ekw7fA3yJgvGciJWta+RMmBzvwEmRDwHwfDV6igqFxTK8m0V/3HzeimXxKuWZM
	Vmsbe2GL1TymKRc0JSnfSuNRyGNZ9irYYLAmLSqMHJi3kJocZkWbqhPULHMZc3Bq
	NHbwF5ttjON97JYNPjfS6A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1wcm-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:27:00 -0700 (PDT)
Received: from twshared17102.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:17 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E07A612A036EF; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 07/10] blk-integrity: simplify mapping sg
Date: Wed, 4 Sep 2024 08:26:02 -0700
Message-ID: <20240904152605.4055570-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: VuWVOBksUpjPp16gqc5Mw_B2PC-p0Nqr
X-Proofpoint-ORIG-GUID: VuWVOBksUpjPp16gqc5Mw_B2PC-p0Nqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_162703_619259_5ABBBA30 
X-CRM114-Status: GOOD (  17.10  )
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

The segments are already packed to the queue limits when adding them to
the bio, so each vector is already its own segment. No need to attempt
compacting them even more.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c         | 35 +++++++++--------------------------
 drivers/nvme/host/rdma.c      |  4 ++--
 drivers/scsi/scsi_lib.c       |  3 +--
 include/linux/blk-integrity.h |  6 ++----
 4 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index c180141b7871c..cfb394eff35c8 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -35,7 +35,6 @@ int blk_rq_count_integrity_segs(struct bio *bio)
=20
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
- * @q:		request queue
  * @bio:	bio with integrity metadata attached
  * @sglist:	target scatterlist
  *
@@ -43,39 +42,23 @@ int blk_rq_count_integrity_segs(struct bio *bio)
  * scatterlist.  The scatterlist must be big enough to hold all
  * elements.  I.e. sized using blk_rq_count_integrity_segs().
  */
-int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
-			    struct scatterlist *sglist)
+int blk_rq_map_integrity_sg(struct bio *bio, struct scatterlist *sglist)
 {
-	struct bio_vec iv, ivprv =3D { NULL };
 	struct scatterlist *sg =3D NULL;
 	unsigned int segments =3D 0;
 	struct bvec_iter iter;
-	int prev =3D 0;
+	struct bio_vec iv;
=20
 	bio_for_each_integrity_vec(iv, bio, iter) {
-
-		if (prev) {
-			if (!biovec_phys_mergeable(q, &ivprv, &iv))
-				goto new_segment;
-			if (sg->length + iv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
-
-			sg->length +=3D iv.bv_len;
-		} else {
-new_segment:
-			if (!sg)
-				sg =3D sglist;
-			else {
-				sg_unmark_end(sg);
-				sg =3D sg_next(sg);
-			}
-
-			sg_set_page(sg, iv.bv_page, iv.bv_len, iv.bv_offset);
-			segments++;
+		if (!sg)
+			sg =3D sglist;
+		else {
+			sg_unmark_end(sg);
+			sg =3D sg_next(sg);
 		}
=20
-		prev =3D 1;
-		ivprv =3D iv;
+		sg_set_page(sg, iv.bv_page, iv.bv_len, iv.bv_offset);
+		segments++;
 	}
=20
 	if (sg)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dc0987d42c6b2..fab205bb4f3ed 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1504,8 +1504,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *=
ibdev, struct request *rq,
 			goto out_unmap_sg;
 		}
=20
-		req->metadata_sgl->nents =3D blk_rq_map_integrity_sg(rq->q,
-				rq->bio, req->metadata_sgl->sg_table.sgl);
+		req->metadata_sgl->nents =3D blk_rq_map_integrity_sg(rq->bio,
+					req->metadata_sgl->sg_table.sgl);
 		*pi_count =3D ib_dma_map_sg(ibdev,
 					  req->metadata_sgl->sg_table.sgl,
 					  req->metadata_sgl->nents,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index dc1a1644cbc0c..33a7d07dcbe26 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1183,8 +1183,7 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *=
cmd)
 			goto out_free_sgtables;
 		}
=20
-		count =3D blk_rq_map_integrity_sg(rq->q, rq->bio,
-						prot_sdb->table.sgl);
+		count =3D blk_rq_map_integrity_sg(rq->bio, prot_sdb->table.sgl);
 		BUG_ON(count > ivecs);
 		BUG_ON(count > queue_max_integrity_segments(rq->q));
=20
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index 0de05278ac824..38b43d6c797df 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -25,8 +25,7 @@ static inline bool queue_limits_stack_integrity_bdev(st=
ruct queue_limits *t,
 }
=20
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
-				   struct scatterlist *);
+int blk_rq_map_integrity_sg(struct bio *, struct scatterlist *);
 int blk_rq_count_integrity_segs(struct bio *);
=20
 static inline bool
@@ -95,8 +94,7 @@ static inline int blk_rq_count_integrity_segs(struct bi=
o *b)
 {
 	return 0;
 }
-static inline int blk_rq_map_integrity_sg(struct request_queue *q,
-					  struct bio *b,
+static inline int blk_rq_map_integrity_sg(struct bio *b,
 					  struct scatterlist *s)
 {
 	return 0;
--=20
2.43.5


