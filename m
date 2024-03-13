Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A42C54E66
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUhnQ6/0wEPPox6qQUghOviQq3jbmjZS4/ctNxPA3qI=; b=ET6D0qpYsEHJnZxJOu8qG5kR2Y
	ImqznOe3r27w8xLVuJE8TeEbOPs1vnoGGVAOGov8ATQM0DbZI+k+G+Y/w//KpWRit238Os+h67Kk/
	5KHCSY8MHeLKoL0d6YoBe7rMXw7mjajLC6xCTWyHjZ0FceZnKAMlQU+p5rCOa5XVhLEetgYrGYOej
	0JapxesrTLwY324Ri2+SAxeUrVsitqPoza5FtkgSHyy0J3vxGULMshgLvQEfOLWafoS+cjlLaN5lb
	VVVLJskiO5/RSkgllNW6ruBV7+CZJ1oxs5qSMukiwn/Q89pka94EjBNle40DSUlatlfQFqbHxRruL
	KOf6hrhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkQiS-0000000Adm4-482E;
	Wed, 13 Mar 2024 15:40:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkQiQ-0000000AdkE-0bbp
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 15:40:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B1BEE61492;
	Wed, 13 Mar 2024 15:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C3EC433C7;
	Wed, 13 Mar 2024 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710344424;
	bh=4oJHI0KfHtFW48aWPDA3mAGSBQe8ddaVpidCtCXY66c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyPZrvutV1rMvBM6CPZ6YdneIOaxMrU+MQB9zKY431uYWS7E8PUMD3VYPUUTQJPA/
	 /RJYvsuyBXKtnvjCwpeeaIVOCWWddhNIL5K6YxIuVs9R4QmYTF4YrNGjG/TS/B0IJe
	 P65yg0NF03klIR7w5fH2iGkInRgaOrKPVoGkDYPlvw1hue0GFj10WHZl6vvwvtjThs
	 JMmF8xQE4aDFjb/zY9qWiGYCWcJDd17XiAwwaXacdNfQodkOzhK0aleDQ4ovDgdttu
	 5pQFm0438fQpQ1mH7rQyOOnferj2EVI6wRiMrx6Szmvs0GOMYU1+yQiJ/4pHv/LgaB
	 EyjMrw6sli/3g==
Date: Wed, 13 Mar 2024 09:40:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] block: move discard checks into the ioctl handler
Message-ID: <ZfHI5Vr7BOU6__rv@kbusch-mbp>
References: <20240312144532.1044427-1-hch@lst.de>
 <20240312144532.1044427-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312144532.1044427-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_084026_258152_844C30FD 
X-CRM114-Status: GOOD (  15.55  )
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
>  
> @@ -124,7 +129,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
>  	if (err)
>  		goto fail;
> -	err = blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL);
> +	err = blkdev_issue_discard(bdev, sector, nr_sects, GFP_KERNEL);
>  fail:
>  	filemap_invalidate_unlock(inode->i_mapping);
>  	return err;
> -- 

The incremental change I think you want atop this patch to keep the
previous behavior:

-- >8 --
diff --git b/block/ioctl.c a/block/ioctl.c
index 57c8171fda93c..e14388548ab97 100644
--- b/block/ioctl.c
+++ a/block/ioctl.c
@@ -95,7 +95,7 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
 static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
-	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
+	sector_t mask = bdev_logical_block_size(bdev) - 1;
 	sector_t sector, nr_sects;
 	uint64_t range[2];
 	uint64_t start, len;
@@ -120,7 +120,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 
 	if (!nr_sects)
 		return -EINVAL;
-	if ((sector | nr_sects) & bs_mask)
+	if ((start | len) & mask)
 		return -EINVAL;
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;

