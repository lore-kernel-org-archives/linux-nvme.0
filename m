Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E086CCD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTSyL/LpaRpyHSI+P/nV+oZG1H26xv9fjmm1fXQdMng=; b=wknqVvTwD1ZZsbDOjlqYbIAghi
	hcyK5LSIeFyakEgPjF9n3WcdhLWV99PFFwS1+3E7HL/Lo2vN4E5S4CP8AM5r9zu2aljivMiVyTrPi
	o3gPmZMINQt8OQkkP+3uoQw7NA2rs/YcP6FXqnnSxQ5S+JK71Kn1uUccnnZqtm0h/YHKSoh5sRexd
	Z0Pue5bOR4avKJedWbQunhhBroi1WXhBQR+4Ad+xBjIH2MA9PDBW4b/08WWmVbsN78YNr8GMIdFmq
	4xndjjPE4Xkv+GqVQvxqhQjfJHs6qImkXGxA+A1hAbMgHyLiC7e5QC2ZeTIE5yGfkr32wnC2tWx5R
	xnTXRmog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuO-00000004NeY-3NpB;
	Wed, 27 May 2026 15:11:00 +0000
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuM-00000004Nbf-44gl;
	Wed, 27 May 2026 15:10:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] bvec: make the bvec_iter helpers inline functions
Date: Wed, 27 May 2026 17:10:22 +0200
Message-ID: <20260527151043.2349900-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527151043.2349900-1-hch@lst.de>
References: <20260527151043.2349900-1-hch@lst.de>
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

The macros are impossible to follow due to the lack of visual type
information and all the braces.  Replace them with inline helpers to
improve on that.  Because the calling conventions are a bit problematic
with a lot of passing structures by value, all the helpers are marked
as __always_inline so that they are force inlined.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/bvec.h | 101 +++++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 37 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d36dd476feda..f4c7ec282ac9 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -104,51 +104,78 @@ struct bvec_iter_all {
 	unsigned	done;
 };
 
-/*
- * various member access, note that bio_data should of course not be used
- * on highmem page vectors
- */
-#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
+static __always_inline const struct bio_vec *
+__bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return bvecs + iter.bi_idx;
+}
 
 /* multi-page (mp_bvec) helpers */
-#define mp_bvec_iter_page(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_page)
+static __always_inline struct page *
+mp_bvec_iter_page(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return __bvec_iter_bvec(bvecs, iter)->bv_page;
+}
 
-#define mp_bvec_iter_len(bvec, iter)				\
-	min((iter).bi_size,					\
-	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
+static __always_inline unsigned int
+mp_bvec_iter_len(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return min(__bvec_iter_bvec(bvecs, iter)->bv_len - iter.bi_bvec_done,
+			iter.bi_size);
+}
 
-#define mp_bvec_iter_offset(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
+static __always_inline unsigned int
+mp_bvec_iter_offset(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return __bvec_iter_bvec(bvecs, iter)->bv_offset + iter.bi_bvec_done;
+}
 
-#define mp_bvec_iter_page_idx(bvec, iter)			\
-	(mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
+static __always_inline unsigned int
+mp_bvec_iter_page_idx(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return mp_bvec_iter_offset(bvecs, iter) / PAGE_SIZE;
+}
 
-#define mp_bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= mp_bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= mp_bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= mp_bvec_iter_offset((bvec), (iter)),	\
-})
+static __always_inline struct bio_vec
+mp_bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return (struct bio_vec) {
+		.bv_page	= mp_bvec_iter_page(bvecs, iter),
+		.bv_len		= mp_bvec_iter_len(bvecs, iter),
+		.bv_offset	= mp_bvec_iter_offset(bvecs, iter),
+	};
+}
 
 /* For building single-page bvec in flight */
- #define bvec_iter_offset(bvec, iter)				\
-	(mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
-
-#define bvec_iter_len(bvec, iter)				\
-	min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),		\
-	      PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
-
-#define bvec_iter_page(bvec, iter)				\
-	(mp_bvec_iter_page((bvec), (iter)) +			\
-	 mp_bvec_iter_page_idx((bvec), (iter)))
-
-#define bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
-})
+static __always_inline unsigned int
+bvec_iter_offset(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return mp_bvec_iter_offset(bvecs, iter) % PAGE_SIZE;
+}
+
+static __always_inline unsigned int
+bvec_iter_len(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return min(mp_bvec_iter_len(bvecs, iter),
+			PAGE_SIZE - bvec_iter_offset(bvecs, iter));
+}
+
+static __always_inline struct page *
+bvec_iter_page(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return mp_bvec_iter_page(bvecs, iter) +
+		mp_bvec_iter_page_idx(bvecs, iter);
+}
+
+static __always_inline struct bio_vec
+bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return (struct bio_vec) {
+		.bv_page	= bvec_iter_page(bvecs, iter),
+		.bv_len		= bvec_iter_len(bvecs, iter),
+		.bv_offset	= bvec_iter_offset(bvecs, iter),
+	};
+}
 
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)
-- 
2.53.0


