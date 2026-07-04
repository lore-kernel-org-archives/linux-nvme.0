Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F05C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ufHR6WcCfu/uFKPa4VS21/xvyGG7qfM6HO7NiBTt5s=; b=4XUuDQLWe0kANszTTroBc+UGSA
	sY8ne26aNgqk6DkBX+82LYaAATpDzqkiVBjsHk1jR2hr8sldTQHBrYB52hBQohgc1u9g0nUXU2hKs
	nN/XdpbhxwVrLfRsCXpJnod9wnS3CJv2pGIOwh3NrkV6qXsVrBA2xhsl59jM/I3Hn5ZcOkrdICTcn
	ZvSs1c+fvw5lhTlgNEzisoW6g+Au0xMymI7Y1VrYDfe2GHUa/uL5bjki7CUFgyOVgnKZ8HEOVe27n
	iy+h3//B3SfF+SVcTAESWiN7NXM651QVuuxXvN9V7vu8l1QPGpDjGxZKQnddS/3MKoO+KdgMxHwJr
	vZH8REdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6PY-00000008ifF-3DMq;
	Sat, 04 Jul 2026 19:52:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6PX-00000008iej-2t6O
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:52:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 68A75407E6;
	Sat,  4 Jul 2026 19:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66E81F000E9;
	Sat,  4 Jul 2026 19:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194743;
	bh=3ufHR6WcCfu/uFKPa4VS21/xvyGG7qfM6HO7NiBTt5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvZcJbFh/Cx+r6qJ3jGtjFZVEDHkPTJ44v98iKdAgLyASaibfSfY7sGH1vWHPajZs
	 PllkZQRybKGEbqmwmvePobLfnPjOMhPRSB4PyG+ku2UzNApK1WUUldpNqHJi0qfCch
	 lqjNm870SdBrUjwKQ17SQJunUouBaKYQniC48Mz10Pdgbi/Ffz4OE61zSWSWFlHhBj
	 TyifFbQbYweXgIsoHmPISAI3pVFK0HOrz2ohKWbox53e0RZI4lyqYECpDk3KDr6IHq
	 xcU6+6cICME4GiNB51Uc5c+U01iWVR6tnz7OkNUUAteSl0P/9/N1R0arjfcejr0+o1
	 hvIOGoRwpEDLQ==
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
Subject: [RFC PATCH v1 03/17] dm snapshot: avoid bio_set_dev in locked map paths
Date: Sun,  5 Jul 2026 03:51:10 +0800
Message-ID: <20260704195124.1375075-4-yukuai@kernel.org>
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

bio_set_dev() is about to become explicitly sleepable.  It currently
updates the bio's target device and then associates the bio with the
destination queue's blkcg state.  After blkcg lookup/creation is moved
under the queue's blkcg_mutex, that association may take blkcg_mutex and
allocate a new blkg.  Callers therefore must not invoke bio_set_dev() from
atomic or otherwise non-sleepable sections.

snapshot_map() has several remap decisions inside
dm_exception_table_lock(), which nests the completed and pending
exception hash-table spinlocks.  Those locks protect the lookup result,
pending-exception insertion, pe->started, and the pending bio lists until
the bio has either been returned to DM core or queued on the pending
exception.  Dropping the locks just to call bio_set_dev() would require
revalidating the exception state and preserving the pending-list ordering
rules; calling a sleepable bio_set_dev() while holding the spinlocks is not
allowed either.

Split out snapshot_bio_set_dev() for these locked remap decisions.  It only
performs the non-sleeping part of bio_set_dev(): clear BIO_REMAPPED, clear
BIO_BPS_THROTTLED when the bdev changes, and update bi_bdev.  It
deliberately does not associate the bio with a blkg while snapshot locks
are held.

This does not lose blkcg attribution for the normal DM_MAPIO_REMAPPED case.
After the target returns, DM core submits the mapped bio through
dm_submit_bio_remap(), and that helper clones the blkg association from the
original bio in the normal submission context.

Some snapshot bios are not submitted by DM core immediately.  Writes
waiting for a pending exception and bios queued during snapshot merge are
kept on snapshot-owned lists and submitted later after copy or merge
completion.  Once bio_set_dev() is no longer used in the locked path,
these delayed bios also need their blkcg association restored at submission
time.  Submit those bios through dm_submit_bio_remap() instead of
submit_bio_noacct() so the association is cloned from the original bio
after the snapshot locks have been released.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-snap.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 1489fda9d24a..373a94156ec7 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -192,6 +192,19 @@ static sector_t chunk_to_sector(struct dm_exception_store *store,
 	return chunk << store->chunk_shift;
 }
 
+/*
+ * Snapshot exception-table locks are spinlocks.  Only update the target
+ * device while holding them; dm_submit_bio_remap() will associate target-owned
+ * bios with the original bio's blkg from a sleepable submission context.
+ */
+static void snapshot_bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+	bio_clear_flag(bio, BIO_REMAPPED);
+	if (bio->bi_bdev != bdev)
+		bio_clear_flag(bio, BIO_BPS_THROTTLED);
+	bio->bi_bdev = bdev;
+}
+
 static int bdev_equal(struct block_device *lhs, struct block_device *rhs)
 {
 	/*
@@ -1566,7 +1579,7 @@ static void flush_bios(struct bio *bio)
 	while (bio) {
 		n = bio->bi_next;
 		bio->bi_next = NULL;
-		submit_bio_noacct(bio);
+		dm_submit_bio_remap(bio, NULL);
 		bio = n;
 	}
 }
@@ -1586,7 +1599,7 @@ static void retry_origin_bios(struct dm_snapshot *s, struct bio *bio)
 		bio->bi_next = NULL;
 		r = do_origin(s->origin, bio, false);
 		if (r == DM_MAPIO_REMAPPED)
-			submit_bio_noacct(bio);
+			dm_submit_bio_remap(bio, NULL);
 		bio = n;
 	}
 }
@@ -1827,7 +1840,7 @@ static void start_full_bio(struct dm_snap_pending_exception *pe,
 	bio->bi_end_io = full_bio_end_io;
 	bio->bi_private = callback_data;
 
-	submit_bio_noacct(bio);
+	dm_submit_bio_remap(bio, NULL);
 }
 
 static struct dm_snap_pending_exception *
@@ -1898,7 +1911,7 @@ __find_pending_exception(struct dm_snapshot *s,
 static void remap_exception(struct dm_snapshot *s, struct dm_exception *e,
 			    struct bio *bio, chunk_t chunk)
 {
-	bio_set_dev(bio, s->cow->bdev);
+	snapshot_bio_set_dev(bio, s->cow->bdev);
 	bio->bi_iter.bi_sector =
 		chunk_to_sector(s->store, dm_chunk_number(e->new_chunk) +
 				(chunk - e->old_chunk)) +
@@ -1982,7 +1995,7 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 			 * defeat the goal of freeing space in origin that is
 			 * implied by the "discard_passdown_origin" feature)
 			 */
-			bio_set_dev(bio, s->origin->bdev);
+			snapshot_bio_set_dev(bio, s->origin->bdev);
 			track_chunk(s, bio, chunk);
 			goto out_unlock;
 		}
@@ -2081,7 +2094,7 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 			goto out;
 		}
 	} else {
-		bio_set_dev(bio, s->origin->bdev);
+		snapshot_bio_set_dev(bio, s->origin->bdev);
 		track_chunk(s, bio, chunk);
 	}
 
@@ -2143,7 +2156,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 		    chunk >= s->first_merging_chunk &&
 		    chunk < (s->first_merging_chunk +
 			     s->num_merging_chunks)) {
-			bio_set_dev(bio, s->origin->bdev);
+			snapshot_bio_set_dev(bio, s->origin->bdev);
 			bio_list_add(&s->bios_queued_during_merge, bio);
 			r = DM_MAPIO_SUBMITTED;
 			goto out_unlock;
@@ -2157,7 +2170,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 	}
 
 redirect_to_origin:
-	bio_set_dev(bio, s->origin->bdev);
+	snapshot_bio_set_dev(bio, s->origin->bdev);
 
 	if (bio_data_dir(bio) == WRITE) {
 		up_write(&s->lock);
-- 
2.51.0


