Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE77CD5BB3
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tdDFrX8lM7K1Y12nbTVKb2PxejimTHNOscZLEaHb94s=; b=dZg1hC0VegxQfXD81q1XsNnN49
	wgyNrfucVNn6ovOeePAhJ+2teaMcWta8OLbegX+x6HYvbTcGme25704c5QAAuKyVYDZzLSgoyFjBg
	yXWdmPCNYWnqytDWFw0wTLI8OlbTMPVX3F9jYWLz97m2hETZ5ePs7V6U4jeug97rodwMx5RtK5AbC
	DYsKB6cwJbu8KDlcmQFN11sl+Hisna5daIOpzirPr6jlM2IEncxp5Cp+7MQOPiwakvI3qZ/7CE+12
	qMGS9EX4Q58jkHnT+KBS5eiaY1qxTcFSROtDJLJwLW3hoYX0CixMqatM6Rte63yLfsRTsxz/Z6usW
	mJ7waD1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRbY-0000000BE8L-3Huu;
	Fri, 22 May 2026 15:16:04 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRbW-0000000BE7b-0Ikt
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 15:16:03 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M1bSQp2537500
	for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 08:16:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=tdDFrX8lM7K1Y12nbT
	VKb2PxejimTHNOscZLEaHb94s=; b=g6I/MGc+B11xPtKXs0AQkKiyegLSc9eRt9
	a6vWxD+rE4E8+SheqXXDfcntUsdJWX0Dsz7QyT6NM1ycjokYcQahdkVT1t6qoTW1
	yVGsEVMyw/QY16kF/Lxza+wPiz4iGbZskogGstd06x4F4y3ICitY6XyUrOAT7dn4
	eTExWGswXxDlZZZuFH35xnYpJJWHLJ3m9GznyxT0rN0plPPZSerf2MvPOoBPlTwT
	JsEknVLPjFK206kSQXJwcLJELkdWM/GMeQPyLfzCs7cA4FRXt8DGpdKGgtIBZweT
	aCP8WgkFd7ZDGKYD8cceSznfS5FT44ZL+4YVyWM0n90W43z8PCQA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e9yy1h3v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 08:15:59 -0700 (PDT)
Received: from twshared124658.16.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Fri, 22 May 2026 15:15:59 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 105CA1B7550E2; Fri, 22 May 2026 08:15:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] block, nvme: export and use passthrough stats
Date: Fri, 22 May 2026 08:15:37 -0700
Message-ID: <20260522151537.1509784-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MiBTYWx0ZWRfX1U2gV9Dqa957
 YFlmhlTz8pQeqmPPLCSYpq6mv5v4ZOlGtiK54buLxj5PIIPUItLw5H+drrOJEv76a50aAWLrCMd
 IrXWAlqD06RPnuHh+kcYUrv0b8KTBQchFId02V2rXdQBLgGXk1TkS2hvt8eJ9GqdnIz2m3BTjOz
 Ef4bRCeS2OlMLv8KKZ0xiRX4Wysn912uYXB7ZdzRJQ2s8w9PZS79Nau8Zwc910HQ3qokBfDfm55
 1ZP/23d7qWW8CvEz1c0uN03xG1WzInVpRhC0g7UEJhnvjGx4Hz/nR5QWr0SJKql45TeLmen+oR5
 /2APvYK1PNF5xG/7DLAy/iW+TAY/tX6yFAayJCbKORcqahfIu011IspzjwzAC8YyyiCjjzNE5nn
 O9U/Wadg9Kn4YfKymDGqqfJCz87B6W2oM2lvQRlAUzC2jTRUDWmxMYivGDo26mrno8UGg5GOAS6
 7iaS+cEZ9BFiwuIb+LQ==
X-Proofpoint-ORIG-GUID: MK5wh_HsCHPhoA9ixSf3bh_c-oUYUcOl
X-Authority-Analysis: v=2.4 cv=c5Cbhx9l c=1 sm=1 tr=0 ts=6a10732f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=b18omjuUomqfQ-ouQ7YA:9
X-Proofpoint-GUID: MK5wh_HsCHPhoA9ixSf3bh_c-oUYUcOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_081602_260953_2F487F4A 
X-CRM114-Status: GOOD (  15.13  )
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

So stacking drivers can also report passthrough workloads through
iostat.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c                | 30 ------------------------------
 drivers/nvme/host/multipath.c |  4 +++-
 include/linux/blk-mq.h        | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28c2d931e75ea..c794b70fefe26 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1088,36 +1088,6 @@ static inline void blk_account_io_done(struct requ=
est *req, u64 now)
 	}
 }
=20
-static inline bool blk_rq_passthrough_stats(struct request *req)
-{
-	struct bio *bio =3D req->bio;
-
-	if (!blk_queue_passthrough_stat(req->q))
-		return false;
-
-	/* Requests without a bio do not transfer data. */
-	if (!bio)
-		return false;
-
-	/*
-	 * Stats are accumulated in the bdev, so must have one attached to a
-	 * bio to track stats. Most drivers do not set the bdev for passthrough
-	 * requests, but nvme is one that will set it.
-	 */
-	if (!bio->bi_bdev)
-		return false;
-
-	/*
-	 * We don't know what a passthrough command does, but we know the
-	 * payload size and data direction. Ensuring the size is aligned to the
-	 * block size filters out most commands with payloads that don't
-	 * represent sector access.
-	 */
-	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
-		return false;
-	return true;
-}
-
 static inline void blk_account_io_start(struct request *req)
 {
 	trace_block_io_start(req);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 263161cb8ac06..435fab0be6401 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -175,9 +175,11 @@ void nvme_mpath_start_request(struct request *rq)
 		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE;
 	}
=20
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	if (!blk_queue_io_stat(disk->queue) ||
 	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+	if (blk_rq_is_passthrough(rq) && !blk_rq_passthrough_stats(rq))
+		return;
=20
 	nvme_req(rq)->flags |=3D NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time =3D bdev_start_io_acct(disk->part0, req_op(rq)=
,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581d..8301830ece8b7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1243,4 +1243,33 @@ static inline int blk_rq_map_sg(struct request *rq=
, struct scatterlist *sglist)
 }
 void blk_dump_rq_flags(struct request *, char *);
=20
+static inline bool blk_rq_passthrough_stats(struct request *req)
+{
+	struct bio *bio =3D req->bio;
+
+	if (!blk_queue_passthrough_stat(req->q))
+		return false;
+
+	/* Requests without a bio do not transfer data. */
+	if (!bio)
+		return false;
+
+	/*
+	 * Stats are accumulated in the bdev, so must have one attached to a
+	 * bio to track stats. Most drivers do not set the bdev for passthrough
+	 * requests, but nvme is one that will set it.
+	 */
+	if (!bio->bi_bdev)
+		return false;
+
+	/*
+	 * We don't know what a passthrough command does, but we know the
+	 * payload size and data direction. Ensuring the size is aligned to the
+	 * block size filters out most commands with payloads that don't
+	 * represent sector access.
+	 */
+	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
+		return false;
+	return true;
+}
 #endif /* BLK_MQ_H */
--=20
2.53.0-Meta


