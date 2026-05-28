Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0704DCD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 01:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZvbxEnuRPHG8YjILxzVfHLsU7XT1tNyIlSqTCxaaEU=; b=u9Nxw3NqnKfONQAkEKtaH1PE1l
	VQhdGpc7gECtpyYkYXMvWEZhdTIwAtbTLXDvPgShAw1HA2i1uFo+4QfwfWU0d9a/Ssn2HX2Fp9+5e
	uz6DmdfVL/VNRb7JlvMI4tppc77NbR/OtE6NtlGiFvbHiqVp36xcGAcNXRKa/DTcDzDogDnrlNYk3
	aQbQHYwpXHoAPTb8WHQefgcv9RQolAtJJ6srl8JckTnkjsxX1Wq9LOE3IMHp1AZwbrry1jPMaQVdh
	Jt7f/tAf46SVU3a7NpKfa3kRrTsfMw07XFNQthXTDzfp42FN57LQ+A7fHasqybWdQAfWy79oSHQnL
	dLBeBTiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP7X-00000004v9F-0gdq;
	Thu, 28 May 2026 01:01:11 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP7T-00000004v8m-3dEq
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 01:01:09 +0000
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKj48R1009889
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:01:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xZvbxEnuRPHG8YjILxzVfHLsU7XT1tNyIlSqTCxaaEU=; b=hq6ukkfODvR+
	zCUYZgxFJgdZBIvdfTSu7bmNkTMwda4RfPcrHnWS8DSqOGJwEr5pOi4mEKSPaM80
	aMgISyvavsduuuamnQVEUBLBgMyaNVRRVZFYuxLqUr7/j9fCph9cWVgupC+J5LUv
	KJvN+RmXNZR/fZaQhY7HjFBIN/6ThjlmsoUYXwDTd1ofR6nPUMsyyxtHirT4BAQw
	ywQAsvEtctkxhoMlWYBGgI7S4S0zpv7RiYxKzrmLufTh3cKTScYY8AexSgVkV1RS
	WsA1LcKd34uQ2/e6Wkg3a57PXTyL74ftvlYHk218h0n15WnFHv7t/DEcl3X6Bwan
	0fx4NFIDKQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1h8sk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:01:06 -0700 (PDT)
Received: from twshared34426.16.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 01:01:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0F3411D39B575; Wed, 27 May 2026 18:00:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Nilay
 Shroff <nilay@linux.ibm.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCHv3 1/2] block: export passthrough stats enabled
Date: Wed, 27 May 2026 18:00:40 -0700
Message-ID: <20260528010041.1533124-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528010041.1533124-1-kbusch@meta.com>
References: <20260528010041.1533124-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNyBTYWx0ZWRfX/Xo4yCKMERAz
 Efa0BfXbTLvP5ZNHdktCxBoawTMBBpKPgrSL1GfH0hebkMMxHFxUZyG1v4eTM7UhD+laV2KA7Un
 D2lxTiHPNNtKDRRk0mW8kN3AlGiKI4FPQ89N82h0IGsr82uFeizfPGXa1Fx9I2XkjendhmRjnQF
 3gd8O2SxlUnlPYxLWGhf5l1PeggUgg3hqq1WC5/8P6Fw1cNzXJoKcle1zpJaX4fbk4ILW3GTl2I
 Q1s/XUTB2xbyOzDbEFHhagZHSSeAaNjr6Mmw5QoEcVj4XHu4SO5yQCN35frotBFRjomo/gXi0x/
 rpMjTR6M3kdhRZwPFXebiZD+UrHxFuBdqldUloiL7CXty/lSXzOwiL1WrgI198dTuU2iopo02RY
 9KWfuofbyDvjOjDXogmXweWR8VXoc9ivcxCq6BlOpiTcM0htMG9f5PM4fIlgd7MtfQLbNABGUtF
 KQgLsUb2ejYL8M63CHQ==
X-Proofpoint-ORIG-GUID: I8HWqaHD8NWR2AQCCRoxF7gg8HlY3190
X-Authority-Analysis: v=2.4 cv=M7h97Sws c=1 sm=1 tr=0 ts=6a1793d2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8
 a=EHD5-2HmoPCg4FQ8pjcA:9
X-Proofpoint-GUID: I8HWqaHD8NWR2AQCCRoxF7gg8HlY3190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_180108_556684_46D767A5 
X-CRM114-Status: GOOD (  19.27  )
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

A user can enable io accounting for passthrough requests, so export the
helper that checks if the request should be tracked. This will enable
stacking drivers to to report iostats for passthrough workloads. Since
the stacking request_queue may not be the one providing the request, the
API has to add a parameter for the caller to specify which one to check.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 32 +-------------------------------
 include/linux/blk-mq.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a24175441380e..8ab6fa59f8d54 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1088,43 +1088,13 @@ static inline void blk_account_io_done(struct req=
uest *req, u64 now)
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
=20
 	if (!blk_queue_io_stat(req->q))
 		return;
-	if (blk_rq_is_passthrough(req) && !blk_rq_passthrough_stats(req))
+	if (blk_rq_is_passthrough(req) && !blk_rq_passthrough_stats(req, req->q=
))
 		return;
=20
 	req->rq_flags |=3D RQF_IO_STAT;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 24b4160aeaad3..af878597afb8c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1252,4 +1252,44 @@ static inline int blk_rq_map_sg(struct request *rq=
, struct scatterlist *sglist)
 }
 void blk_dump_rq_flags(struct request *, char *);
=20
+/**
+ * blk_rq_passthrough_stats - check if this request should account stats
+ * @rq: request to check
+ * @q: the queue accumulating the stats
+ *
+ * Note, @q does not necessarily need to be the request_queue that provi=
des
+ * @rq.
+ *
+ * Return: true if stats should be accounted.
+ */
+static inline bool blk_rq_passthrough_stats(struct request *rq,
+					    struct request_queue *q)
+{
+	struct bio *bio =3D rq->bio;
+
+	if (!blk_queue_passthrough_stat(q))
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
+	if (blk_rq_bytes(rq) & (bdev_logical_block_size(bio->bi_bdev) - 1))
+		return false;
+	return true;
+}
 #endif /* BLK_MQ_H */
--=20
2.53.0-Meta


