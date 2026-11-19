Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D6606A32C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O9NApnO2;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=dqQxzuxe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=s3gTUBSKHbEfKVIWdTL7aoQee4hjar3Z0u47LY7+snY=; b=O9NApnO2HHXzsG
	AW02eguchHRgTIVbqGeokBUIkUzYfAlVnQzuagZ+P5phn3P7AyfidPNMGNLRnKT/wHIgRPgIdSHqh
	hdpvcmGkmVRtUHQCtwRpaCys2GIBakjFZlPlTvTaz85AtsskX0FmASo0yK8m5R2Kwl9LSXfIHtEoP
	zFZOqDLY7PbVcp8XmV9ZfhbYXbXiC01Z4Ux8c7GAnfqRnqenEa2E547Nh5lL6L1+CfQs+7GPEkKwD
	Z8zod5yuBVy+HrALsTFl4DvaNXHnIaTjxne31hsteeWdwWXDHSWlGh79msdwDromrKFcCOIb1u7mA
	DvbrDr7SalhAyuwuxd+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0dq-0000000Bjn7-43F3;
	Thu, 19 Nov 2026 11:49:26 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0dl-0000000Bjhx-3cBT
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 11:49:23 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261119114919epoutp0259853b02a71e3b27b86bb660a8aa7715~pb_Xvu-0P2808428084epoutp02_
	for <linux-nvme@lists.infradead.org>; Thu, 19 Nov 2026 11:49:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261119114919epoutp0259853b02a71e3b27b86bb660a8aa7715~pb_Xvu-0P2808428084epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795088959;
	bh=s3gTUBSKHbEfKVIWdTL7aoQee4hjar3Z0u47LY7+snY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqQxzuxeRRmh1EFAmYTtlnDzHNy7szmV2NX64ahPOy54B26M25Xz30VI04bYOSF9u
	 Rc5GSlJ1M6YFK2iHf6Sp9rnXXbgVSPbljvzbwmT2AqKQChT6mEQdWCkZnWLwf42PXm
	 48NpZ632c3Yi5bLhjokddHWbtTriJA9f1DimvsLI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261119114919epcas5p35d531a748785348673944fddcd54006d~pb_XN5G2m1102911029epcas5p3C;
	Thu, 19 Nov 2026 11:49:19 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jVcFV1xFDz2SSKb; Thu, 19 Nov
	2026 11:49:18 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261119095725epcas5p3a8e14a90891afe16faded4fb78484b49~pacqyFUJp0437304373epcas5p33;
	Thu, 19 Nov 2026 09:57:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119095723epsmtip17c51681d284e723f2550c9ff004cea68~pacotAQBp2192721927epsmtip1a;
	Thu, 19 Nov 2026 09:57:23 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, asml.silence@gmail.com, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, James.Bottomley@HansenPartnership.com, mkp@kernel.org,
	bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
Subject: [PATCH v4 4/5] block: map dma-buf iterators in
 blk_rq_map_user_iov()
Date: Thu, 19 Nov 2026 15:26:14 +0530
Message-Id: <20261119095615.1840522-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119095615.1840522-1-anuj20.g@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119095725epcas5p3a8e14a90891afe16faded4fb78484b49
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261119095725epcas5p3a8e14a90891afe16faded4fb78484b49
References: <20261119095615.1840522-1-anuj20.g@samsung.com>
	<CGME20261119095725epcas5p3a8e14a90891afe16faded4fb78484b49@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_034922_238326_82B94B43 
X-CRM114-Status: GOOD (  15.75  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A dma-buf iterator can't fall back to a bounce copy, so map it directly
with blk_rq_map_user_bvec(), which already handles it through
bio_iov_iter_set(). Fail with -EINVAL where a copy would otherwise be
needed, and update the blk_rq_map_user_bvec() comment to match.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 7369aba74771..a65b255b229c 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -459,7 +459,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
 
-/* Prepare bio for passthrough IO given ITER_BVEC iter */
+/* Prepare a bio for passthrough I/O from a directly mapped iterator. */
 static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
 	unsigned int max_bytes = rq->q->limits.max_hw_sectors << SECTOR_SHIFT;
@@ -506,6 +506,19 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	struct iov_iter i;
 	int ret = -EINVAL;
 
+	if (iov_iter_is_dmabuf_map(iter)) {
+		if (map_data || (iov_iter_alignment(iter) & align))
+			return -EINVAL;
+		ret = blk_rq_map_user_bvec(rq, iter);
+		/*
+		 * -EREMOTEIO asks the caller to fall back to a bounce copy,
+		 * which a dma-buf can't do.
+		 */
+		if (ret == -EREMOTEIO)
+			ret = -EINVAL;
+		return ret;
+	}
+
 	if (map_data)
 		copy = true;
 	else if (iov_iter_alignment(iter) & align)
-- 
2.25.1


