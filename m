Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B22DC7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=utvU5QtMOHItQUMD6lrtAs8Wr5pQXqi5OJWCl5bkj/0=; b=Tt5rsKZ4XKJcVgtxR9DjsqYOUl
	lBx//l2tZX0Kxu97L18J2P2ZkFGI5ErsRmR1S2Sw2NldaSEuGGmNIdf7l+xjV9yyYt8Urb6IARpXT
	cAZW8CedBtQYMfwSjE2upsyvB75QacV5OU4wou0zU3W2adVCHVEWvHhgcfbd4sXBbQ3I0kX/T8Pu/
	AEl1U3AFvehKVmezz+ijRjde5YisBmbwVX9kK0BL/XEsrtI1d0QqvIqX5yKf8shr4sbsgklkhMuyz
	oRHHUEbntfke9D/fhsNYVRuJD1UFBhiszqiiJciftvYzLtittgJLCNWX4b9R6Qq4eF/rFqxmqzIrM
	Cs9KpdWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKUx-005vGl-18;
	Wed, 03 May 2023 21:58:55 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKUu-005vG5-1M
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 21:58:53 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6436e075166so422366b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 May 2023 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683151130; x=1685743130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utvU5QtMOHItQUMD6lrtAs8Wr5pQXqi5OJWCl5bkj/0=;
        b=tvIXyHrnLyKA2x1/3ixxeDOmxncJn3NGOI34hCBw6aO0vlBonwcg1VFOG5j3O8dbXI
         6INVus5KAgUVJq2EsYw5CY9f9Ik16f7QXHgdKbNWrWt5O94CBfM1xEj4/vRg4s+5elHd
         FSc1O2VPz2/GHRq/pdkaGfYgQ1P1sRS6Bs+ZcHCC9woSFJBCySsUZM4dSURJ+ynG7Xot
         CHzooPFNGVLm90Gu2WAvozhH/rrV4glEWUZhEstADJ6Jqv1kQEEuy+jJSX9CeWXFshVu
         SdRH0tPycWs8EbaHXYCPYCihh0qtb5/2zAqhhJ6PbpqHs5YaC8mvf27EKhScsw321GZw
         6hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683151130; x=1685743130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utvU5QtMOHItQUMD6lrtAs8Wr5pQXqi5OJWCl5bkj/0=;
        b=UU8aNFarEf7cSouhnpyYBX6fAVe04LerQRvAzrZDEABPvX0q20X1AYbaalh+itEFko
         49ql3vk2XaYIUKaoAK1uv2vADQ5sQRJK4GE+eieUzkBvsrwjctOAJT77fKcWQyP9x6gN
         9jtVe8BRsl2V2eHj/hOgZrlW8hZZmCLazhWxCusuZwBP0IsglvvpvzvEG3kLQ5cmyluW
         dYezpgwHgxvuZwuU+JzlO8JXaDrWo3llDgQDcqx/k8k7SFnPj7+DF0XVw3qaZ5YTaN0s
         d837ePLmwffwoW+OUkMN+JaTS/RRNNYZIkHBATfxzWOm0cyU7+PvEwLA+5M1eJxDYk35
         4keA==
X-Gm-Message-State: AC+VfDzdKDUshtu2snUlMrSPOEBii8WxNn0ygIYkT8B2cKlAy8P7NgL4
	xSjJEc2EnDO3FEkl6nti4jZ4lQ==
X-Google-Smtp-Source: ACHHUZ6p7TCZTMBYI9apxL3KzrmzkMEgHVXC+J+6oGMOdBUet/QJwy+eVYfp51Of6HElOgcccqSInQ==
X-Received: by 2002:a05:6a20:1593:b0:f3:3578:6699 with SMTP id h19-20020a056a20159300b000f335786699mr28979966pzj.45.1683151130066;
        Wed, 03 May 2023 14:58:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id y72-20020a62644b000000b006372791d708sm24025265pfb.104.2023.05.03.14.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:58:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1puKUo-00B0iy-Si; Thu, 04 May 2023 07:58:46 +1000
Date: Thu, 4 May 2023 07:58:46 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jejb@linux.ibm.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH RFC 02/16] fs/bdev: Add atomic write support info to statx
Message-ID: <20230503215846.GE3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503183821.1473305-3-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_145852_482095_0DAFFE3E 
X-CRM114-Status: GOOD (  29.23  )
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

On Wed, May 03, 2023 at 06:38:07PM +0000, John Garry wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> Extend statx system call to return additional info for atomic write support
> support if the specified file is a block device.
> 
> Add initial support for a block device.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/bdev.c              | 21 +++++++++++++++++++++
>  fs/stat.c                 | 10 ++++++++++
>  include/linux/blkdev.h    |  4 ++++
>  include/linux/stat.h      |  2 ++
>  include/uapi/linux/stat.h |  7 ++++++-
>  5 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 1795c7d4b99e..6a5fd5abaadc 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1014,3 +1014,24 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>  
>  	blkdev_put_no_open(bdev);
>  }
> +
> +/*
> + * Handle statx for block devices to get properties of WRITE ATOMIC
> + * feature support.
> + */
> +void bdev_statx_atomic(struct inode *inode, struct kstat *stat)
> +{
> +	struct block_device *bdev;
> +
> +	bdev = blkdev_get_no_open(inode->i_rdev);
> +	if (!bdev)
> +		return;
> +
> +	stat->atomic_write_unit_min = queue_atomic_write_unit_min(bdev->bd_queue);
> +	stat->atomic_write_unit_max = queue_atomic_write_unit_max(bdev->bd_queue);
> +	stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
> +	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
> +	stat->result_mask |= STATX_WRITE_ATOMIC;
> +
> +	blkdev_put_no_open(bdev);
> +}
> diff --git a/fs/stat.c b/fs/stat.c
> index 7c238da22ef0..d20334a0e9ae 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -256,6 +256,14 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
>  			bdev_statx_dioalign(inode, stat);
>  	}
>  
> +	/* Handle STATX_WRITE_ATOMIC for block devices */
> +	if (request_mask & STATX_WRITE_ATOMIC) {
> +		struct inode *inode = d_backing_inode(path.dentry);
> +
> +		if (S_ISBLK(inode->i_mode))
> +			bdev_statx_atomic(inode, stat);
> +	}

This duplicates STATX_DIOALIGN bdev handling.

Really, the bdev attribute handling should be completely factored
out of vfs_statx() - blockdevs are not the common fastpath for stat
operations. Somthing like:

	/*
	 * If this is a block device inode, override the filesystem
	 * attributes with the block device specific parameters
	 * that need to be obtained from the bdev backing inode.
	 */
	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
		bdev_statx(path.dentry, stat);

And then all the overrides can go in the one function that doesn't
need to repeatedly check S_ISBLK()....


> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 6b6f2992338c..19d33b2897b2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1527,6 +1527,7 @@ int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
>  int sync_blockdev_nowait(struct block_device *bdev);
>  void sync_bdevs(bool wait);
>  void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
> +void bdev_statx_atomic(struct inode *inode, struct kstat *stat);
>  void printk_all_partitions(void);
>  #else
>  static inline void invalidate_bdev(struct block_device *bdev)
> @@ -1546,6 +1547,9 @@ static inline void sync_bdevs(bool wait)
>  static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>  {
>  }
> +static inline void bdev_statx_atomic(struct inode *inode, struct kstat *stat)
> +{
> +}
>  static inline void printk_all_partitions(void)
>  {
>  }

That also gets rid of the need for all these fine grained exports
out of the bdev code for statx....

> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 52150570d37a..dfa69ecfaacf 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -53,6 +53,8 @@ struct kstat {
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
>  	u64		change_cookie;
> +	u32		atomic_write_unit_max;
> +	u32		atomic_write_unit_min;
>  };
>  
>  /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7cab2c65d3d7..c99d7cac2aa6 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -127,7 +127,10 @@ struct statx {
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u32	stx_atomic_write_unit_max;
> +	__u32	stx_atomic_write_unit_min;
> +	/* 0xb0 */
> +	__u64	__spare3[11];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };

No documentation on what units these are in. Is there a statx() man
page update for this addition?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

