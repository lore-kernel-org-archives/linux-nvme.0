Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9A1C3DA7E
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jul 2024 00:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nGqkeFAkbcv4z8RCf1qr4WxfwwRLNp08umo4uiv1YFc=; b=JjUH6TDyoYCy5kTnvthGmiK+yQ
	bdDM5wjc1Y8B7Nm9e5Gs8it7GNMHbJBq61Wz0nGB3SnRZrW3VNxvXx2QTPiDSI+MuB1HJoPtEig6C
	8IK5BBlGGr+9K4CgLl5FSNTkocorTQx6FMDmikLwc1/iVfnAwGLvjCZp2kd20TxKkGID6F8WK4N5Z
	ydQTbWdgiqyeVFUpS8LsxZNfyQuBeUV/zzq+Fc0GVzTF4qaQTp9OkWjQp9gScLiNjznIkVP8gSa9r
	Z9qXEwzbIHjTwVlswYfSEV0j3JN9q/Z/6ppp6Xg2cTZ9WykUlSmZBLLFte7fV2djcxkaHNnhu/hPP
	63j+F2yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXs5p-00000007Z75-2yDn;
	Sun, 28 Jul 2024 00:48:57 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXs5d-00000007Z1I-3NuD
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jul 2024 00:48:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0B449CE0929;
	Sun, 28 Jul 2024 00:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DA8C4AF0F;
	Sun, 28 Jul 2024 00:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127723;
	bh=OP4Jz20guFdytwqiSyJYMbytLrEavIFQ99UdbvUPhO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbLCZgVKQvHzZPnEULyKfkMXvccc5miJWxFgPRQ3/STLpGvlmN8zzUSi9xcYDlLPB
	 q1SGP3MNZIT+yJ1zBxEhWZX+YPaUZhUQAkNWA95OaROmTcU/yNCagy95+fDwdFPwtr
	 UQM6UROVNOogF+HA3avYdD1kRHo5t5tPVVgy2EmNiV2Y6++fRyqzm+BEOangIG3t57
	 3F36fL8oGtA1hzAmcKQTGnSXo89zQgELfpZ9XlFxSYArt6i/SW084Jgl97ode8+T6D
	 5ASL7S+9N5ruo2kDbVig7sjckR0QahbYARbT1JR7L4yATWT1oNYpFnUP9N+VtFckbu
	 hnMlJUdvlX3rA==
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
Subject: [PATCH AUTOSEL 6.1 6/8] block: change rq_integrity_vec to respect the iterator
Date: Sat, 27 Jul 2024 20:48:28 -0400
Message-ID: <20240728004831.1702511-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004831.1702511-1-sashal@kernel.org>
References: <20240728004831.1702511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240727_174846_240033_7E58CEDF 
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
index 32e89ea853a47..21712063cbd5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -873,9 +873,9 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
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
@@ -1015,7 +1015,7 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
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


