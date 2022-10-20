Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9247C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBG93+i4RqIMen+EdnicHSiNmzZBQwOLKztWbkR03aM=; b=yOsu8rZI3lNxhvMDeweiFN29v7
	kUrL3yjNdZ0Ppqcv65OM7UhzD5nHOkc+tc4/E2C8mHdcPOStZJhc+iT8Aav5cf5Yl8+GSuVkvsnZA
	ADEm6M95sjBg0AdYjEZhmXh4UbOgsNtEn4SbKwJzn9aDaMAnNl42m9QSl6ymit5OUHZhdsKbbdAcQ
	wLCmxfwhRzVZ/uc7q7dZpfeMZII/p+eGdnylOMfGqHTymn1xAkjD7SowqQGUIseKrpnaGIPjR1tS5
	t7vTrwMMccB1lYYYl7/Y8db6JKGTuD9a46aHdQYM9TLVnM7OHYk/EfTePU5UjSBC9XC08Z5OstwZ1
	+yahe5wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olUC2-00EObF-07; Thu, 20 Oct 2022 11:58:34 +0000
Received: from [88.128.92.117] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olTDs-00Dqdz-Vz; Thu, 20 Oct 2022 10:56:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/8] block: set the disk capacity to 0 in blk_mark_disk_dead
Date: Thu, 20 Oct 2022 12:56:01 +0200
Message-Id: <20221020105608.1581940-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
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

nvme and xen-blkfront are already doing this to stop buffered writes from
creating dirty pages that can't be written out later.  Move it to the
common code.  Note that this follows the xen-blkfront version that does
not send and uevent as the uevent is a bit confusing when the device is
about to go away a little later, and the the size change is just to stop
buffered writes faster.

This also removes the comment about the ordering from nvme, as bd_mutex
not only is gone entirely, but also hasn't been used for locking updates
to the disk size long before that, and thus the ordering requirement
documented there doesn't apply any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c                | 3 +++
 drivers/block/xen-blkfront.c | 1 -
 drivers/nvme/host/core.c     | 7 +------
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423df..2877b5f905579 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -555,6 +555,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
 {
 	set_bit(GD_DEAD, &disk->state);
 	blk_queue_start_drain(disk->queue);
+
+	/* stop buffered writers from dirtying pages that can't written out */
+	set_capacity(disk, 0);
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 35b9bcad9db90..b28489290323f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2129,7 +2129,6 @@ static void blkfront_closing(struct blkfront_info *info)
 	if (info->rq && info->gd) {
 		blk_mq_stop_hw_queues(info->rq);
 		blk_mark_disk_dead(info->gd);
-		set_capacity(info->gd, 0);
 	}
 
 	for_each_rinfo(info, rinfo, i) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c19..44a5321743128 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5106,10 +5106,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 /*
  * Prepare a queue for teardown.
  *
- * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
- * the capacity to 0 after that to avoid blocking dispatchers that may be
- * holding bd_butex.  This will end buffered writers dirtying pages that can't
- * be synced.
+ * This must forcibly unquiesce queues to avoid blocking dispatch.
  */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
@@ -5118,8 +5115,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 
 	blk_mark_disk_dead(ns->disk);
 	nvme_start_ns_queue(ns);
-
-	set_capacity_and_notify(ns->disk, 0);
 }
 
 /**
-- 
2.30.2


