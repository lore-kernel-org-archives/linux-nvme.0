Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905ABEE57CF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cI4PGri7hMTRHjnyM/50PhrK4S2rzpkniDkZMLEWhLw=; b=PUNaO53UyE1SQnGR/I7samyL63
	egjmsrbMVc5Ub1GmjJsAXQF+IWEVAxYFff9xjCvrIbKg7YFqeePvbCJYCzhbp1BPHly5vdgkMynwz
	u4x6izPdsC85KryOIIbnnoCtZ9t7FZ5pPAPNMuAHHkYk7G1frDuWdZDJI/45sf8dDZGFk36FoHBwZ
	kzokckjNlntpYNmoKulb4uhqEkijRoLcX+K/zKUadpnQHc293ePEop6N4i7pU9Ku8zrFJ/NcJrWU9
	0VcojOCNW2Z3IH4knxy9FSM9UX937EzxurUtEQCUD8NGGLvX0cYGbsaq8YvLVDSeaHl5buuVphS+3
	FJcBF6Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThw-0000000Aqlc-282o;
	Wed, 11 Sep 2024 20:12:56 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThq-0000000Aqia-2ljF
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:12:53 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BHjdxX019460
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=cI4PGri7hMTRHjnyM/50PhrK4S2rzpkniDkZMLEWhLw=; b=
	mzkEnVpg/vvg9ATgCufbsPPrfXMilhSs05IQdQeBTHIUrTHGYBR1p7TpPUE+raul
	aHjO64VLrCV7JS7whVbYN2RqQLkSaY+k2y8Actp7FdxItBXa1QSAy1lc4m67PWoq
	IKtUWJWsNdl/UcxQo13L5pBwRolyEuI4gUF1fVsgRs/OqWncEzSMtdCwWJfyXZus
	eYcyU2G3Abj2nqCzTVGdOz31xDeYaCHRXvSIA9rZWfailSRGRPd9EllbIS5uuOEA
	neIob9EKHTkPxeeVAfR4uL14kvo0WkScKF9/kstrAGGP6LWaPIy8Fel4aUzC3l41
	i/nnzX1EFz+QuUrw/15WWA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kbpe38qg-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:49 -0700 (PDT)
Received: from twshared25838.31.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 037CB12E5EDAE; Wed, 11 Sep 2024 13:12:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 05/10] block: provide a request helper for user integrity segments
Date: Wed, 11 Sep 2024 13:12:35 -0700
Message-ID: <20240911201240.3982856-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hIz3Whc-3SnuSJ9lVYieWV_0ogVX78b0
X-Proofpoint-GUID: hIz3Whc-3SnuSJ9lVYieWV_0ogVX78b0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131250_814361_26096574 
X-CRM114-Status: GOOD (  14.48  )
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

Provide a helper keep the request flags and nr_integrity_segments in
sync with the bio's integrity payload. This is an integrity equivalent
to the normal data helper function, 'blk_rq_map_user()'.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         |  1 -
 block/blk-integrity.c         | 14 ++++++++++++++
 drivers/nvme/host/ioctl.c     |  6 ++----
 include/linux/blk-integrity.h |  7 +++++++
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8d1fb38f745f9..357a022eed411 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -371,7 +371,6 @@ int bio_integrity_map_user(struct bio *bio, void __us=
er *ubuf, ssize_t bytes,
 		kfree(bvec);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(bio_integrity_map_user);
=20
 /**
  * bio_integrity_prep - Prepare bio for integrity I/O
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 84065691aaed0..ddc742d58330b 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -107,6 +107,20 @@ int blk_rq_map_integrity_sg(struct request_queue *q,=
 struct bio *bio,
 }
 EXPORT_SYMBOL(blk_rq_map_integrity_sg);
=20
+int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
+			      ssize_t bytes, u32 seed)
+{
+	int ret =3D bio_integrity_map_user(rq->bio, ubuf, bytes, seed);
+
+	if (ret)
+		return ret;
+
+	rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q, rq->bio)=
;
+	rq->cmd_flags |=3D REQ_INTEGRITY;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_map_user);
+
 bool blk_integrity_merge_rq(struct request_queue *q, struct request *req=
,
 			    struct request *next)
 {
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 1d769c842fbf5..b9b79ccfabf8a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
-#include <linux/bio-integrity.h>
 #include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
@@ -153,11 +152,10 @@ static int nvme_map_user_request(struct request *re=
q, u64 ubuffer,
 		bio_set_dev(bio, bdev);
=20
 	if (has_metadata) {
-		ret =3D bio_integrity_map_user(bio, meta_buffer, meta_len,
-					     meta_seed);
+		ret =3D blk_rq_integrity_map_user(req, meta_buffer, meta_len,
+						meta_seed);
 		if (ret)
 			goto out_unmap;
-		req->cmd_flags |=3D REQ_INTEGRITY;
 	}
=20
 	return ret;
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index de98049b7ded9..9c7029aa9c22a 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -28,6 +28,8 @@ static inline bool queue_limits_stack_integrity_bdev(st=
ruct queue_limits *t,
 int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
 				   struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
+int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
+			      ssize_t bytes, u32 seed);
=20
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -102,6 +104,11 @@ static inline int blk_rq_map_integrity_sg(struct req=
uest_queue *q,
 {
 	return 0;
 }
+static inline int blk_rq_integrity_map_user(struct request *rq, void __u=
ser *ubuf,
+			      ssize_t bytes, u32 seed)
+{
+	return -EINVAL;
+}
 static inline struct blk_integrity *bdev_get_integrity(struct block_devi=
ce *b)
 {
 	return NULL;
--=20
2.43.5


