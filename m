Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CDEC27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=H5PrZC3wARxzuDSS35YKymK2QxWjB5gAOd2JPIJ8IIs=; b=SpEn5H2+yVZkY96+pItj6imIb8
	rSYoO4FrLHwn4pNAXFEi2/NIsGlPZH8/1qdS4Th9c3weB/PIHcM1KlrucgZs3JTrr97/hJP7ZnNqI
	SiCjNZ3NKP4pAmTChXQdSZ9x+XsPjN7uYxEgBNBfoYobEbMwZfPzhpiRf/aHKiXpJSaECZRvYoR83
	mj6vuQaQeaEPaGcPUdQ6TVH6W/qVu8kfGlsoPQICLnCocSD44UOuAw9i89BwZIytM7lV35jMUeIXO
	84x+KgPHQ28rZIknLhHzj+c8BHSm30K6GTsmTr7jn4mVkBFnrx+mJ22Z2g8437usYtht4GaGUYrF9
	8FuUCIUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdAN-00000004o7o-0UnH;
	Mon, 10 Jun 2024 11:26:23 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdAI-00000004o6z-45k0
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 11:26:21 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240610112610epoutp04743b080367193cf518b882adf9862364~XoPg6osLT0835608356epoutp04F
	for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 11:26:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240610112610epoutp04743b080367193cf518b882adf9862364~XoPg6osLT0835608356epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718018770;
	bh=H5PrZC3wARxzuDSS35YKymK2QxWjB5gAOd2JPIJ8IIs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=e+4T9GWeszLRABgHfvTID+VNQIVrLFPoA9dKS+RwWVsr/J4DVrpaEOrp4jegl5l4B
	 /pyXfDSejEANhTjjXBDQEnkx8lWaN4u8zZkrdp3WJFvIUw+1UP6PV90X1ILLDgDeC8
	 tXZOJX2IYU+ADCHqN9TYyxWDb1Pb4+clecuziDBY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240610112610epcas5p28caefce5679b80e6d39304920f68c5b2~XoPggFFwi2826128261epcas5p2H;
	Mon, 10 Jun 2024 11:26:10 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VyTyS5LZNz4x9Q7; Mon, 10 Jun
	2024 11:26:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.C1.19174.0D2E6666; Mon, 10 Jun 2024 20:26:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7~XoJphKCI72514725147epcas5p1A;
	Mon, 10 Jun 2024 11:19:27 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610111927epsmtrp103c1ea7595d63bd46982c4db7082296c~XoJpghO3o1035010350epsmtrp1u;
	Mon, 10 Jun 2024 11:19:27 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-e3-6666e2d0d7d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.46.18846.F31E6666; Mon, 10 Jun 2024 20:19:27 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610111926epsmtip28a89bb83cdd1c4828647a6575ce84c2f~XoJoTr_aK0849908499epsmtip2N;
	Mon, 10 Jun 2024 11:19:26 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v3] block: unmap and free user mapped integrity via
 submitter
Date: Mon, 10 Jun 2024 16:41:44 +0530
Message-Id: <20240610111144.14647-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmuu6FR2lpBiuWqVg0TfjLbLH6bj+b
	xcrVR5ksjv5/y2Yx6dA1Rou9t7Qt5i97ym6x/Pg/JgcOj8tnSz02repk89i8pN5j980GNo+P
	T2+xePRtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
	qq2Si0+ArltmDtBJSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
	dL281BIrQwMDI1OgwoTsjCcPTzAV3FKt2PX9JFMD41n5LkZODgkBE4nrPz8zdzFycQgJ7GGU
	+LZwEiuE84lR4uOmaywgVWBO1xltmI6b7fsZIYp2Mkr8Pv6KEaLoM6PE/nW8IDabgLrEkeet
	YHERgQCJWaevgDUwC3QySvzqugeWEBbwl/g87QIziM0ioCrxbv8NVhCbV8BSYvnvCUwQ2+Ql
	Zl76zg4RF5Q4OfMJ2EXMQPHmrbPB7pYQuMUusefDVTaIBheJmddfsEPYwhKvjm+BsqUkXva3
	QdnpEj8uP4VaUCDRfGwfI4RtL9F6qh9oKAfQAk2J9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SO
	eTC2kkT7yjlQtoTE3nMNULaHxIPFp5ggARQr0fH3GtMERvlZSN6ZheSdWQibFzAyr2KUSi0o
	zk1PTTYtMNTNSy2Hx2xyfu4mRnDS1ArYwbh6w1+9Q4xMHIyHGCU4mJVEeIUyktOEeFMSK6tS
	i/Lji0pzUosPMZoCA3kis5Rocj4wbeeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2a
	WpBaBNPHxMEp1cCU+vtjwYO0k5t/tofHqycq7KksL/6aGtiR7y65iid20fqy32cPK7mwvAhp
	n1zn2Mp/YqrB8Tu3BRcGHAznvd6SHrIi+23jpFDRoJTTOzqUxT9xreZ9cMztbEW0uKDZihzO
	Wrbf91ctj+Z73BXN9eBR/JMrLeEKCtc0048c3LOZUX97/FmZY1pHvsRf3HW8N/VwvB7L/wKf
	TQKSHtm73i9fo+EuKLL/8Rwl5cgtZ1YUHv9ou8DyyOWbj8QjhLsrQ5vE5A8/M/RfoPW8LHjB
	UaNPW29qqT7Iu6+zXfSqw/klJSIKqgtPuknsz/nocINt84z3oovN/1/se3ug4OXKCM0e9jeL
	oh8bLalcffPpizVsSizFGYmGWsxFxYkAScRBaiMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvK79w7Q0g/NntS2aJvxltlh9t5/N
	YuXqo0wWR/+/ZbOYdOgao8XeW9oW85c9ZbdYfvwfkwOHx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvjycMTTAW3VCt2fT/J1MB4Vr6LkZNDQsBE
	4mb7fsYuRi4OIYHtjBJ32r+zQyQkJE69XMYIYQtLrPz3nB2i6COjxO4N3WwgCTYBdYkjz1uB
	ijg4RARCJHqOmIDUMAv0MkocebGfBaRGWMBX4tzif2CDWARUJd7tv8EKYvMKWEos/z2BCWKB
	vMTMSxCLeQUEJU7OfALWywwUb946m3kCI98sJKlZSFILGJlWMYqmFhTnpucmFxjqFSfmFpfm
	pesl5+duYgSHrVbQDsZl6//qHWJk4mA8xCjBwawkwiuUkZwmxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwBRknR/UuUXPQPw6txX7s4qcBSsvvfmWoPim
	5BF3c0atqHrPuqsbP1m3nI75UHfiFturpvdTDht9nPZyCvOys5/rpGZ/7eZvEBfxusd88M35
	6oiW+cri3zndOW04bL/rWx8zE3XnPGDeI70mm2tu/axnutcT2rzaj049MvVg+vvfbx+eWmh+
	9WPRzMbjesmn15w3POH1hNXIqNVy8xIrlwq/K8e3L3Z+tsGsd+7zeu0w1rxvvc9TPZwS8xVX
	HgpfonE651l0pPNGRnup79Lr00K3Z8q3vK07/WdjMtdOfqvC0+c31d1itgxrsDzCNCu+ZrPS
	yXpGEWOrkpUbvnwRfeGqxe8mcPyGziqeT9sMUpVYijMSDbWYi4oTAUEb6QTKAgAA
X-CMS-MailID: 20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7
References: <CGME20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_042619_784422_C9D9AC09 
X-CRM114-Status: GOOD (  20.64  )
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

The user mapped intergity is copied back and unpinned by
bio_integrity_free which is a low-level routine. Do it via the submitter
rather than doing it in the low-level block layer code, to split the
submitter side from the consumer side of the bio.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c     | 26 ++++++++++++++++++++++++--
 drivers/nvme/host/ioctl.c | 15 +++++++++++----
 include/linux/bio.h       |  4 ++++
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961e..8b528e12136f 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -144,16 +144,38 @@ void bio_integrity_free(struct bio *bio)
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct bio_set *bs = bio->bi_pool;
 
+	if (bip->bip_flags & BIP_INTEGRITY_USER)
+		return;
 	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
 		kfree(bvec_virt(bip->bip_vec));
-	else if (bip->bip_flags & BIP_INTEGRITY_USER)
-		bio_integrity_unmap_user(bip);
 
 	__bio_integrity_free(bs, bip);
 	bio->bi_integrity = NULL;
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
 
+/**
+ * bio_integrity_unmap_free_user - Unmap and free bio user integrity payload
+ * @bio:	bio containing bip to be unmapped and freed
+ *
+ * Description: Used to unmap and free the user mapped integrity portion of a
+ * bio. Submitter attaching the user integrity buffer is responsible for
+ * unmapping and freeing it during completion.
+ */
+void bio_integrity_unmap_free_user(struct bio *bio)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bio_set *bs = bio->bi_pool;
+
+	if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
+		return;
+	bio_integrity_unmap_user(bip);
+	__bio_integrity_free(bs, bip);
+	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
+}
+EXPORT_SYMBOL(bio_integrity_unmap_free_user);
+
 /**
  * bio_integrity_add_page - Attach integrity metadata
  * @bio:	bio to update
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 499a8bb7cac7..2dff5933cae9 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -111,6 +111,13 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
+static void nvme_unmap_bio(struct bio *bio)
+{
+	if (bio_integrity(bio))
+		bio_integrity_unmap_free_user(bio);
+	blk_rq_unmap_user(bio);
+}
+
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, struct io_uring_cmd *ioucmd, unsigned int flags)
@@ -157,7 +164,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 out_unmap:
 	if (bio)
-		blk_rq_unmap_user(bio);
+		nvme_unmap_bio(bio);
 out:
 	blk_mq_free_request(req);
 	return ret;
@@ -195,7 +202,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (bio)
-		blk_rq_unmap_user(bio);
+		nvme_unmap_bio(bio);
 	blk_mq_free_request(req);
 
 	if (effects)
@@ -406,7 +413,7 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	if (pdu->bio)
-		blk_rq_unmap_user(pdu->bio);
+		nvme_unmap_bio(pdu->bio);
 	io_uring_cmd_done(ioucmd, pdu->status, pdu->result, issue_flags);
 }
 
@@ -432,7 +439,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	 */
 	if (blk_rq_is_poll(req)) {
 		if (pdu->bio)
-			blk_rq_unmap_user(pdu->bio);
+			nvme_unmap_bio(pdu->bio);
 		io_uring_cmd_iopoll_done(ioucmd, pdu->result, pdu->status);
 	} else {
 		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d5379548d684..818e93612947 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -731,6 +731,7 @@ static inline bool bioset_initialized(struct bio_set *bs)
 		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
 
 int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len, u32 seed);
+void bio_integrity_unmap_free_user(struct bio *bio);
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
@@ -807,6 +808,9 @@ static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
 {
 	return -EINVAL;
 }
+static inline void bio_integrity_unmap_free_user(struct bio *bio)
+{
+}
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-- 
2.25.1


