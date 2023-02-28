Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4A1C7EE2E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bUGYE9+7FygxTf3bzLk0PUgDOHGQlHnO8xHMKl07pr0=; b=Qs4Hrzlhjxnb1CDFNvHgb2lv1G
	QRMI4mI7jJ8kcDea4YPQG6oO9/qCf/hNlt+LAlOLPk/pOujAuQcXhvE1cXmN1FrjTufUD0gBU0b3j
	ZGpL5zdC7XldXfk6fVoUbTUWnCV0C0TguYbWkjg/HL7itlzrpMvMrr7gwQOWZ0Jdf7bEVf1VYa9ar
	8Wg6T6s/qPcXez566bmH4U7QUaj2XuWWWHjqS5nT8dkSCk9s/zVnQ/MAfeO+jTOEjg3YgrTsbBGrl
	w1uHExeZSfmhWAd7sAKMLIgNINjk9Ru3fGW3SWI75ZqQAjB85AgULy78JDuGXVvOBPNfEth4EznA5
	xccssRoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWoNK-00BhUv-Jl; Tue, 28 Feb 2023 01:01:50 +0000
Received: from [45.249.212.56] (helo=dggsgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWoNG-00BhRd-MF
	for linux-nvme@lists.infradead.org; Tue, 28 Feb 2023 01:01:49 +0000
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PQfFg1Q16z4f3jMy
	for <linux-nvme@lists.infradead.org>; Tue, 28 Feb 2023 09:01:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP3 (Coremail) with SMTP id _Ch0CgDn4R9nUv1j3JdHEA--.17465S3;
	Tue, 28 Feb 2023 09:01:29 +0800 (CST)
Subject: Re: [PATCH -next RFC] block: count 'ios' and 'sectors' when io is
 done for bio-based device
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, agk@redhat.com,
 snitzer@kernel.org, dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, guz.fnst@cn.fujitsu.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <05bbc421-100c-c18d-4261-e5669cfdfb94@huaweicloud.com>
Date: Tue, 28 Feb 2023 09:01:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R9nUv1j3JdHEA--.17465S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW8ury5KrWrWr4DKF15urg_yoW7ZF1UpF
	40g3WrCrZIqwn0gw4UJayDCF1rKa10qry7CrW7Jry5Aw4ktryvvF10y3Z0yr1rCa97uFZr
	Aa4rZF9ruw42k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_170147_108956_F19801AF 
X-CRM114-Status: GOOD (  21.75  )
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

Hi,

friendly ping ...

Thanks,
Kuai

ÔÚ 2023/02/23 17:12, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While using iostat for raid, I observed very strange 'await'
> occasionally, and turns out it's due to that 'ios' and 'sectors' is
> counted in bdev_start_io_acct(), while 'nsecs' is counted in
> bdev_end_io_acct(). I'm not sure why they are ccounted like that
> but I think this behaviour is obviously wrong because user will get
> wrong disk stats.
> 
> Fix the problem by counting 'ios' and 'sectors' when io is done, like
> what rq-based device does.
> 
> Fixes: 394ffa503bc4 ("blk: introduce generic io stat accounting help function")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-core.c              | 16 ++++++----------
>   drivers/md/dm.c               |  6 +++---
>   drivers/nvme/host/multipath.c |  8 ++++----
>   include/linux/blkdev.h        |  5 ++---
>   4 files changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 82b5b2c53f1e..fe1d320f5f07 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -953,16 +953,11 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
>   	}
>   }
>   
> -unsigned long bdev_start_io_acct(struct block_device *bdev,
> -				 unsigned int sectors, enum req_op op,
> +unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
>   				 unsigned long start_time)
>   {
> -	const int sgrp = op_stat_group(op);
> -
>   	part_stat_lock();
>   	update_io_ticks(bdev, start_time, false);
> -	part_stat_inc(bdev, ios[sgrp]);
> -	part_stat_add(bdev, sectors[sgrp], sectors);
>   	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
>   	part_stat_unlock();
>   
> @@ -978,13 +973,12 @@ EXPORT_SYMBOL(bdev_start_io_acct);
>    */
>   unsigned long bio_start_io_acct(struct bio *bio)
>   {
> -	return bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
> -				  bio_op(bio), jiffies);
> +	return bdev_start_io_acct(bio->bi_bdev, bio_op(bio), jiffies);
>   }
>   EXPORT_SYMBOL_GPL(bio_start_io_acct);
>   
>   void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
> -		      unsigned long start_time)
> +		      unsigned int sectors, unsigned long start_time)
>   {
>   	const int sgrp = op_stat_group(op);
>   	unsigned long now = READ_ONCE(jiffies);
> @@ -992,6 +986,8 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
>   
>   	part_stat_lock();
>   	update_io_ticks(bdev, now, true);
> +	part_stat_inc(bdev, ios[sgrp]);
> +	part_stat_add(bdev, sectors[sgrp], sectors);
>   	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
>   	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
>   	part_stat_unlock();
> @@ -1001,7 +997,7 @@ EXPORT_SYMBOL(bdev_end_io_acct);
>   void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
>   			      struct block_device *orig_bdev)
>   {
> -	bdev_end_io_acct(orig_bdev, bio_op(bio), start_time);
> +	bdev_end_io_acct(orig_bdev, bio_op(bio), bio_sectors(bio), start_time);
>   }
>   EXPORT_SYMBOL_GPL(bio_end_io_acct_remapped);
>   
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index eace45a18d45..f5cc330bb549 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -512,10 +512,10 @@ static void dm_io_acct(struct dm_io *io, bool end)
>   		sectors = io->sectors;
>   
>   	if (!end)
> -		bdev_start_io_acct(bio->bi_bdev, sectors, bio_op(bio),
> -				   start_time);
> +		bdev_start_io_acct(bio->bi_bdev, bio_op(bio), start_time);
>   	else
> -		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), start_time);
> +		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), sectors,
> +				 start_time);
>   
>   	if (static_branch_unlikely(&stats_enabled) &&
>   	    unlikely(dm_stats_used(&md->stats))) {
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index fc39d01e7b63..9171452e2f6d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -123,9 +123,8 @@ void nvme_mpath_start_request(struct request *rq)
>   		return;
>   
>   	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
> -	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0,
> -					blk_rq_bytes(rq) >> SECTOR_SHIFT,
> -					req_op(rq), jiffies);
> +	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
> +						      jiffies);
>   }
>   EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
>   
> @@ -136,7 +135,8 @@ void nvme_mpath_end_request(struct request *rq)
>   	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>   		return;
>   	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> -		nvme_req(rq)->start_time);
> +			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
> +			 nvme_req(rq)->start_time);
>   }
>   
>   void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d1aee08f8c18..941304f17492 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1446,11 +1446,10 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
>   		wake_up_process(waiter);
>   }
>   
> -unsigned long bdev_start_io_acct(struct block_device *bdev,
> -				 unsigned int sectors, enum req_op op,
> +unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
>   				 unsigned long start_time);
>   void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
> -		unsigned long start_time);
> +		      unsigned int sectors, unsigned long start_time);
>   
>   unsigned long bio_start_io_acct(struct bio *bio);
>   void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
> 


