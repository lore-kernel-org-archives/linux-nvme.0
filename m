Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DD5C4828D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jLrb3pjokKn9zvmp/V9+dly/Dd+3yJac0z9XH4MqKaA=; b=id9VoRD/nOIimFXbuuOUojiH+E
	B8aFAY6j9aELa9wuGBLxLvJlv9arM12dfc9GE+qvBNOWAT6BU/Uu2sDdSQYzl1xadU9A8ZFele4jI
	Oeq1V451mOIembWIwMlC4ssE3Vlmx9VOjVONV4sxw+Nxjw2Aixzdt5XwawygUzB0lEWs3wIc+S/Y7
	lUUFnw37SwixA2SUhRUylMEyHLb6FEdIxtM9gBu09wJeJEMt3IhzhaglSV1z315SFJy/LxGN8hMz6
	RSAdaR+x2G+/r5FPUSs52TrBCj8Mt6U79O9eE/9h9JXGjFxrVUsh/CkzSoCReNCDqCirzDhhT5/Oe
	UMM7oPUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVXGs-000000087NU-00an;
	Thu, 01 Feb 2024 13:38:26 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVWoF-00000007v5A-2vFZ
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 13:08:53 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240201130846epoutp041f0583c8ded9d203da8b61b805223435~vvx_qFrNv3147831478epoutp04d
	for <linux-nvme@lists.infradead.org>; Thu,  1 Feb 2024 13:08:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240201130846epoutp041f0583c8ded9d203da8b61b805223435~vvx_qFrNv3147831478epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706792926;
	bh=jLrb3pjokKn9zvmp/V9+dly/Dd+3yJac0z9XH4MqKaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNF4ci2WKDW9wR5TYgkaYHceqN5zO/gnRVkrxuyKT75TzEEoXpL3LnvL5f5vaTHCI
	 x2l44bBvHL0fzn96xznprbU6rU3xPeEadYyl+f+yUDdj8noFKUffBWEtbTVDEYcos2
	 nqZVkuvh769B5X2mUR573fYVA1HGAJPYA+12Kqqg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240201130846epcas5p27bcb691f83f1e8c23327f46d100eca8a~vvx_YVAs82512125121epcas5p2S;
	Thu,  1 Feb 2024 13:08:46 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TQfNr28nNz4x9Pq; Thu,  1 Feb
	2024 13:08:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.80.09672.CD79BB56; Thu,  1 Feb 2024 22:08:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d~vvx8OULFl2255122551epcas5p1K;
	Thu,  1 Feb 2024 13:08:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240201130843epsmtrp20061d9c24cd46be53882e73146973c24~vvx8NoN_H2690026900epsmtrp2N;
	Thu,  1 Feb 2024 13:08:43 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-bc-65bb97dc9382
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.3C.08755.BD79BB56; Thu,  1 Feb 2024 22:08:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240201130841epsmtip13d69a6fa38060d651019dc0bf3561f83~vvx58rW1F2210222102epsmtip16;
	Thu,  1 Feb 2024 13:08:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>, Chinmay Gameti
	<c.gameti@samsung.com>
Subject: [PATCH v2 2/3] block: support PI at non-zero offset within metadata
Date: Thu,  1 Feb 2024 18:31:25 +0530
Message-Id: <20240201130126.211402-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201130126.211402-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhu6d6btTDb7e5rJYfbefzeL79j4W
	i5sHdjJZrFx9lMni6P+3bBaTDl1jtNh7S9ti/rKn7BbLj/9jslj3+j2LA5fH+XsbWTwuny31
	2LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fnTXIBHFHZNhmpiSmpRQqpecn5KZl56bZK3sHx
	zvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAFyoplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
	bJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjNub2lhK+h3q1hywLuB8bBFFyMHh4SA
	icTaG5pdjFwcQgK7GSUu/p7PDuF8YpRYOH8JK4TzjVGic8oEpi5GTrCOBw2ToBJ7GSW+7toE
	5XxmlFh28zULyFw2AU2JC5NLQRpEBJIkPvadZwSpYRZYyigxZ/JBRpCEsICPRNerb2BTWQRU
	JS5d2w9m8wpYSvS3LYbaJi8x89J3dhCbU8BKon9KOxtEjaDEyZlPWEBsZqCa5q2zmUEWSAhM
	5JD4s+keI0Szi8TNW2/YIGxhiVfHt7BD2FISn9/thYonS1yaeQ5qWYnE4z0HoWx7idZT/cwg
	zzADPbN+lz7ELj6J3t9PmCBhxyvR0SYEUa0ocW/SU1YIW1zi4YwlULaHxMOPICeDwqeXUWLu
	1FuMExjlZyF5YRaSF2YhbFvAyLyKUTK1oDg3PbXYtMA4L7UcHq/J+bmbGMHpVMt7B+OjBx/0
	DjEycTAeYpTgYFYS4V0ptzNViDclsbIqtSg/vqg0J7X4EKMpMIwnMkuJJucDE3peSbyhiaWB
	iZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MXst2TRYpiIxtD1+xy/PXyaBP
	c3bc4tn2OpTHqvm3adTb1brZpdvifxVGJ3qcnfa8m2VtmdyK81cfbGwJfxWSyCfIpB17at6D
	7Z+cDuYWzo/YwZtyo/XdRq+5Ml/Y3B9ynjK5r7S/fc2cb9P0Hlw5M3Hqxmmx01xWaTGGfBf5
	sPaP+leZpa/Wvdt+RCb1MbPLxMgglqnX9zTJ5tZ4Rx25ui2js2DPj0lM7Z/+f4lc58eygf3j
	tj2br13xNbtZdHChyLtrGYvtr/k8CJ0oraVx7vLMJb+i0u/uDyidJyQ0SUTzF+e29t2lP1Kb
	lgQ8OZIawlJ5fbLJS8tvyycfcNbct33Cho3mF4v0zpRXzF3a+yBLiaU4I9FQi7moOBEA5fjY
	lzAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO7t6btTDdYvN7BYfbefzeL79j4W
	i5sHdjJZrFx9lMni6P+3bBaTDl1jtNh7S9ti/rKn7BbLj/9jslj3+j2LA5fH+XsbWTwuny31
	2LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fnTXIBHFFcNimpOZllqUX6dglcGbe3tLAV9LtV
	LDng3cB42KKLkZNDQsBE4kHDJNYuRi4OIYHdjBLtk+4zQyTEJZqv/WCHsIUlVv57zg5R9JFR
	Yt3RL4xdjBwcbAKaEhcml4LUiAhkSHT8ngHWyyywklGieX45iC0s4CPR9eobE4jNIqAqcena
	fjCbV8BSor9tMRPEfHmJmZe+g+3iFLCS6J/SzgZiCwHVTJs9hR2iXlDi5MwnLBDz5SWat85m
	nsAoMAtJahaS1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGRoKW5g3H7qg96
	hxiZOBgPMUpwMCuJ8K6U25kqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6Yklqdmpq
	QWoRTJaJg1Oqgan8QkGrwW6f9xsNCoJW+y5LN8x7YPcs7/uyg0tXzPu8Q4t/Y4PHj9wVOVc/
	zQ7+Hv5197cMlVPPCjYqOj/lK7A5NPugzJ2NF1uP+r/5kFE26cGJ6iVfln7bcuKNS8Ld9RvP
	SrwKbSvkunvmSv1xmSaLG6d6mv4Gd21ROT3p+iee6FUNPdr5X+/pVDdy5z4Kvqjx+5bAIsFX
	0VXrF2t96j527++Om3fLvVvPcmx0P+rn3jrnmPsBnzw3JY1Z2cvPsPwLzdbeqHDQRFJD0W/D
	fHuVhNnapTHyjjoCh3Xc7z86UyR+VmJ21HzWQ248J7fvyE/pUheS8Txx2uKKX/mHz/fPpMza
	Gbyl6X586J1LbHdWKbEUZyQaajEXFScCAAfKPKTzAgAA
X-CMS-MailID: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_050852_129088_85669095 
X-CRM114-Status: GOOD (  20.01  )
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

Block layer integrity processing assumes that protection information
(PI) is placed in the first bytes of each metadata block.

Remove this limitation and include the metadata before the PI in the
calculation of the guard tag.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Chinmay Gameti <c.gameti@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/bio-integrity.c         |  1 +
 block/blk-integrity.c         |  1 +
 block/t10-pi.c                | 52 +++++++++++++++++++++++++----------
 include/linux/blk-integrity.h |  1 +
 include/linux/blkdev.h        |  1 +
 5 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index c9a16fba58b9..2e3e8e04961e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -395,6 +395,7 @@ static blk_status_t bio_integrity_process(struct bio *bio,
 	iter.tuple_size = bi->tuple_size;
 	iter.seed = proc_iter->bi_sector;
 	iter.prot_buf = bvec_virt(bip->bip_vec);
+	iter.pi_offset = bi->pi_offset;
 
 	__bio_for_each_segment(bv, bio, bviter, *proc_iter) {
 		void *kaddr = bvec_kmap_local(&bv);
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d4e9b4556d14..ccbeb6dfa87a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -370,6 +370,7 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->profile = template->profile ? template->profile : &nop_profile;
 	bi->tuple_size = template->tuple_size;
 	bi->tag_size = template->tag_size;
+	bi->pi_offset = template->pi_offset;
 
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 251a7b188963..d90892fd6f2a 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -32,12 +32,16 @@ static __be16 t10_pi_ip_fn(__be16 csum, void *data, unsigned int len)
 static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 		csum_fn *fn, enum t10_dif_type type)
 {
+	u8 offset = iter->pi_offset;
 	unsigned int i;
 
 	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
-		struct t10_pi_tuple *pi = iter->prot_buf;
+		struct t10_pi_tuple *pi = iter->prot_buf + offset;
 
 		pi->guard_tag = fn(0, iter->data_buf, iter->interval);
+		if (offset)
+			pi->guard_tag = fn(pi->guard_tag, iter->prot_buf,
+					   offset);
 		pi->app_tag = 0;
 
 		if (type == T10_PI_TYPE1_PROTECTION)
@@ -56,12 +60,13 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		csum_fn *fn, enum t10_dif_type type)
 {
+	u8 offset = iter->pi_offset;
 	unsigned int i;
 
 	BUG_ON(type == T10_PI_TYPE0_PROTECTION);
 
 	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
-		struct t10_pi_tuple *pi = iter->prot_buf;
+		struct t10_pi_tuple *pi = iter->prot_buf + offset;
 		__be16 csum;
 
 		if (type == T10_PI_TYPE1_PROTECTION ||
@@ -84,6 +89,8 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		}
 
 		csum = fn(0, iter->data_buf, iter->interval);
+		if (offset)
+			csum = fn(csum, iter->prot_buf, offset);
 
 		if (pi->guard_tag != csum) {
 			pr_err("%s: guard tag error at sector %llu " \
@@ -134,8 +141,10 @@ static blk_status_t t10_pi_type1_verify_ip(struct blk_integrity_iter *iter)
  */
 static void t10_pi_type1_prepare(struct request *rq)
 {
-	const int tuple_sz = rq->q->integrity.tuple_size;
+	struct blk_integrity *bi = &rq->q->integrity;
+	const int tuple_sz = bi->tuple_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
+	u8 offset = bi->pi_offset;
 	struct bio *bio;
 
 	__rq_for_each_bio(bio, rq) {
@@ -154,7 +163,7 @@ static void t10_pi_type1_prepare(struct request *rq)
 
 			p = bvec_kmap_local(&iv);
 			for (j = 0; j < iv.bv_len; j += tuple_sz) {
-				struct t10_pi_tuple *pi = p;
+				struct t10_pi_tuple *pi = p + offset;
 
 				if (be32_to_cpu(pi->ref_tag) == virt)
 					pi->ref_tag = cpu_to_be32(ref_tag);
@@ -183,9 +192,11 @@ static void t10_pi_type1_prepare(struct request *rq)
  */
 static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 {
-	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
-	const int tuple_sz = rq->q->integrity.tuple_size;
+	struct blk_integrity *bi = &rq->q->integrity;
+	unsigned intervals = nr_bytes >> bi->interval_exp;
+	const int tuple_sz = bi->tuple_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
+	u8 offset = bi->pi_offset;
 	struct bio *bio;
 
 	__rq_for_each_bio(bio, rq) {
@@ -200,7 +211,7 @@ static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 
 			p = bvec_kmap_local(&iv);
 			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
-				struct t10_pi_tuple *pi = p;
+				struct t10_pi_tuple *pi = p + offset;
 
 				if (be32_to_cpu(pi->ref_tag) == ref_tag)
 					pi->ref_tag = cpu_to_be32(virt);
@@ -288,12 +299,16 @@ static __be64 ext_pi_crc64(u64 crc, void *data, unsigned int len)
 static blk_status_t ext_pi_crc64_generate(struct blk_integrity_iter *iter,
 					enum t10_dif_type type)
 {
+	u8 offset = iter->pi_offset;
 	unsigned int i;
 
 	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
-		struct crc64_pi_tuple *pi = iter->prot_buf;
+		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
 
 		pi->guard_tag = ext_pi_crc64(0, iter->data_buf, iter->interval);
+		if (offset)
+			pi->guard_tag = ext_pi_crc64(be64_to_cpu(pi->guard_tag),
+					iter->prot_buf, offset);
 		pi->app_tag = 0;
 
 		if (type == T10_PI_TYPE1_PROTECTION)
@@ -319,10 +334,11 @@ static bool ext_pi_ref_escape(u8 *ref_tag)
 static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 				      enum t10_dif_type type)
 {
+	u8 offset = iter->pi_offset;
 	unsigned int i;
 
 	for (i = 0; i < iter->data_size; i += iter->interval) {
-		struct crc64_pi_tuple *pi = iter->prot_buf;
+		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
 		u64 ref, seed;
 		__be64 csum;
 
@@ -344,6 +360,10 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 		}
 
 		csum = ext_pi_crc64(0, iter->data_buf, iter->interval);
+		if (offset)
+			csum = ext_pi_crc64(be64_to_cpu(csum), iter->prot_buf,
+					    offset);
+
 		if (pi->guard_tag != csum) {
 			pr_err("%s: guard tag error at sector %llu " \
 			       "(rcvd %016llx, want %016llx)\n",
@@ -373,8 +393,10 @@ static blk_status_t ext_pi_type1_generate_crc64(struct blk_integrity_iter *iter)
 
 static void ext_pi_type1_prepare(struct request *rq)
 {
-	const int tuple_sz = rq->q->integrity.tuple_size;
+	struct blk_integrity *bi = &rq->q->integrity;
+	const int tuple_sz = bi->tuple_size;
 	u64 ref_tag = ext_pi_ref_tag(rq);
+	u8 offset = bi->pi_offset;
 	struct bio *bio;
 
 	__rq_for_each_bio(bio, rq) {
@@ -393,7 +415,7 @@ static void ext_pi_type1_prepare(struct request *rq)
 
 			p = bvec_kmap_local(&iv);
 			for (j = 0; j < iv.bv_len; j += tuple_sz) {
-				struct crc64_pi_tuple *pi = p;
+				struct crc64_pi_tuple *pi = p +  offset;
 				u64 ref = get_unaligned_be48(pi->ref_tag);
 
 				if (ref == virt)
@@ -411,9 +433,11 @@ static void ext_pi_type1_prepare(struct request *rq)
 
 static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 {
-	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
-	const int tuple_sz = rq->q->integrity.tuple_size;
+	struct blk_integrity *bi = &rq->q->integrity;
+	unsigned intervals = nr_bytes >> bi->interval_exp;
+	const int tuple_sz = bi->tuple_size;
 	u64 ref_tag = ext_pi_ref_tag(rq);
+	u8 offset = bi->pi_offset;
 	struct bio *bio;
 
 	__rq_for_each_bio(bio, rq) {
@@ -428,7 +452,7 @@ static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 
 			p = bvec_kmap_local(&iv);
 			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
-				struct crc64_pi_tuple *pi = p;
+				struct crc64_pi_tuple *pi = p + offset;
 				u64 ref = get_unaligned_be48(pi->ref_tag);
 
 				if (ref == ref_tag)
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 378b2459efe2..e253e7bd0d17 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -20,6 +20,7 @@ struct blk_integrity_iter {
 	unsigned int		data_size;
 	unsigned short		interval;
 	unsigned char		tuple_size;
+	unsigned char		pi_offset;
 	const char		*disk_name;
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d7cac3de65b3..bb4d811fee46 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -108,6 +108,7 @@ struct blk_integrity {
 	const struct blk_integrity_profile	*profile;
 	unsigned char				flags;
 	unsigned char				tuple_size;
+	unsigned char				pi_offset;
 	unsigned char				interval_exp;
 	unsigned char				tag_size;
 };
-- 
2.25.1


