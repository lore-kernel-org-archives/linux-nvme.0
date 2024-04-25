Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E142AC10F15
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZpVI+2oz3hOIVHmIDa5Dfh1pTAGcWIpPyXMJ0UEsJ9M=; b=OZEUyDYGtNADMnngI3E+pVCptt
	LLX+Wjs1z0fVrCtBgze16vw/AGVzy+ju5jOrsnlZpWKxJzHdZhjymvI8vlx3orizgQPFM1uMG0eEu
	yF47xG9JMCUGRmpemzh1z+Ap0GPL/5Z48vNqtgaTHggQpZk06J6qBYBQZr5CsTQ73qS8bZAfdkav5
	q5S/VkSpEhG380EsEiyjO7zdbSXdqVHXqgCyM1SiAfYgrn82UIPeI1GWAXbf5qIyzeoA/vxz8/kVe
	D+E33j6cCku2S+5kKvXbOR0WkYSWM2cEomugG/f7FyJ9WH2WD3dBdixUa61Bsg1ETHUrAH8mrYHXo
	VMCJPsaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0481-00000009m3P-3wFn;
	Thu, 25 Apr 2024 18:47:29 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047l-00000009lqP-2Wsa
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 18:47:17 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240425184711epoutp03753f46d7a9ae6b74204f680293b6fb61~Jmlb2Sz_12305023050epoutp03E
	for <linux-nvme@lists.infradead.org>; Thu, 25 Apr 2024 18:47:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240425184711epoutp03753f46d7a9ae6b74204f680293b6fb61~Jmlb2Sz_12305023050epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714070831;
	bh=ZpVI+2oz3hOIVHmIDa5Dfh1pTAGcWIpPyXMJ0UEsJ9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5YNw6cCtaRVoeV0CGnet7Pxi0N1Dazvg9sBsItugLbRgucyUrLhQA4Hcy5is/lrP
	 D6h6Zkv/fghX4tsv5e2Kf+mhCbCKFkxuwwgV3qGU5SJEsJCKUVWlZj9xWZwlpZ74TP
	 Y7CDJFFGVOq+FzvMjnjxVzAMIaAFOJifXqlsYulo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240425184710epcas5p38c919ee7548dbf6d85e36427a50cb697~JmlbSzWtt0687706877epcas5p34;
	Thu, 25 Apr 2024 18:47:10 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VQPwY12gVz4x9Pq; Thu, 25 Apr
	2024 18:47:09 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.20.09665.C25AA266; Fri, 26 Apr 2024 03:47:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240425184708epcas5p4f1d95cd8d285614f712868d205a23115~JmlZGm_No1482414824epcas5p4t;
	Thu, 25 Apr 2024 18:47:08 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240425184708epsmtrp12435c2216b41129151b5da961d30625b~JmlZF1L8o0085000850epsmtrp1i;
	Thu, 25 Apr 2024 18:47:08 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-27-662aa52cd31b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.F0.07541.C25AA266; Fri, 26 Apr 2024 03:47:08 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240425184706epsmtip103cfb1eb0a27f8948c2292d55253d0a5~JmlXL-eNj0041100411epsmtip1r;
	Thu, 25 Apr 2024 18:47:06 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH 09/10] block: add support to send meta buffer
Date: Fri, 26 Apr 2024 00:09:42 +0530
Message-Id: <20240425183943.6319-10-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425183943.6319-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmlq7uUq00g1lLmC2aJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvF0f9v2SwmHbrGaLH3lrbF/GVP2S2W
	H//H5MDrcW3GRBaPnbPusntcPlvqsWlVJ5vH5iX1HrtvNrB5fHx6i8Wjb8sqRo/Pm+QCOKOy
	bTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlZSKEvM
	KQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe8
	f3+eqeCNesWB81UNjIsVuhg5OSQETCQOH5rE2sXIxSEksJtR4uWOq0wQzidGiW1TGthAqoQE
	vjFKfLmbDNMxf/d3qKK9jBJNG0+xQDifGSV+n9zB3MXIwcEmoClxYXIpSIOIQIrEq3WvGUFq
	mAWeMkrs+XqTCaRGWMBWYuVrJ5AaFgFViUPXp7OD2LwCFhJXfn5nh1gmLzHzEoTNCRSffPE0
	VI2gxMmZT1hAbGagmuats5lB5ksIrOSQaDl2kRmi2UViRftxVghbWOLV8S1QQ6UkXva3QdnJ
	EpdmnmOCsEskHu85CGXbS7Se6gf7hRnol/W79CF28Un0/n4Cdr6EAK9ER5sQRLWixL1JT6E2
	iUs8nLEEyvaQmHr0GTskeLoZJVZcvss0gVF+FpIXZiF5YRbCtgWMzKsYJVMLinPTU4tNC4zz
	Usvh0Zqcn7uJEZx0tbx3MD568EHvECMTB+MhRgkOZiUR3psfNdKEeFMSK6tSi/Lji0pzUosP
	MZoCw3gis5Rocj4w7eeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp
	1cBkcio07/EdY9PK8nmeVWfiu+2OOup82qZn+WLnXqb+tjN9AqaqkpZ+wXVHr6m4bZCtu3uh
	8aHvr5Xm53ONZ4dt9Vq20X/pHjbrbEeN605Su24xlsvpfgupjxVO2SU6u/GvwONCtQ+Jk3Ol
	nyo++WBz4EST/pnubV0sq63amH99jtFP3Ft73u9iS2w6Z/yFkJmbLZTYuhsb7ducNzNsX26w
	ikP/u4GK6/37AYdjjqooP/YuWPRmymytGW+vWcR7dqp29CiG/V4c/6Z3h6bn+RC98t8Fi7Uc
	Kg+k7wjUjYnrt94gOvt7ramEvspsgXLO+6KLZy/+esZKY833KddUdKsqC68GvTn+ZalE4+sN
	z5RYijMSDbWYi4oTAXv9jUBDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnK7OUq00g73bxCyaJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvF0f9v2SwmHbrGaLH3lrbF/GVP2S2W
	H//H5MDrcW3GRBaPnbPusntcPlvqsWlVJ5vH5iX1HrtvNrB5fHx6i8Wjb8sqRo/Pm+QCOKO4
	bFJSczLLUov07RK4Mt6/P89U8Ea94sD5qgbGxQpdjJwcEgImEvN3f2cCsYUEdjNK3HhqAhEX
	l2i+9oMdwhaWWPnvOZDNBVTzkVHiQM8s1i5GDg42AU2JC5NLQWpEBLIk9vZfAathFnjLKLFt
	6Uo2kBphAVuJla+dQGpYBFQlDl2fDjaTV8BC4srP71Dz5SVmXoKwOYHiky+eZoe4x1xi6ppF
	jBD1ghInZz5hAbGZgeqbt85mnsAoMAtJahaS1AJGplWMkqkFxbnpucmGBYZ5qeV6xYm5xaV5
	6XrJ+bmbGMHxoqWxg/He/H96hxiZOBgPMUpwMCuJ8N78qJEmxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA5OPb//e2uPRDhPOq+rMN0pmKv1zka/3RVLn
	Pt/PHb+e/tvNuFJnQ++TZSLlDw4J5k3xSjTUDra/bTDp3EnXVvfV7SG6cff8ub9d2PPh64PA
	r6vMGphntZ2eZDRJ+IRiqKQa89xHyfWLkt3fnPzw8vrnRTN23/DlfxlcvvsDj9faipBzH/T/
	/vnW4p3uyVH2VozlpBrDwSeRu/62lW9+oGBwzabl2K0pF6fMUC/W25pzZWZUYsbMpkypTs8Y
	77k3piqdMoyyzGI/Weks3XxCbX7JKusVj6o2antHVpxbUxp4W07+OPe52tNsket2chk13Xp8
	xd6m7xiHq8bbv9Z75u/4zcYWJR4XO3nzmcbLCa+UWIozEg21mIuKEwFRqecdBgMAAA==
X-CMS-MailID: 20240425184708epcas5p4f1d95cd8d285614f712868d205a23115
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184708epcas5p4f1d95cd8d285614f712868d205a23115
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184708epcas5p4f1d95cd8d285614f712868d205a23115@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_114714_122506_488BFD1D 
X-CRM114-Status: GOOD (  20.99  )
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

If iocb contains the meta, extract that and prepare the bip.
Extend bip so that can it can carry three new integrity-check flags
and application tag.

Make sure that ->prepare_fn and ->complete_fn are skipped for
user-owned meta buffer.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio-integrity.c | 31 ++++++++++++++++++++++++++++++-
 block/fops.c          |  9 +++++++++
 block/t10-pi.c        |  6 ++++++
 include/linux/bio.h   | 10 ++++++++++
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 1085cf45f51e..dab76fd73813 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -11,7 +11,7 @@
 #include <linux/export.h>
 #include <linux/bio.h>
 #include <linux/workqueue.h>
-#include <linux/slab.h>
+#include <uapi/linux/io_uring.h>
 #include "blk.h"
 
 static struct kmem_cache *bip_slab;
@@ -318,6 +318,35 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
 	return nr_bvecs;
 }
 
+int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	u16 bip_flags = 0;
+	int ret;
+
+	if (!bi)
+		return -EINVAL;
+
+	if (meta->iter.count < bio_integrity_bytes(bi, bio_sectors(bio)))
+		return -EINVAL;
+
+	ret = bio_integrity_map_user(bio, &meta->iter, 0);
+	if (!ret) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+
+		if (meta->flags & META_CHK_GUARD)
+			bip_flags |= BIP_USER_CHK_GUARD;
+		if (meta->flags & META_CHK_APPTAG)
+			bip_flags |= BIP_USER_CHK_APPTAG;
+		if (meta->flags & META_CHK_REFTAG)
+			bip_flags |= BIP_USER_CHK_REFTAG;
+
+		bip->bip_flags |= bip_flags;
+		bip->apptag = meta->apptag;
+	}
+	return ret;
+}
+
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter,
 			  u32 seed)
 {
diff --git a/block/fops.c b/block/fops.c
index 679d9b752fe8..e488fa66dd60 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -353,6 +353,15 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
+	if (unlikely(iocb->ki_flags & IOCB_USE_META)) {
+		ret = bio_integrity_map_iter(bio, iocb->private);
+		WRITE_ONCE(iocb->private, NULL);
+		if (unlikely(ret)) {
+			bio_put(bio);
+			return ret;
+		}
+	}
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		bio->bi_opf |= REQ_NOWAIT;
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index d90892fd6f2a..72d1522417a1 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -156,6 +156,8 @@ static void t10_pi_type1_prepare(struct request *rq)
 		/* Already remapped? */
 		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
 			break;
+		if (bip->bip_flags & BIP_INTEGRITY_USER)
+			break;
 
 		bip_for_each_vec(iv, bip, iter) {
 			unsigned int j;
@@ -205,6 +207,8 @@ static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 		struct bio_vec iv;
 		struct bvec_iter iter;
 
+		if (bip->bip_flags & BIP_INTEGRITY_USER)
+			break;
 		bip_for_each_vec(iv, bip, iter) {
 			unsigned int j;
 			void *p;
@@ -408,6 +412,8 @@ static void ext_pi_type1_prepare(struct request *rq)
 		/* Already remapped? */
 		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
 			break;
+		if (bip->bip_flags & BIP_INTEGRITY_USER)
+			break;
 
 		bip_for_each_vec(iv, bip, iter) {
 			unsigned int j;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0281b356935a..8724305bce62 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -329,6 +329,9 @@ enum bip_flags {
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
 	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
 	BIP_COPY_USER		= 1 << 6, /* Kernel bounce buffer in use */
+	BIP_USER_CHK_GUARD	= 1 << 7,
+	BIP_USER_CHK_APPTAG	= 1 << 8,
+	BIP_USER_CHK_REFTAG	= 1 << 9,
 };
 
 struct uio_meta {
@@ -348,6 +351,7 @@ struct bio_integrity_payload {
 	unsigned short		bip_vcnt;	/* # of integrity bio_vecs */
 	unsigned short		bip_max_vcnt;	/* integrity bio_vec slots */
 	unsigned short		bip_flags;	/* control flags */
+	u16			apptag;		/* apptag */
 
 	struct bvec_iter	bio_iter;	/* for rewinding parent bio */
 
@@ -729,6 +733,7 @@ static inline bool bioset_initialized(struct bio_set *bs)
 	for_each_bio(_bio)						\
 		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
 
+int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta);
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter, u32 seed);
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
@@ -808,6 +813,11 @@ static inline int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter,
 	return -EINVAL;
 }
 
+static inline int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 /*
-- 
2.25.1


