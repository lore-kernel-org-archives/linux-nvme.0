Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797F5C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v9HSzt/DU0sJkVqXpTJOEZLAe15Mipuuo7k8GXKR8W4=; b=PvdR/FjFa6oSbDLFZPFmG0og/u
	/MBIUU53Xyzqwzagft/QxyLvAg5ucJTihDLTGktWmJ0zOyTQQK3K85h5RzKQoeBjixMQPcDbb9EGM
	7U9SIj/+fyaDvuBtYITK6VA1SF36jBNi7Zq7eB27PX/aawdrFmPaKEEXUGmL5dig8JkOzK/sFoMLr
	UDsf1R3t3rln3HvYqb46DtXbiJsfDIZ73UEyIdrUbttERGcYRqLau2SK91uObS0gVQbrvqbKp3fG3
	MM5YhYqKoAMZWv1p7ug9xUD1shYQJ8NjoXM9LLc96V4LLQ5V1zJqBiGCuUQl/g6bdTI1YFJjijDre
	cp5WwS0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl3H-009fuX-QQ; Fri, 10 Jun 2022 20:16:15 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl3D-009fse-2A
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:16:12 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25AHLDC1003455
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:16:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=v9HSzt/DU0sJkVqXpTJOEZLAe15Mipuuo7k8GXKR8W4=;
 b=GSKF+o9km8xqOmibihfinbz5uQz+D6TH2oOI7wJdR6UWLfsX85smqDcJGvJ4jEmyJe5n
 cWD0jiTwpeUckcyckZQMQqzdtsXpH7Sz3idz1RqD90AtCtYveiY2tJQbWVhL98GWZm3M
 ux/AUzitiPPjS9lscaLamJb0aZFjzCOmgTA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3gma9e972e-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:16:10 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:16:08 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 89A794E9D691; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv6 02/11] block/bio: remove duplicate append pages code
Date: Fri, 10 Jun 2022 12:58:21 -0700
Message-ID: <20220610195830.3574005-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 00KMZOn29E5MKtwHF37RE01hjQsjMqcb
X-Proofpoint-GUID: 00KMZOn29E5MKtwHF37RE01hjQsjMqcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_131611_271369_4CE024C0 
X-CRM114-Status: GOOD (  22.13  )
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

The getting pages setup for zone append and normal IO are identical. Use
common code for each.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 102 ++++++++++++++++++++++------------------------------
 1 file changed, 42 insertions(+), 60 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d481d5e4fe47..5618c6a4b3a3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1159,6 +1159,37 @@ static void bio_put_pages(struct page **pages, siz=
e_t size, size_t off)
 		put_page(pages[i]);
 }
=20
+static int bio_iov_add_page(struct bio *bio, struct page *page,
+		unsigned int len, unsigned int offset)
+{
+	bool same_page =3D false;
+
+	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
+		if (WARN_ON_ONCE(bio_full(bio, len)))
+			return -EINVAL;
+		__bio_add_page(bio, page, len, offset);
+		return 0;
+	}
+
+	if (same_page)
+		put_page(page);
+	return 0;
+}
+
+static int bio_iov_add_zone_append_page(struct bio *bio, struct page *pa=
ge,
+		unsigned int len, unsigned int offset)
+{
+	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
+	bool same_page =3D false;
+
+	if (bio_add_hw_page(q, bio, page, len, offset,
+			queue_max_zone_append_sectors(q), &same_page) !=3D len)
+		return -EINVAL;
+	if (same_page)
+		put_page(page);
+	return 0;
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct p=
age *))
=20
 /**
@@ -1177,7 +1208,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
-	bool same_page =3D false;
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
@@ -1186,7 +1216,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	 * Move page array up in the allocated memory for the bio vecs as far a=
s
 	 * possible so that we can start filling biovecs from the beginning
 	 * without overwriting the temporary page array.
-	*/
+	 */
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
@@ -1196,18 +1226,18 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
=20
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
 		struct page *page =3D pages[i];
+		int ret;
=20
 		len =3D min_t(size_t, PAGE_SIZE - offset, left);
+		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
+			ret =3D bio_iov_add_zone_append_page(bio, page, len,
+					offset);
+		else
+			ret =3D bio_iov_add_page(bio, page, len, offset);
=20
-		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
-			if (same_page)
-				put_page(page);
-		} else {
-			if (WARN_ON_ONCE(bio_full(bio, len))) {
-				bio_put_pages(pages + i, left, offset);
-				return -EINVAL;
-			}
-			__bio_add_page(bio, page, len, offset);
+		if (ret) {
+			bio_put_pages(pages + i, left, offset);
+			return ret;
 		}
 		offset =3D 0;
 	}
@@ -1216,51 +1246,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	return 0;
 }
=20
-static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *=
iter)
-{
-	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
-	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
-	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
-	unsigned int max_append_sectors =3D queue_max_zone_append_sectors(q);
-	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
-	struct page **pages =3D (struct page **)bv;
-	ssize_t size, left;
-	unsigned len, i;
-	size_t offset;
-	int ret =3D 0;
-
-	/*
-	 * Move page array up in the allocated memory for the bio vecs as far a=
s
-	 * possible so that we can start filling biovecs from the beginning
-	 * without overwriting the temporary page array.
-	 */
-	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
-	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
-
-	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
-	if (unlikely(size <=3D 0))
-		return size ? size : -EFAULT;
-
-	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
-		struct page *page =3D pages[i];
-		bool same_page =3D false;
-
-		len =3D min_t(size_t, PAGE_SIZE - offset, left);
-		if (bio_add_hw_page(q, bio, page, len, offset,
-				max_append_sectors, &same_page) !=3D len) {
-			bio_put_pages(pages + i, left, offset);
-			ret =3D -EINVAL;
-			break;
-		}
-		if (same_page)
-			put_page(page);
-		offset =3D 0;
-	}
-
-	iov_iter_advance(iter, size - left);
-	return ret;
-}
-
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1295,10 +1280,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct=
 iov_iter *iter)
 	}
=20
 	do {
-		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
-			ret =3D __bio_iov_append_get_pages(bio, iter);
-		else
-			ret =3D __bio_iov_iter_get_pages(bio, iter);
+		ret =3D __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
 	/* don't account direct I/O as memory stall */
--=20
2.30.2


