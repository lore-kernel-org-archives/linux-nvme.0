Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69028C00140
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7eLK7n5MSmjwsNp02AHb8YY5HXvpcfFEurh3XLNu31E=; b=cwMZMyLcm3LXzjBN1L0nNop0bQ
	m54xVkLvEAgJr23UGCBJng+rcDhU/wY06MPlFaL7rFqeKholk5oPxt1E7dkBNWmO8hQ8ZSMH2DnTq
	A7qD+z8aF1Xw4taQRXYvb5gq5rHv76iwpu2xjpCKKxqxPElg5rdllbAIPy+CV+1df4OcJx8Drx1LH
	eo6hxFlWtBqY6ttkdcdx9RYjEe5dyHSZHSW23VCy/ftZTfR4TNZEkG7M0s8qm/jf++vQV/p9tQI5z
	af4yPRIAI+KdscaETpq8fZVsgVu7N03PXCSjlMZOLJcQhihJLI306hMiYFVhHFGExL/NtgL8EQcAQ
	9jFPuW8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08n-00GiWO-QI; Fri, 05 Aug 2022 16:25:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08W-00GiOe-5z
	for linux-nvme@bombadil.infradead.org; Fri, 05 Aug 2022 16:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7eLK7n5MSmjwsNp02AHb8YY5HXvpcfFEurh3XLNu31E=; b=bgPjstTldomAPeaOPXuan1I0NJ
	P+H53LocKZoF1loLoeep8E/Rgoe8SnetD6Dsajyk4mVbvGTiiRFPE0wzzSK1MastEGo9TytnEXUGV
	2PTEhaYg4sdUBLOnEbmgISyhFSJ8YgHh3wcj32hLEKLmZXJlR/gm01kEwL3W5iSMwxAVHxEnra7k7
	Z0nMVZZBxYEFEr4U+8UL/4uknZSiZ2wRFx+fhZqfGCREUv9L2Bdeekzz8fddxgYb09FKWYkQrtBWQ
	4ndte+6QMslne8SPl5eXFtOiE8vN02hJ075tD7vXTk81TS0g94HmCt2x7SQuKDGnQWKa4af85+hEI
	yQwtG87Q==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08P-003Igv-RM
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 16:25:18 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275G6qYc012150
	for <linux-nvme@lists.infradead.org>; Fri, 5 Aug 2022 09:24:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7eLK7n5MSmjwsNp02AHb8YY5HXvpcfFEurh3XLNu31E=;
 b=GFCeQG1BSKObhcSU4vgJA4D+79FS9WYu9uXTAU77Ymcyq3KAaYSQ8+T2E9H2F5Wj8U1r
 ISuWFaKvZC0GdEPM3+ETCUBDwMZ0WUwcS4nzhYCXCQ6ZpGNP93gi6b1njnTj6CerHn1V
 FkRY1HJrbVe8lpCrqa0l72JTbm1fVAGR3Z0= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hs3cf1d7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 05 Aug 2022 09:24:57 -0700
Received: from twshared33626.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 09:24:55 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D1D317037505; Fri,  5 Aug 2022 09:24:45 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <Kernel-team@fb.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/7] iov_iter: introduce type for preregistered dma tags
Date: Fri, 5 Aug 2022 09:24:40 -0700
Message-ID: <20220805162444.3985535-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220805162444.3985535-1-kbusch@fb.com>
References: <20220805162444.3985535-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VKczMqt0qwFGwsAVtc3RomHuXyPjU77a
X-Proofpoint-GUID: VKczMqt0qwFGwsAVtc3RomHuXyPjU77a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_09,2022-08-05_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_172514_584852_686107D9 
X-CRM114-Status: GOOD (  20.69  )
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

Introduce a new iov_iter type representing a pre-registered DMA address
tag. The tag is an opaque cookie specific to the lower level driver that
created it, and can be referenced at any arbitrary offset.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/uio.h |  9 +++++++++
 lib/iov_iter.c      | 27 ++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 34ba4a731179..a55e4b86413a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -26,6 +26,7 @@ enum iter_type {
 	ITER_PIPE,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMA_TAG,
 };
=20
 struct iov_iter_state {
@@ -46,6 +47,7 @@ struct iov_iter {
 		const struct bio_vec *bvec;
 		struct xarray *xarray;
 		struct pipe_inode_info *pipe;
+		void *dma_tag;
 	};
 	union {
 		unsigned long nr_segs;
@@ -85,6 +87,11 @@ static inline bool iov_iter_is_bvec(const struct iov_i=
ter *i)
 	return iov_iter_type(i) =3D=3D ITER_BVEC;
 }
=20
+static inline bool iov_iter_is_dma_tag(const struct iov_iter *i)
+{
+	return iov_iter_type(i) =3D=3D ITER_DMA_TAG;
+}
+
 static inline bool iov_iter_is_pipe(const struct iov_iter *i)
 {
 	return iov_iter_type(i) =3D=3D ITER_PIPE;
@@ -229,6 +236,8 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int d=
irection, const struct kvec
 			unsigned long nr_segs, size_t count);
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const str=
uct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
+void iov_iter_dma_tag(struct iov_iter *i, unsigned int direction, void *=
dma_tag,
+			unsigned int dma_offset, size_t count);
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pi=
pe_inode_info *pipe,
 			size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t=
 count);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 507e732ef7cf..ebdf81473526 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1070,6 +1070,9 @@ void iov_iter_advance(struct iov_iter *i, size_t si=
ze)
 		iov_iter_iovec_advance(i, size);
 	} else if (iov_iter_is_bvec(i)) {
 		iov_iter_bvec_advance(i, size);
+	} else if (iov_iter_is_dma_tag(i)) {
+		i->iov_offset +=3D size;
+		i->count -=3D size;
 	} else if (iov_iter_is_pipe(i)) {
 		pipe_advance(i, size);
 	} else if (unlikely(iov_iter_is_xarray(i))) {
@@ -1201,6 +1204,21 @@ void iov_iter_bvec(struct iov_iter *i, unsigned in=
t direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
=20
+void iov_iter_dma_tag(struct iov_iter *i, unsigned int direction,
+			void *dma_tag, unsigned int dma_offset,
+			size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i =3D (struct iov_iter){
+		.iter_type =3D ITER_DMA_TAG,
+		.data_source =3D direction,
+		.dma_tag =3D dma_tag,
+		.iov_offset =3D dma_offset,
+		.count =3D count
+	};
+}
+EXPORT_SYMBOL(iov_iter_dma_tag);
+
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 			struct pipe_inode_info *pipe,
 			size_t count)
@@ -1335,6 +1353,9 @@ bool iov_iter_is_aligned(const struct iov_iter *i, =
unsigned addr_mask,
 	if (iov_iter_is_bvec(i))
 		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
=20
+	if (iov_iter_is_dma_tag(i))
+		return !(i->iov_offset & addr_mask);
+
 	if (iov_iter_is_pipe(i)) {
 		unsigned int p_mask =3D i->pipe->ring_size - 1;
 		size_t size =3D i->count;
@@ -2124,8 +2145,8 @@ EXPORT_SYMBOL(import_single_range);
  */
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
-	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i)) &&
-			 !iov_iter_is_kvec(i))
+	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
+			 !iov_iter_is_dma_tag(i)) && !iov_iter_is_kvec(i))
 		return;
 	i->iov_offset =3D state->iov_offset;
 	i->count =3D state->count;
@@ -2141,7 +2162,7 @@ void iov_iter_restore(struct iov_iter *i, struct io=
v_iter_state *state)
 	BUILD_BUG_ON(sizeof(struct iovec) !=3D sizeof(struct kvec));
 	if (iov_iter_is_bvec(i))
 		i->bvec -=3D state->nr_segs - i->nr_segs;
-	else
+	else if (!iov_iter_is_dma_tag(i))
 		i->iov -=3D state->nr_segs - i->nr_segs;
 	i->nr_segs =3D state->nr_segs;
 }
--=20
2.30.2


