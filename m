Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A41C54E60
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VjiNJMj6lv6xSOzWYTzvr2i2M7boMMC6hKAnN+ZZj6M=; b=gUaGMQ58CpyDGrbAXz/BOAu4fo
	mJpI36FVMXZsVc9UIVN2dxBB0kojvZIzxckDlGD35rmv5UKZCntfjlw+hClNsPKG48YpSIMLO9YNj
	tXpqS6Rf2wyWpGCjUXad60mF+zEWMuLXF8UD+lxWkwTCXOf3EP03gqdeOXtmO/W1pMngcAg5dL1CT
	jm2UmyfoITVcaxgYSQBXRBsFmtlYGPswm/CsvHHi7XBHwIlv0W4CpZscuPRPFxHO5rQR7USVkQ/9W
	cVI/VN+uQ0iFhNpC1NPkxnGtHDLJZvUpc/cY9DnfLQ5cxuKCnMrWrXS/5QQwK0ZIdYkMrwx+O4v6Z
	SaBYgZ6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qd-00000006D8s-0ynv;
	Tue, 12 Mar 2024 14:48:31 +0000
Received: from [50.226.187.238] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qa-00000006D70-3Udu;
	Tue, 12 Mar 2024 14:48:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 2/5] block: add a bio_chain_and_submit helper
Date: Tue, 12 Mar 2024 08:48:23 -0600
Message-Id: <20240312144826.1045212-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312144826.1045212-1-hch@lst.de>
References: <20240312144826.1045212-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is basically blk_next_bio just with the bio allocation moved
to the caller to allow for more flexible bio handling in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 28 ++++++++++++++++++++--------
 include/linux/bio.h |  1 +
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d24420ed1c4c6f..32ff538b29e564 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -345,18 +345,30 @@ void bio_chain(struct bio *bio, struct bio *parent)
 }
 EXPORT_SYMBOL(bio_chain);
 
-struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
-		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
+/**
+ * bio_chain_and_submit - submit a bio after chaining it to another one
+ * @prev: bio to chain and submit
+ * @new: bio to chain to
+ *
+ * If @prev is non-NULL, chain it to @new and submit it.
+ *
+ * Return: @new.
+ */
+struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 {
-	struct bio *new = bio_alloc(bdev, nr_pages, opf, gfp);
-
-	if (bio) {
-		bio_chain(bio, new);
-		submit_bio(bio);
+	if (prev) {
+		bio_chain(prev, new);
+		submit_bio(prev);
 	}
-
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
+
+struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
+		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
+{
+	return bio_chain_and_submit(bio, bio_alloc(bdev, nr_pages, opf, gfp));
+}
 EXPORT_SYMBOL_GPL(blk_next_bio);
 
 static void bio_alloc_rescue(struct work_struct *work)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 875d792bffff82..643d61b7cb82f7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -824,5 +824,6 @@ static inline void bio_clear_polled(struct bio *bio)
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp);
+struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new);
 
 #endif /* __LINUX_BIO_H */
-- 
2.39.2


