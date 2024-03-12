Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61F8C54E5D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 22:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t5Y0ZkpL8pv5ND+BwhLtUg1FuCHMS8Wb8W4WSKhEpJ4=; b=gp2wKFNzZ3LDajbIOXegS04HvT
	5qpzGL1+PmKYGYAOQ5WtVoCmtvSS45Wd1qxRaIHZXkriIv80ojAoq2chYLZsTm0TT9uXpbEwhkIAT
	kl3lSSkrc3Gvy/cb/HOhbNTKpOAufmPtjG4lC+Xuk3QHJmlrVnLkjt6sfBxa8TmRGf8Ox98qXJ68c
	Vzio4NPkbir8f67ZGHYT7LdN58JkllJMjEBpIL0Om0PdPFJZ4XfYfdii8LTnZ+jtAPRZWF+srfmA3
	F20KG33g/fNLki9H0FBgl8uaGru1x3aU60lNmTn6z0Vvfh1sftvPlh+R8dQdXHdTqJMzz7mwwx6ei
	14072QEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkAMp-00000007l0W-13lM;
	Tue, 12 Mar 2024 22:13:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkAMk-00000007kzT-3kUd
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 22:13:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1DDF261329;
	Tue, 12 Mar 2024 22:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549ACC433F1;
	Tue, 12 Mar 2024 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710281577;
	bh=9uq/j3Hgz3Vttrm8luZzODCRNkQqejQaOuzuZQeBZnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nT2NL4iyCmA0WNjwMrhLBIK3E4V5hxU/npyfBL3ZpzgemrK+gfAzrwixATP1A9cMm
	 lqfxnfHWZwbnKIE+e9ZzN5u34fAjg1bicAZ4fok8DUBLlUzRN04UQDVR9ydFeJVfQI
	 R2/+op6Tldx3OO5Y+weXXltAsTS1Nsv7mZJ7ARSQ4ZlRUqFj+y2HNovyoChWMprOmw
	 kZBTB4viIZakkq9mCZyoNIFXAFOrrkf7e7OPa4kaEWeMhnTWRry91/oGDEi1dVdUON
	 qpDdN8FWb9ma7yVsUTnESw4SoCeFknMHGAKsRyc2GeCYJteWUSqv4l0shIlmUnt2qw
	 zrfRatW5y/H2g==
Date: Tue, 12 Mar 2024 16:12:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] block: move discard checks into the ioctl handler
Message-ID: <ZfDTZpuumZSn6oPp@kbusch-mbp.mynextlight.net>
References: <20240312144532.1044427-1-hch@lst.de>
 <20240312144532.1044427-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312144532.1044427-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_151259_278737_C9A35BB6 
X-CRM114-Status: GOOD (  13.01  )
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

On Tue, Mar 12, 2024 at 08:45:27AM -0600, Christoph Hellwig wrote:
> @@ -95,6 +95,8 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
>  static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  		unsigned long arg)
>  {
> +	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
> +	sector_t sector, nr_sects;
>  	uint64_t range[2];
>  	uint64_t start, len;
>  	struct inode *inode = bdev->bd_inode;
> @@ -105,18 +107,21 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  
>  	if (!bdev_max_discard_sectors(bdev))
>  		return -EOPNOTSUPP;
> +	if (bdev_read_only(bdev))
> +		return -EPERM;
>  
>  	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
>  		return -EFAULT;
>  
>  	start = range[0];
>  	len = range[1];
> +	sector = start >> SECTOR_SHIFT;
> +	nr_sects = len >> SECTOR_SHIFT;
>  
> -	if (start & 511)
> +	if (!nr_sects)
>  		return -EINVAL;
> -	if (len & 511)
> +	if ((sector | nr_sects) & bs_mask)
>  		return -EINVAL;
> -
>  	if (start + len > bdev_nr_bytes(bdev))
>  		return -EINVAL;

Maybe you want to shift lower bytes out of consideration, but it is
different, right? For example, if I call this ioctl with start=5 and
len=555, it would return EINVAL, but your change would let it succeed
the same as if start=0, len=512.

