Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41A2D111A1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1yEesIXP8hqj3mWCayZYKotAS9KxK7WmVJifezfxMwM=; b=jmLF26q4IM7SGtRj2Mxz1XBhOG
	8Ng9qcOUo+A5QuXx2Ci81UEeiNjkR7ZW2ZGEOiv73HEWxVJ2tzG9RJe/ba8oWHq8CbXrBXuIQvjgs
	gkvwpOuWtQrhh6wjB9zKBpc57qqa0wQVxkZhOls0psmPrs5qIXREU71GYAKlQDTYunnBYWfquxI+N
	JOYSE+PUX764PwoJc9S00tiEJ2N6fPf7AUgVd5FFRz7kwA3xPUqxom8sexnq+rTXaO4AD5bOaBwqg
	bJ2j49rKXBEJKn7xsJeVuC2I2+la64M8rt+flhbN8LyrYQLaXO4u/KBGVoH8PsZX2KNu9Njgj0aOP
	TMVPnXsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zR4-0000000EHFa-3NTh;
	Mon, 04 Nov 2024 15:56:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zQz-0000000EHAT-2VCW
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 15:56:08 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241104155601epoutp042a1c94fa293d75d7da26ddfeb90327a1~EzwFk1f9n1250312503epoutp04y
	for <linux-nvme@lists.infradead.org>; Mon,  4 Nov 2024 15:56:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241104155601epoutp042a1c94fa293d75d7da26ddfeb90327a1~EzwFk1f9n1250312503epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730735761;
	bh=1yEesIXP8hqj3mWCayZYKotAS9KxK7WmVJifezfxMwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBHZQ9U5ROZQk2h6x+IS3FL3DA92d3s76S5CkIiagVxlxyyQYvdII0YfoJE2f/kVm
	 ze2kzkroHhz6sXv30Q+cN+4FyCx37BmWuPIkDcxUCF6BKzjMldzT2abgTSKXKWMnzQ
	 jau2Udr8i45yNTELevZD/XEpf9svO44clDO6wEaw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241104155601epcas5p192070f7df15f18991addc70bb2dc39c2~EzwFCvMs11118411184epcas5p1B;
	Mon,  4 Nov 2024 15:56:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Xhwzz2bHgz4x9Pr; Mon,  4 Nov
	2024 15:55:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	14.A7.09420.F8EE8276; Tue,  5 Nov 2024 00:55:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241104141448epcas5p4179505e12f9cf45fd792dc6da6afce8e~EyXtYfRMJ3055130551epcas5p4S;
	Mon,  4 Nov 2024 14:14:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241104141448epsmtrp24edf578e5cd5bc2c3557be95e558f742~EyXtSpHQ21987019870epsmtrp2u;
	Mon,  4 Nov 2024 14:14:48 +0000 (GMT)
X-AuditID: b6c32a49-33dfa700000024cc-f5-6728ee8f6110
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	57.68.35203.8D6D8276; Mon,  4 Nov 2024 23:14:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241104141445epsmtip2fe62a3d3e82bbb4099a5873d2b216399~EyXq5CkzQ3023030230epsmtip2s;
	Mon,  4 Nov 2024 14:14:45 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v7 02/10] block: copy back bounce buffer to user-space
 correctly in case of split
Date: Mon,  4 Nov 2024 19:35:53 +0530
Message-Id: <20241104140601.12239-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104140601.12239-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmpm7/O410g8fL+Sw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAV1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGh
	rqGlhbmSQl5ibqqtkotPgK5bZg7QO0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
	ApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IxHd9ayF5zjq5i25TZLA+N6ni5GDg4JAROJ9//c
	uxi5OIQEdjNK3Pk0g6WLkRPI+cQosbQ3ECLxjVGitW02O0gCpOHx5E3sEIm9jBJf//9mg3A+
	M0oc7/rADFLFJqAuceR5KyNIQkRgD6NE78LTLCAOs8BLoLmrFoEtERZIlvg3ZypYB4uAqsSG
	Xw/BdvAKWEr8vXKXCWKfvMTMS9/B4pwCVhJz/t5lgagRlDg58wmYzQxU07x1NjPIAgmBCxwS
	d5Z/YYFodpG4+3011CBhiVfHt0A9ISXx+d1eNgg7XeLH5adQNQUSzcf2MULY9hKtp/qZQaHE
	LKApsX6XPkRYVmLqqXVMEHv5JHp/P4Fq5ZXYMQ/GVpJoXzkHypaQ2HuuAcr2kNg27QIzJLh6
	GSX+TjvJMoFRYRaSf2Yh+WcWwuoFjMyrGCVTC4pz01OLTQsM81LL4dGcnJ+7iRGcxrU8dzDe
	ffBB7xAjEwfjIUYJDmYlEd55qerpQrwpiZVVqUX58UWlOanFhxhNgQE+kVlKNDkfmEnySuIN
	TSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpg0p98vtY9TFQ5auaf342s
	OW6XEnU9PJtLBNn+mKyRVrdPZfysl37T2ugLvzd/3ISCZ+U3Cj+/VZk7/X/80hUeZSJzFllo
	FaZwr9+g3iGmbxtsJcWRYfOEm+/Yl6K9v3MrLaVuXZO+9FHNuy2Dc/eTiQEb0y8cWCkze0dt
	oDxz3Ay+800+9gHvUq4VGUSe9uH598T/ikzsOr5et8bqHzO3BspOi5mf0SEw+16UyhHrxBrp
	wyXnOH4Jf9HKWc1d1sF19WOHX9eCmF9/nhruuig8ucKpLNb8WGJns51JfxGraLqIbuHufdav
	j71SePUhSWZG7cY3zMVBftLrQnQrr69Yt3LV/p/vX7GVOudExSixFGckGmoxFxUnAgCodLRx
	bAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXvfGNY10g0Nz+Sw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAVxSXTUpqTmZZapG+XQJXxqM7a9kLzvFVTNtym6WB
	cT1PFyMnh4SAicTjyZvYQWwhgd2MErM/pUPEJSROvVzGCGELS6z89xyohguo5iOjxM+F55hA
	EmwC6hJHnreCFYkInGCUmD/RDaSIGaRowpfZLCAJYYFEiW9n9oJtYBFQldjw6yGYzStgKfH3
	yl0miA3yEjMvfQeLcwpYScz5e5cF4iJLiU1Nl1gg6gUlTs58AmYzA9U3b53NPIFRYBaS1Cwk
	qQWMTKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjTEtzB+P2VR/0DjEycTAeYpTg
	YFYS4Z2Xqp4uxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1Oq
	gYm9/8fns/6W0/9LW+82/l33+sCEbyfvNJ+dzZfwUik0MfgPf87va3ekjPYnzVvZPUkiwyhW
	Wbn/zTkl/QsTE96wW4isUX+ZqmPff+yUlcilEz5f9no7Sl/5MtXd7Kn4da9DgVmts7inSeU0
	TC6q6zwrZhz2N+ZsZ6Cp4RsP6d7OW+7HX//JYmeYOO3kw575O69O6DCde0PovFT5mnef2ULz
	a8K/2D5cyHHCOP2KYoo451cZJbuT9/OOrP6z4rrOHW+1Bkl2gWsuN+qtjCPb1j1l3XtLM1P+
	+oRLniYuypOCml3yuBcuszz5vtY6MF/yi6zGM9XLEb82/hKv1Kg9JCU+/fTe4JkzZ0a77wnZ
	Xa3EUpyRaKjFXFScCAD3IHOYIgMAAA==
X-CMS-MailID: 20241104141448epcas5p4179505e12f9cf45fd792dc6da6afce8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241104141448epcas5p4179505e12f9cf45fd792dc6da6afce8e
References: <20241104140601.12239-1-anuj20.g@samsung.com>
	<CGME20241104141448epcas5p4179505e12f9cf45fd792dc6da6afce8e@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_075605_984362_89E8A519 
X-CRM114-Status: GOOD (  17.57  )
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
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
[hch: better names for variables]
Signed-off-by: Christoph Hellwig <hch@lst.de>
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


