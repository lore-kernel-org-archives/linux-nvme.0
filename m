Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE92AC43602
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+BiKm4kVK4oPKVGcsKEfBVImUZcHd9qj5zTEiTKcjs4=; b=N1xOb8uph6y/o8XTnQeeTgytxn
	sxB1546AcQ3TBpbJeNGpNZKcaV5MRYXyiLftKffPigsq+0bH0REexeuxX145x/OF0EzIwAnfF+Wb0
	+WwXtQA7pGux18OYoHwSkzNwbxfCYUzFozBRq8193pt0NekKM7HTzoIzEMo3YaDrpumQErMj7mfLL
	8hnCePhHB01q/naSUANED++F74+x/bivRrWCqFOaKFfW6U/BildEdU1sWTeJEZ8pAr+tSqwKjbxCd
	uYlhrO9x8A1m1PcEsyejHnVWhb9TTVqcGr6+aTzmWgQ9ClFqIoZR99O6prCAMZhMz/qB68ga+V8gM
	gxOG82hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6R2-00000008jD0-2oQh;
	Sat, 04 Jul 2026 19:53:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6R1-00000008jCS-0N86
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:53:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8787E61374;
	Sat,  4 Jul 2026 19:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C477A1F000E9;
	Sat,  4 Jul 2026 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194834;
	bh=+BiKm4kVK4oPKVGcsKEfBVImUZcHd9qj5zTEiTKcjs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnPjrSXoAI1pj9LrT9/YYsJtmp5BA7OGXwpAMroDo3L6eJWrMBi03RQaGLvD9OriC
	 CGw47ifQXwsu6nuSAIceH1OkAeijT15S/VCDrk/EtRqF9POH6jafoU/0XxchU6L9Qq
	 za9TtK25VBeCcT01PxbjLBWuZqZycT8VIaFLEfodUFtirF8RHRmoejk9/yKeDyYMaX
	 mO6hz2zf3Dr7K22UlOxzhJza6AXvQEyjhl4ZHewyxQvmzLsTLXwKmn3SaJTfc0cFOB
	 SoV0Bx1Dk37H7tOJ4DtcHCETnzNadD4VfXYBZSbTsTRE4tc9bg60iuRlCQDHgTqPrt
	 +9Xq1ySEdQ3jw==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	linux-bcache@vger.kernel.org
Subject: [RFC PATCH v1 11/17] block: avoid scheduling from non-blocking helper allocations
Date: Sun,  5 Jul 2026 03:51:18 +0800
Message-ID: <20260704195124.1375075-12-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260704195124.1375075-1-yukuai@kernel.org>
References: <20260704195124.1375075-1-yukuai@kernel.org>
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

From: Yu Kuai <yukuai@fygo.io>

blk_alloc_discard_bio() and blk_rq_map_bio_alloc() can be used with
non-blocking GFP masks.  Their bio allocation now handles bdev association in
nowait mode, so the helpers can pass the target bdev directly and avoid local
open-coded association paths.

The discard helper can also be reached from io_uring with GFP_NOWAIT.  Keep
its long-loop cond_resched() only for blocking callers.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-lib.c | 3 ++-
 block/blk-map.c | 7 +------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 688bc67cbf73..b5645f8f69b6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -56,7 +56,8 @@ struct bio *blk_alloc_discard_bio(struct block_device *bdev,
 	 * discards (like mkfs).  Be nice and allow us to schedule out to avoid
 	 * softlocking if preempt is disabled.
 	 */
-	cond_resched();
+	if (gfpflags_allow_blocking(gfp_mask))
+		cond_resched();
 	return bio;
 }
 
diff --git a/block/blk-map.c b/block/blk-map.c
index 768549f19f97..75c7b864c15a 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -46,14 +46,9 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 		unsigned int nr_vecs, gfp_t gfp_mask)
 {
 	struct block_device *bdev = rq->q->disk ? rq->q->disk->part0 : NULL;
-	struct bio *bio;
 
-	bio = bio_alloc_bioset(bdev, nr_vecs, rq->cmd_flags, gfp_mask,
+	return bio_alloc_bioset(bdev, nr_vecs, rq->cmd_flags, gfp_mask,
 				&fs_bio_set);
-	if (!bio)
-		return NULL;
-
-	return bio;
 }
 
 /**
-- 
2.51.0


