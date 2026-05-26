Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E363CD5BD0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g+gNnuCEu0CCTScieZP2q/o0Hc0wagg2kuzY3RUVL2k=; b=Y7W0u9y2OzFbn1w91UZmONroSE
	ppn1D6g0qsd16wX3gqEpAhKjnIv/CD4L0kDMMTstkA0eigphxjOSwcEvhZheL36UdjHD76oCeUZLE
	GyINKd9FTG4Hca5grYnhAfd4pOj8B+relAHdMBx69EODMTUjgnt+W1JAlVnQ4Z/8dm9nlqpMcRN57
	n34dmLbAGvrulD8Mwdyp5u53bo6URPCVXO9LgDRXfVpZPHouPUH+izMoeAMLndfLP2mGI2TQvQGrj
	BkInRMIoSjGI+gsvgXu2qa/NY2DbTyHzgWzcDVKIZ/jwGYCz8ZslThfPWUqNC20fyXJWBLoY8mAHh
	ku/Op2pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtsa-00000002Owg-0xsB;
	Tue, 26 May 2026 15:39:40 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtsX-00000002OvM-2a8g
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 15:39:38 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PKuCHs1978827
	for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 08:39:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=g+gNnuCEu0CCTScieZP2q/o0Hc0wagg2kuzY3RUVL2k=; b=dY7DvuzRE5Ci
	McDxPH0acpwnWq4lkkWpk8gsiO13+1Ka0OKoUH6uPd2zuY0XB9/n3gf6XfSAowvT
	ROEMJA1OFMgFubpjOLL/ZKkJZNbOuyq7xO4YRP7lzIalIxG4Vj00ooP7sIgwG24C
	jFOupEFKrXYhv0L4QtmwUDdnbgWG0u+YbiN26/E5GPsdSTgTgpaAZYP6ExPhKezb
	ux4xSmB0Ri5s1KCWw4BnQ9kLFKxKO0GRVe0JF8M4GKKSNGJGz+Ifp94081zo1akg
	LAvk2kKqDOdgrdpnYH+oRVlQ2+7wVSLDFoBOFsgHp87+FjFrYwN6trGWjihstz+a
	1ZJmtrzhzg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ec08tjvy1-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 08:39:37 -0700 (PDT)
Received: from twshared10183.03.snb3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:39:33 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4BB121CA8D4B7; Tue, 26 May 2026 08:39:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 1/2] block: export passthrough stats enabled
Date: Tue, 26 May 2026 08:39:20 -0700
Message-ID: <20260526153921.2402015-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526153921.2402015-1-kbusch@meta.com>
References: <20260526153921.2402015-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNSBTYWx0ZWRfX1TR8BmntfFNl
 CZcEyhH52zpD7Be+1+v2/JEYQiSu2Br+CnFYGaNURhebpYkAFGsWStxmhjbiMtUpPdIbIJJyWos
 foE2R8UL4E9a5Y2qdwDG8oY9CiTBd+sQ4XiFCwEkvDJIAPkS6EExiDpOzI44Oc3HW3rV6QHltMx
 jG9C0FM0dlWYvm2TneCWGbe4PnuQ8PNXMuL9GakTem2mbzX/SIeeANcuuVin6bJFjHYP4dewllm
 Tcy8Z3Vg9UeALl7D9lqsKssOJdhYTrViV59wGTils+DBkfSzScjEelsNPhUJJho2jo1GAGzj+vt
 mfu1Ram9VE7uDA3RrduMZEsNqIprUbTlslXRrFT2xR6MODby+5MBmPctFLUhwMglBFy4F3dm5fq
 xwc3FnPOsfE7PrVEkO7K/ho+IXd/YkRi0sHWSzrAhmeN29OcPpljqqkAplqy+o0CAPVnmzrxGu5
 E8n/7rbnUUceu9N0Sjw==
X-Proofpoint-GUID: ANTafdlnUbRzxmYh9NSSIjY2flocHjY5
X-Proofpoint-ORIG-GUID: ANTafdlnUbRzxmYh9NSSIjY2flocHjY5
X-Authority-Analysis: v=2.4 cv=LvKiDHdc c=1 sm=1 tr=0 ts=6a15beb9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=EHD5-2HmoPCg4FQ8pjcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_083937_663967_BE7C91B0 
X-CRM114-Status: GOOD (  16.44  )
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
stacking drivers to to report iostats for passthrough workloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 32 +-------------------------------
 include/linux/blk-mq.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28c2d931e75ea..48115e1d9d6a8 100644
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
index 18a2388ba581d..25931a8076d2a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1243,4 +1243,34 @@ static inline int blk_rq_map_sg(struct request *rq=
, struct scatterlist *sglist)
 }
 void blk_dump_rq_flags(struct request *, char *);
=20
+static inline bool blk_rq_passthrough_stats(struct request *req,
+					    struct request_queue *q)
+{
+	struct bio *bio =3D req->bio;
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
+	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
+		return false;
+	return true;
+}
 #endif /* BLK_MQ_H */
--=20
2.53.0-Meta


