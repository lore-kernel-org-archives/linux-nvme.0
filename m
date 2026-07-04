Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0640DC43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UpXvpcnAu5pgU9SHm7QWz6pfcN7DZMwYKXJhMRcb+Cs=; b=UnsbAi5Ltt2LiNk9eGdSaSwMYC
	q84LGpawl4dNzz/RSwsiIsyLdYruvt+c/fHtLJAC/zy7I55IBTqdP0Sc7QwIzgwUEexVzyXoTQcQV
	ebZD2Tud814V1iN5/Wbxx/g5RoiZ9a3dqpMbUhxe3OTiXDnrJX/yoPxRr2SSV0HPk8AyhZ55OTus9
	4sWwo3Sq1eIAykub1oUT/wrAn1q0uC2WWM2/HheFR+ANLGTdUPsiUh1sZAmmT9ZUXVdlUn6Z93/Ll
	4dK7NOr+btdMmy1SudtMnprK4qguSRfyXcJ7IZng2+qZ0NwTvXbC5rU5Irc4MMDaekwN3Af1qX3lK
	UUgKA+gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6S1-00000008jeQ-2U25;
	Sat, 04 Jul 2026 19:54:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Rz-00000008jd4-3gDi
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:54:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5355761373;
	Sat,  4 Jul 2026 19:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA921F000E9;
	Sat,  4 Jul 2026 19:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194895;
	bh=UpXvpcnAu5pgU9SHm7QWz6pfcN7DZMwYKXJhMRcb+Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fR33eH1sdYUEdR1Fed/6lqSA4AAIcfO+4koussb8lEDg+rQy92E+JIm7f8v6DgcAr
	 f8Nmzxu/7v94bNlJW2EP6Zal2Rixoa6Gp43ajkdgnf6CAZ4qKac8XnT80/yOuuCiw8
	 c1nsIvmRP5HAOlyYcy9ZPKBljWKrrNicdmHUM2l9sUCh0XHKy+cTFZOrt+SxD6kmti
	 i0mV/yxqS0K7EaWktFviJAlQrdNYsw7XAQ3JJqzrIv47siTqrfyEImW56Sxv6jXJIC
	 R9OhuYPvrHSwamW/fUa9hna/OwOdTf4XOUCGEx/nAuAcz0HBxSpj4waj23dHTfIE7y
	 DJtZttvFKeLQQ==
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
Subject: [RFC PATCH v1 17/17] blk-cgroup: share blkg creation between lookup and config prep
Date: Sun,  5 Jul 2026 03:51:24 +0800
Message-ID: <20260704195124.1375075-18-yukuai@kernel.org>
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

blkg_conf_prep() open-codes the same parent walk and blkg creation that
blkg_lookup_create() already performs. Make blkg_lookup_create() report
whether the target blkg was created or found while still returning the
closest existing blkg on failure, then have blkg_conf_prep() use the
helper and treat errors as config failures.

This keeps the bio association path's closest-blkg fallback and removes
the duplicate config path loop.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-cgroup.c | 81 +++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 55 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ddc9073d7ab9..ae481bcde934 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -448,17 +448,19 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
  * blkg_lookup_create - lookup blkg, try to create one if not there
  * @blkcg: blkcg of interest
  * @disk: gendisk of interest
+ * @gfp_mask: allocation mask to use
+ * @blkgp: out parameter for the target blkg, or closest blkg on failure
  *
  * Lookup blkg for the @blkcg - @disk pair.  If it doesn't exist, try to
  * create one.  blkg creation is performed recursively from blkcg_root such
  * that all non-root blkg's have access to the parent blkg.  This function
  * must be called with @disk->queue->blkcg_mutex held.
  *
- * Returns the blkg or the closest blkg if blkg_create() fails as it walks
- * down from root.
+ * On success, *@blkgp points to the target blkg and 0 is returned.  On
+ * failure, *@blkgp points to the closest blkg and the errno is returned.
  */
-static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-		struct gendisk *disk)
+static int blkg_lookup_create(struct blkcg *blkcg, struct gendisk *disk,
+			      gfp_t gfp_mask, struct blkcg_gq **blkgp)
 {
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
@@ -470,7 +472,8 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 		    blkg != rcu_dereference(blkcg->blkg_hint))
 			rcu_assign_pointer(blkcg->blkg_hint, blkg);
 		rcu_read_unlock();
-		return blkg;
+		*blkgp = blkg;
+		return 0;
 	}
 	rcu_read_unlock();
 
@@ -497,16 +500,16 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 		}
 		rcu_read_unlock();
 
-		blkg = blkg_create(pos, disk, GFP_NOIO);
+		blkg = blkg_create(pos, disk, gfp_mask);
 		if (IS_ERR(blkg)) {
-			blkg = ret_blkg;
-			break;
+			*blkgp = ret_blkg;
+			return PTR_ERR(blkg);
+		}
+		if (pos == blkcg) {
+			*blkgp = blkg;
+			return 0;
 		}
-		if (pos == blkcg)
-			break;
 	}
-
-	return blkg;
 }
 
 static void blkg_destroy(struct blkcg_gq *blkg)
@@ -839,46 +842,10 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		goto fail_unlock;
 	}
 
-	blkg = blkg_lookup(blkcg, q);
-	if (blkg)
-		goto success;
-
-	/*
-	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
-	 * non-root blkgs have access to their parents.
-	 */
-	while (true) {
-		struct blkcg *pos = blkcg;
-		struct blkcg *parent;
-
-		parent = blkcg_parent(blkcg);
-		rcu_read_lock();
-		while (parent && !blkg_lookup(parent, q)) {
-			pos = parent;
-			parent = blkcg_parent(parent);
-		}
-		rcu_read_unlock();
-
-		if (!blkcg_policy_enabled(q, pol)) {
-			ret = -EOPNOTSUPP;
-			goto fail_unlock;
-		}
-
-		rcu_read_lock();
-		blkg = blkg_lookup(pos, q);
-		rcu_read_unlock();
-		if (!blkg) {
-			blkg = blkg_create(pos, disk, GFP_NOIO);
-			if (IS_ERR(blkg)) {
-				ret = PTR_ERR(blkg);
-				goto fail_unlock;
-			}
-		}
+	ret = blkg_lookup_create(blkcg, disk, GFP_NOIO, &blkg);
+	if (ret)
+		goto fail_unlock;
 
-		if (pos == blkcg)
-			goto success;
-	}
-success:
 	ctx->blkg = blkg;
 	return 0;
 
@@ -2018,6 +1985,8 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 	if (blkg)
 		return blkg;
 	if (nowait) {
+		int ret;
+
 		/*
 		 * mutex_trylock() itself does not sleep, but mutexes still
 		 * follow task-context locking rules.  Keep atomic nowait callers
@@ -2026,9 +1995,11 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 		if (!preemptible() || !mutex_trylock(&q->blkcg_mutex))
 			return NULL;
 
-		blkg = blkg_lookup_create(blkcg, bio->bi_bdev->bd_disk,
-					  GFP_ATOMIC);
-		if (blkg)
+		ret = blkg_lookup_create(blkcg, bio->bi_bdev->bd_disk,
+					 GFP_ATOMIC, &blkg);
+		if (ret)
+			blkg = NULL;
+		else if (blkg)
 			blkg = blkg_lookup_tryget(blkg);
 		mutex_unlock(&q->blkcg_mutex);
 
@@ -2040,7 +2011,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 	 * time, hold lock to create new blkg.
 	 */
 	mutex_lock(&q->blkcg_mutex);
-	blkg = blkg_lookup_create(blkcg, bio->bi_bdev->bd_disk);
+	blkg_lookup_create(blkcg, bio->bi_bdev->bd_disk, GFP_NOIO, &blkg);
 	if (blkg)
 		blkg = blkg_lookup_tryget(blkg);
 	mutex_unlock(&q->blkcg_mutex);
-- 
2.51.0


