Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CC1C4828F
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Feb 2024 07:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWEBgPorOsSGJ07ecvAQxR0gZ8MmCgBQMNx3m2Et4Jk=; b=cV40WAfNlEeIV4selPPcBPod2B
	srN4GL4kDcJ3/TVb/udaUO6NuN5X2kGEMgyL0UbaWX+TO9GBN0ZW50XSRICRQCPfWNlqZUy7l8Jc2
	82nvk0urEUPqu+rL1KxYeWZSD60VRFxIuk3+1tzwNGxTGU2B/vvMa70nG3b/pRzeZ/32LJPoasojp
	XJqRq/uWQ6a4qZr8HaPIXOqq5qmaC9hKcnM96+K4eM7SoZtqeDB59jrr+PmfVGwivgk1QoPpNjv5V
	OuW2HWDOeGTgsEBTj9lM2NDOCBo7/6ak6Cl6tyDBgSVQpn7jHXADayfz8wBGrRhdI4YQDcgAr09a6
	F59pY5pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYLYr-0000000GMtv-2omq;
	Fri, 09 Feb 2024 07:44:37 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYLYm-0000000GMtM-3BI4
	for linux-nvme@lists.infradead.org;
	Fri, 09 Feb 2024 07:44:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 69322CE1F77;
	Fri,  9 Feb 2024 07:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F47CC433C7;
	Fri,  9 Feb 2024 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707464667;
	bh=8hPt35qwRNiqM7E/NAuVeN0iulCZTDSGB64rom1/iK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N48zljBWfUubIvX0MUYFWqfl6rPsb78Iuq4D7JxpYeP9qvXRrk9pFVtNPG958TxfD
	 +vGODzAaCy9jcR4gPg1qmPA15BPf6wFA1xdT5H25LeaBRe4aD063S5dFXGsk3rZZfp
	 nRlF1gZUVVVtRlWxmBz7Rjw7hKnnYP8oABe1jzw4EDkUfsz8BFIyGR+icMYChdCF4L
	 /JN4H7lRm7ANC4HrekEzSRn2UQVpOItwAbDsu0jIJeeUTlMaFjs3IxENEcKftob8XX
	 Lashwuzy8nHlTM24X8G9km4JhTVHVJk67i7e6QiRQFF/8fdfRZBDuhx5P8/B9mW0MV
	 idTp1kr45CINA==
Message-ID: <7c2c7925-b21c-4861-81a7-d49f39a85e29@kernel.org>
Date: Fri, 9 Feb 2024 16:44:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-1-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-1-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_234433_012965_E4E26F94 
X-CRM114-Status: GOOD (  18.34  )
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

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
> zonefs_zone_mgmt().
> 
> As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
> from a place that can recurse back into the filesystem on memory reclaim,
> it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
> 
> Link: https://lore.kernel.org/all/ZZcgXI46AinlcBDP@casper.infradead.org/
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 93971742613a..63fbac018c04 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
>  
>  	trace_zonefs_zone_mgmt(sb, z, op);
>  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
> -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
> +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
>  	if (ret) {
>  		zonefs_err(sb,
>  			   "Zone management operation %s at %llu failed %d\n",
> 

Given that zonefs_inode_zone_mgmt() which calls zonefs_zone_mgmt() is only used
for sequential zone inodes, and that these inodes cannot be written with
buffered IOs, I think this is safe as we will never have dirty pages to
writeback for reclaim. So there should be no risk of re-entering the FS on
reclaim with GFP_KERNEL.

So:

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


