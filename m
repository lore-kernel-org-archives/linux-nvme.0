Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA80CD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53LR8ALSOVcr1chIg7i5h6RsLjS4b0KKwqAikvUBUeM=; b=pfe/v3VV9mM8B4KlQBUGa45RKC
	Dtn+e/5HBKvPS44QmF70NoYzbYgeU3+24a8JMAzJ2Et1P4uUTd1ULuCXyHg3RNVzCFpjKnpDmFK1T
	OLX8guore6COBsySz3HUETCpkKGVCNuro/DszM/bJMuOkMERMbdA1VficrbYiBiZ+zLUpZTjle3qW
	iOREACUtTmwWR3NXU0d2MBpoS1O340HrCXIJBJ7CLYpo/Uc/pbQ+FXGNqctKJxj4YZ4v2lOsLyTVf
	Z+9OAwcADs5QBOfWJBiTzSrXG+Z9s5smvzoz5vEIF7opboH0cOLQiIKpCjOPEq3ciFu8Y6fM3FAMK
	Ld0GwrSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAc-00000002NYO-2O6O;
	Tue, 19 May 2026 17:23:54 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAZ-00000002NWa-46Al
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 17:23:53 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JE8sUk2574853
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:23:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=53LR8ALSOVcr1chIg7i5h6RsLjS4b0KKwqAikvUBUeM=; b=oSHl2CiW0NvA
	ck+XR12XCjJF76m2ynQ1f1RtmmW8W440AnNoR7qYEQcD+niDx18op1zpg8q5KmMk
	EOagVJ7RdJGz5Gd/WtgEpvA1BhybrNBT7p8inKRmy8rZcXz25U83f3gTHPTgxgWN
	TSrjyAxKgr3ex4mWwA3Hf5/OqRg8DaLfVMdNn8nRlve6me+h/qziamtax05YNJAI
	VCauRvaiMtoXqjjq4zXpKEFhDRHq6UfUX6ikM3AS2sW7sTciR/46iVngv91D+Ykt
	2L4iB+dcUra8OioerPQR8wHAqyuZZ278Zh3FFFtXfbsEwMRxi7JWWD5xzSjdVAu3
	R6c3sVwnbg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8sc51bm2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:23:50 -0700 (PDT)
Received: from twshared11179.02.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:48 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id EA7081A75979B; Tue, 19 May 2026 10:23:34 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 3/5] block: validate bio bounds in the queue entered context
Date: Tue, 19 May 2026 10:23:24 -0700
Message-ID: <20260519172326.3462354-4-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519172326.3462354-1-kbusch@meta.com>
References: <20260519172326.3462354-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TaimcxQh c=1 sm=1 tr=0 ts=6a0c9ca6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=4C8x5qO1QXPBt7sUNhsA:9
X-Proofpoint-ORIG-GUID: 79MZ7y5bc1pHnNCYAw_BdigSlai0mKQd
X-Proofpoint-GUID: 79MZ7y5bc1pHnNCYAw_BdigSlai0mKQd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3MyBTYWx0ZWRfX/NB3atZAIYNC
 iSiWR2c/HP+68CeB0YN519HYs9HqaHPfClPgvtlrLOG9d/z+M4LIyvrkrvlYC+wXYWzJABFEJb2
 NDsAkvg90qNwYTd1ys2dKJQKoeJ0mQ8wolu+5z6Tue11d11BHq8jnGrXSbFJw0mfUqwQPMivS0V
 dOWyTBG6qkdw0l+XmnwwJQUP5TbiwZob+ZoB7y6jFlxcW2XUpHxDLqa88/tJ3EX7Cpf/j2ClCGS
 hPj8cmWUiOUFgCDqkVrJ+tVa9v/5bVF50pCegd9aTBTuQ4rxRfcNrChcQU6WLoyHTk5UqcUlY+1
 tESc+TvrMZjNd3gJXruKd7K/yrTGCmi8bEqG7xA15sRdqt8QZFVqlGQoExfVgc3TZqksYi1yLhH
 h9SC7ZXd8ccRz8x7Pnqz62kOfdgsV3YuUaL2YQ+QRGfRaCAijfhp5DvApEHGS0SxkfIbWoRcSiu
 QTbImOWAYbVwhY8yOjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_102352_718905_4A78A95E 
X-CRM114-Status: GOOD (  19.08  )
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

bio_check_eod() in submit_bio_noacct() validates that a bio does not
extend beyond the partition's available sectors. This check runs before
bio_queue_enter(), so it is not serialized against queue limit updates.
A driver that freezes the queue, updates limits, changes the capacity,
and unfreezes can race with a bio that passed the early check under the
old capacity.

Remove bio_check_eod() and replace it with a bounds check in
__bio_split_to_limits(), which runs after the queue usage reference has
been acquired. The check uses partition-aware arithmetic to validate
both partition bounds and disk capacity in a single comparison that
works correctly on the post-remap sector values.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c | 26 --------------------------
 block/blk.h      | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 92a802dc8042c..c200d0fc44fe7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -547,30 +547,6 @@ int should_fail_bio(struct bio *bio)
 }
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
=20
-/*
- * Check whether this bio extends beyond the end of the device or partit=
ion.
- * This may well happen - the kernel calls bread() without checking the =
size of
- * the device, e.g., when mounting a file system.
- */
-static inline int bio_check_eod(struct bio *bio)
-{
-	sector_t maxsector =3D bdev_nr_sectors(bio->bi_bdev);
-	unsigned int nr_sectors =3D bio_sectors(bio);
-
-	if (nr_sectors &&
-	    (nr_sectors > maxsector ||
-	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
-		if (!maxsector)
-			return -EIO;
-		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-				    "%pg: rw=3D%d, sector=3D%llu, nr_sectors =3D %u limit=3D%llu\n",
-				    current->comm, bio->bi_bdev, bio->bi_opf,
-				    bio->bi_iter.bi_sector, nr_sectors, maxsector);
-		return -EIO;
-	}
-	return 0;
-}
-
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
@@ -802,8 +778,6 @@ void submit_bio_noacct(struct bio *bio)
 		goto end_io;
 	bio_check_ro(bio);
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
-		if (unlikely(bio_check_eod(bio)))
-			goto end_io;
 		if (bdev_is_partition(bdev) &&
 		    unlikely(blk_partition_remap(bio)))
 			goto end_io;
diff --git a/block/blk.h b/block/blk.h
index bf1a80493ff1c..e70acb2d358e3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -423,6 +423,17 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
 static inline struct bio *__bio_split_to_limits(struct bio *bio,
 		const struct queue_limits *lim, unsigned int *nr_segs)
 {
+	if (unlikely(bio_end_sector(bio) > bdev_nr_sectors(bio->bi_bdev) +
+					   bio->bi_bdev->bd_start_sect)) {
+		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
+				    "%pg: rw=3D%d, sector=3D%llu, nr_sectors =3D %u limit=3D%llu\n",
+				    current->comm, bio->bi_bdev, bio->bi_opf,
+				    bio->bi_iter.bi_sector, bio_sectors(bio),
+				    bdev_nr_sectors(bio->bi_bdev) +
+					bio->bi_bdev->bd_start_sect);
+		goto ioerr;
+	}
+
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
@@ -442,6 +453,9 @@ static inline struct bio *__bio_split_to_limits(struc=
t bio *bio,
 		*nr_segs =3D 0;
 		return bio;
 	}
+ioerr:
+	bio_io_error(bio);
+	return NULL;
 }
=20
 /**
--=20
2.53.0-Meta


