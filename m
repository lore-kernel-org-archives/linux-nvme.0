Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B46C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhzZxghKLjv/eAyw20BiM/yJyRuvLKKix2OV+q1Q9hY=; b=LRvdTO5ofs+td/6WBhkGBaj/BF
	8kIN6IBklEovaadp83Xv406ejvfWxgoaIDk2osZuEYfGD/pjta3P05v94+WX4M/VSNuJofoHsBAdT
	UhN9pWoEii7XoEd6+xNLr08dDIBW9Tmd97d1rXsfQ+UAZGshn55ZBWTLRHyNMe3ls8e3+uOMxp6d5
	PGSl52GBKm0JlkryKSbDvrRtNwLiLkyq5SmdmkeMyNaoGq0FZZ9c567l6lrcN2Cn4lYTPsS+4595L
	s8RgQTUP4n8BPA5gAJP0gB28AwbbnjS/2dbHutilxEGNaVaILoR65boTst83tLqpqyPFs/rsdK4PE
	LUKY7UWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBEJe-00HA6T-JS; Sat, 22 Jan 2022 11:12:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEJS-00HA1Q-Le
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:12:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhzZxghKLjv/eAyw20BiM/yJyRuvLKKix2OV+q1Q9hY=;
 b=KUZSPmsI3sC5ATdrDqJHDNDt93Ea+6dYQO+L8aETvfjvuwBJp9dABguVbgXEXz4m9ZdMOn
 FOwSbel5QGIXvisCH+DvA06ZYqb98iPdrXh0ZXaWUXWq4rtJt0MNjOUslQyyOhtYwr1yBP
 uOMa2EiYObCvX+fahcLFdtcDSprAWw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-VdJ4s97LPuO7HEw3K5CcjQ-1; Sat, 22 Jan 2022 06:11:56 -0500
X-MC-Unique: VdJ4s97LPuO7HEw3K5CcjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B58BD1083F60;
 Sat, 22 Jan 2022 11:11:54 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03059108BD2C;
 Sat, 22 Jan 2022 11:11:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 03/13] block: move blkcg initialization/destroy into disk
 allocation/release handler
Date: Sat, 22 Jan 2022 19:10:44 +0800
Message-Id: <20220122111054.1126146-4-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031206_804628_FC8DE258 
X-CRM114-Status: GOOD (  15.93  )
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

blkcg works on FS bio level, so it is reasonable to make both blkcg and
gendisk sharing same lifetime. Meantime there won't be any FS IO when
releasing disk, so safe to move blkcg initialization/destroy into disk
allocation/release handler

Long term, we can move blkcg into gendisk completely.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c  |  5 -----
 block/blk-sysfs.c |  7 -------
 block/genhd.c     | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2a400fa8cabd..d9477191b303 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -495,17 +495,12 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
 		goto fail_stats;
 
-	if (blkcg_init_queue(q))
-		goto fail_ref;
-
 	blk_queue_dma_alignment(q, 511);
 	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
 	return q;
 
-fail_ref:
-	percpu_ref_exit(&q->q_usage_counter);
 fail_stats:
 	blk_free_queue_stats(q->stats);
 fail_split:
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e20eadfcf5c8..6f326b44fb00 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -751,13 +751,6 @@ static void blk_exit_queue(struct request_queue *q)
 		ioc_clear_queue(q);
 		elevator_exit(q);
 	}
-
-	/*
-	 * Remove all references to @q from the block cgroup controller before
-	 * restoring @q->queue_lock to avoid that restoring this pointer causes
-	 * e.g. blkcg_print_blkgs() to crash.
-	 */
-	blkcg_exit_queue(q);
 }
 
 /**
diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a..b9b0db168ce1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1112,6 +1112,14 @@ static void disk_release(struct device *dev)
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
+
+	/*
+	 * Remove all references to @q from the block cgroup controller before
+	 * restoring @q->queue_lock to avoid that restoring this pointer causes
+	 * e.g. blkcg_print_blkgs() to crash.
+	 */
+	blkcg_exit_queue(disk->queue);
+
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
 	iput(disk->part0->bd_inode);	/* frees the disk */
@@ -1308,6 +1316,10 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
 		goto out_destroy_part_tbl;
 
+	/* todo: move blkcg into gendisk */
+	if (blkcg_init_queue(q))
+		goto out_erase_part0;
+
 	rand_initialize_disk(disk);
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
@@ -1320,6 +1332,8 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 #endif
 	return disk;
 
+out_erase_part0:
+	xa_erase(&disk->part_tbl, 0);
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	disk->part0->bd_disk = NULL;
-- 
2.31.1


