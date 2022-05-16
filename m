Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004DBC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 22:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6cIkZu1t4JcnuW9jTK0PkgF8th7GaouWhYTdI3D3pyk=; b=3Gucq8VlRP3h0YWahTffgWQ8X6
	eVOnmwUsvJ0LyI4MR5rFMpLBzaSASzXMCc0Ym+oF4U4R5qaT2T8wQO7OqMzh9/ZPz8fBL5jgh0Ab7
	QuoI2nHnMhJ/PweHE4268d97F0AZVMuZL5qsPgTgVPU4JXdUGwkl/l0Ishje/DOrsEVHldHnhU0qn
	wHdYMT3xNFpNMgqqcXAsM92vW5hXSKUhvu0LeOUyXwu7lvVDM6tONLEClDj7nNROCthpgAuhQxOvK
	/NvK9ql242ZCiGmJTB9hJQdc26UWpsrRtuV4xm0UM/sWRnXGnB+0nATMpAgfVCWDeNW/RKM8/VA1J
	CNAN3Gxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqink-00APmQ-CM; Mon, 16 May 2022 22:02:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqing-00APl9-Ru
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 22:02:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 795551F939;
 Mon, 16 May 2022 22:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652738565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6cIkZu1t4JcnuW9jTK0PkgF8th7GaouWhYTdI3D3pyk=;
 b=WIhYvYEZcJpAzfluzqgnCgqoHviPg90OjQmw4bs072LgnnGqsiE/4UuMiX7NNiu7SYt0tG
 N29JVeHRfPwAAO9zoEFeDTIvjtO682d2smEJwb8eqWO+upjxNP+SQ10Vg5hyFnbAuIZ8zk
 DAltVMxGzxwpgu2Y/RcPgjBCG29y9zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652738565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6cIkZu1t4JcnuW9jTK0PkgF8th7GaouWhYTdI3D3pyk=;
 b=98ihLesEtp+MaFmDUwSOzucf9EYfg9IyKPNxVVFd/HqJJ3yMz3X35in+n0wIM10GXhgEZu
 JK7GAlzwShThY5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 102A313ADC;
 Mon, 16 May 2022 22:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w1/AAgXKgmLnQAAAMHmgww
 (envelope-from <dsterba@suse.cz>); Mon, 16 May 2022 22:02:45 +0000
Date: Mon, 16 May 2022 23:58:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
 dsterba@suse.com, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 jiangbo.365@bytedance.com, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 05/13] btrfs: zoned: Cache superblock location in
 btrfs_zoned_device_info
Message-ID: <20220516215826.GZ18596@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
 axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, dm-devel@redhat.com,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999@eucas1p2.samsung.com>
 <20220516165416.171196-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516165416.171196-6-p.raghav@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_150249_089695_533FD3E6 
X-CRM114-Status: GOOD (  20.36  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 16, 2022 at 06:54:08PM +0200, Pankaj Raghav wrote:
> Instead of calculating the superblock location every time, cache the
> superblock zone location in btrfs_zoned_device_info struct and use it to
> locate the zone index.
> 
> The functions such as btrfs_sb_log_location_bdev() and
> btrfs_reset_sb_log_zones() which work directly on block_device shall
> continue to use the sb_zone_number because btrfs_zoned_device_info
> struct might not have been initialized at that point.
> 
> This patch will enable non power-of-2 zoned devices to not perform
> division to lookup superblock and its mirror location.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/btrfs/zoned.c | 13 +++++++++----
>  fs/btrfs/zoned.h |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 06f22c021..e8c7cebb2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -511,6 +511,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  			   max_active_zones - nactive);
>  	}
>  
> +	/* Cache the sb zone number */
> +	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
> +		zone_info->sb_zone_location[i] =
> +			sb_zone_number(zone_info->zone_size_shift, i);
> +	}

I don't think we need to cache the value right now, it's not in any hot
path and call to bdev_zone_no is relatively cheap (only dereferencing a
few pointers, all in-memory values).

