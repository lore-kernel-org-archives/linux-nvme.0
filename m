Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7020C5472E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 10:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1SgBe/bIw4UZFTnEY47DrIroMxr4nIL6WJSjqlhA05Q=; b=xqV5Or1xAMgzx+wwja+X77HEeb
	kAsQjZRNR7CDKvcZif4yu1plahIdGJdcH30+UWP4ZEzyVB4Eju3aklgQEFZhoaEEI2x1xYFKXwPh2
	B9Tt8BNhWxvjVMKVqDJ5JG4FLmI/MBqO7FWRwyxTrkRoetzGywO9pyHClPfjZ5h+zeQh9p5Kd9EbL
	u4I8w7O9hVXeEmQ1GjSxxJLMERAEE5hLV7dLSwpF3LscZTFrOAEz7Uvi89k6tuiyel+uKVD8bnz5J
	QvrnYwTviJm2t9LBlQbXC4ntygaN4IoUug+XJUtvj6zO7gH8FggFmks6vWT1lm+q/TDarxU+TIO8y
	n7zAOGqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shRqQ-0000000GOsm-23GK;
	Fri, 23 Aug 2024 10:48:38 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shRqB-0000000GOgX-3OeK
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 10:48:25 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240823104820epoutp026425871bb4243258b8c0cf2a3f574cbf~uVdmp3EjB0950809508epoutp02g
	for <linux-nvme@lists.infradead.org>; Fri, 23 Aug 2024 10:48:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240823104820epoutp026425871bb4243258b8c0cf2a3f574cbf~uVdmp3EjB0950809508epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724410100;
	bh=1SgBe/bIw4UZFTnEY47DrIroMxr4nIL6WJSjqlhA05Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOfxQroKP3cP5X8swgFEV1N0e9RWXp5rW5SFApUA4rFQlbn+p4XifMieQbqlEikvA
	 dWlXtp5E8GWTnF1XKN+2KiR79WN2dUmbrI3v+RG5S2NVpcp4MLX84Mzy+URVGLqapX
	 LVwTpqliO+TE2UhgLztAdmlesf3uk0b27Wh7cUrA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240823104820epcas5p12a938076eb9c62c64199a28fa498e5c3~uVdmIpwER2850228502epcas5p1c;
	Fri, 23 Aug 2024 10:48:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wqxcf39bdz4x9Q0; Fri, 23 Aug
	2024 10:48:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.8F.09743.1F868C66; Fri, 23 Aug 2024 19:48:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240823104620epcas5p2118c152963d6cadfbc9968790ac0e536~uVb2uOBWF1853818538epcas5p29;
	Fri, 23 Aug 2024 10:46:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240823104620epsmtrp29c081cebc9c898dfb876eb8922773530~uVb2thqK50114601146epsmtrp2W;
	Fri, 23 Aug 2024 10:46:20 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-76-66c868f1a27a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7D.1B.08964.C7868C66; Fri, 23 Aug 2024 19:46:20 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240823104618epsmtip2230219aa34e06babef4aa6c9b4175d9b~uVb00PXRD1410214102epsmtip2l;
	Fri, 23 Aug 2024 10:46:18 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v3 03/10] block: handle split correctly for user meta bounce
 buffer
Date: Fri, 23 Aug 2024 16:08:03 +0530
Message-Id: <20240823103811.2421-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823103811.2421-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmhu7HjBNpBq+eCVg0TfjLbDFn1TZG
	i9V3+9ksbh7YyWSxcvVRJot3redYLCYdusZosf3MUmaLvbe0LeYve8pu0X19B5vF8uP/mBx4
	PHbOusvucflsqcemVZ1sHpuX1HvsvtnA5vHx6S0Wj74tqxg9Np+u9vi8SS6AMyrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoXiWFssScUqBQQGJx
	sZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsazefsYCzZz
	VjS372FsYHzP3sXIySEhYCKxdv49xi5GLg4hgd2MEv0ds8ASQgKfGCWmfNOASHxjlJjT2sLS
	xcgB1vGqRRuiZi+jxLEmG4iaz4wS50/dZgRJsAmoSxx53gpmiwhUSjzf9YMFpIhZYBOjxK/r
	x5hAEsICoRK3F80AK2IRUJU4v+sN2GZeAQuJf4vWMUKcJy8x89J3sDingKVE0+wGFogaQYmT
	M5+A2cxANc1bZzODLJAQWMkhce3RA6jfXCQmN89igrCFJV4d3wIVl5L4/G4vG4SdLvHj8lOo
	mgKJ5mP7oBbbS7Se6mcG+ZhZQFNi/S59iLCsxNRT65gg9vJJ9P5+AtXKK7FjHoytJNG+cg6U
	LSGx91wDlO0hsevfemZIaPUwSkz7coFpAqPCLCT/zELyzyyE1QsYmVcxSqYWFOempxabFhjl
	pZbDIzk5P3cTIzgJa3ntYHz44IPeIUYmDsZDjBIczEoivEn3jqYJ8aYkVlalFuXHF5XmpBYf
	YjQFBvhEZinR5HxgHsgriTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNT
	qoEpKio10lhzI5Pc9dnnRYULclgzV/NY36p5F29Ql3gzRfjRy8s/NbSudkwyXuaklfbhjNEd
	IX8+y9hLrmXtT9tTWzUFMzy4NaJDTBq/pt//aNnU/OmQrFhk5/tNDny9yszfNnnNtCnhca/p
	3aQfW5NoYBLd97NlptRuE/b582Y7qTmy75668lbO0YwV8zRe/px3XLjr71rG8LJZD/mtxbZx
	s0TqL/rIzBU/q3nDo9MfLy7x/qd6PYLHcYvgJsO8498M1Xazdq2o0PNaKG+sbuZ1dH0m+9S9
	qxd0HRHRaTkjengG2xs/j7wpJznSAjnPGx/5VsvPtGqWd6HykVnbr3S4nTObc3XZjKnlwTMD
	BZVYijMSDbWYi4oTAYYf08ZLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvG5Nxok0gwnbxC2aJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFpMOXWO02H5mKbPF3lvaFvOXPWW36L6+g81i+fF/TA48
	Hjtn3WX3uHy21GPTqk42j81L6j1232xg8/j49BaLR9+WVYwem09Xe3zeJBfAGcVlk5Kak1mW
	WqRvl8CV8WzePsaCzZwVze17GBsY37N3MXJwSAiYSLxq0e5i5OIQEtjNKNE/8TpbFyMnUFxC
	4tTLZYwQtrDEyn/P2SGKPjJKzJ0wCyzBJqAuceR5KyNIQkSgkVFiS/MXFhCHWWAHo8S6Z4vB
	qoQFgiXePV/MBGKzCKhKnN/1hh3E5hWwkPi3aB3UCnmJmZe+g8U5BSwlmmY3sIDYQkA1y5af
	YYSoF5Q4OfMJWJwZqL5562zmCYwCs5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqX
	rpecn7uJERwrWpo7GLev+qB3iJGJg/EQowQHs5IIb9K9o2lCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUamJhaN5++09W37fIHvtuxf8WPzbfKn3D+5W4r
	mbflsXP3yT67elBnq8ujN3cmuCu/NGYtv/5IXV5248WDXa0vHZckukv4nDz4rybWO2CLsaP2
	nob6Z+sTvZcvX7Hlyuuyy52nr//1nPM8niv2+AnNkvT2LwZCDXtPWHPUKB38VLaeVWmlZUqv
	0vkVrM+eBXIsmy+sKdep1/bMbufSTbYFn0578a5dpKL/+I9bwoeIy5t0OvytF7H6lrnn2z5b
	/cJttrjkbne7mC2+R6Z+lDM78/5ziWDWRNE53X+WsAV6S0ycf1nLp8NBYof3X82I/T2Xrzan
	VkpLrU29r3zy//rDLUkmW6/6aISfyHU7rl8RxqHEUpyRaKjFXFScCAA/CGPHBAMAAA==
X-CMS-MailID: 20240823104620epcas5p2118c152963d6cadfbc9968790ac0e536
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240823104620epcas5p2118c152963d6cadfbc9968790ac0e536
References: <20240823103811.2421-1-anuj20.g@samsung.com>
	<CGME20240823104620epcas5p2118c152963d6cadfbc9968790ac0e536@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_034824_251087_273AA77A 
X-CRM114-Status: GOOD (  15.60  )
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

Copy back the bounce buffer to user-space in entirety when the parent
bio completes.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 0b69f2b003c3..d8b810a2b4bf 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -118,9 +118,11 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
 
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 {
+	struct bio *bio = bip->bip_bio;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
 	struct bio_vec *copy = &bip->bip_vec[1];
-	size_t bytes = bip->bip_iter.bi_size;
+	size_t bytes = bio_iter_integrity_bytes(bi, bip->bio_iter);
 	struct iov_iter iter;
 	int ret;
 
@@ -253,6 +255,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	bip->bip_flags |= BIP_COPY_USER;
 	bip->bip_iter.bi_sector = seed;
 	bip->bip_vcnt = nr_vecs;
+	bip->bio_iter = bio->bi_iter;
 	return 0;
 free_bip:
 	bio_integrity_free(bio);
-- 
2.25.1


