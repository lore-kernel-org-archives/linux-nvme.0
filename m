Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB55C25B79
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkWjcVB2EkqR+PDxGkHHxANmsHb/lfTlVuDnVf1TiSo=; b=qXslYOrJ2Z8hNnKCeBohF1L21r
	wShUECKGHtpmFITE5RDw9zSmxq6PD0idGZ4YbbupsKxl9587Ty/A5lmO4BFTXQO0NIjm0iXIMOvcP
	ijoQx10XX9j/kgW/7PGZRn4Pt4FrHQN53ioel2qx+cXz6bDD2V8chg0CH/UD4YIbOn96vB6ypMROC
	qCCK/qFnIz8FNj2ONhUp5BAeXvDZDyF2Yqf3NR/q8nPRtW5V238ZNZ0Wj4xFwzOWveIvVd4tyyUZQ
	0t4ofYicx3Pd/n0Y9YaHGXEnlnbvgq7QV5zyKdjzZkZgVszOwXBGUnDDy8S1foFVZ1sVPwfKmDytS
	89Oiy7og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7d-0000000GgIc-3ZPr;
	Tue, 14 May 2024 17:39:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7Y-0000000GgCF-1d1w
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:39:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B2DDDCE1265;
	Tue, 14 May 2024 17:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA59C32782;
	Tue, 14 May 2024 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708362;
	bh=nKOQbmAsvRgnkJlMIxmUUs3nh180UwytsivOS6qm4gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sW7ST2nZRp4Av9CDL8V23mKnU7oTtIBdSSH61U5juZ85jhYI+AcUuJKbZ8oRTzzkc
	 yNzxKK04R56Tm3y4e28RkiPrEbCjfZS9/rLwb4I7MV6ZXQ7MmVTh6u7pfieQ92F7DO
	 JyVO4PcvvMBLHvwiZzc85ECea34JQ4fyngtKlc694M9DEETWI0uONbN2er/1L2HiY3
	 LW0i56JD1gVAA3zrZ8pwzjXJQkJRrwzLIJ2DrOWCD8shEQMcmTgu8IFnkDA3IkpMR/
	 kAa1oA9n0aLYaoxUxQ3bOLMGXQaQFsNAcuxdMJfWHf0XAyGgRCOy018ASzpyzF9b9/
	 ThDAJLpycXuAw==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/6] blk-merge: split bio by max_segment_size, not PAGE_SIZE
Date: Tue, 14 May 2024 19:38:57 +0200
Message-Id: <20240514173900.62207-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_103924_737971_050A1DDA 
X-CRM114-Status: GOOD (  11.77  )
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

Bvecs can be larger than a page, and the block layer handles
this just fine. So do not split by PAGE_SIZE but rather by
the max_segment_size if that happens to be larger.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 block/blk-merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4e3483a16b75..570573d7a34f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -278,6 +278,7 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, bytes = 0;
+	unsigned bv_seg_lim = max(PAGE_SIZE, lim->max_segment_size);
 
 	bio_for_each_bvec(bv, bio, iter) {
 		/*
@@ -289,7 +290,7 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
-		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
+		    bv.bv_offset + bv.bv_len <= bv_seg_lim) {
 			nsegs++;
 			bytes += bv.bv_len;
 		} else {
-- 
2.35.3


