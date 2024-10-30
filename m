Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9CCD6B6B7
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 18:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1yEesIXP8hqj3mWCayZYKotAS9KxK7WmVJifezfxMwM=; b=sg4y2JHuzZBQDqZzUUjsm0TD24
	0IAqIZwr827lhqUqRmx/ISil79BHnjLfucO8Qo0hOcR/Zoh2EYorSjfTI7yG6DfNjROg4dKNSBZdE
	w/EYNJ1sAA7iAQ8NSS062dKhRC5Ow5wAoPPLWM9HpAidEIZn7TBS0a9QuanOgTNM2sh590QaGoa6z
	P2umt9BjaOBQ9138lLJCAI7w5+V3HBo2UEn3UJFMvKQIdMir51CNw6aCMqe3i1Lc2zsXI8yQY4MvL
	ya9CG6SGG74QIoAZs0p4qadH3+EQwrV7m9g98ADhUOduj1fc/gw6zR1GR1DlP9boW371yQrMBgdl/
	Ir9l6pQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6DAb-00000001O7z-3aWX;
	Wed, 30 Oct 2024 18:11:49 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6D8z-00000001NQP-2Erb
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 18:10:11 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241030181005epoutp03462a0f7c6e09db70e8f1879eb370a7c1~DTWt6Uffo2895828958epoutp03M
	for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2024 18:10:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241030181005epoutp03462a0f7c6e09db70e8f1879eb370a7c1~DTWt6Uffo2895828958epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730311805;
	bh=1yEesIXP8hqj3mWCayZYKotAS9KxK7WmVJifezfxMwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+b75B7Y2U7RwWRjYvXr0VrYOUyJT0BWU8vIsl0FOjgKrP4ZSurKNQgONXerI4BDB
	 fM+tL/7MUbQ2FChdnWWsVP4RsYTJ/MAyTq+brtWrjTjNdXwDCsbaKNRaVVJcUR0a4V
	 ctiQiwRAXXXLlkethsI33z4zqiLBJYcKesOUIz40=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241030181005epcas5p2e52c1e3d150255a45c61820871d80dd3~DTWtU-U2T1352813528epcas5p2F;
	Wed, 30 Oct 2024 18:10:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XdwBz46l5z4x9Pp; Wed, 30 Oct
	2024 18:10:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.10.09420.B7672276; Thu, 31 Oct 2024 03:10:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241030181002epcas5p2b44e244bcd0c49d0a379f0f4fe07dc3f~DTWrP0boz2064320643epcas5p2p;
	Wed, 30 Oct 2024 18:10:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241030181002epsmtrp280269c041b62b74f9eb055f94dba84f1~DTWrPD-KR0895708957epsmtrp2h;
	Wed, 30 Oct 2024 18:10:02 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-e3-6722767b242c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.B8.18937.A7672276; Thu, 31 Oct 2024 03:10:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241030181000epsmtip210691a6ad2b351cf1479df74fe80be57~DTWo54p830487504875epsmtip25;
	Wed, 30 Oct 2024 18:10:00 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	anuj1072538@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v6 02/10] block: copy back bounce buffer to user-space
 correctly in case of split
Date: Wed, 30 Oct 2024 23:31:04 +0530
Message-Id: <20241030180112.4635-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030180112.4635-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmlm51mVK6wbnnMhYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJotJh64xWuy9pW2xZ+9JFov5
	y56yW3Rf38Fmsfz4PyaL83+Ps1qcnzWH3UHQY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHh+f
	3mLx6NuyitHjzIIj7B6fN8l5bHrylimAKyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ
	19DSwlxJIS8xN9VWycUnQNctMwfoHSWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpO
	gUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsajO2vZC87xVUzbcpulgXE9TxcjJ4eEgInEtQM3
	2bsYuTiEBHYzSnx7fosJwvnEKPF4xkIWOGf7ztWsMC2tG+8wQiR2Mkr8vv+RDSQhJPAZqOp/
	UhcjBwebgKbEhcmlIGERgaWMEiuvR4PUMws0MEn03u1lBkkICyRLzLo1ix2knkVAVeLkFbB6
	XgFzielzX7FB7JKXmHnpOzuIzSlgIfFhx00WiBpBiZMzn4DZzEA1zVtnM0PUn+GQ6PnsD2G7
	SGx5OBUqLizx6vgWdghbSuLzu71Q87MlHjx6wAJh10js2NwH9aO9RMOfG6wgpzEDvbJ+lz7E
	Kj6J3t9PmEDCEgK8Eh1tQhDVihL3Jj2F6hSXeDhjCZTtIfG5dwE0PLsZJbbOusg0gVF+FpIP
	ZiH5YBbCtgWMzKsYJVMLinPTU4tNCwzzUsvh0Zqcn7uJEZymtTx3MN598EHvECMTB+MhRgkO
	ZiURXssgxXQh3pTEyqrUovz4otKc1OJDjKbAEJ7ILCWanA/MFHkl8YYmlgYmZmZmJpbGZoZK
	4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTCZ7f8i/H3q7NdcYXcWShVujeB48VdTKFZLwVXl
	Gs+UlfsaX9jqLNid/+X0r1O2Ak/7bzPwM20Uq++d7mmZWzZ/7Y64+7u+r79+WNSmc87elppW
	bfnCO9NnvPm/fu9a75s7z4hESU+cqNZVosPc6XR51acG7XMi+QlGl75LXKuKEN445+zHU76N
	htEmz1vaA3m9Nv3Y4PFys/5yCyHxScIPuXh2a1x33M6xJrHv28xPk4O//Ar4t4FddKUXb9/2
	U5+8WBflrDfjT55qkD8vY5fY3CeeIj8/7lsSd+9fqtf6i+WGz9MMZy1dr3xKVeQui9KzlCu/
	xdenKC840bTmu/Vb5pnmxR4K8pX/D7JIR27oVmIpzkg01GIuKk4EAK4nJvRcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXreqTCndYNceE4uPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8WkQ9cYLfbe0rbYs/cki8X8
	ZU/ZLbqv72CzWH78H5PF+b/HWS3Oz5rD7iDosXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49P
	b7F49G1ZxehxZsERdo/Pm+Q8Nj15yxTAFcVlk5Kak1mWWqRvl8CV8ejOWvaCc3wV07bcZmlg
	XM/TxcjJISFgItG68Q4jiC0ksJ1R4usdDoi4uETztR/sELawxMp/z9khaj4ySiz9mt7FyMHB
	JqApcWFyaRcjF4eIwHpGibN7J7CA1DALdDFJXN7ADWILCyRKHF30jRmknkVAVeLklVKQMK+A
	ucT0ua/YIMbLS8y89B1sPKeAhcSHHTdZIFaZS1xfeIYdol5Q4uTMJ1Dj5SWat85mnsAoMAtJ
	ahaS1AJGplWMoqkFxbnpuckFhnrFibnFpXnpesn5uZsYwZGlFbSDcdn6v3qHGJk4GA8xSnAw
	K4nwWgYppgvxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUw
	2apJXTp18v/GaaVGE56lhrQbvi2T6VN4X27F9e2CvuCSxO9TjtR79Sr/FHlXnxTTFp3O9W8H
	7zbuKY1utd5SHQYLK2WrvE7apn3pvvdc1fLw4sXtYeqfpnTzXXgSH5getiD6crvpkp0rJs6I
	vP5JbmLW7+Mal1nmNZ9OqnGVCGnoXCxd2dGyXOBV6O5L7mvM0x2ZGV4rft7xQnBJfpLDG1tV
	+yX75th5zRBe0eF5J40z8NGit+YcT8KenDb5b/HmuMVKx/gVy79ka54M1vX0nma84cvta4/u
	7LigWm8QI5Iglq4hW10ge4ftIr/+jXburO6JH3/G28uvefBUdfGPTp3wM2dfnKivT2I8nPRd
	iaU4I9FQi7moOBEAo8YKiRsDAAA=
X-CMS-MailID: 20241030181002epcas5p2b44e244bcd0c49d0a379f0f4fe07dc3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241030181002epcas5p2b44e244bcd0c49d0a379f0f4fe07dc3f
References: <20241030180112.4635-1-joshi.k@samsung.com>
	<CGME20241030181002epcas5p2b44e244bcd0c49d0a379f0f4fe07dc3f@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_111009_935833_A09E957F 
X-CRM114-Status: GOOD (  16.41  )
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


