Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79F7C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 21:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6KcRdxUsnfY4lrURoaAoZmnUMAtid4aFLe7flA5XXZs=; b=u74tNFGEcs9/BY1rLx7TodmdzU
	Gtcf9V5EqjhtLeLbxYiy7oUgprkmZ96ZjqAm4MvAvccFYuOccs5m7Y2Q/EdNORRC/FGq0kdtz5ML1
	2NbfjS0UwygN3bSXBDx2/RIebV/5r5pMNFljiO0fLhJkEfte8RF+V7DotPVgUlfiTn6TpVEHEEpsV
	rPVaXLFQGW6jyyqoUc4Ib/3ENIrDbnlf8yU6vB/MUhusQ4uda++uHAPgVsBIdog8w4eprN/IYMZ+2
	fPvCww0MkvZXZeZz+B4CnO79ilC7guNxJChs+j0bcQdtnquaC3BtjjCYaNXW9RD9XJfQjr16BCoES
	r86xBIdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riLMe-00000006TN9-3onh;
	Thu, 07 Mar 2024 21:33:21 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riLMY-00000006TK0-1SdQ
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 21:33:18 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6e64997a934so1141342b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709847192; x=1710451992; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KcRdxUsnfY4lrURoaAoZmnUMAtid4aFLe7flA5XXZs=;
        b=LJL7TcwV4UcqCiq2Jbmi5a9E+sHf7xYh9NddV2oAeMUnR1bGgknHQEV8FqW7Fwn1M4
         KDAO4e9cc82s8YbLZMEHaD47/ZN5ZmdivGNXfiUNWbAA9Fe9grzK+HAbdiDH0C3/9DkA
         t/QzTBMydmHYZzDAk2MC3B/GGgEBfeHc37B8zuyxN7IGCmOpqGlHCeSsEl3k22xwRttQ
         IzbdXilFrXV9FoUi7St9jiISB10IHCOHqHqrQuWypT3G76E3qqJUKx5sY9hb3e6DXGu/
         usGsCWQ2ASE5YgmigLB9M8t8c1IEGx7N+ucU21aN8BSKH2Q5VXjEqTyiSKMjiqQUAL5Q
         FGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847192; x=1710451992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KcRdxUsnfY4lrURoaAoZmnUMAtid4aFLe7flA5XXZs=;
        b=bGBbZi20DrKRzZhn0QuHJ+RTQukJ8A9dwRZgTIwWXEBMUYBjfX0ot0+yj5kTDfeK02
         ByyJCAGmcG5FmhYd3GU31/tf75v351Zh+RyhAWx8UbO7CU8zCZrheSDWXEJGKVvUhw7a
         0aX/fYNiW0Amrh8noToIeZu+4i3BGw7iAM95JGGn9YJJdFlAro4j5aP7VKH3YgMDqHdo
         wWgbjSzdASNOPaqdj3hL0SSr2WiFVMVUf23dfqDQ7D/lKHI6KnJk8A1uOSct7yqGEajA
         7JpTluH4PRswffku3AtPuYc06WGGqrjcOmxuoehBwBJxo1N5csIhADs/YbkwtXsGT/ri
         I6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZOyu5pujdjDWE62uZ1hFlq79XQOUouydMRigYudEDGuLc5WCLSX6g64lcitM9Q79BbdGGBUzXnLDZ8U/Qdv+O2uryMkkc73Wa3tD8iOw=
X-Gm-Message-State: AOJu0YyPcYrThPOy9y4WQPIGe+b4tF9l9Cs+NDgRtkqNWiZ3OwEnsxBg
	3VirsSvqcIINzu+KyNiY1N8eCcLpDK5nYvhBpnllz88C3PpnvZUMprLdIplKpKM=
X-Google-Smtp-Source: AGHT+IEIZ5Bq0gUkg8eGb8dSnjmcn/yxs210qHWqUuXnY0jZp8AuB4DTJR7s1nyb0ByOyBua3WrKtA==
X-Received: by 2002:a05:6a21:32aa:b0:1a1:77ed:5abc with SMTP id yt42-20020a056a2132aa00b001a177ed5abcmr2708513pzb.34.1709847192375;
        Thu, 07 Mar 2024 13:33:12 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id y9-20020a62f249000000b006e535bf8da4sm12845551pfl.57.2024.03.07.13.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:33:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1riLMS-00GQUj-1Z;
	Fri, 08 Mar 2024 08:33:08 +1100
Date: Fri, 8 Mar 2024 08:33:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/10] block: move discard checks into the ioctl handler
Message-ID: <ZeoylEeVMt2fXT2R@dread.disaster.area>
References: <20240307151157.466013-1-hch@lst.de>
 <20240307151157.466013-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307151157.466013-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_133314_830577_50F19A8C 
X-CRM114-Status: GOOD (  29.28  )
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

On Thu, Mar 07, 2024 at 08:11:49AM -0700, Christoph Hellwig wrote:
> Most bio operations get basic sanity checking in submit_bio and anything
> more complicated than that is done in the callers.  Discards are a bit
> different from that in that a lot of checking is done in
> __blkdev_issue_discard, and the specific errnos for that are returned
> to userspace.  Move the checks that require specific errnos to the ioctl
> handler instead, and just leave the basic sanity checking in submit_bio
> for the other handlers.  This introduces two changes in behavior:
> 
>  1) the logical block size alignment check of the start and len is lost
>     for non-ioctl callers.
>     This matches what is done for other operations including reads and
>     writes.  We should probably verify this for all bios, but for now
>     make discards match the normal flow.
>  2) for non-ioctl callers all errors are reported on I/O completion now
>     instead of synchronously.  Callers in general mostly ignore or log
>     errors so this will actually simplify the code once cleaned up
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

OK.

> ---
>  block/blk-lib.c | 13 -------------
>  block/ioctl.c   | 13 +++++++++----
>  2 files changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index f873eb9a886f63..50923508a32466 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -59,19 +59,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
>  {
>  	struct bio *bio = *biop;
> -	sector_t bs_mask;
> -
> -	if (bdev_read_only(bdev))
> -		return -EPERM;
> -	if (!bdev_max_discard_sectors(bdev))
> -		return -EOPNOTSUPP;
> -
> -	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
> -	if ((sector | nr_sects) & bs_mask)
> -		return -EINVAL;
> -
> -	if (!nr_sects)
> -		return -EINVAL;
>  
>  	while (nr_sects) {
>  		sector_t req_sects =
> diff --git a/block/ioctl.c b/block/ioctl.c
> index de0cc0d215c633..1d5de0a890c5e8 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -95,6 +95,8 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
>  static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  		unsigned long arg)
>  {
> +	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
> +	sector_t sector, nr_sects;

This changes the alignment checks from a hard coded 512 byte sector
to the logical block size of the device. I don't see a problem with
this (it fixes a bug) but it should at least be mentioned in the
commit message.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

