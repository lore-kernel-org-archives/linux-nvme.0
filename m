Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBD1C47DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Feb 2024 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=dYKBi+Kx0kph0B/S8oQqjrPvt1FVU1da3rN7thqVsdg=; b=pnqBeAVCGR9K+x
	rfKStVLILwQRrc+9/UxDbnTXpaES41y96tk5PUXfG6OSZS1tHZiRg2dE1ti003UaQt3fenejND0zk
	H4wYiEcWNw/6bDYUGOgLskSS8/4y1hkf7uh42UB3FxKZ+OHkyRXEcYqI9xdYMaPFRP1AXbzO8C53J
	7Og9p1TZbSCIOr/syidg8GpROw+Y7f/0W7Ca1l6bEs+7MJ83lg1W3K2eBz3IAKkeLvPep1BzY+gB8
	+w16SchEji9415avCaM0dnltWnQ/mIcHxcSdy5O/s+F/HXN7vJy5xZd0y0ZwDMXqkAOAveERgbFj3
	ia4t7D40FxmJt/aW5pJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reFMb-0000000F3pa-1G0j;
	Sun, 25 Feb 2024 14:20:21 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reFMY-0000000F3o9-1XT6
	for linux-nvme@lists.infradead.org;
	Sun, 25 Feb 2024 14:20:19 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1dc5d0162bcso18734665ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 25 Feb 2024 06:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708870814; x=1709475614; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dYKBi+Kx0kph0B/S8oQqjrPvt1FVU1da3rN7thqVsdg=;
        b=gyUdhVVxJ91DXv0ZFEFfnS+Sgprfw6ZkUAbUG6Ip7fMifPbJ9n7+3GPcGcnlzbVVx3
         nzV2O5GFXDTIBuqea8aETzBXUnQu5d9il/IvkX4WCLUU12ChB5B5f55dGQH1A2T85GAG
         gRG9b0qPr4LIhsXGOA5upIXUvn871uLBoirSoYdnhYWW044607KxvnFITeyXt05uVIOW
         OBvLO9HanKZzHW2B0gQzNnsRF87VbJM4eVpWbJJuzGK7l5RiugjvRahKtPTSzhLe5AsO
         6YisJWChzLPea+7oqUVClW97wjTSkIAAsaofTcgnLR+CnOsPfvuDn5YWrGU0XAMciMnd
         FLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708870814; x=1709475614;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYKBi+Kx0kph0B/S8oQqjrPvt1FVU1da3rN7thqVsdg=;
        b=aGmlUyHZOlT26bb/pSIVlkLquJubeZoTiS1xjslUl2dd58hOacHfskMLeea2EMzHx7
         LtGPVQtcFqrhUHDr9uEtayFyNzTirRplnkK8MMvOsaLgyJVLKkTc3qplj91TlfB4pKyZ
         twPvrYFzskz5adi9lWnjoPbX8SE+UxG6vYasrk/vpJD5dpCjsaxq9LPtSQNpyR2+PObe
         vIAiQWNwOfszw9xZUbtY5gD0Fx0RvMfF1kl/FeNVdWgpfPCQ8NJFjhxipoL3RFnT9V6p
         dOW1tWkTuhCDlwLr2yLgEd0hrrTPBmSr5XL05EFg2vNWbmcx3fW2jDj297bPK3vTCeYG
         6cZg==
X-Forwarded-Encrypted: i=1; AJvYcCVVfmR2lKKEmuk89C2rgiraygtZUcXbhiMJq7WmkezkO3yi1lV2wRlpblVVEEZIW4d50C7/GbSELjw2UsEc6hbwCGNI662tlcpOcnNP96s=
X-Gm-Message-State: AOJu0YxSvP5CtalNCvyFnSJYZORVX70mZwGfTzJpeoCVYLHnkDwWwJSY
	OcaTUTO0lMTfl1/TCV6yba274b6NTX3M0yIQDfd0kyr3Gz7tlBVz
X-Google-Smtp-Source: AGHT+IEXYxsOr0QSU3u6gD+WhXD9eZzTG9jlMHzB6YlRK1F6+maANbBs6nKGmmS0D2Yf2XVZrvmbdA==
X-Received: by 2002:a17:902:6506:b0:1dc:8fb0:2b9e with SMTP id b6-20020a170902650600b001dc8fb02b9emr1407177plk.34.1708870814349;
        Sun, 25 Feb 2024 06:20:14 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b001d7252fef6bsm2357872pla.299.2024.02.25.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 06:20:13 -0800 (PST)
Date: Sun, 25 Feb 2024 19:50:06 +0530
Message-Id: <87frxg1v8p.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, Prasad Singamsetty <prasad.singamsetty@oracle.com>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 06/11] block: Add atomic write support for statx
In-Reply-To: <20240219130109.341523-7-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_062018_434308_8701991C 
X-CRM114-Status: GOOD (  25.72  )
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

John Garry <john.g.garry@oracle.com> writes:

> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
>
> Extend statx system call to return additional info for atomic write support
> support if the specified file is a block device.
>
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/bdev.c           | 37 +++++++++++++++++++++++++++----------
>  fs/stat.c              | 13 ++++++-------
>  include/linux/blkdev.h |  5 +++--
>  3 files changed, 36 insertions(+), 19 deletions(-)
>
> diff --git a/block/bdev.c b/block/bdev.c
> index e9f1b12bd75c..0dada9902bd4 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1116,24 +1116,41 @@ void sync_bdevs(bool wait)
>  	iput(old_inode);
>  }
>  
> +#define BDEV_STATX_SUPPORTED_MASK (STATX_DIOALIGN | STATX_WRITE_ATOMIC)
> +
>  /*
> - * Handle STATX_DIOALIGN for block devices.
> - *
> - * Note that the inode passed to this is the inode of a block device node file,
> - * not the block device's internal inode.  Therefore it is *not* valid to use
> - * I_BDEV() here; the block device has to be looked up by i_rdev instead.
> + * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
>   */
> -void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
> +void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask)

why change this to dentry? Why not keep it as inode itself?

-ritesh

>  {
>  	struct block_device *bdev;
>  
> -	bdev = blkdev_get_no_open(inode->i_rdev);
> +	if (!(request_mask & BDEV_STATX_SUPPORTED_MASK))
> +		return;
> +
> +	/*
> +	 * Note that d_backing_inode() returns the inode of a block device node
> +	 * file, not the block device's internal inode.  Therefore it is *not*
> +	 * valid to use I_BDEV() here; the block device has to be looked up by
> +	 * i_rdev instead.
> +	 */
> +	bdev = blkdev_get_no_open(d_backing_inode(dentry)->i_rdev);
>  	if (!bdev)
>  		return;
>  
> -	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> -	stat->dio_offset_align = bdev_logical_block_size(bdev);
> -	stat->result_mask |= STATX_DIOALIGN;
> +	if (request_mask & STATX_DIOALIGN) {
> +		stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> +		stat->dio_offset_align = bdev_logical_block_size(bdev);
> +		stat->result_mask |= STATX_DIOALIGN;
> +	}
> +
> +	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
> +		struct request_queue *bd_queue = bdev->bd_queue;
> +
> +		generic_fill_statx_atomic_writes(stat,
> +			queue_atomic_write_unit_min_bytes(bd_queue),
> +			queue_atomic_write_unit_max_bytes(bd_queue));
> +	}
>  
>  	blkdev_put_no_open(bdev);
>  }
> diff --git a/fs/stat.c b/fs/stat.c
> index 522787a4ab6a..bd0618477702 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -290,13 +290,12 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
>  		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
>  	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
>  
> -	/* Handle STATX_DIOALIGN for block devices. */
> -	if (request_mask & STATX_DIOALIGN) {
> -		struct inode *inode = d_backing_inode(path.dentry);
> -
> -		if (S_ISBLK(inode->i_mode))
> -			bdev_statx_dioalign(inode, stat);
> -	}
> +	/* If this is a block device inode, override the filesystem
> +	 * attributes with the block device specific parameters
> +	 * that need to be obtained from the bdev backing inode
> +	 */
> +	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
> +		bdev_statx(path.dentry, stat, request_mask);
>  
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 40ed56ef4937..4f04456f1250 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1541,7 +1541,7 @@ int sync_blockdev(struct block_device *bdev);
>  int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
>  int sync_blockdev_nowait(struct block_device *bdev);
>  void sync_bdevs(bool wait);
> -void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
> +void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask);
>  void printk_all_partitions(void);
>  int __init early_lookup_bdev(const char *pathname, dev_t *dev);
>  #else
> @@ -1559,7 +1559,8 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
>  static inline void sync_bdevs(bool wait)
>  {
>  }
> -static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
> +static inline void bdev_statx(struct dentry *dentry, struct kstat *stat,
> +				u32 request_mask)
>  {
>  }
>  static inline void printk_all_partitions(void)
> -- 
> 2.31.1

