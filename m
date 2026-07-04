Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35E1C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IMQbQISVAbhBxGEmQUNEuoIO6XRWj/mUR1OFTwmhoWU=; b=Y3cWdb6Eg2sSxIhANGj4aVK/9o
	HijN+qc0GRlZrmkp6JguQAdJw5OLQts8hEjDHdBXCAJ96mmCGUgWUk3y5GW4uctPC5B7GeA+Cg7U5
	TPGAAa3nfmZigOQyGlZ7x1IDN8bxSeDD7EZSjkm0BUvYWmlaZMJXE/WHcwlmZlaxxVwNA3uAQ8k2s
	jJ/fZ7PfVWEKz0xQlExVEcoSwhPFd9nAzDBFPuNYQ8l7M4q754hP+7QK1KLWnNxV1a2CFHuW3V2OO
	36L3YkWp9KejDt7MtcGBoFNAbPiaBddF66Or6OQza+HuGfRe93zV1i/kjCJD6SJkVQUxtFtQzI8bM
	UcmP+2TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Q8-00000008irp-14U2;
	Sat, 04 Jul 2026 19:53:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Q6-00000008ir2-1qtF
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:52:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 35905417BF;
	Sat,  4 Jul 2026 19:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE8D1F00A3D;
	Sat,  4 Jul 2026 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194778;
	bh=IMQbQISVAbhBxGEmQUNEuoIO6XRWj/mUR1OFTwmhoWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jz0UEcfbtYkG3YhFEXkGKO7nS2alMJXm/TlG0j0X/UUxrEKvCbGGVZ+9YKSSMacyd
	 LVIjPqzBhHVqMdnyyOOL8AVdt+X3tLuqVwZ9sYifW3y9x3jfGKoshPsT3SL5/LrPjT
	 vdjGof8P2a9w51vHxRb8M/vjwnFwQdAK8HVAsvBOTUuerEGaGNQvhwonfYSY2Vf3Ee
	 bOhzJPwrdFbfzuEM+9pfuaGuEeyDDSC6HkLf/nQoN6JQWv8ZtqBQe+K/hM06fSoJ5D
	 KSr69+ZLoySYaecNJqxCBqk/1K33NqhLoGXyt8M+wjWcp5vqkczvQXPg+83dyYodH0
	 IB50yw8KU/vpQ==
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
Subject: [RFC PATCH v1 06/17] blk-cgroup: support non-blocking bio association
Date: Sun,  5 Jul 2026 03:51:13 +0800
Message-ID: <20260704195124.1375075-7-yukuai@kernel.org>
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

Allow bio association helpers to be called from non-blocking paths by
returning whether the association succeeded and by taking a nowait argument.
The normal callers pass nowait=false and keep the existing behavior of
creating missing blkgs.

For nowait=true, the helper only succeeds when the needed blkg already
exists.  This lets callers set or clone a bio's bdev without entering the
sleepable missing-blkg creation path.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bfq-cgroup.c           |  5 ++--
 block/bio.c                  |  6 ++---
 block/blk-cgroup.c           | 44 ++++++++++++++++++++++++---------
 block/blk-crypto-fallback.c  |  2 +-
 drivers/md/bcache/request.c  |  2 +-
 drivers/md/dm.c              |  2 +-
 drivers/md/md.c              |  2 +-
 drivers/nvdimm/nd_virtio.c   |  5 +++-
 fs/gfs2/lops.c               |  3 +--
 fs/ocfs2/cluster/heartbeat.c |  2 +-
 include/linux/bio.h          | 47 ++++++++++++++++++++++++------------
 include/linux/writeback.h    |  2 +-
 mm/page_io.c                 |  2 +-
 13 files changed, 82 insertions(+), 42 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e82ff03bda02..5c2faf56c8ef 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -616,13 +616,14 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
 		}
 		bfqg = blkg_to_bfqg(blkg);
 		if (bfqg->pd.online) {
-			bio_associate_blkg_from_css(bio, &blkg->blkcg->css);
+			bio_associate_blkg_from_css(bio, &blkg->blkcg->css, false);
 			return bfqg;
 		}
 		blkg = blkg->parent;
 	}
 	bio_associate_blkg_from_css(bio,
-				&bfqg_to_blkg(bfqd->root_group)->blkcg->css);
+				&bfqg_to_blkg(bfqd->root_group)->blkcg->css,
+				false);
 	return bfqd->root_group;
 }
 
diff --git a/block/bio.c b/block/bio.c
index f2a5f4d0a967..b74e9961c8ee 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -236,7 +236,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_blkg = NULL;
 	bio->issue_time_ns = 0;
 	if (bdev)
-		bio_associate_blkg(bio);
+		bio_associate_blkg(bio, false);
 #ifdef CONFIG_BLK_CGROUP_IOCOST
 	bio->bi_iocost_cost = 0;
 #endif
@@ -281,7 +281,7 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf)
 	bio->bi_io_vec = bv;
 	bio->bi_bdev = bdev;
 	if (bio->bi_bdev)
-		bio_associate_blkg(bio);
+		bio_associate_blkg(bio, false);
 	bio->bi_opf = opf;
 }
 EXPORT_SYMBOL(bio_reset);
@@ -857,7 +857,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 		if (bio->bi_bdev == bio_src->bi_bdev &&
 		    bio_flagged(bio_src, BIO_REMAPPED))
 			bio_set_flag(bio, BIO_REMAPPED);
-		bio_clone_blkg_association(bio, bio_src);
+		bio_clone_blkg_association(bio, bio_src, false);
 	}
 
 	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d2a1f5903f24..92846094043a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2068,7 +2068,7 @@ static inline struct blkcg_gq *blkg_lookup_tryget(struct blkcg_gq *blkg)
  * up taking a reference on or %NULL if no reference was taken.
  */
 static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
-		struct cgroup_subsys_state *css)
+		struct cgroup_subsys_state *css, bool nowait)
 {
 	struct request_queue *q = bio->bi_bdev->bd_queue;
 	struct blkcg *blkcg = css_to_blkcg(css);
@@ -2110,18 +2110,30 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
  * A reference will be taken on the blkg and will be released when @bio is
  * freed.
  */
-void bio_associate_blkg_from_css(struct bio *bio,
-				 struct cgroup_subsys_state *css)
+bool bio_associate_blkg_from_css(struct bio *bio,
+		struct cgroup_subsys_state *css, bool nowait)
 {
-	if (bio->bi_blkg)
+	struct blkcg_gq *blkg;
+
+	if (!nowait)
+		might_sleep();
+
+	if (bio->bi_blkg) {
 		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
 
 	if (css && css->parent) {
-		bio->bi_blkg = blkg_tryget_closest(bio, css);
+		blkg = blkg_tryget_closest(bio, css, nowait);
+		if (!blkg)
+			return false;
+		bio->bi_blkg = blkg;
 	} else {
 		blkg_get(bdev_get_queue(bio->bi_bdev)->root_blkg);
 		bio->bi_blkg = bdev_get_queue(bio->bi_bdev)->root_blkg;
 	}
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
 
@@ -2134,16 +2146,19 @@ EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
  * already associated, the css is reused and association redone as the
  * request_queue may have changed.
  */
-void bio_associate_blkg(struct bio *bio)
+bool bio_associate_blkg(struct bio *bio, bool nowait)
 {
 	struct cgroup_subsys_state *css;
+	bool ret;
 
 	if (blk_op_is_passthrough(bio->bi_opf))
-		return;
+		return true;
+	if (!bio->bi_bdev)
+		return true;
 
 	if (bio->bi_blkg) {
 		css = bio_blkcg_css(bio);
-		bio_associate_blkg_from_css(bio, css);
+		return bio_associate_blkg_from_css(bio, css, nowait);
 	} else {
 		rcu_read_lock();
 		css = blkcg_css();
@@ -2151,9 +2166,10 @@ void bio_associate_blkg(struct bio *bio)
 			css = NULL;
 		rcu_read_unlock();
 
-		bio_associate_blkg_from_css(bio, css);
+		ret = bio_associate_blkg_from_css(bio, css, nowait);
 		if (css)
 			css_put(css);
+		return ret;
 	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg);
@@ -2163,10 +2179,14 @@ EXPORT_SYMBOL_GPL(bio_associate_blkg);
  * @dst: destination bio
  * @src: source bio
  */
-void bio_clone_blkg_association(struct bio *dst, struct bio *src)
+bool bio_clone_blkg_association(struct bio *dst, struct bio *src, bool nowait)
 {
-	if (src->bi_blkg)
-		bio_associate_blkg_from_css(dst, bio_blkcg_css(src));
+	if (!src->bi_blkg)
+		return true;
+	if (!dst->bi_bdev)
+		return false;
+
+	return bio_associate_blkg_from_css(dst, bio_blkcg_css(src), nowait);
 }
 EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
 
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 2a5c52ab74b4..b99470bee8b6 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -187,7 +187,7 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_write_stream	= bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
-	bio_clone_blkg_association(bio, bio_src);
+	bio_clone_blkg_association(bio, bio_src, false);
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 3fa3b13a410f..c2b7a694ea99 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -848,7 +848,7 @@ static CLOSURE_CALLBACK(cached_dev_read_done)
 		s->iop.bio->bi_iter.bi_sector =
 			s->cache_miss->bi_iter.bi_sector;
 		s->iop.bio->bi_iter.bi_size = s->insert_bio_sectors << 9;
-		bio_clone_blkg_association(s->iop.bio, s->cache_miss);
+		bio_clone_blkg_association(s->iop.bio, s->cache_miss, false);
 		bch_bio_map(s->iop.bio, NULL);
 
 		bio_copy_data(s->cache_miss, s->iop.bio);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7287bed6eb64..c54636235ffe 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1364,7 +1364,7 @@ void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone)
 	if (!tgt_clone)
 		tgt_clone = clone;
 
-	bio_clone_blkg_association(tgt_clone, io->orig_bio);
+	bio_clone_blkg_association(tgt_clone, io->orig_bio, false);
 
 	/*
 	 * Account io->origin_bio to DM dev on behalf of target
diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..d63c8841aaad 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9355,7 +9355,7 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 		return;
 
 	bio_chain(discard_bio, bio);
-	bio_clone_blkg_association(discard_bio, bio);
+	bio_clone_blkg_association(discard_bio, bio, false);
 	mddev_trace_remap(mddev, discard_bio, bio->bi_iter.bi_sector);
 	submit_bio_noacct(discard_bio);
 }
diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 13d1ed1c466c..0391b41a4fce 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -121,7 +121,10 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 		if (!child)
 			return -ENOMEM;
 		child->bi_bdev = bio->bi_bdev;
-			bio_clone_blkg_association(child, bio);
+		if (!bio_clone_blkg_association(child, bio, true)) {
+			bio_put(child);
+			return -ENOMEM;
+		}
 		child->bi_iter.bi_sector = -1;
 		bio_chain(child, bio);
 		submit_bio(child);
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6dabe73ad790..ac45ccbde2a9 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -484,7 +484,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs,
 	struct bio *new;
 
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, opf, GFP_NOIO);
-	bio_clone_blkg_association(new, prev);
+	bio_clone_blkg_association(new, prev, false);
 	new->bi_iter.bi_sector = sector;
 	bio_chain(new, prev);
 	submit_bio(prev);
@@ -1114,4 +1114,3 @@ const struct gfs2_log_operations *gfs2_log_ops[] = {
 	&gfs2_revoke_lops,
 	NULL,
 };
-
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index ec70f3b62837..eb7f30707092 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -537,7 +537,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 		goto bail;
 	}
 	bio->bi_bdev = reg_bdev(reg);
-	bio_associate_blkg_from_css(bio, blkcg_root_css);
+	bio_associate_blkg_from_css(bio, blkcg_root_css, true);
 
 	/* Must put everything in 512 byte sectors for the bio... */
 	bio->bi_iter.bi_sector = (reg->hr_start_block + cs) << (bits - 9);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f7d94d37893f..026df09a2546 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -508,19 +508,39 @@ static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_bdev->bd_disk)
 
+static inline void bio_set_dev_no_blkg(struct bio *bio,
+		struct block_device *bdev)
+{
+	bio_clear_flag(bio, BIO_REMAPPED);
+	if (bio->bi_bdev != bdev)
+		bio_clear_flag(bio, BIO_BPS_THROTTLED);
+	bio->bi_bdev = bdev;
+}
+
 #ifdef CONFIG_BLK_CGROUP
-void bio_associate_blkg(struct bio *bio);
-void bio_associate_blkg_from_css(struct bio *bio,
-				 struct cgroup_subsys_state *css);
-void bio_clone_blkg_association(struct bio *dst, struct bio *src);
+bool bio_associate_blkg(struct bio *bio, bool nowait);
+bool bio_associate_blkg_from_css(struct bio *bio,
+				 struct cgroup_subsys_state *css,
+				 bool nowait);
+bool bio_clone_blkg_association(struct bio *dst, struct bio *src,
+				bool nowait);
 void blkcg_punt_bio_submit(struct bio *bio);
 #else	/* CONFIG_BLK_CGROUP */
-static inline void bio_associate_blkg(struct bio *bio) { }
-static inline void bio_associate_blkg_from_css(struct bio *bio,
-					       struct cgroup_subsys_state *css)
-{ }
-static inline void bio_clone_blkg_association(struct bio *dst,
-					      struct bio *src) { }
+static inline bool bio_associate_blkg(struct bio *bio, bool nowait)
+{
+	return true;
+}
+static inline bool bio_associate_blkg_from_css(struct bio *bio,
+					       struct cgroup_subsys_state *css,
+					       bool nowait)
+{
+	return true;
+}
+static inline bool bio_clone_blkg_association(struct bio *dst,
+					      struct bio *src, bool nowait)
+{
+	return true;
+}
 static inline void blkcg_punt_bio_submit(struct bio *bio)
 {
 	submit_bio(bio);
@@ -529,11 +549,8 @@ static inline void blkcg_punt_bio_submit(struct bio *bio)
 
 static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
 {
-	bio_clear_flag(bio, BIO_REMAPPED);
-	if (bio->bi_bdev != bdev)
-		bio_clear_flag(bio, BIO_BPS_THROTTLED);
-	bio->bi_bdev = bdev;
-	bio_associate_blkg(bio);
+	bio_set_dev_no_blkg(bio, bdev);
+	bio_associate_blkg(bio, false);
 }
 
 /*
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 62552a2ce5b9..8165536fbbb0 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -262,7 +262,7 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 	 * regular writeback instead of writing things out itself.
 	 */
 	if (wbc->wb)
-		bio_associate_blkg_from_css(bio, wbc->wb->blkcg_css);
+		bio_associate_blkg_from_css(bio, wbc->wb->blkcg_css, false);
 }
 
 void inode_switch_wbs_work_fn(struct work_struct *work);
diff --git a/mm/page_io.c b/mm/page_io.c
index c96d3e4cf872..48404f8604cb 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -321,7 +321,7 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct folio *folio)
 		css = NULL;
 	rcu_read_unlock();
 
-	bio_associate_blkg_from_css(bio, css);
+	bio_associate_blkg_from_css(bio, css, false);
 	if (css)
 		css_put(css);
 }
-- 
2.51.0


