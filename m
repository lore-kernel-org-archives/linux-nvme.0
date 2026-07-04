Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AD2C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OOX++ewQg78wECJAGHPUeEMc5Quzv2keNF1I002bjOw=; b=P6XHqiAj5To26+7UJlKnEOTBWT
	pyKYweJ93eP8jm7rRdMR6wyDEOGRc7ryoYk1hNdZk92RldN/UV2OUMuhhPCekAfM75f9uGTFIkEDs
	wPdDJXGFDJcgBJE5Hb2kRxhWk7LEO897UqPPzgQp+6SeqEnE3DGjevL6peilGhHqMjDMapI9o8Qio
	shEZwYTDHjSefFRJhL7gXeHvSD44z3EfkWa7vl9szuYOVdMc+kK0lC8CSGnO3jE1s4fKAHRjzWDsq
	5KPeudspRg+JUeHroZdbh0DSLfK6edjjG/C63vt57PWTs20WzZUvw5puZBjxfTFe7d63LtLVU+Hqf
	FCp2jgzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6QT-00000008izz-2BrL;
	Sat, 04 Jul 2026 19:53:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6QQ-00000008izP-42EV
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:53:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A66461373;
	Sat,  4 Jul 2026 19:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF5A1F00A3A;
	Sat,  4 Jul 2026 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194798;
	bh=OOX++ewQg78wECJAGHPUeEMc5Quzv2keNF1I002bjOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+c6rGkyEMK6P9/fA3zL0Y4SHxsybxvP8Hqa6uJbUpkEt0wyim3m5oDHLweWoaDRD
	 rKsp4lY6RdY780yCDOrQPuLst/K1KHE92XxDnkPPVWp4TbxSSst1IA7UROSkgHc7jn
	 7U5cDoLQZCXdaXND3yBanJSkpMWzTeuu9gXK6L8ahDj2rRS/upcEDxaPqQBtn91Q38
	 eqwN57qpnvjXN7VwSA68WIxP61VGgk+OpAK6TIAqC+F+77Ov7un0Nc9Ek6gzk/jLxP
	 J6U9pxL7ZmsZOJsmxKzjRtgtcvntzZX0oqHu/rXzhZZfX9JMSASMUJCQ3IhPyFstHL
	 A7P7rXlca+5rw==
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
Subject: [RFC PATCH v1 08/17] bcache: avoid sleeping blkg association from locked paths
Date: Sun,  5 Jul 2026 03:51:15 +0800
Message-ID: <20260704195124.1375075-9-yukuai@kernel.org>
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

cached_dev_cache_miss() allocates cache_bio with GFP_NOWAIT.  Passing a bdev
to bio_alloc_bioset() can attach blkcg state and sleep to create a missing
blkg after blkg lookup is protected by q->blkcg_mutex.

Use the nowait bio allocation/association path.  If the cache bio needs a
missing blkg to be created, fail the association and fall back to the existing
miss submission path.

journal_write_unlocked() also resets journal bios while holding the journal
spinlock.  Reset those bios without a bdev, set bi_bdev while still under the
lock, and associate blkcg after dropping the lock.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/bcache/journal.c | 9 ++++++---
 drivers/md/bcache/request.c | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 144693b7c46a..49d2fb9a5f20 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -714,8 +714,9 @@ static CLOSURE_CALLBACK(journal_write_unlocked)
 
 		atomic_long_add(sectors, &ca->meta_sectors_written);
 
-		bio_reset(bio, ca->bdev, REQ_OP_WRITE | 
-			  REQ_SYNC | REQ_META | REQ_PREFLUSH | REQ_FUA);
+		bio_reset(bio, NULL, REQ_OP_WRITE | REQ_SYNC | REQ_META |
+			  REQ_PREFLUSH | REQ_FUA);
+		bio->bi_bdev = ca->bdev;
 		bio->bi_iter.bi_sector	= PTR_OFFSET(k, i);
 		bio->bi_iter.bi_size = sectors << 9;
 
@@ -740,8 +741,10 @@ static CLOSURE_CALLBACK(journal_write_unlocked)
 
 	spin_unlock(&c->journal.lock);
 
-	while ((bio = bio_list_pop(&list)))
+	while ((bio = bio_list_pop(&list))) {
+		bio_associate_blkg(bio, false);
 		closure_bio_submit(c, bio, cl);
+	}
 
 	continue_at(cl, journal_write_done, NULL);
 }
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index c2b7a694ea99..647ca5018d07 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -932,6 +932,8 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	if (!cache_bio)
 		goto out_submit;
 
+	if (!bio_clone_blkg_association(cache_bio, miss, true))
+		goto out_put;
 	cache_bio->bi_iter.bi_sector	= miss->bi_iter.bi_sector;
 	cache_bio->bi_iter.bi_size	= s->insert_bio_sectors << 9;
 
-- 
2.51.0


