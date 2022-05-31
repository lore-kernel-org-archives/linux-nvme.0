Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B702C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBTJzpfwkjUsUlRGiDqeDPclwObqIgkDJOxJq79advA=; b=EvjUj7Ckf1w/mtrtlD5HY2GqZs
	jt+bSNtXsaPv8OAhuybjPS2+dFYtiEqe5GLsMI5do0FUwKKvctgRyq7thXN5UuQRjYkrGjCPL8HCi
	4ddv1DyRWgch8LOW55b6wk9qf8V3sv+CewP02fIks+UN4N1T98zYuBlWjd4p5aWyEhFbOSsjQkwPe
	FBgXL0oa/ynNI+xS/3dFvIalNmpMtCTKtKjIQGYdco8iZ0o3pVtEm+ek90Yl7BIhVhFxgSsH+ScRb
	uPhXBnccFcWjpZMNmK5XiIVa/aZOkYqD7sqEISgUoRgD/Q+EFxIV08X97CZnfNMzn0UaZGEnCefwi
	jBegEzGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7MU-00CIP3-4k; Tue, 31 May 2022 19:17:02 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7MM-00CILS-VA
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 19:16:57 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiIIH020449
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:16:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kBTJzpfwkjUsUlRGiDqeDPclwObqIgkDJOxJq79advA=;
 b=PvBwoi0w5oNjL4Fj9Knn6R0qDKcz+kIS1ZrPPwfXBECHj6LmXKGffLFTHITkC4xoVMq/
 2KssXH3gIz8YHRp8/MyMYHgW7/SFJ3N0jLXrfkv4H+/mYImENPABeT5y6JRISp9iS2qD
 8r0C/vMFhyr4MECLawTX+agOjYpUQ7Avfyw= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbguqqw8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:16:54 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:16:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D93414924B16; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 06/11] block/merge: count bytes instead of sectors
Date: Tue, 31 May 2022 12:11:32 -0700
Message-ID: <20220531191137.2291467-7-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Z-4fdrIwKzyNo1R26-BnRA7gepS3PrQN
X-Proofpoint-ORIG-GUID: Z-4fdrIwKzyNo1R26-BnRA7gepS3PrQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_121655_057407_5401EB2E 
X-CRM114-Status: GOOD (  21.30  )
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

Individual bv_len's may not be a sector size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v4->v5:

  Updated comment (Christoph)

 block/blk-merge.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7771dacc99cb..21fb4d14ca3e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -201,11 +201,11 @@ static inline unsigned get_max_segment_size(const s=
truct request_queue *q,
  * @nsegs:    [in,out] Number of segments in the bio being built. Increm=
ented
  *            by the number of segments from @bv that may be appended to=
 that
  *            bio without exceeding @max_segs
- * @sectors:  [in,out] Number of sectors in the bio being built. Increme=
nted
- *            by the number of sectors from @bv that may be appended to =
that
- *            bio without exceeding @max_sectors
+ * @bytes:    [in,out] Number of bytes in the bio being built. Increment=
ed
+ *            by the number of bytes from @bv that may be appended to th=
at
+ *            bio without exceeding @max_bytes
  * @max_segs: [in] upper bound for *@nsegs
- * @max_sectors: [in] upper bound for *@sectors
+ * @max_bytes: [in] upper bound for *@bytes
  *
  * When splitting a bio, it can happen that a bvec is encountered that i=
s too
  * big to fit in a single segment and hence that it has to be split in t=
he
@@ -216,10 +216,10 @@ static inline unsigned get_max_segment_size(const s=
truct request_queue *q,
  */
 static bool bvec_split_segs(const struct request_queue *q,
 			    const struct bio_vec *bv, unsigned *nsegs,
-			    unsigned *sectors, unsigned max_segs,
-			    unsigned max_sectors)
+			    unsigned *bytes, unsigned max_segs,
+			    unsigned max_bytes)
 {
-	unsigned max_len =3D (min(max_sectors, UINT_MAX >> 9) - *sectors) << 9;
+	unsigned max_len =3D min(max_bytes, UINT_MAX) - *bytes;
 	unsigned len =3D min(bv->bv_len, max_len);
 	unsigned total_len =3D 0;
 	unsigned seg_size =3D 0;
@@ -237,7 +237,7 @@ static bool bvec_split_segs(const struct request_queu=
e *q,
 			break;
 	}
=20
-	*sectors +=3D total_len >> 9;
+	*bytes +=3D total_len;
=20
 	/* tell the caller to split the bvec if it is too big to fit */
 	return len > 0 || bv->bv_len > max_len;
@@ -269,8 +269,8 @@ static struct bio *blk_bio_segment_split(struct reque=
st_queue *q,
 {
 	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
 	struct bvec_iter iter;
-	unsigned nsegs =3D 0, sectors =3D 0;
-	const unsigned max_sectors =3D get_max_io_size(q, bio);
+	unsigned nsegs =3D 0, bytes =3D 0;
+	const unsigned max_bytes =3D get_max_io_size(q, bio) << 9;
 	const unsigned max_segs =3D queue_max_segments(q);
=20
 	bio_for_each_bvec(bv, bio, iter) {
@@ -282,12 +282,12 @@ static struct bio *blk_bio_segment_split(struct req=
uest_queue *q,
 			goto split;
=20
 		if (nsegs < max_segs &&
-		    sectors + (bv.bv_len >> 9) <=3D max_sectors &&
+		    bytes + bv.bv_len <=3D max_bytes &&
 		    bv.bv_offset + bv.bv_len <=3D PAGE_SIZE) {
 			nsegs++;
-			sectors +=3D bv.bv_len >> 9;
-		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors, max_segs,
-					 max_sectors)) {
+			bytes +=3D bv.bv_len;
+		} else if (bvec_split_segs(q, &bv, &nsegs, &bytes, max_segs,
+					   max_bytes)) {
 			goto split;
 		}
=20
@@ -300,13 +300,20 @@ static struct bio *blk_bio_segment_split(struct req=
uest_queue *q,
 split:
 	*segs =3D nsegs;
=20
+	/*
+	 * Individual bvecs may not be logical block aligned. Round down the
+	 * split size so that each bio is properly sector size aligned, even if
+	 * we do not use the full hardware limits.
+	 */
+	bytes =3D ALIGN_DOWN(bytes, queue_logical_block_size(q));
+
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
-	return bio_split(bio, sectors, GFP_NOIO, bs);
+	return bio_split(bio, bytes >> SECTOR_SHIFT, GFP_NOIO, bs);
 }
=20
 /**
@@ -375,7 +382,7 @@ EXPORT_SYMBOL(blk_queue_split);
 unsigned int blk_recalc_rq_segments(struct request *rq)
 {
 	unsigned int nr_phys_segs =3D 0;
-	unsigned int nr_sectors =3D 0;
+	unsigned int bytes =3D 0;
 	struct req_iterator iter;
 	struct bio_vec bv;
=20
@@ -398,7 +405,7 @@ unsigned int blk_recalc_rq_segments(struct request *r=
q)
 	}
=20
 	rq_for_each_bvec(bv, rq, iter)
-		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &nr_sectors,
+		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &bytes,
 				UINT_MAX, UINT_MAX);
 	return nr_phys_segs;
 }
--=20
2.30.2


