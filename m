Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83935FC6171
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EK7qRVh7IubhEF75usjllDVX8wTrwNSbwEX2ZPVAxZ4=; b=pmUwHqW0Ze7xSSnQG9y5LWRxlN
	NQL2pLXqrWLVeMABMOFCO8WVpD/V9Z/9xIkS3u4OBQbzUWXUAKMFdGSKgc8V2MzWUTQRw03aMeSlP
	99kNgC/rV8mJKPTqSg11/QTWYKWaQXiZcbgHZpTYxOu74+bF+fUNGNdAcLC3ZOE1ASyYUPwn34l+p
	ABY3UYQIHOa0ZSobiO/lytVytwiHHUzKawnQWTWKrxponc1ChX1/2dyZyKfk8Cwj+E5+VeDOq3mXr
	931/4s7tRExBF1GGAYCQ4MLd5DlioknItKAiyeatqKHflCE4a7S5qmZVH13uTLBbiWL/BJphyTcc5
	9hcklR6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spB3A-0000000GoaZ-3CaB;
	Fri, 13 Sep 2024 18:29:44 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2m-0000000GoNP-0Qs1
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:29:43 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI2Llc003051
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=EK7qRVh7IubhEF75usjllDVX8wTrwNSbwEX2ZPVAxZ4=; b=
	TjYEE7q+wgX0XEKkcNJRs2RGesVbDegYUp+HLCdvhP7zrqHfohg3ek3iTeoo+meG
	BBVc4rVWbwZy0hXGn5+DVQMO7hYf+vAvmbM5kFupk7hFbth4FP800IBqxZeiooGN
	6qAhyDt1zKE1G53ikDLp23fUuw9jreMlAznSwFwxT7fKBUG0Rv7FkK69ERmN/kGI
	8bgUQMbI2FxmbCcQYZpZb1LO80kHTzakPAyHodDud3CxCp8Yskwq5OASjWgcJGCL
	FghDqLZNkxvsMQU9g2MBdOSvaAPGYoleevYzCcb5r+ZVOyZHOpxrEdN4a8R29JhX
	cJAtHF8JxJcwvGUMP7aFWw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kha4qjc4-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:19 -0700 (PDT)
Received: from twshared32638.07.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 691FB12F91047; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 3/9] blk-integrity: properly account for segments
Date: Fri, 13 Sep 2024 11:28:48 -0700
Message-ID: <20240913182854.2445457-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3ax1XI1J7kMoE_N1TrQNYMtd5Bspl62a
X-Proofpoint-ORIG-GUID: 3ax1XI1J7kMoE_N1TrQNYMtd5Bspl62a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_112920_413399_11475E49 
X-CRM114-Status: GOOD (  14.42  )
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

Both types of merging when integrity data is used are miscounting the
segments:

Merging two requests wasn't accounting for the new segment count, so add
the "next" segment count to the first on a successful merge to ensure
this value is accurate.

Merging a bio into an existing request was double counting the bio's
segments, even if the merge failed later on. Move the segment accounting
to the end when the merge is successful.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 2 --
 block/blk-merge.c     | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 010decc892eaa..afd101555d3cb 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -153,8 +153,6 @@ bool blk_integrity_merge_bio(struct request_queue *q,=
 struct request *req,
 	    q->limits.max_integrity_segments)
 		return false;
=20
-	req->nr_integrity_segments +=3D nr_integrity_segs;
-
 	return true;
 }
=20
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 56769c4bcd799..ad763ec313b6a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -639,6 +639,9 @@ static inline int ll_new_hw_segment(struct request *r=
eq, struct bio *bio,
 	 * counters.
 	 */
 	req->nr_phys_segments +=3D nr_phys_segs;
+	if (bio_integrity(bio))
+		req->nr_integrity_segments +=3D blk_rq_count_integrity_sg(req->q,
+									bio);
 	return 1;
=20
 no_merge:
@@ -731,6 +734,7 @@ static int ll_merge_requests_fn(struct request_queue =
*q, struct request *req,
=20
 	/* Merge is OK... */
 	req->nr_phys_segments =3D total_phys_segments;
+	req->nr_integrity_segments +=3D next->nr_integrity_segments;
 	return 1;
 }
=20
--=20
2.43.5


