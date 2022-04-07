Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA1DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 05:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mSljOe/NcqR0nJ5LYJS1IexMd+XWdNrUUnY7u8p4ss=; b=hEi7jJL3yXYM6E+kb2i7OwAnKy
	BvXOvjZNHPX+YxcBvEh03enC9IYX56kY/MjzH0CLxGgcgwNEuv7rvV1EheOl6Ww4fdrPSxNb/UVNm
	xDY0xeZOKj10XeW7/e1lwVZVLdkveiPtcp3/F1OX6+pzs+Mngttm3TYujC33itg/MsviN4udepbjv
	jVhM4hA8focINPLZo8p+rJbzx08S4HfOhI1nFOy+ockMxvKcx69SJytVeI08Rmt/HX5a+Jmcn9URt
	yjZ9xn04tSA20HjWnZFapPcXhsertw3gOIKMBqi1vZETAFN/GIl9rF+vQCFbax027ro4d4LvmEtfw
	Gzz2Y6nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncKW5-009UUn-3w; Thu, 07 Apr 2022 05:17:09 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncKVN-009UHr-1E; Thu, 07 Apr 2022 05:16:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B76E021122;
 Thu,  7 Apr 2022 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649308580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3mSljOe/NcqR0nJ5LYJS1IexMd+XWdNrUUnY7u8p4ss=;
 b=S8u6tT4MOmjtYxCqeb3qmZNn/bHZfqArgo8fnUTx30csmaC8EzqkNzsFCobTftsYYuUnLo
 j2CEECTylf45En922p7zGMdDliHlOB0W/p8IrTqMAAnrwN0MZYWeSbIR9ZZAecmXn6aNZm
 pYWtnVOXe4neFTwM3RVsKoYuaP4pLxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649308580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3mSljOe/NcqR0nJ5LYJS1IexMd+XWdNrUUnY7u8p4ss=;
 b=8wVCLmcmG2fqohkxPiOTT+zNzsZDHS4xqLNwNHKElc9o7Ynzusas5Vi1t3zyX0xdAJFT8y
 NypPr2uWld7TnxBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81FE713A66;
 Thu,  7 Apr 2022 05:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0FojFJ5zTmLoQAAAMHmgww
 (envelope-from <colyli@suse.de>); Thu, 07 Apr 2022 05:16:14 +0000
Message-ID: <2aee78dd-d5b6-5444-da28-34ab2631b264@suse.de>
Date: Thu, 7 Apr 2022 13:16:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 23/27] block: add a bdev_max_discard_sectors helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-24-hch@lst.de>
From: Coly Li <colyli@suse.de>
In-Reply-To: <20220406060516.409838-24-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_221625_299515_B0577F8E 
X-CRM114-Status: GOOD (  20.03  )
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

On 4/6/22 2:05 PM, Christoph Hellwig wrote:
> Add a helper to query the number of sectors support per each discard bio
> based on the block device and use this helper to stop various places from
> poking into the request_queue to see if discard is supported and if so how
> much.  This mirrors what is done e.g. for write zeroes as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


For the bcache part,

Acked-by: Coly Li <colyli@suse.de>


Thanks.


Coly Li



> ---
>   block/blk-core.c                    |  2 +-
>   block/blk-lib.c                     |  2 +-
>   block/ioctl.c                       |  3 +--
>   drivers/block/drbd/drbd_main.c      |  2 +-
>   drivers/block/drbd/drbd_nl.c        | 12 +++++++-----
>   drivers/block/drbd/drbd_receiver.c  |  5 ++---
>   drivers/block/loop.c                |  9 +++------
>   drivers/block/rnbd/rnbd-srv-dev.h   |  6 +-----
>   drivers/block/xen-blkback/xenbus.c  |  2 +-
>   drivers/md/bcache/request.c         |  4 ++--
>   drivers/md/bcache/super.c           |  2 +-
>   drivers/md/bcache/sysfs.c           |  2 +-
>   drivers/md/dm-cache-target.c        |  9 +--------
>   drivers/md/dm-clone-target.c        |  9 +--------
>   drivers/md/dm-io.c                  |  2 +-
>   drivers/md/dm-log-writes.c          |  3 +--
>   drivers/md/dm-raid.c                |  9 ++-------
>   drivers/md/dm-table.c               |  4 +---
>   drivers/md/dm-thin.c                |  9 +--------
>   drivers/md/dm.c                     |  2 +-
>   drivers/md/md-linear.c              |  4 ++--
>   drivers/md/raid0.c                  |  2 +-
>   drivers/md/raid1.c                  |  6 +++---
>   drivers/md/raid10.c                 |  8 ++++----
>   drivers/md/raid5-cache.c            |  2 +-
>   drivers/target/target_core_device.c |  8 +++-----
>   fs/btrfs/extent-tree.c              |  4 ++--
>   fs/btrfs/ioctl.c                    |  2 +-
>   fs/exfat/file.c                     |  2 +-
>   fs/exfat/super.c                    | 10 +++-------
>   fs/ext4/ioctl.c                     | 10 +++-------
>   fs/ext4/super.c                     | 10 +++-------
>   fs/f2fs/f2fs.h                      |  3 +--
>   fs/f2fs/segment.c                   |  6 ++----
>   fs/fat/file.c                       |  2 +-
>   fs/fat/inode.c                      | 10 +++-------
>   fs/gfs2/rgrp.c                      |  2 +-
>   fs/jbd2/journal.c                   |  7 ++-----
>   fs/jfs/ioctl.c                      |  2 +-
>   fs/jfs/super.c                      |  8 ++------
>   fs/nilfs2/ioctl.c                   |  2 +-
>   fs/ntfs3/file.c                     |  2 +-
>   fs/ntfs3/super.c                    |  2 +-
>   fs/ocfs2/ioctl.c                    |  2 +-
>   fs/xfs/xfs_discard.c                |  2 +-
>   fs/xfs/xfs_super.c                  | 12 ++++--------
>   include/linux/blkdev.h              |  5 +++++
>   mm/swapfile.c                       | 17 ++---------------
>   48 files changed, 87 insertions(+), 163 deletions(-)

[snipped]


> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index fdd0194f84dd0..e27f67f06a428 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1005,7 +1005,7 @@ static void cached_dev_write(struct cached_dev *dc, struct search *s)
>   		bio_get(s->iop.bio);
>   
>   		if (bio_op(bio) == REQ_OP_DISCARD &&
> -		    !blk_queue_discard(bdev_get_queue(dc->bdev)))
> +		    !bdev_max_discard_sectors(dc->bdev))
>   			goto insert_data;
>   
>   		/* I/O request sent to backing device */
> @@ -1115,7 +1115,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
>   	bio->bi_private = ddip;
>   
>   	if ((bio_op(bio) == REQ_OP_DISCARD) &&
> -	    !blk_queue_discard(bdev_get_queue(dc->bdev)))
> +	    !bdev_max_discard_sectors(dc->bdev))
>   		bio->bi_end_io(bio);
>   	else
>   		submit_bio_noacct(bio);
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index bf3de149d3c9f..296f200b2e208 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2350,7 +2350,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>   	ca->bdev->bd_holder = ca;
>   	ca->sb_disk = sb_disk;
>   
> -	if (blk_queue_discard(bdev_get_queue(bdev)))
> +	if (bdev_max_discard_sectors((bdev)))
>   		ca->discard = CACHE_DISCARD(&ca->sb);
>   
>   	ret = cache_alloc(ca);
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index d1029d71ff3bc..c6f677059214d 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -1151,7 +1151,7 @@ STORE(__bch_cache)
>   	if (attr == &sysfs_discard) {
>   		bool v = strtoul_or_return(buf);
>   
> -		if (blk_queue_discard(bdev_get_queue(ca->bdev)))
> +		if (bdev_max_discard_sectors(ca->bdev))
>   			ca->discard = v;
>   
>   		if (v != CACHE_DISCARD(&ca->sb)) {


[snipped]


