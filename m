Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27DBD44D79
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQM1oME+yjLcszh/NNdlGeevLgEVh+e4WfItNIpaOVY=; b=Yh8Xbax0FJ9Gi9cJcuXcgvEnbV
	JnY36DDRjvJjzPjoIwRJp9S39wZUqscFMG5GRVy5nUwrUXlRs4Q10hN4oE+AL/N4MFXk8GXm+BfJE
	YE/IwFxi631EiznKfhzxj5gbY1GyKkQQA9DyYAdbnmJEnFY5T+3DscTi+b5liGhWFRkzyFnSDhi/H
	ioEWjKm5nSiTbpxG/6vDS+sJnHvSiwcV85yvAUr6NEPjOh6IGl6Odp57OQe1opOZrASmTaUSCnSYz
	UTPq+rrrB6EvVtKad3CQEFm6gmkSBXd7wpLyo2gT9S6qT7ljTonGpePBx97R21pJJUIi33PmElc6f
	VfIKuZVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8h3Q-00000003cea-3hQm;
	Wed, 06 Nov 2024 14:30:40 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8h1c-00000003bhm-29MM
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 14:28:52 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241106142842epoutp01d3dac8ce7dbe34bea65f0438e5de1e3a~FZ2a088q71687016870epoutp01h
	for <linux-nvme@lists.infradead.org>; Wed,  6 Nov 2024 14:28:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241106142842epoutp01d3dac8ce7dbe34bea65f0438e5de1e3a~FZ2a088q71687016870epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730903322;
	bh=FQM1oME+yjLcszh/NNdlGeevLgEVh+e4WfItNIpaOVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebHZSSZVpOVFzERRI/pT63le5Mxuhzazucfl39ecFWd9wowRzJRFLWDfaRYQKgsrw
	 vxZ0MGrB4wzgN//ZrRRqmm+aCZHOPA7+jhNBXlMvwF0vtrqTRD/+kS+h7W1v0Rh3/3
	 +a7tlXHcb8exou7Cb/+4p9gh6FnhPUnVNfje8YfA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241106142841epcas5p4c14347e219d955ba91889adee9e17d87~FZ2aOjGTs1566915669epcas5p43;
	Wed,  6 Nov 2024 14:28:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Xk6yJ1g9bz4x9Pv; Wed,  6 Nov
	2024 14:28:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.D2.09800.81D7B276; Wed,  6 Nov 2024 23:28:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241106122659epcas5p28505a2288f3ac24408aaf138ac053793~FYMI9TjDC0502105021epcas5p2B;
	Wed,  6 Nov 2024 12:26:59 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241106122659epsmtrp25d9dbd51809b4af77c8f8fd43592fb90~FYMI7psJw2560925609epsmtrp27;
	Wed,  6 Nov 2024 12:26:59 +0000 (GMT)
X-AuditID: b6c32a4b-4a7fa70000002648-14-672b7d189239
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.26.07371.2906B276; Wed,  6 Nov 2024 21:26:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241106122656epsmtip15daa342826f8e12932f9a06f871347b8~FYMGmHqSV0829608296epsmtip1p;
	Wed,  6 Nov 2024 12:26:56 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v8 02/10] block: copy back bounce buffer to user-space
 correctly in case of split
Date: Wed,  6 Nov 2024 17:48:34 +0530
Message-Id: <20241106121842.5004-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106121842.5004-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmpq5ErXa6wbGTHBYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJotJh64xWuy9pW2xZ+9JFov5
	y56yW3Rf38Fmsfz4PyaL83+Ps1qcnzWH3UHQY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHh+f
	3mLx6NuyitHjzIIj7B6fN8l5bHrylimAKyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ
	19DSwlxJIS8xN9VWycUnQNctMwfoHSWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpO
	gUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbn2U1MBav5KlY1TGNrYJzE08XIySEhYCLRMHsr
	YxcjF4eQwG5GiUlPPkI5nxglfs67ygzhfGOUWHR6CRtMy5oLa1khEnsZJdbf+8gO4XxmlHg7
	bSYjSBWbgLrEkeetYLNEBPYwSvQuPM0C4jALvGSUWLpqEQtIlbBAssTvf3/AOlgEVCVubJzH
	BGLzClhI3Py+hAVin7zEzEvf2UFsTgFLibOftzFC1AhKnJz5BKyGGaimeetssGMlBC5wSDz/
	cxnqWBeJa+d3M0LYwhKvjm9hh7ClJD6/2wtVky7x4/JTJgi7QKL52D6oenuJ1lP9QEM5gBZo
	SqzfpQ8RlpWYemodE8RePone30+gWnkldsyDsZUk2lfOgbIlJPaea4CyPSRunGhmggRXD6PE
	nueXWCcwKsxC8s8sJP/MQli9gJF5FaNkakFxbnpqsWmBcV5qOTyik/NzNzGCU7mW9w7GRw8+
	6B1iZOJgPMQowcGsJMLrH6WdLsSbklhZlVqUH19UmpNafIjRFBjgE5mlRJPzgdkkryTe0MTS
	wMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGJsGXUtO3uixsTpL+VyPWP7Fr
	r9iOPo0fdVacOwxarq1mLXl5v6q+2k82dSGvTnqed+bk+f3M19TiTVasPbP68er+e1LlFzQ0
	dV9P3yOaHOS99vMOa+3mvLVRF1c+X9pdzv3IfWmDpvjyzydtTVLmruF4WHp1mdJ3TuUbZybN
	PiP6pNx7oW/DuUu3a45uTXHee2YDk8yrUvEZS05p5hbM3H77aE+IkGnge3FzAZvLR/q3XN2q
	LCjX1Gx5ar2n7bVltr+44zaGLlhr0L9sxXMB9RWXemuO29bvLVF9/T9B+es1j5h3Lqp/hMWX
	7GeIvziryun++QUlO04FhZw/w5tx+V2uf9t8oxYvNdY7vrs6HymxFGckGmoxFxUnAgCxsso/
	bgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO7kBO10g6lzGS0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAVxSXTUpqTmZZapG+XQJXxufZTUwFq/kqVjVMY2tg
	nMTTxcjJISFgIrHmwlrWLkYuDiGB3YwSJ7d/ZoNISEicermMEcIWllj57zk7RNFHRom12xey
	giTYBNQljjxvBSsSETjBKDF/ohtIETNI0YQvs1lAEsICiRIXVn0Fm8oioCpxY+M8JhCbV8BC
	4ub3JSwQG+QlZl76zg5icwpYSpz9vA1sqBBQzZ8FfcwQ9YISJ2c+AatnBqpv3jqbeQKjwCwk
	qVlIUgsYmVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgRHmpbGDsZ78//pHWJk4mA8
	xCjBwawkwusfpZ0uxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwT
	B6dUA1PwK7FrMzrjHZkk23aqRClUnHgwvXMPz+SspQeUE1fKRyYzKMnyHvT3nr1jNnsnL/P6
	tUvCpZcURrddXLo34u7j11G2s7sel+/8vqJhcRyXsdyrTa+vvKrbuM1XUCNMOLng0OOumA9N
	PAtbUsSn/hU3vSsRsHDt3CVV+RfnL8nhYQsy+ffs362XBwXnax9IUr3fKyXaY/Pioa/yy+Jo
	YYeipgvNipyv1MunifCLfy1qPJ7/yf1eLJPKzEPy/1iV7GpXe/n55Thdlp297rpE3JfQJ2mO
	24zaNime0Hs3kcWzoOThypTd0w7aOeYZf5hrkFnk8ePBth8h7x53/+gOS93QPbdxwpakr9xa
	tbZPtJRYijMSDbWYi4oTAVSSS2ojAwAA
X-CMS-MailID: 20241106122659epcas5p28505a2288f3ac24408aaf138ac053793
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106122659epcas5p28505a2288f3ac24408aaf138ac053793
References: <20241106121842.5004-1-anuj20.g@samsung.com>
	<CGME20241106122659epcas5p28505a2288f3ac24408aaf138ac053793@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_062849_037859_A52D0D4C 
X-CRM114-Status: GOOD (  19.48  )
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

Copy back the bounce buffer to user-space in entirety when the parent
bio completes. The existing code uses bip_iter.bi_size for sizing the
copy, which can be modified. So move away from that and fetch it from
the vector passed to the block layer. While at it, switch to using
better variable names.

Fixes: 492c5d455969f ("block: bio-integrity: directly map user buffers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index a448a25d13de..4341b0d4efa1 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -118,17 +118,18 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
 
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 {
-	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
-	struct bio_vec *copy = &bip->bip_vec[1];
-	size_t bytes = bip->bip_iter.bi_size;
-	struct iov_iter iter;
+	unsigned short orig_nr_vecs = bip->bip_max_vcnt - 1;
+	struct bio_vec *orig_bvecs = &bip->bip_vec[1];
+	struct bio_vec *bounce_bvec = &bip->bip_vec[0];
+	size_t bytes = bounce_bvec->bv_len;
+	struct iov_iter orig_iter;
 	int ret;
 
-	iov_iter_bvec(&iter, ITER_DEST, copy, nr_vecs, bytes);
-	ret = copy_to_iter(bvec_virt(bip->bip_vec), bytes, &iter);
+	iov_iter_bvec(&orig_iter, ITER_DEST, orig_bvecs, orig_nr_vecs, bytes);
+	ret = copy_to_iter(bvec_virt(bounce_bvec), bytes, &orig_iter);
 	WARN_ON_ONCE(ret != bytes);
 
-	bio_integrity_unpin_bvec(copy, nr_vecs, true);
+	bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs, true);
 }
 
 /**
-- 
2.25.1


