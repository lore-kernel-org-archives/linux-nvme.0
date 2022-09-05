Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99FCECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 16:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G67kfqT7ju2Wy37bOXw+s0IVht5UeVvdSkoq3vkdofw=; b=mGRVyUhxbNCHpXB5W7r9oKuDML
	uWoRHeDlYjy7MCnebpqjMxwxrHX6y4wD29hBgpGHtZqZyrsYc68VM2sXOEfQDmXvJX+soE5ccbxaW
	KkM2Sklg/46V/5Eni9XRm0O/+f1FrWC9hKaodyWT/DCPy2ZDpPXnweMISWeGnQzuWezYRguiCfaSB
	dch+SNPb7Kglbsuiuz/uqsbonIZSTXD4wuyj3urWIovJO3DTjkeDQbecKm/WnCY0LzbbzLeMRlCqq
	hW3KYTG4DEozEp7HGnGD9lFn3u7V3i+HBllnR13h+xjiY3Dq3vm3sduygb30QUXfHxHeDmU7oRSE9
	vcngVlyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVFCS-0071m6-Di; Mon, 05 Sep 2022 16:43:52 +0000
Received: from desiato.infradead.org ([90.155.92.199])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCmc-004B56-7s
	for linux-nvme@bombadil.infradead.org; Mon, 05 Sep 2022 14:09:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=G67kfqT7ju2Wy37bOXw+s0IVht5UeVvdSkoq3vkdofw=; b=kRoGwFyDc3BRed1j94aliooLW+
	ENu9D2UOjSlK1ne32RX87GFalFth7zBSp9eC84ExN+Tbk0+fxdSYUUhzp8VGitC5tzojGoFSHyteA
	5SlKwfFVrbz126KQDNDzH4/m6K3bbUp7FgIHoCYizqs0915Gq9mz2oS+JkXrth16FA7jPxcm0bmr1
	QaAQ0tiqDMinD5RMILa1tDCE2PUZyxzSNaVOI5plCm4hxeu/3r1SH9Q0DVfNXRQXFODr03RRvDw7g
	0TQArWWnHRSs3M5qfAEORrgoftFrio0y6OKT54fZS7LoPDrtF6RLbP6gYan4J3KJ6ZfCBslDPcKub
	OoftH5TA==;
Received: from mailout3.samsung.com ([203.254.224.33])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCcy-009gK9-1T
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 13:59:06 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220905135856epoutp03db0cd4e9650b6dc2adbca642690d8535~R_5CpHjEv3039730397epoutp03a
	for <linux-nvme@lists.infradead.org>; Mon,  5 Sep 2022 13:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220905135856epoutp03db0cd4e9650b6dc2adbca642690d8535~R_5CpHjEv3039730397epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662386336;
	bh=G67kfqT7ju2Wy37bOXw+s0IVht5UeVvdSkoq3vkdofw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bp8wxTbZKacg+af/F6lpau9GdvKqhUF+Xoh84T22984Ajbm5OjIWweC+oWxLI9U/t
	 sT/iBENyqKNZxdK/LpFDVvxuacHqHkCkoCsd+jj/iuPSBprTj4xmZrayL5a5o+7Gw0
	 bom7tpAqH+CQXZGmzSgJ4JYIOBaTqWHJ27E3OgCQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220905135855epcas5p1bdf1140ebaf3a912b7d14a20c1ae714c~R_5B9p9WH1346413464epcas5p1i;
	Mon,  5 Sep 2022 13:58:55 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MLqqw3CLbz4x9Px; Mon,  5 Sep
	2022 13:58:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.E4.54060.C9006136; Mon,  5 Sep 2022 22:58:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1~R_4_iyTRr2360423604epcas5p31;
	Mon,  5 Sep 2022 13:58:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220905135851epsmtrp15b2d28fe3e50751c375187b4e47ffe54~R_4_h5uK71158011580epsmtrp1k;
	Mon,  5 Sep 2022 13:58:51 +0000 (GMT)
X-AuditID: b6c32a4b-e33fb7000000d32c-ad-6316009c301f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.39.14392.B9006136; Mon,  5 Sep 2022 22:58:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220905135850epsmtip1bc414ac091b3d460bb555c5f5fc1b9f4~R_49EWyB-1794417944epsmtip1N;
	Mon,  5 Sep 2022 13:58:50 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v4 3/4] block: add helper to map bvec iterator for
 passthrough
Date: Mon,  5 Sep 2022 19:18:32 +0530
Message-Id: <20220905134833.6387-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905134833.6387-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmpu4cBrFkg0N3xSyaJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF3lvaFvOXPWV34PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5tH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM6Y84e1YL9yxbPtTewNjItluhg5OSQETCTe/DrL
	3MXIxSEksJtRYsPfqVDOJ0aJG7+WsoFUCQl8Y5T422kJ07FseQsbRNFeRomurj1MEM5nRokD
	5z6wdDFycLAJaEpcmFwK0iAi4CVx//Z7VpAaZpAVq/++ZQVJCAtESmyZ+pARxGYRUJVY9f0/
	O4jNK2Au0TxxGgvENnmJmZe+g8U5BSwkJnXdZ4OoEZQ4OfMJWA0zUE3z1tlgZ0sItHJILO+Z
	yQbR7CKx+PIVJghbWOLV8S3sELaUxMv+Nig7WeLSzHNQNSUSj/cchLLtJVpP9TODPMMM9Mz6
	XfoQu/gken8/YQIJSwjwSnS0CUFUK0rcm/SUFcIWl3g4YwmU7SFxtmkDOyR8uhkleltWM05g
	lJ+F5IVZSF6YhbBtASPzKkbJ1ILi3PTUYtMC47zUcni8JufnbmIEJ1Et7x2Mjx580DvEyMTB
	eIhRgoNZSYQ3ZYdIshBvSmJlVWpRfnxRaU5q8SFGU2AYT2SWEk3OB6bxvJJ4QxNLAxMzMzMT
	S2MzQyVx3inajMlCAumJJanZqakFqUUwfUwcnFINTDX1C/e4Jk7o25HQ4elj4Mp7eJks68k7
	+0+Eady+cy5w+a0v0cYB6l/aOoszZLrFsy8bWHw+bLhE4Fjw11NZF0pfHtSyZMrUkfxj+THV
	dM7zt3ct4zbvK5meJa/isOi7venfppL2xzOlT7+ruLyje+dxnQ5tLe5VeXNbXEIM96nb/ZR7
	aMLMIW51aVlmZYlOr9WT7VyF928H5vppbmU9FSV2fU7IhQkvmETKorouzLz29cVOtcL0JlP9
	x/9W3Hl77u6R9bbqk9YscDcVU1mzja0vxD5YYqn6/5Uf5Cs+NTl9ivbOs2bR0rmgIbXdKyup
	4If83bvxUd92VF9IqhbKesv5YaHcdaNQJWeHkB8TlViKMxINtZiLihMB4vhtbSsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnO5sBrFkg6uNGhZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi6P/37JZTDp0jdFi7y1ti/nLnrI7cHnsnHWX3ePy2VKP
	Tas62Tw2L6n32H2zgc2jb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mub8YS3Yr1zxbHsTewPj
	YpkuRk4OCQETiWXLW9hAbCGB3YwSn97UQ8TFJZqv/WCHsIUlVv57DmRzAdV8ZJS413IYyOHg
	YBPQlLgwuRSkRkQgQOJg42WwGmaBg4wS55u+sYAkhAXCJa7NfsQEYrMIqEqs+v4fbCivgLlE
	88RpLBAL5CVmXvoOFucUsJCY1HUf6iBziT0znjJC1AtKnJz5BKyeGai+eets5gmMArOQpGYh
	SS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREc/lqaOxi3r/qgd4iRiYPxEKME
	B7OSCG/KDpFkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODil
	GpiyytYkTvupL31thrdezBevPrdrGq72z5hOHjo985C7x4Hiw3cEi05+MXNhOnYuJyDK5bK/
	zcZELo79PVelX7zu3Ot66mzPurViO7QeftfOzjR+Uht/62htsaXoEpWpJ1TnntLjbdIKsJ+w
	QPKcq6Bhtw3bthdzs/tmFs15s2lq2vq3TyWjBVjsogLkb2uZd+lYMZ9P8g90d9tzTV+ovOF9
	yDx1wb9vbuypPhut+lH+sNa5n6vzDBZdr7B+V50k9ejXvV0rZeZcec+Xm2Oo8N76QFlWtP7O
	/U2+jNFTe/ptH3psnVf3+7/6yXMd77v2L5mSX2Ea1vYlyq35dAbnhJpdHE89fdsF2z9ctlvc
	0arEUpyRaKjFXFScCADGjApr7gIAAA==
X-CMS-MailID: 20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1
References: <20220905134833.6387-1-joshi.k@samsung.com>
	<CGME20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_145904_705086_AB90F3C6 
X-CRM114-Status: GOOD (  26.03  )
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

Add blk_rq_map_user_bvec which maps the bvec iterator into a bio and
places that into the request. This helper will be used in nvme for
uring-passthrough with fixed-buffer.
While at it, create another helper bio_map_get to reduce the code
duplication.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-map.c        | 94 +++++++++++++++++++++++++++++++++++++-----
 include/linux/blk-mq.h |  1 +
 2 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index f3768876d618..e2f268167342 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -241,17 +241,10 @@ static void bio_map_put(struct bio *bio)
 	}
 }
 
-static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
+static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
 		gfp_t gfp_mask)
 {
-	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
-	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
 	struct bio *bio;
-	int ret;
-	int j;
-
-	if (!iov_iter_count(iter))
-		return -EINVAL;
 
 	if (rq->cmd_flags & REQ_POLLED) {
 		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
@@ -259,13 +252,31 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
 					&fs_bio_set);
 		if (!bio)
-			return -ENOMEM;
+			return NULL;
 	} else {
 		bio = bio_kmalloc(nr_vecs, gfp_mask);
 		if (!bio)
-			return -ENOMEM;
+			return NULL;
 		bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
 	}
+	return bio;
+}
+
+static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
+		gfp_t gfp_mask)
+{
+	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
+	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
+	struct bio *bio;
+	int ret;
+	int j;
+
+	if (!iov_iter_count(iter))
+		return -EINVAL;
+
+	bio = bio_map_get(rq, nr_vecs, gfp_mask);
+	if (bio == NULL)
+		return -ENOMEM;
 
 	while (iov_iter_count(iter)) {
 		struct page **pages, *stack_pages[UIO_FASTIOV];
@@ -612,6 +623,69 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_user);
 
+/* Prepare bio for passthrough IO given an existing bvec iter */
+int blk_rq_map_user_bvec(struct request *rq, struct iov_iter *iter)
+{
+	struct request_queue *q = rq->q;
+	size_t iter_count, nr_segs;
+	struct bio *bio;
+	struct bio_vec *bv, *bvec_arr, *bvprvp = NULL;
+	struct queue_limits *lim = &q->limits;
+	unsigned int nsegs = 0, bytes = 0;
+	int ret, i;
+
+	iter_count = iov_iter_count(iter);
+	nr_segs = iter->nr_segs;
+
+	if (!iter_count || (iter_count >> 9) > queue_max_hw_sectors(q))
+		return -EINVAL;
+	if (nr_segs > queue_max_segments(q))
+		return -EINVAL;
+
+	/* no iovecs to alloc, as we already have a BVEC iterator */
+	bio = bio_map_get(rq, 0, GFP_KERNEL);
+	if (bio == NULL)
+		return -ENOMEM;
+
+	bio_iov_bvec_set(bio, iter);
+	blk_rq_bio_prep(rq, bio, nr_segs);
+
+	/* loop to perform a bunch of sanity checks */
+	bvec_arr = (struct bio_vec *)iter->bvec;
+	for (i = 0; i < nr_segs; i++) {
+		bv = &bvec_arr[i];
+		/*
+		 * If the queue doesn't support SG gaps and adding this
+		 * offset would create a gap, disallow it.
+		 */
+		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv->bv_offset)) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		/* check full condition */
+		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		if (bytes + bv->bv_len <= iter_count &&
+				bv->bv_offset + bv->bv_len <= PAGE_SIZE) {
+			nsegs++;
+			bytes += bv->bv_len;
+		} else {
+			ret = -EINVAL;
+			goto out_free;
+		}
+		bvprvp = bv;
+	}
+	return 0;
+out_free:
+	bio_map_put(bio);
+	return ret;
+}
+EXPORT_SYMBOL(blk_rq_map_user_bvec);
+
 /**
  * blk_rq_unmap_user - unmap a request with user data
  * @bio:	       start of bio list
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b43c81d91892..83bef362f0f9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -970,6 +970,7 @@ struct rq_map_data {
 	bool from_user;
 };
 
+int blk_rq_map_user_bvec(struct request *rq, struct iov_iter *iter);
 int blk_rq_map_user(struct request_queue *, struct request *,
 		struct rq_map_data *, void __user *, unsigned long, gfp_t);
 int blk_rq_map_user_iov(struct request_queue *, struct request *,
-- 
2.25.1


