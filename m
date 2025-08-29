Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F33CA0FFD
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqeGlfnCcP/78XD3MlSdQnU+kfWsJ/iig4l+gmh5668=; b=VVSTAc+ZdzncxSVOOk+HG5YLwu
	QvwWqtTM2BRJ0FEMySck+Hm2otP7z0N+3ouiWsqvsRWz6POv0R8hTDj7xnNVHa8uDzbTfe3j5n7FR
	U0KI+YWEmFuD4PdisaqgJBNHuK1q5GRTNVNQ9GuYbbzZW4Uk2i8CQ8BXxwelA1c57vVDqyM5vydkC
	B6Z+AD6Z6igAhheoB1mqWSmMB2xmaB/cYsLGSZSkB6KOZdiFZH/6kArgW54VUl00HN4v4opO109v5
	0yrLPmjzE1NOhC9ycXUIxrPq52NGa3c578A+rZqfaZaMqMSJ81CwtIeTYgjdFc3CEFU2EDhokMYdn
	wdsBvsng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us2rx-00000006WeJ-1e5I;
	Fri, 29 Aug 2025 17:26:33 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us00h-000000060Qe-1MND
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 14:23:24 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57T7shkT3380910
	for <linux-nvme@lists.infradead.org>; Fri, 29 Aug 2025 07:23:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KqeGlfnCcP/78XD3MlSdQnU+kfWsJ/iig4l+gmh5668=; b=SovaXCaCWm5j
	5OcIhQh9Z5NuW8/tLdeXubup5NnmJWZCi644GrM6wq5mODsAkYyr6UCKdpgdU4AH
	nfIo0RX3Q7B3RfYpuUpULEQN1dSx9nanOz1I91wpEo8Up6JBhxCRRQGm8vp6/128
	OSyEMSnSqpO5L8xw9ELKaHhksBouqABlz3ml7EAw5SXbPCI7uBQu0+kzaVXgPHOr
	2dsFA+xVzvtZPjDByaJl7ksbwobl0pNcQWPclYbl3a+LE505zh33jU3p1VVgLXTZ
	1gUjnMHbtQLtBFeGqai06kiCTsmB2YmFxbgpTEnGOg0gniHEsTPOHPSBkHbcWtiZ
	wWrKji6FFQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48u87w1wd6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 29 Aug 2025 07:23:22 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 29 Aug 2025 14:23:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4EA2311FADB6; Fri, 29 Aug 2025 07:23:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] blk-integrity: enable p2p source and destination
Date: Fri, 29 Aug 2025 07:23:06 -0700
Message-ID: <20250829142307.3769873-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829142307.3769873-1-kbusch@meta.com>
References: <20250829142307.3769873-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bsJMBFai c=1 sm=1 tr=0 ts=68b1b7da cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=NyUx0YTEs4DmRO4HD-YA:9
X-Proofpoint-GUID: 0G--nIIHQLseCD09bEuqH_QMVhHhD0IO
X-Proofpoint-ORIG-GUID: 0G--nIIHQLseCD09bEuqH_QMVhHhD0IO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDEyMSBTYWx0ZWRfX/RrCYD61lIr6
 Y9B/qoK59o/sNAYTSn1CY1bUDwcj1E8JusGlm7B0NPcOJ6/uAOrFSW8JJjCzIAznxsclcXluCKU
 vYiVzKe65yQDMWuFoXpT+sO6auqKaBiPYAw+eOvC06vOkuY5TcYKFvp+ZkNcAlhmc1gOdytzfpm
 pGcJzw2NONLQ/26bEB7yEzaSKOoiZ9bZpG0TFJyUxLDwrp7uq+ZMfCYmyzWPHrwg9jFzoaYnMp0
 d5S7OubrLRKexPMUFVCLNzjDJ1IWk0SnOSfptV2lMPEkoiYCZX5uhLip/tuiNzF20xgJY1Or4O7
 pgoQURAo/PX7Z16OAM2h9rCIWjlrq81OirGAjJFrbCgQCj0/bsYVpHWnwe2Dj8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_05,2025-08-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_072323_371761_E5EFC1AF 
X-CRM114-Status: GOOD (  12.97  )
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

From: Keith Busch <kbusch@kernel.org>

User provided metadata can come from anywhere, including p2p pages. Set
the extraction flags to allow p2p pages for the metadata buffer if the
block device allows it. Similar to data payloads, ensure the bio
disallows merging if we see a p2p page.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..5709ce2bf3464 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -230,7 +230,8 @@ static int bio_integrity_init_user(struct bio *bio, s=
truct bio_vec *bvec,
 }
=20
 static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **=
pages,
-				    int nr_vecs, ssize_t bytes, ssize_t offset)
+				    int nr_vecs, ssize_t bytes, ssize_t offset,
+				    bool *is_p2p)
 {
 	unsigned int nr_bvecs =3D 0;
 	int i, j;
@@ -251,6 +252,9 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 			bytes -=3D next;
 		}
=20
+		if (is_pci_p2pdma_page(page))
+			*is_p2p =3D true;
+
 		bvec_set_page(&bvec[nr_bvecs], pages[i], size, offset);
 		offset =3D 0;
 		nr_bvecs++;
@@ -265,10 +269,11 @@ int bio_integrity_map_user(struct bio *bio, struct =
iov_iter *iter)
 	unsigned int align =3D blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages =3D stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec =3D stack_vec;
+	iov_iter_extraction_t extraction_flags =3D 0;
 	size_t offset, bytes =3D iter->count;
+	bool copy, is_p2p =3D false;
 	unsigned int nr_bvecs;
 	int ret, nr_vecs;
-	bool copy;
=20
 	if (bio_integrity(bio))
 		return -EINVAL;
@@ -286,15 +291,23 @@ int bio_integrity_map_user(struct bio *bio, struct =
iov_iter *iter)
 	}
=20
 	copy =3D !iov_iter_is_aligned(iter, align, align);
-	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset=
);
+
+	if (blk_queue_pci_p2pdma(q))
+		extraction_flags |=3D ITER_ALLOW_P2PDMA;
+
+	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
+					extraction_flags, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
=20
-	nr_bvecs =3D bvec_from_pages(bvec, pages, nr_vecs, bytes, offset);
+	nr_bvecs =3D bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
+				   &is_p2p);
 	if (pages !=3D stack_pages)
 		kvfree(pages);
 	if (nr_bvecs > queue_max_integrity_segments(q))
 		copy =3D true;
+	if (is_p2p)
+		bio->bi_opf |=3D REQ_NOMERGE;
=20
 	if (copy)
 		ret =3D bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes);
--=20
2.47.3


