Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D60C32771
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Aug 2022 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tzGYFtcZm58+i7gZlKId0iWHEtzko0JqMTEVRvMBpzw=; b=h+snC8T2SXEYVqzMksk7iTVV8x
	tHizONvBsl17Rlp+QAgFRdM4s9RHkWCbFo20Srlyc/B7xH8S9L5TgCzdtTzvMZMzPwCUOAAH0HxOV
	RVOagHSNkRlHRp9tnMok7O8uWft+Bi1B1aAPy8fgwMkS++2dO3vv6c3rN5N1ZxDvBL0gKitVibrwi
	WjuTcNIOr06ajiG4Ds5/25LiB2HugaZAk6aoctX2HolW/YXFXlpACtfwI7h49HOOJS+I00xknNALf
	TcMO5P0bQIlZ3FBDY7khnnRzum27qRuV7XK6/l6CeZBDRSTjvf3UcglR6q9VDyymZmwCoVoSfmxdy
	qULymUAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOzR7-005uF2-DD; Fri, 19 Aug 2022 10:41:09 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOzQr-005tyU-9J
	for linux-nvme@lists.infradead.org; Fri, 19 Aug 2022 10:40:56 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220819104049epoutp01bd63e5b6305d43264da3cceb748268b0~MuONjjSXd2656526565epoutp01S
	for <linux-nvme@lists.infradead.org>; Fri, 19 Aug 2022 10:40:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220819104049epoutp01bd63e5b6305d43264da3cceb748268b0~MuONjjSXd2656526565epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660905649;
	bh=tzGYFtcZm58+i7gZlKId0iWHEtzko0JqMTEVRvMBpzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rtycfx26PR5oZLJLtSuSjplNsUqu1psetw6EScllqWVn7Ia2aN7Vo8igZEydNqZpw
	 aKoxDP/U3lm0cjQowsv3bOyocgCTIPIm4NsYk6v2Q+e+ygxqS4A1gjuTyG967wjqro
	 2F90q/XmsTMsaSPoOzIwFk/u2nv/uDuSylWUw0EU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220819104049epcas5p19ed8c5a3cdb95ec6cd0fc9f22e6abcb5~MuONOiVE30663706637epcas5p1t;
	Fri, 19 Aug 2022 10:40:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4M8JF95dJxz4x9Px; Fri, 19 Aug
	2022 10:40:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.E3.49477.AA86FF26; Fri, 19 Aug 2022 19:40:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220819104042epcas5p177f384cd4c15918f666c7eacc4dfab4c~MuOHCpSKa0652106521epcas5p1v;
	Fri, 19 Aug 2022 10:40:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220819104042epsmtrp1ad49f1f504746d22c6b0f7358e4b0c0a~MuOHB57cr1513515135epsmtrp1I;
	Fri, 19 Aug 2022 10:40:42 +0000 (GMT)
X-AuditID: b6c32a49-82dff7000000c145-83-62ff68aa7b76
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.85.08802.AA86FF26; Fri, 19 Aug 2022 19:40:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220819104040epsmtip1bd7bae4cb87fe4a4ae49f8560660bba2~MuOE-h6LQ0577205772epsmtip1i;
	Fri, 19 Aug 2022 10:40:39 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next 3/4] block: add helper to map bvec iterator for
 passthrough
Date: Fri, 19 Aug 2022 16:00:20 +0530
Message-Id: <20220819103021.240340-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819103021.240340-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmlu6qjP9JBs33LSyaJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22L+sqfsFocmNzM5cHlcPlvqsWlVJ5vH
	5iX1HrtvNrB5vN93lc2jb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
	dQ0tLcyVFPISc1NtlVx8AnTdMnOAjlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
	FJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdceH2ZvWC1ZMWTW71sDYyTRLoYOTkkBEwkPh3c
	zNTFyMUhJLCbUaJly1k2COcTo8TjG7vYIZzPjBKbj65ig2mZdm0zI0RiF6PEprXzWOGqfl98
	z9zFyMHBJqApcWFyKUiDiICRxP5PJ8FqmAUuMErc23mTBSQhLBAm8Wf3FkYQm0VAVeLF3tVg
	Nq+ApcSqbe+gtslLzLz0nR3E5hSwkpi19CobRI2gxMmZT8DmMAPVNG+dzQyyQEKgk0Ni9/YX
	LBDNLhJzNrewQtjCEq+Ob2GHsKUkXva3QdnJEpdmnmOCsEskHu85CGXbS7Se6gd7hhnomfW7
	9CF28Un0/n7CBBKWEOCV6GgTgqhWlLg36SnUJnGJhzOWQNkeEle7VkCDtJdR4sbUHewTGOVn
	IXlhFpIXZiFsW8DIvIpRMrWgODc9tdi0wDAvtRwes8n5uZsYwYlUy3MH490HH/QOMTJxMB5i
	lOBgVhLhvXHnT5IQb0piZVVqUX58UWlOavEhRlNgGE9klhJNzgem8rySeEMTSwMTMzMzE0tj
	M0MlcV6vq5uShATSE0tSs1NTC1KLYPqYODilGpg4e1+tOWU15+nqpb/Yao+6/k02lI9sYl3y
	pLRKTH2iFeOUlnhr520c652srJxZhJrmuXj4fD9evH/1+p01h66qnOVrTReMf5/ffro04oXJ
	WYFOtg09BkGpBusOOK8Tczi6vvfpsf/rn/pcnuzi1Pudc1+TfdizEGa1uieF02+luHDcPfb3
	8stC/UbGOrl9sz9ZMBzYeS9vka7y5UcPlzT8c5z08t9/S0lR0V/LZz4Ik8lxlDt64031st25
	c6P0b6obtZ846B70M7IqKXKWp0dsfbliCJtc79LdGlJa3tZLNDYdON3QdnDJkcQVSyd6KR64
	tSuPbfKFKNXZEjXFCw8u+db2KNwyJJ/xlN4x5ntKLMUZiYZazEXFiQBqWBkSLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO6qjP9JBv8f8Fs0TfjLbLH6bj+b
	xc0DO5ksVq4+ymTxrvUci8XR/2/ZLCYdusZosfeWtsX8ZU/ZLQ5NbmZy4PK4fLbUY9OqTjaP
	zUvqPXbfbGDzeL/vKptH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZVx4fZm9YLVkxZNbvWwN
	jJNEuhg5OSQETCSmXdvM2MXIxSEksINRYsHqdUwQCXGJ5ms/2CFsYYmV/56zQxR9ZJR48ukn
	kMPBwSagKXFhcilIjYiAmcTSw2tYQGqYBW4wSuzrnQI2SFggROLq+fdgg1gEVCVe7F3NCGLz
	ClhKrNr2jg1igbzEzEvfwWo4BawkZi29ChYXAqr59beDCaJeUOLkzCcsIDYzUH3z1tnMExgF
	ZiFJzUKSWsDItIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgGtLR2MO5Z9UHvECMT
	B+MhRgkOZiUR3ht3/iQJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUI
	JsvEwSnVwCTmuaG7qiM7zunB9OhzLlWO+/NC7jSfytH9EX3/5rrnGzYrqh4L/q/D+HzpRnbV
	Z/2ni0MLn14SeJjG9+z+VYY7thNlJYWvLu5RURavkH+dduru9T7z78clGhl+pyy2jWg/F232
	Iz1QurAm6SHD/R3Jib8sZig7/dn+9Qp/9NeM+nlzguV8umc65N17dEFgzaa+LzvlAjYZJTj+
	jND+V2djkLdr9/Qa+wcbtM8UMzXP8mkUVlBIZ7Usc60Nn5Acf1lr8yw+k5ul8ySu3vvvGmle
	n332hhr7AfcOax4TkcTbbFEC4itWNOVE59SeW+Fk9UC59fs1N7+ZLwr0/razXuet3Ln13dzP
	pwstGyVWKrEUZyQaajEXFScCAH0cK9DwAgAA
X-CMS-MailID: 20220819104042epcas5p177f384cd4c15918f666c7eacc4dfab4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220819104042epcas5p177f384cd4c15918f666c7eacc4dfab4c
References: <20220819103021.240340-1-joshi.k@samsung.com>
	<CGME20220819104042epcas5p177f384cd4c15918f666c7eacc4dfab4c@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_034053_728530_B020C98A 
X-CRM114-Status: GOOD (  25.15  )
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

Add blk_rq_map_user_fixedb which maps the bvec iterator into a bio and
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
index d0ff80a9902e..ee17cc78bf00 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -611,6 +611,77 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
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
index 9d1af7a0a401..a7c9c836d2f3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -971,6 +971,7 @@ struct rq_map_data {
 	bool from_user;
 };
 
+int blk_rq_map_user_fixedb(struct request *rq, struct iov_iter *iter);
 int blk_rq_map_user(struct request_queue *, struct request *,
 		struct rq_map_data *, void __user *, unsigned long, gfp_t);
 int blk_rq_map_user_iov(struct request_queue *, struct request *,
-- 
2.25.1


