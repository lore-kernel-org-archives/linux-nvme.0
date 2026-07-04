Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76D3C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ek99CdRP9XOBvBl51kk4zcMLTBONOw6ugzRQ5ls0qAY=; b=2tV8S7LxzO9UH8qRa+jIFLywWH
	myb04CWtMRl4scA0Aq6XdIKzWX7SiihLE83X3jc1mjhxP8yCXT7NEyku7PFeSllXoewdR49CFvQBo
	IDE9R1t8dviSP4mf6Zxcbbp//4IdknHFi6wzFRJmGpu62YEUR5Ocw0LzKklpDwSIqHdy1YmK3hqVb
	GcbJlACh54Bo85CwC8IyyYYo4QEjt+uvWHn4Ma0tg8w0GoYz66z5e7Iwuc+yvpZEphloJ/FqtvRY8
	dJa6632RItEOWmyDjtTLlL6bvvyL8SMkJES0OW719LrK0GAVrLG5L9kedPfBwsH5qvbtGTtwxpxzE
	hxoVzXfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Rh-00000008jS3-1VLC;
	Sat, 04 Jul 2026 19:54:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Rf-00000008jRP-3bC0
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:54:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F0AA61373;
	Sat,  4 Jul 2026 19:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5B41F000E9;
	Sat,  4 Jul 2026 19:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194875;
	bh=ek99CdRP9XOBvBl51kk4zcMLTBONOw6ugzRQ5ls0qAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YhTkm8uUfl1OgWxnILixlz+38xh0XlfbUWFmbA8XWx3LNrmOzVBR2MQuBtRGI+Vq+
	 CiX0igj9jR7CZ1B7iiSeTfp5YnWVqZeY7Csev+A+/dzYwMZHqso5icmoBQfoVXgTFm
	 +4qiU/jhVS4hfncPVzB27onFj6PvGQ1/qO17AWBMlz9X9nuzxfshQJuV6Zf5bidW3M
	 b4sBbIJ4JHttejZW7pU2JUnOhfZBz6IAZPmJUzVbxsBk29MFmmKb8bpuauFeoyVO2I
	 d0/f2PCAITZOEm6NDfnKcAqVaWSVYwbwBDCFGKKoqerIu+cEaqyUOY/ya+9QnYnvuh
	 +0wG66P5W+5yw==
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
Subject: [RFC PATCH v1 15/17] blk-cgroup: remove blkg radix tree preloading
Date: Sun,  5 Jul 2026 03:51:22 +0800
Message-ID: <20260704195124.1375075-16-yukuai@kernel.org>
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

blkg creation is now serialized by q->blkcg_mutex and no longer runs
under q->queue_lock.  The radix tree is initialized with GFP_NOWAIT, so
radix_tree_insert() cannot sleep while blkcg->lock is held and the old
preload dance is no longer needed.

Remove the preload calls and the associated unwind path.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-cgroup.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 71313bb3c4f3..b99ab8d67798 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -420,7 +420,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 			pol->pd_init_fn(blkg->pd[i]);
 	}
 
-	/* insert */
 	spin_lock_irq(&blkcg->lock);
 	ret = radix_tree_insert(&blkcg->blkg_tree, disk->queue->id, blkg);
 	if (likely(!ret)) {
@@ -875,16 +874,10 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail_unlock;
 		}
 
-		if (radix_tree_preload(GFP_KERNEL)) {
-			blkg_free(new_blkg);
-			ret = -ENOMEM;
-			goto fail_unlock;
-		}
-
 		if (!blkcg_policy_enabled(q, pol)) {
 			blkg_free(new_blkg);
 			ret = -EOPNOTSUPP;
-			goto fail_preloaded;
+			goto fail_unlock;
 		}
 
 		rcu_read_lock();
@@ -896,12 +889,10 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			blkg = blkg_create(pos, disk, new_blkg);
 			if (IS_ERR(blkg)) {
 				ret = PTR_ERR(blkg);
-				goto fail_preloaded;
+				goto fail_unlock;
 			}
 		}
 
-		radix_tree_preload_end();
-
 		if (pos == blkcg)
 			goto success;
 	}
@@ -909,8 +900,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	ctx->blkg = blkg;
 	return 0;
 
-fail_preloaded:
-	radix_tree_preload_end();
 fail_unlock:
 	mutex_unlock(&q->blkcg_mutex);
 	/*
@@ -1448,7 +1437,6 @@ int blkcg_init_disk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *new_blkg, *blkg;
-	bool preloaded;
 
 	/*
 	 * If the queue is shared across disk rebind (e.g., SCSI), the
@@ -1466,8 +1454,6 @@ int blkcg_init_disk(struct gendisk *disk)
 	if (!new_blkg)
 		return -ENOMEM;
 
-	preloaded = !radix_tree_preload(GFP_KERNEL);
-
 	/* Make sure the root blkg exists. */
 	mutex_lock(&q->blkcg_mutex);
 	blkg = blkg_create(&blkcg_root, disk, new_blkg);
@@ -1475,16 +1461,12 @@ int blkcg_init_disk(struct gendisk *disk)
 		goto err_unlock;
 	q->root_blkg = blkg;
 
-	if (preloaded)
-		radix_tree_preload_end();
 	mutex_unlock(&q->blkcg_mutex);
 
 	return 0;
 
 err_unlock:
 	mutex_unlock(&q->blkcg_mutex);
-	if (preloaded)
-		radix_tree_preload_end();
 	return PTR_ERR(blkg);
 }
 
-- 
2.51.0


