Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5013BC3DA4A
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jul 2024 00:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v+4jRn09kkTxBMZIc3IY7seCpX62rPXtVeyTvtT1rVg=; b=gEk0iMa//WYwb345x1KKTplzDI
	/qxOReLx/IE64ZtkoXMlhHeYWTzIxzFBxQ6wP2/DSA6o5Xs6OOHOPRsgJEm5L+lBOpl3rJNhI2947
	Il7Ls5jZsZ9YtEvV9IHvp06dfvFYxOvPwh8o01B5MxfEHKniWdx2p2A2PMiuyo9J6b0dF0HWIayua
	WfsVv/FaPrcfhiDt7+stv+6P1Wf+RPZqrP0VCsC6fdxGjDg9C/BjHcj6zat6miicwMZvYY4BLwufW
	wKajFmKm2dEiGCYT4mFYlj1IRgoyXg/ggyB9abz9ljE3lPJh66b/auXwUQIGvTYz5t8aqNKQTaygK
	6oeRqu/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXs5o-00000007Z6Y-3n8l;
	Sun, 28 Jul 2024 00:48:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXs5L-00000007YvB-18t1
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jul 2024 00:48:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 61A266108E;
	Sun, 28 Jul 2024 00:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB893C4AF0F;
	Sun, 28 Jul 2024 00:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127706;
	bh=cCrF0eILIbTULWrteyOh0RqBozS/DkpMy1BxsHTqIv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POIQAdT43Biw89AifVJcWKTqu6bM68+H6X17bAY1pCZSpkzKDUm7W8z52K/3dcJ1n
	 P9k43RqJTMDmZRKT987tO+hfvWitcsBatIbbfG3Fy/an9+V6ImClGVkLiVO5whNND1
	 cLnlMpYITSnRF3C+90HHwYT8F9i3rPmGlSJV2PluH/jNxvfSTMWCkxJ7Umn7g4VDGX
	 1rsQ57DOp6KfhfUuxhLiszVRxgM7LBMt1l81i+VMdNFXvhVxHxciQUHtymH30AtKyo
	 820o8DhgFZBtY1a1uwyAwcPaPstM9Idcc8R8ATYPdGe3/DsbTCPZSUjwn0Lur4EVdx
	 iCxjK/ji2pz7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 7/9] block: change rq_integrity_vec to respect the iterator
Date: Sat, 27 Jul 2024 20:48:08 -0400
Message-ID: <20240728004812.1701139-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004812.1701139-1-sashal@kernel.org>
References: <20240728004812.1701139-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240727_174827_468853_9BBB0171 
X-CRM114-Status: GOOD (  18.38  )
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit cf546dd289e0f6d2594c25e2fb4e19ee67c6d988 ]

If we allocate a bio that is larger than NVMe maximum request size,
attach integrity metadata to it and send it to the NVMe subsystem, the
integrity metadata will be corrupted.

Splitting the bio works correctly. The function bio_split will clone the
bio, trim the iterator of the first bio and advance the iterator of the
second bio.

However, the function rq_integrity_vec has a bug - it returns the first
vector of the bio's metadata and completely disregards the metadata
iterator that was advanced when the bio was split. Thus, the second bio
uses the same metadata as the first bio and this leads to metadata
corruption.

This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
instead of returning the first vector. mp_bvec_iter_bvec reads the
iterator and uses it to build a bvec for the current position in the
iterator.

The "queue_max_integrity_segments(rq->q) > 1" check was removed, because
the updated rq_integrity_vec function works correctly with multiple
segments.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c       |  6 +++---
 include/linux/blk-integrity.h | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710fd4d862520..c2f53267cb8c3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -826,9 +826,9 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio_vec bv = rq_integrity_vec(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
-			rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -968,7 +968,7 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+			       rq_integrity_vec(req).bv_len, rq_dma_dir(req));
 	}
 
 	if (blk_rq_nr_phys_segments(req))
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 378b2459efe2d..69f73d0546118 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -105,14 +105,13 @@ static inline bool blk_integrity_rq(struct request *rq)
 }
 
 /*
- * Return the first bvec that contains integrity data.  Only drivers that are
- * limited to a single integrity segment should use this helper.
+ * Return the current bvec that contains the integrity data. bip_iter may be
+ * advanced to iterate over the integrity data.
  */
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
-	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
-		return NULL;
-	return rq->bio->bi_integrity->bip_vec;
+	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
+				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
@@ -178,7 +177,8 @@ static inline int blk_integrity_rq(struct request *rq)
 
 static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 {
-	return NULL;
+	/* the optimizer will remove all calls to this function */
+	return (struct bio_vec){ };
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 #endif /* _LINUX_BLK_INTEGRITY_H */
-- 
2.43.0


