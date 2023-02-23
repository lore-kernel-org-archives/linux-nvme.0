Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36FBC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Feb 2023 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cvzaAhRm/kT3WMBhuHCz3PiVIrb1RIMER4WcBaWzRf0=; b=uOMSEHd5Fbg7AAPEexnt91FXJI
	+kT6Ukkr1N4QEBK1QiP+LQNVAGpWgnhNJo5gWOsG77yWhwyn8ypEmIiOnqobHtBEtcdtbM3DLqnP9
	qSQc0NlvNzaY+VrkZ9TBGxW9A2CMoEijOtpRq94SxKZYI5lb7hgWPSPHO6BsEabij+SvAC9EKzVkL
	xqpT4uuk0dQq5BqIsqu7pWgxNYapNHvtwCa53vCdi8odsvMRwqGptEvdUth0Pt6BUbwN/O+vPmHgs
	uAMKYGgwQfV/PuJMDfAHgGv/oQsRXB9bYigjSFgJcORza/t0nfgUVHW6dXyo3Qa5MAnEozwnksTgl
	vcdKtRtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pV7Hv-00FaK4-JW; Thu, 23 Feb 2023 08:49:15 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pV7Hr-00FaHq-TB
	for linux-nvme@lists.infradead.org; Thu, 23 Feb 2023 08:49:14 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PMmsP1gkSz4f3mVn
	for <linux-nvme@lists.infradead.org>; Thu, 23 Feb 2023 16:48:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP3 (Coremail) with SMTP id _Ch0CgBH9CF5KPdjdmo0Dw--.40730S4;
	Thu, 23 Feb 2023 16:48:59 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	dm-devel@redhat.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	guz.fnst@cn.fujitsu.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next RFC] block: count 'ios' and 'sectors' when io is done for bio-based device
Date: Thu, 23 Feb 2023 17:12:26 +0800
Message-Id: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CF5KPdjdmo0Dw--.40730S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1fXr43Gr1DGr4UXr4rGrg_yoW7AF1fpF
	48W3WrCrZrXwnYg3yUAayDuF1rKa10q347AFW7J345Zw4ktryvvF10y3Wqyr15Ca97uFW7
	Aa48AF9rur42k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	U6c_fUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230223_004912_326652_753706F5 
X-CRM114-Status: GOOD (  11.95  )
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

From: Yu Kuai <yukuai3@huawei.com>

While using iostat for raid, I observed very strange 'await'
occasionally, and turns out it's due to that 'ios' and 'sectors' is
counted in bdev_start_io_acct(), while 'nsecs' is counted in
bdev_end_io_acct(). I'm not sure why they are ccounted like that
but I think this behaviour is obviously wrong because user will get
wrong disk stats.

Fix the problem by counting 'ios' and 'sectors' when io is done, like
what rq-based device does.

Fixes: 394ffa503bc4 ("blk: introduce generic io stat accounting help function")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c              | 16 ++++++----------
 drivers/md/dm.c               |  6 +++---
 drivers/nvme/host/multipath.c |  8 ++++----
 include/linux/blkdev.h        |  5 ++---
 4 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 82b5b2c53f1e..fe1d320f5f07 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -953,16 +953,11 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	}
 }
 
-unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, enum req_op op,
+unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 				 unsigned long start_time)
 {
-	const int sgrp = op_stat_group(op);
-
 	part_stat_lock();
 	update_io_ticks(bdev, start_time, false);
-	part_stat_inc(bdev, ios[sgrp]);
-	part_stat_add(bdev, sectors[sgrp], sectors);
 	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
@@ -978,13 +973,12 @@ EXPORT_SYMBOL(bdev_start_io_acct);
  */
 unsigned long bio_start_io_acct(struct bio *bio)
 {
-	return bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-				  bio_op(bio), jiffies);
+	return bdev_start_io_acct(bio->bi_bdev, bio_op(bio), jiffies);
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
 void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
-		      unsigned long start_time)
+		      unsigned int sectors, unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
@@ -992,6 +986,8 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 
 	part_stat_lock();
 	update_io_ticks(bdev, now, true);
+	part_stat_inc(bdev, ios[sgrp]);
+	part_stat_add(bdev, sectors[sgrp], sectors);
 	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
@@ -1001,7 +997,7 @@ EXPORT_SYMBOL(bdev_end_io_acct);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 			      struct block_device *orig_bdev)
 {
-	bdev_end_io_acct(orig_bdev, bio_op(bio), start_time);
+	bdev_end_io_acct(orig_bdev, bio_op(bio), bio_sectors(bio), start_time);
 }
 EXPORT_SYMBOL_GPL(bio_end_io_acct_remapped);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index eace45a18d45..f5cc330bb549 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -512,10 +512,10 @@ static void dm_io_acct(struct dm_io *io, bool end)
 		sectors = io->sectors;
 
 	if (!end)
-		bdev_start_io_acct(bio->bi_bdev, sectors, bio_op(bio),
-				   start_time);
+		bdev_start_io_acct(bio->bi_bdev, bio_op(bio), start_time);
 	else
-		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), start_time);
+		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), sectors,
+				 start_time);
 
 	if (static_branch_unlikely(&stats_enabled) &&
 	    unlikely(dm_stats_used(&md->stats))) {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fc39d01e7b63..9171452e2f6d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -123,9 +123,8 @@ void nvme_mpath_start_request(struct request *rq)
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
-	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0,
-					blk_rq_bytes(rq) >> SECTOR_SHIFT,
-					req_op(rq), jiffies);
+	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
+						      jiffies);
 }
 EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
@@ -136,7 +135,8 @@ void nvme_mpath_end_request(struct request *rq)
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
-		nvme_req(rq)->start_time);
+			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
+			 nvme_req(rq)->start_time);
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d1aee08f8c18..941304f17492 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1446,11 +1446,10 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
-unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, enum req_op op,
+unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 				 unsigned long start_time);
 void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
-		unsigned long start_time);
+		      unsigned int sectors, unsigned long start_time);
 
 unsigned long bio_start_io_acct(struct bio *bio);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
-- 
2.31.1


