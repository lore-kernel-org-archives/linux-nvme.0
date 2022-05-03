Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC0FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 20:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mbnLZXvmjiUydw6XV2zP4n7v0/cS2cpfMEj9/h01KLs=; b=Pg09Kn1J1rT8MIsJzJ5BjdQXmS
	F3T0Y9tEJM0CeTCyqLbBiV2tnN3ujNqMHYh7VcO45jAYZeUVeYXGdUC4Msn47hxoLZ7RnrSyReM0U
	NkfCp2K7fOZgAtA8Orr5+EZogyVUQOaHijrELm7tzW7xLIqCAINh40ws2EE98fMusPh+9XqhxeUUF
	xJhub2HEm3uX4YdvmOvuOWkG5tM/ryvREXjl87CtDsdfWJCRXhWptOoadYjo0uiErM6gZuXAs58VC
	KgNR0R9fsyqB8OXpMjndQuGKYjSWZmmonGn82mwkz3EVRMgqEPFeeDS9ZbyOcI5H4bgKeD3UQ3d97
	TrKiyDWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlykt-007UD2-7p; Tue, 03 May 2022 20:04:19 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlykp-007U9y-W1
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 20:04:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3137CB82061;
 Tue,  3 May 2022 20:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F65C385A4;
 Tue,  3 May 2022 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651608251;
 bh=yEwIKUkYrUe+UB4k6sDSTOcJaUQFRLK0s3/p+P/axO8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GI4PqtOAj9PMvq17VbxQwejZWyW9waSFBPKixzYGnlcgVZKbWRTtbDsNIZZwaqgJW
 oRbRzsBLXIeXqedBxITy5sBQxpsdE8I0dm3cEPiXGUZcnaeNIQ12WIBdr1DNLQll1t
 +pUS07koL10aaZ31K0ZVF/uLZ+EZZBoxW+DCQadgwgerGjiYcHn3UgSgB4OcJyJiYe
 i6tehN8h7cCda5ctDbs17t6pRzGracdobePQtcHkfSJEEz+G6rES43RSs+L4zfA7c4
 iHfsO8Ek/+4eQNxEj3/7v/WG9g0aL4gDw9K4vOzjBpm1V5OnkKQ8fUIpjm9PDrF8aA
 kouE3UjVHDJkQ==
Date: Tue, 3 May 2022 13:04:08 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me,
 damien.lemoal@opensource.wdc.com, dsterba@suse.com,
 johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
 chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
 kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 14/16] f2fs: call bdev_zone_sectors() only once on
 init_blkz_info()
Message-ID: <YnGKuET79JQ+ssPp@google.com>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160311eucas1p151141fc73adc590b40ad6f935b1ac214@eucas1p1.samsung.com>
 <20220427160255.300418-15-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427160255.300418-15-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_130416_201626_22884919 
X-CRM114-Status: GOOD (  18.65  )
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

Applied to f2fs tree. Thanks,

On 04/27, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Instead of calling bdev_zone_sectors() multiple times, call
> it once and cache the value locally. This will make the
> subsequent change easier to read.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/f2fs/super.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ea939db18f88..f64761a15df7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3678,22 +3678,25 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>  	struct block_device *bdev = FDEV(devi).bdev;
>  	sector_t nr_sectors = bdev_nr_sectors(bdev);
>  	struct f2fs_report_zones_args rep_zone_arg;
> +	u64 zone_sectors;
>  	int ret;
>  
>  	if (!f2fs_sb_has_blkzoned(sbi))
>  		return 0;
>  
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
>  	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
> -				SECTOR_TO_BLOCK(bdev_zone_sectors(bdev)))
> +				SECTOR_TO_BLOCK(zone_sectors))
>  		return -EINVAL;
> -	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(bdev_zone_sectors(bdev));
> +	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(zone_sectors);
>  	if (sbi->log_blocks_per_blkz && sbi->log_blocks_per_blkz !=
>  				__ilog2_u32(sbi->blocks_per_blkz))
>  		return -EINVAL;
>  	sbi->log_blocks_per_blkz = __ilog2_u32(sbi->blocks_per_blkz);
>  	FDEV(devi).nr_blkz = SECTOR_TO_BLOCK(nr_sectors) >>
>  					sbi->log_blocks_per_blkz;
> -	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
> +	if (nr_sectors & (zone_sectors - 1))
>  		FDEV(devi).nr_blkz++;
>  
>  	FDEV(devi).blkz_seq = f2fs_kvzalloc(sbi,
> -- 
> 2.25.1

