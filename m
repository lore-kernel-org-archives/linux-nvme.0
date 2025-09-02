Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A70CA1007
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 00:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cBrf5yw3v5nX8JGtQ7uv8R4eFJ2lqhxaw+fwEA0WyII=; b=Mj0yRTssRBjcBLIXRszIAp046L
	4zqKu8TnChYM7aCRBVtZvndCC1Pq2W4wN5TbFu667sTgKOA2niyYyoGVNNA/d9TYzH+zA6MD7OaQY
	z7vO6XZb9aEElSm4yQ34i0VxnN9vPGyKEPe73bQk6+om0rtA0z4asYaFgaEYl6Ch38QTFeX3S8HQ4
	QwCL9SHHD/XqNae9O7iFMDsIQBofbjNpe/Czs29KiwCi+ez8GsbqtbyruRcOOAT0eQcLHtwtkfPeg
	C4qc/qv3tZllDibdpDPnAJIuYJcYcun/OeHAkcdG52RKtCU1YTpFr3cYkcMMNrSV/GHAZtr691eK4
	2hH2taNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utbcO-00000002pba-16pj;
	Wed, 03 Sep 2025 00:44:56 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utXCF-00000001pTj-3u7E
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 20:01:41 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582EkAvd3604190
	for <linux-nvme@lists.infradead.org>; Tue, 2 Sep 2025 13:01:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cBrf5yw3v5nX8JGtQ7uv8R4eFJ2lqhxaw+fwEA0WyII=; b=YVb5Gzb0ZUz9
	v917AMXeir7khFGBgAwnzaSu1qto5RxTfmSyjY/TeBBcNQai3qvzIL5YUDt1TDCx
	VDG/6GCHiZru25VrYwP9zXz12D/of7fr2BVo/9Rxhl3MBBovfrpRKVIDO9aQv15s
	4xSWDP2rPU+y/9zqFMtxjoNKiR0cMRPY7y1Lix3GGSU/+MZVKyNCcruvLKLRwsOb
	7kxuVjlMMj5Oo16hTjhQCwCz1r+mcak6p9zs8i/wozgJH12N0DeoIIzMusz6Q+OG
	QVb8zszLoydKnrppPV19YdQM/UpNTInFAi6ZFvYfElbie3vRn7PiWlTaGg8rAYyT
	6nuaLqbJqA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48x2mutrpm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 02 Sep 2025 13:01:38 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 2 Sep 2025 20:01:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9BDEE142C456; Tue,  2 Sep 2025 13:01:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] blk-integrity: enable p2p source and destination
Date: Tue, 2 Sep 2025 13:01:20 -0700
Message-ID: <20250902200121.3665600-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250902200121.3665600-1-kbusch@meta.com>
References: <20250902200121.3665600-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDE5OCBTYWx0ZWRfXyL7GTvIn29Oa
 8fUuE8DMWT7k/ec2uAt0Mof6m3spMeZGOXlWeQwhmA4pPz3y7Md3JFAvF8gx67n5jvpVF4xhl2p
 EyOtektho5k+1RfaA+u1an0UzA+5NXp6waYFnH2nHkhzXBvYcLH8lsTuxWjBegRsDZ+FsJww+s2
 Iiw3KKS12cQn/HC+Hh5h9weOcK7oUStbVhZJ4wfnTXRl9GN24nCXRtW2WNmog82On+a9JMdWv5j
 NGwrD7ZsVJEGFxI62OxnI6CecEpPn0BmolvtxbZlq6v/p6RXP47m8hgK7akl2Cl6TT53I4alDdB
 g3dAaGqejEpuFk2VvODLbqUEnCRipFWjz3pAxQ3w6TI1ZfLWeKZ8Btl1G7RqHM=
X-Authority-Analysis: v=2.4 cv=dcCA3WXe c=1 sm=1 tr=0 ts=68b74d23 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=nFeozVan30irdC35seoA:9
X-Proofpoint-GUID: L1Jig5q--sTrwuvR_XDRgScg_WNYViXi
X-Proofpoint-ORIG-GUID: L1Jig5q--sTrwuvR_XDRgScg_WNYViXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_130139_993958_5738F4C0 
X-CRM114-Status: GOOD (  14.61  )
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

Set the extraction flags to allow p2p pages for the metadata buffer if
the block device allows it. Similar to data payloads, ensure the bio
does not allow merging if we see a p2p page.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..d3618ed106f4e 100644
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
+		if (is_pci_p2pdma_page(pages[i]))
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


