Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ACBC43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vu29rf3lgakjneFMYKQ+WlczmzTnFJdW6M8FMGJJaOM=; b=W6/0Wmhooo4TGypVe8hT2cXMnB
	SL4OMmll1m41M7a046jL0ToE5Bt3DdG4f56dJFQGszepEja/Q8L4Y6HS2mvT+yJwMewyhRRhRjCMC
	R6HB6hIJGFAtHnAeeeNU7mh82L77RI5C5X1sKA+IzALkkba1BZOT4UBxbJWVNwQYShiY/8bMjrMGd
	yyVQFeh31KbAqMh2/DQUiLJAY2fuyGQgc+2xYYaPHkyc+mD8/CuEQA/U/B+E1riH3Oy6fHQa/Yp/o
	8GDfijsitR7WC7V3D9O1kEFaBmVQcX32t9N6BOz/U2pIlkHZz/oR2wAGgttDGjK5/V5XBb9piwg8r
	e+vJYiSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6RB-00000008jFw-3JjZ;
	Sat, 04 Jul 2026 19:54:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6RA-00000008jFi-3FY9
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:54:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F00B417FA;
	Sat,  4 Jul 2026 19:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476421F00A3A;
	Sat,  4 Jul 2026 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194844;
	bh=vu29rf3lgakjneFMYKQ+WlczmzTnFJdW6M8FMGJJaOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V8jnWK9jzq4GRSEcFyc0bp1R43aK8YPsy+08Ecfds9ufrTzFxQ5455bosqhDVRN+Z
	 k0BOU6V1l8YVOEbF0uMzedEZt90DC1dcrk17aimxaVhjsmxLgoLMC+8CG/V0MP8UC4
	 LqRKf0fUE08DWoci1Ant5r0qh2Xo3yItrIS4oE8lB++xl1ZqCiYL/tNwe8mSvBM8g8
	 ijyk5DIKJHJj5ZSGBCg3nNt5/GG0lz8h17mSrDCjmDglc/NfgMVBBHC6DIbzGp9/sG
	 N4H8/EAk6m18lPAlCmN44Iz9cgCkvTbJZoUhM0y/9W0Mx+7ui8BUDXYL76fRxl8XHO
	 wEb9s9gHJDi2w==
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
Subject: [RFC PATCH v1 12/17] dm: avoid sleeping blkg association from NOWAIT remaps
Date: Sun,  5 Jul 2026 03:51:19 +0800
Message-ID: <20260704195124.1375075-13-yukuai@kernel.org>
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

DM allocates normal NOWAIT target clones with GFP_NOWAIT.  Targets that set
needs_bio_set_dev can therefore make alloc_tio() associate blkcg state from a
non-blocking allocation path, which may sleep while creating a missing blkg
after blkg lookup is protected by q->blkcg_mutex.

Set the default bdev without blkcg association first, then associate blkcg
with nowait=true for non-blocking allocations.  If a blkg would need creating,
fail the NOWAIT allocation with BLK_STS_AGAIN.

Targets that advertise DM_TARGET_NOWAIT may also remap bios in their map
functions.  Those remaps update only the bdev for NOWAIT bios, then
DM submission clones the original bio's blkg association with nowait=true
before lower submission.  If that would need to sleep, complete the clone with
BLK_STS_AGAIN.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-linear.c        |  2 +-
 drivers/md/dm-stripe.c        |  6 +++---
 drivers/md/dm-switch.c        |  2 +-
 drivers/md/dm-unstripe.c      |  2 +-
 drivers/md/dm.c               | 28 +++++++++++++++++++++++++---
 include/linux/device-mapper.h |  8 ++++++++
 6 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 38c17846deb0..f75a372acd20 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -90,7 +90,7 @@ int linear_map(struct dm_target *ti, struct bio *bio)
 {
 	struct linear_c *lc = ti->private;
 
-	bio_set_dev(bio, lc->dev->bdev);
+	dm_bio_set_dev(bio, lc->dev->bdev);
 	bio->bi_iter.bi_sector = linear_map_sector(ti, bio->bi_iter.bi_sector);
 
 	return DM_MAPIO_REMAPPED;
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 750865fd3ae7..73f9483a3e8a 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -257,7 +257,7 @@ static int stripe_map_range(struct stripe_c *sc, struct bio *bio,
 	stripe_map_range_sector(sc, bio_end_sector(bio),
 				target_stripe, &end);
 	if (begin < end) {
-		bio_set_dev(bio, sc->stripe[target_stripe].dev->bdev);
+		dm_bio_set_dev(bio, sc->stripe[target_stripe].dev->bdev);
 		bio->bi_iter.bi_sector = begin +
 			sc->stripe[target_stripe].physical_start;
 		bio->bi_iter.bi_size = to_bytes(end - begin);
@@ -278,7 +278,7 @@ int stripe_map(struct dm_target *ti, struct bio *bio)
 	if (bio->bi_opf & REQ_PREFLUSH) {
 		target_bio_nr = dm_bio_get_target_bio_nr(bio);
 		BUG_ON(target_bio_nr >= sc->stripes);
-		bio_set_dev(bio, sc->stripe[target_bio_nr].dev->bdev);
+		dm_bio_set_dev(bio, sc->stripe[target_bio_nr].dev->bdev);
 		return DM_MAPIO_REMAPPED;
 	}
 	if (unlikely(bio_op(bio) == REQ_OP_DISCARD) ||
@@ -293,7 +293,7 @@ int stripe_map(struct dm_target *ti, struct bio *bio)
 			  &stripe, &bio->bi_iter.bi_sector);
 
 	bio->bi_iter.bi_sector += sc->stripe[stripe].physical_start;
-	bio_set_dev(bio, sc->stripe[stripe].dev->bdev);
+	dm_bio_set_dev(bio, sc->stripe[stripe].dev->bdev);
 
 	return DM_MAPIO_REMAPPED;
 }
diff --git a/drivers/md/dm-switch.c b/drivers/md/dm-switch.c
index 5952f02de1e6..9eea6c263eed 100644
--- a/drivers/md/dm-switch.c
+++ b/drivers/md/dm-switch.c
@@ -323,7 +323,7 @@ static int switch_map(struct dm_target *ti, struct bio *bio)
 	sector_t offset = dm_target_offset(ti, bio->bi_iter.bi_sector);
 	unsigned int path_nr = switch_get_path_nr(sctx, offset);
 
-	bio_set_dev(bio, sctx->path_list[path_nr].dmdev->bdev);
+	dm_bio_set_dev(bio, sctx->path_list[path_nr].dmdev->bdev);
 	bio->bi_iter.bi_sector = sctx->path_list[path_nr].start + offset;
 
 	return DM_MAPIO_REMAPPED;
diff --git a/drivers/md/dm-unstripe.c b/drivers/md/dm-unstripe.c
index bfcbe6bfa71a..900b1ac88bc8 100644
--- a/drivers/md/dm-unstripe.c
+++ b/drivers/md/dm-unstripe.c
@@ -136,7 +136,7 @@ static int unstripe_map(struct dm_target *ti, struct bio *bio)
 {
 	struct unstripe_c *uc = ti->private;
 
-	bio_set_dev(bio, uc->dev->bdev);
+	dm_bio_set_dev(bio, uc->dev->bdev);
 	bio->bi_iter.bi_sector = map_to_core(ti, bio) + uc->physical_start;
 
 	return DM_MAPIO_REMAPPED;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c54636235ffe..6dde3c699122 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -610,6 +610,8 @@ static void free_io(struct dm_io *io)
 	bio_put(&io->tio.clone);
 }
 
+static void free_tio(struct bio *clone);
+
 static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 			     unsigned int target_bio_nr, unsigned int *len, gfp_t gfp_mask)
 {
@@ -644,8 +646,12 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 
 	/* Set default bdev, but target must bio_set_dev() before issuing IO */
 	clone->bi_bdev = md->disk->part0;
-	if (likely(ti != NULL) && unlikely(ti->needs_bio_set_dev))
-		bio_set_dev(clone, md->disk->part0);
+	if (likely(ti != NULL) && unlikely(ti->needs_bio_set_dev)) {
+		bio_set_dev_no_blkg(clone, md->disk->part0);
+		if (!bio_associate_blkg(clone,
+				!gfpflags_allow_blocking(gfp_mask)))
+			goto fail;
+	}
 
 	if (len) {
 		clone->bi_iter.bi_size = to_bytes(*len);
@@ -654,6 +660,14 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 	}
 
 	return clone;
+
+fail:
+	if (dm_tio_flagged(clone_to_tio(clone), DM_TIO_INSIDE_DM_IO)) {
+		clone->bi_bdev = NULL;
+		clone_to_tio(clone)->io = NULL;
+	}
+	free_tio(clone);
+	return NULL;
 }
 
 static void free_tio(struct bio *clone)
@@ -1364,7 +1378,15 @@ void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone)
 	if (!tgt_clone)
 		tgt_clone = clone;
 
-	bio_clone_blkg_association(tgt_clone, io->orig_bio, false);
+	if (tgt_clone->bi_opf & REQ_NOWAIT) {
+		if (!bio_clone_blkg_association(tgt_clone, io->orig_bio, true)) {
+			tgt_clone->bi_status = BLK_STS_AGAIN;
+			tgt_clone->bi_end_io(tgt_clone);
+			return;
+		}
+	} else {
+		bio_clone_blkg_association(tgt_clone, io->orig_bio, false);
+	}
 
 	/*
 	 * Account io->origin_bio to DM dev on behalf of target
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index cd4faaf5d427..ca1e1cfee74f 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -713,6 +713,14 @@ module_exit(dm_##name##_exit)
 #define DM_MAPIO_DELAY_REQUEUE	DM_ENDIO_DELAY_REQUEUE
 #define DM_MAPIO_KILL		4
 
+static inline void dm_bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+	if (bio->bi_opf & REQ_NOWAIT)
+		bio_set_dev_no_blkg(bio, bdev);
+	else
+		bio_set_dev(bio, bdev);
+}
+
 #define dm_sector_div64(x, y)( \
 { \
 	u64 _res; \
-- 
2.51.0


