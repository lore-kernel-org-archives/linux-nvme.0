Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59F7C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQ8NFFnrfR/LxjP0ImdEIBDB39CcwzRHlHhlzG8LKL0=; b=cwOmDTTBUlhR6EqlCTp6PoTyqI
	b2g4MuVNMB0wuwW32uksxXXDqz5Mpf15hcdoRsxD7IAi2M3Al0rHUgRFiVJIkHoh0/QkITkETFZWY
	TqWrIIQxQNxgb2dqE9GIb2u3B+EvL5UITBiSPFo9EbV0I7CZksRFLRrnKl5wtCzpvEyYvRgj6E9Je
	zOW6gNUalDofIqDTtec7cFMZcY3BCH329g6PNThQFhbHg3gc3eNPHdMUwrDLQm9X1Y0WYEdnuLXOq
	6t1yxCyuoN/B3eEPGSfw341Jl7DdG1xdvYT4eaAeVJcwgFZ5mjcRI0DDFlcT4tugt1nB8hKEtmTXY
	8IwJrv+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Qc-00000008j3o-1N4R;
	Sat, 04 Jul 2026 19:53:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6QX-00000008j2f-1Yw1
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:53:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 246204373A;
	Sat,  4 Jul 2026 19:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04741F000E9;
	Sat,  4 Jul 2026 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194805;
	bh=zQ8NFFnrfR/LxjP0ImdEIBDB39CcwzRHlHhlzG8LKL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GaWuNgIbCwmzP/42S9NjcYrEKh2oUpGrkIAKeT20J6b1vRH4wcKKjaPAek2aTwMeQ
	 pcr4Byu3MTJJlaWTMeqmVIqfcbjXVq2+US7UGlbSj59zTH6o6yatGKs+z6pDbJysmN
	 QhvYmsxxLbDiaXEseGwF4BD158z4u9o6dB9/p3JvLqCsitCuxqdwoQPFIMqaWj9zpi
	 +5z1Rp8rIjathQmJYXiSGDJca6vTkzlOHZ2NB86clARjAPpiBpiqy9RYPjeas9GdTc
	 BqhNcE5+57HLidXrJwJPAiIYDOZ3hr3s6j0Y6u8Ih8w1PvPidZNL4uJuH5Dp0SDtZy
	 eWs+RLcFRHQDQ==
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
Subject: [RFC PATCH v1 09/17] dm bufio: avoid blkg association from GFP_NOWAIT bio init
Date: Sun,  5 Jul 2026 03:51:16 +0800
Message-ID: <20260704195124.1375075-10-yukuai@kernel.org>
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

dm-bufio allocates a bio with bio_kmalloc(GFP_NOWAIT) and then initializes it
with the target bdev.  That initialization can attach blkcg state and sleep to
create a missing blkg once blkg lookup is protected by q->blkcg_mutex.

Initialize the bio without a bdev, set the bdev fields, and associate blkcg
with nowait=true.  Fall back to dm_io if a missing blkg would need to be
created.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-bufio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 26fedf5883ef..2002d9020dd6 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1347,7 +1347,14 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		use_dmio(b, op, sector, n_sectors, offset, ioprio);
 		return;
 	}
-	bio_init_inline(bio, b->c->bdev, 1, op);
+	bio_init_inline(bio, NULL, 1, op);
+	bio_set_dev_no_blkg(bio, b->c->bdev);
+	if (!bio_associate_blkg(bio, true)) {
+		bio_uninit(bio);
+		kfree(bio);
+		use_dmio(b, op, sector, n_sectors, offset, ioprio);
+		return;
+	}
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
-- 
2.51.0


