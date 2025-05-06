Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90331C3ABC4
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fly4fygGWFwfsIMnf/ScH10Rni944s+sIuQ7LVjredw=; b=O8zBNWtSz/YsU7PrHoSqWhZzS1
	43U6oacov3vZRcYZrUdbeCrmj51fJp9QWmp/6HVH8b5qCOcG55uos7oj3sxd+DcQXcYpi+fwsFy8P
	jFr/7GhL/m0NwwYotSB62nZnxLisdIOyquK0qcdBbAdrn8oa4rIYUZsCIfjj6ulZgAsPMBq4CAviK
	GEUf3Ngr2sgtF8MoCngG1HgSsSx+v/Pqa0m6PZsA6KpsZCcBN1UKgS4JGnzMsyceuT5ir+B+fZP5N
	/MJSMfZMvgRJ6w3j7R6t4R5uZIwwo/UdAjeM9oM9zmgCVCMAwGA9l26ghlSrx2hQD2DT84MQsJq6V
	K0PDRrKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKjI-0000000CaGL-3vCw;
	Tue, 06 May 2025 16:01:12 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHNm-0000000Bu6r-14qt
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:26:55 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250506122640epoutp03d9de5c49c27f7e8c73788fb915060b6a~878ieM5AZ2457624576epoutp03W
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 12:26:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250506122640epoutp03d9de5c49c27f7e8c73788fb915060b6a~878ieM5AZ2457624576epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534400;
	bh=fly4fygGWFwfsIMnf/ScH10Rni944s+sIuQ7LVjredw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDmWAzADRoPCXnJxuuumwvsXTDs+L+21AlOKDWqa07xO2rzgLitgR5Ss1KL6YxcxH
	 cU4L97Hfl3joR5Y0a7dDLha++tfaqlsGLvF8FziW0X51tJjNLhdsLERio7qdRbp/3y
	 9HT6bxyp9ZYsysJ+yc6A5o5TZN4l6eV7wt7G+UZY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250506122639epcas5p219c65b82fe7e69c96019528c1f5f6291~878h0xslA2629626296epcas5p2R;
	Tue,  6 May 2025 12:26:39 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.177]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZsHgx6lJtz6B9m6; Tue,  6 May
	2025 12:26:37 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250506122637epcas5p4a4e84171a1c6fa4ce0f01b6783fa2385~878fWuxOq1362913629epcas5p4_;
	Tue,  6 May 2025 12:26:37 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250506122637epsmtrp186cfaa2c3dae78c6472bb0d199297e3a~878fWA97k2524025240epsmtrp1g;
	Tue,  6 May 2025 12:26:37 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-da-6819fffca100
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.E5.07818.CFFF9186; Tue,  6 May 2025 21:26:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122635epsmtip243ccc0d442cd051d968e2a46b1cf7711~878duJM1c1663216632epsmtip2K;
	Tue,  6 May 2025 12:26:35 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Hannes
	Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v16 02/11] block: add a bi_write_stream field
Date: Tue,  6 May 2025 17:47:23 +0530
Message-Id: <20250506121732.8211-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO6f/5IZBs8nWVrMWbWN0WL13X42
	iz2LJjFZrFx9lMniXes5Fouj/9+yWUw6dI3RYu8tbYs9e0+yWMxf9pTdYtvv+cwO3B47Z91l
	97h8ttRj06pONo/NS+o9dt9sYPPo27KK0WPz6WqPz5vkAjiiuGxSUnMyy1KL9O0SuDJWHN3L
	WjBdsmLatkvsDYytol2MnBwSAiYSJxafZOti5OIQEtjNKLHz/CJmiIS4RPO1H+wQtrDEyn/P
	2SGKPjJKTH1xkLGLkYODTUBT4sLkUpAaEYEAiZeLHzOD1DALfGCU2DNxNiNIQljAVuL83sVg
	NouAqsSP29/BFvAKmEu8PHMCaoG8xMxL38FsTgELieV7ZoHVCwHVvDh6hB2iXlDi5MwnLCA2
	M1B989bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM4KrQ0
	djC++9akf4iRiYPxEKMEB7OSCO/9+5IZQrwpiZVVqUX58UWlOanFhxilOViUxHlXGkakCwmk
	J5akZqemFqQWwWSZODilGpiilJf/mRVz4KHm/ucZi6ZP/jzlKWO9pHVxVI7vT+3N55+t4bRY
	pCKz/tRB48peh22Rc2M/L9bL6z2lviup/4NW8OcFj2O2MgrbPn+ve+CW8SnOzE1BD+4YtDhc
	0VfbtjzQ1O/yaiWzZK4IRsdjSn8evPmV/cj4hetLM7HiaoU+dbbt8Q/PVftEKTyXObLhxvpp
	1zYUJ71yEzbICT538uud8vI1G6cnlhxasen+jPNlr/PKG74tFxDlMrjOm+xSO8VUmlPYWzaw
	OzBU8HnPPOGDzRIVhUUPjWzynHuMt1fvmpc57ZxzPNcS+d5UhfY3Nzy17eVCjCt61rfHeEXX
	rNW9e7hm+paPZ2/y9mU911NiKc5INNRiLipOBACAq8Hq+QIAAA==
X-CMS-MailID: 20250506122637epcas5p4a4e84171a1c6fa4ce0f01b6783fa2385
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122637epcas5p4a4e84171a1c6fa4ce0f01b6783fa2385
References: <20250506121732.8211-1-joshi.k@samsung.com>
	<CGME20250506122637epcas5p4a4e84171a1c6fa4ce0f01b6783fa2385@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_052649_383896_3A6827C1 
X-CRM114-Status: GOOD (  18.20  )
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

From: Christoph Hellwig <hch@lst.de>

Add the ability to pass a write stream for placement control in the bio.
The new field fits in an existing hole, so does not change the size of
the struct.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio.c                 | 2 ++
 block/blk-crypto-fallback.c | 1 +
 block/blk-merge.c           | 4 ++++
 include/linux/blk_types.h   | 1 +
 4 files changed, 8 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 4e6c85a33d74..1e42aefc7377 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -251,6 +251,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
 	bio->bi_write_hint = 0;
+	bio->bi_write_stream = 0;
 	bio->bi_status = 0;
 	bio->bi_iter.bi_sector = 0;
 	bio->bi_iter.bi_size = 0;
@@ -827,6 +828,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
+	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
 
 	if (bio->bi_bdev) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index f154be0b575a..005c9157ffb3 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -173,6 +173,7 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
+	bio->bi_write_stream	= bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fdd4efb54c6c..782308b73b53 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -832,6 +832,8 @@ static struct request *attempt_merge(struct request_queue *q,
 
 	if (req->bio->bi_write_hint != next->bio->bi_write_hint)
 		return NULL;
+	if (req->bio->bi_write_stream != next->bio->bi_write_stream)
+		return NULL;
 	if (req->bio->bi_ioprio != next->bio->bi_ioprio)
 		return NULL;
 	if (!blk_atomic_write_mergeable_rqs(req, next))
@@ -953,6 +955,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		return false;
 	if (rq->bio->bi_write_hint != bio->bi_write_hint)
 		return false;
+	if (rq->bio->bi_write_stream != bio->bi_write_stream)
+		return false;
 	if (rq->bio->bi_ioprio != bio->bi_ioprio)
 		return false;
 	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5a46067e85b1..f38425338c3f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -220,6 +220,7 @@ struct bio {
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
 	enum rw_hint		bi_write_hint;
+	u8			bi_write_stream;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 
-- 
2.25.1


