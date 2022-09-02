Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D495EECAAD5
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dm/Nnr6JGnmxszsDZaW5IiaJ+M26+G4F49QpwlNNnaA=; b=YMFA8Yt9IV3rBlF4o68JqESgiF
	KMPwVovvq4oCHA2NjdSArKdWpPsV4timJtF1SY7Wy/df15W0/Wy99Zb5IXasBGZzug6bTBe8V9j7W
	ACNOTELt+U8qULQ9cyvmgIiTIL7jKnQn5bjfDRuRJtXN1uS9NGT2ZBIE8rtKAoXFIbunfqLg5En1K
	awdzS0u/xaeSTpTS1THNYynlrqwzoIqU8xz+7QzdhK6c5jh97bBWhLsh7MHZkNGrT9W0S77XPdt9R
	RX8CTvFT8/8qXZV13N23adUaTzAziCYaVA2NhJOF9aN4t9hfFXkfSAgs1+sYvZjLoIo60lNMtFe+/
	eyt4M83Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU8aE-006AdB-JJ; Fri, 02 Sep 2022 15:27:50 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU8Zo-006ACp-IR
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 15:27:29 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220902152716epoutp048ceda5b9944f9369e16f4dde3f16693e~RFKUST1y90454604546epoutp04B
	for <linux-nvme@lists.infradead.org>; Fri,  2 Sep 2022 15:27:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220902152716epoutp048ceda5b9944f9369e16f4dde3f16693e~RFKUST1y90454604546epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662132436;
	bh=Dm/Nnr6JGnmxszsDZaW5IiaJ+M26+G4F49QpwlNNnaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4R+IuJap7nE4hwifspjU7vn+rvCQceUYWn1gQPKyJElMTvWC5auvybiRUpplhK7b
	 9PdldLQSphNYn209g9e2w45PWsXfA5YTE8oMVRLx2DpJjN/TC/CbLjFhEk89+Zxt4H
	 l7RU3vKwMG941M8inHcJGu8pL0LPrrCxArkIXYQw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220902152716epcas5p1e0e29ab5939703ae6c11dba634a250a1~RFKTquwV80055200552epcas5p1M;
	Fri,  2 Sep 2022 15:27:16 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MK1xF4Tm6z4x9Px; Fri,  2 Sep
	2022 15:27:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.30.53458.1D022136; Sat,  3 Sep 2022 00:27:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220902152712epcas5p2622e861ac4a5ae9820a9af9442d556b4~RFKQtdbXp2622926229epcas5p2w;
	Fri,  2 Sep 2022 15:27:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220902152712epsmtrp1b4e675935859b06e5a8dce3c8f8b3097~RFKQsox9P2718227182epsmtrp1W;
	Fri,  2 Sep 2022 15:27:12 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-2a-631220d129dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	07.BE.18644.0D022136; Sat,  3 Sep 2022 00:27:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220902152711epsmtip2273e14672649e055b5ee7c33538dc9f4~RFKPQIn-L1295812958epsmtip23;
	Fri,  2 Sep 2022 15:27:11 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v3 3/4] block: add helper to map bvec iterator for
 passthrough
Date: Fri,  2 Sep 2022 20:46:56 +0530
Message-Id: <20220902151657.10766-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902151657.10766-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmpu5FBaFkg/ONChZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi6P/37JZTDp0jdFi7y1ti/nLnrI7cHnsnHWX3ePy2VKP
	Tas62Tw2L6n32H2zgc2jb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
	dQ0tLcyVFPISc1NtlVx8AnTdMnOAjlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
	FJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdMPrabsWC5ZMWlL8cYGxj7RLoYOTkkBEwk9p/r
	Zu5i5OIQEtjNKHF8yUlWCOcTo8S3123sEM5nRon2d4eAyjjAWla8q4WI72KUePl8HxNcUXd7
	PxtIEZuApsSFyaUgK0QEvCTu334PNpUZZMXqv29ZQRLCApESHbtuMoHYLAKqEvuPb2UEsXkF
	LCSmtPewQNwnLzHz0nd2EJtTwFLi6dU3rBA1ghInZz4Bq2EGqmneOhvsBwmBTg6JH8+Xs0M0
	u0jcOHyLDcIWlnh1fAtUXEriZX8blJ0scWnmOSYIu0Ti8Z6DULa9ROupfrCPmYGeWb9LH2IX
	n0Tv7ydMkIDglehoE4KoVpS4N+kpK4QtLvFwxhIo20Piz9OzjJDw6WGUWL/8G/sERvlZSF6Y
	heSFWQjbFjAyr2KUTC0ozk1PLTYtMMpLLYdHbHJ+7iZGcBrV8trB+PDBB71DjEwcjIcYJTiY
	lUR4px4WSBbiTUmsrEotyo8vKs1JLT7EaAoM44nMUqLJ+cBEnlcSb2hiaWBiZmZmYmlsZqgk
	zjtFmzFZSCA9sSQ1OzW1ILUIpo+Jg1OqgYmh+LXGhXfxR1l87vakKKn2aDx+2iG3zyVDdoZY
	84sSoXWCF87+D9ptsEHv9HeL2Q+6Gna4KCp7HZvoZlV1Izff+dTt7U8n1+SI8xU+qnv8pE+l
	tU/WYaKW5LRNZw8+tA3aV+mjd/TV2ZM3FmdXp5yVDFjosG9j6XW1NOX3l7bX/3gkeMt8Qmtw
	j8FXw1mHEuevPW/OW3lM5N6cQ2bnHhx0+5h69K/afuvSVY+PXFmW8eFkZ4x4pO72yFajKIe2
	j9qsrz8WOX27FNXt8GgGd9qr6A9NKYW+Qdb7DLsfXgwUS7A8oNO6b03xkaYLrdb/zH5tm8yo
	petqaZQWHrzlMf9JK4+pn9SZE94+PTRnYpcSS3FGoqEWc1FxIgC1Po9cLAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO4FBaFkg+9T9CyaJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF3lvaFvOXPWV34PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5tH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZUw+tpuxYLlkxaUvxxgb
	GPtEuhg5OCQETCRWvKvtYuTiEBLYwSixvWMpWxcjJ1BcXKL52g92CFtYYuW/5+wQRR8ZJQ69
	7mQCaWYT0JS4MLkUpEZEIEDiYONlsBpmgYOMEuebvrGAJIQFwiXW/nsKNpRFQFVi//GtjCA2
	r4CFxJT2HhaIBfISMy99B1vGKWAp8fTqG1YQWwioZseknWwQ9YISJ2c+AatnBqpv3jqbeQKj
	wCwkqVlIUgsYmVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHgJbWDsY9qz7oHWJk
	4mA8xCjBwawkwjv1sECyEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KL
	YLJMHJxSDUxGdeX8v7mMC1oWn1984EaE7pmZF0IZxR9VN9bNqZQvX2qYEKLBWbzshL6OVJzO
	vB1XK86IbywpNok+ZWfyIfnQwScHp6n/7W2u6j19vW23avemp8smnuE+cZ9htcfbxaG/jjKw
	Z0j09aqt1Y3UuXJBtznWWqMq2Tzpzzfh8NDMvqb+6HLLW4t09xQekL90+GHJ08P1ExUPTfKM
	v94VpePawl5izZz68sbtBS3af6/uWjZRNGXH9dh5K/zY+nfPeStY9HeD+Z3z+Rz8E+y7Vryc
	8smzz1GDZVVy/5kty9+4TypMsLO5/8jkq9FLo9WdjYJFZYkCsU7ftBWOfDdYa/msMmhD6Cpj
	7QKb4pmP1ZRYijMSDbWYi4oTAYOujLrvAgAA
X-CMS-MailID: 20220902152712epcas5p2622e861ac4a5ae9820a9af9442d556b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220902152712epcas5p2622e861ac4a5ae9820a9af9442d556b4
References: <20220902151657.10766-1-joshi.k@samsung.com>
	<CGME20220902152712epcas5p2622e861ac4a5ae9820a9af9442d556b4@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_082725_028368_9FEAA420 
X-CRM114-Status: GOOD (  24.05  )
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
places that into the request.
This helper is to be used in nvme for uring-passthrough with
fixed-buffer.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-map.c        | 71 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 72 insertions(+)

diff --git a/block/blk-map.c b/block/blk-map.c
index f3768876d618..0f7dc568e34b 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -612,6 +612,77 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
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
+	if (rq->cmd_flags & REQ_POLLED) {
+		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
+
+		/* no iovecs to alloc, as we already have a BVEC iterator */
+		bio = bio_alloc_bioset(NULL, 0, opf, GFP_KERNEL,
+					&fs_bio_set);
+		if (!bio)
+			return -ENOMEM;
+	} else {
+		bio = bio_kmalloc(0, GFP_KERNEL);
+		if (!bio)
+			return -ENOMEM;
+		bio_init(bio, NULL, bio->bi_inline_vecs, 0, req_op(rq));
+	}
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


