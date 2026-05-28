Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCDECD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 00:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tdDFrX8lM7K1Y12nbTVKb2PxejimTHNOscZLEaHb94s=; b=rbEqZma5dEBPsrwyU6kW+vng/F
	v2C5qK4ER4kVBLKrhvL/zRMLWMtBamp1zN06ywbDTg4s2ViRdBTbe6m3kc46OR0dkGT2KrwzIBlHF
	pi5wji23cqmuDcPGqN8dFBtXb6pSVwTpxVIFcP/NzlJTDkYJ18ZQT6QX6Sn89XyYE2t00dCrfTltk
	hMJU3khoOfghw0izvZELAFWT4daLhF9IVE9L6+1GGJOPT0h8TNA3VJsrAoxuRmlL1PwWZun6QIlPI
	mftd8lbqMwBfspkP7gRDBtp5bIVy7cM6/94uNS/1eDGfLPfFIsZt64gB67xRSnapYdvn4JC6Je9GW
	zPmtQgYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP5o-00000004uyo-3Zzx;
	Thu, 28 May 2026 00:59:24 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP5h-00000004uyT-3oL4
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 00:59:19 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKj3o5094242
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 17:59:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=tdDFrX8lM7K1Y12nbT
	VKb2PxejimTHNOscZLEaHb94s=; b=V8xxkH8ub2lpZHTUrBB/4Yj8grCi/TExBF
	g3ZGlTViECupEYhyNJepX0wZEf3vCXXZB2Cl810q0NFODhjxEAA0tG5SMol0sgLp
	OHF7XfgZvqjf6imA3vH6iQjTPZfWAnOF0gFs2XP6RRHlI0STiyA9gMf0hqjGtaAA
	tspjR3j/9/xPZWkrEOg7urx6zNiSQ2nQllZYJoQftD9e2s6m/8IZuDtF6M+C+Ew/
	CYAj2/FcLpElCI5V0deywPapX0P6ke3d3qG3jyDbJGvd+E2b8BfGvhvFYL47ThSy
	xyEYwyfyGR+r5sZ+DMFcv42DsU+RfDLb491oytc58OzKVBNReLew==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1982y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 17:59:16 -0700 (PDT)
Received: from twshared12601.02.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 00:59:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B88741D39B137; Wed, 27 May 2026 17:58:56 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block, nvme: export and use passthrough stats
Date: Wed, 27 May 2026 17:58:48 -0700
Message-ID: <20260528005848.1517715-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7UsR11d6mXwDcJHmDNBO-kUrUhyCD09w
X-Authority-Analysis: v=2.4 cv=Yu8/gYYX c=1 sm=1 tr=0 ts=6a179364 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=b18omjuUomqfQ-ouQ7YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNyBTYWx0ZWRfX8xPVS/4IfEjY
 JGhoG4ni1KdSduLSeEpi3E4+GTXqVOqsxvhE4KhDtddCaAF9JjyB6u1AddwKvYUmEgVetJv+zIK
 bVnwi4p7XekWff6jDp3lad4rPqbAiNzgDZK1eqeseieZ2jiRNWDEzHKdD6+jXR1rOeZ8Zyeym0H
 b5TSHt9pJkO9NHbK/JnaXN0EIbJ0sWUGMfnUwNQxF+yNiPG4D/P5jTYRaMlHG6/6HwHrwHb5eWN
 XxmHBnviHdn5UzJDldVwBLce/HRMU+gAF0U0JYGjAYZenpWSeRbNbAy1fFNqevefZ2Mmqu0pF3W
 M18jUfeWC6LbADVz1LqC+Lf9/P3GHt/49sQxZY3ttJuKQLthT20shKWKnfQyZhujxlL91XFxUQq
 Mi+/pNb9nP95DcLdu85bM3BBdX9aA1VA/s+zpJsSm01iciVHxXchMggY9V57UMUmV3CPxROHwCT
 h7EdnS5ilDvP2y+85EQ==
X-Proofpoint-ORIG-GUID: 7UsR11d6mXwDcJHmDNBO-kUrUhyCD09w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_175918_154140_A2FDEA25 
X-CRM114-Status: GOOD (  15.61  )
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


