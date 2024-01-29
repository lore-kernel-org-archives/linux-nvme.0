Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F7C47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 23:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJ/adbXNeENWraKDlCoH3Ivzuv7/MQojEYbIx7jumos=; b=ChrvWxV221RNWbGuZr99Ogg6Np
	vcMuiMpAZMWW/yTwyU68Yn36q+eKGtwNl4HGIdcmTIoU9NCcKZbu3/igmCIvFECHRuJnmpcMIHg69
	EnrbOW6Rq6PD9vOy/B/2Q8ISd3ORIXHWPd8I82+vaEOeGtrCE0ABKhGie9oXqvWDO3lwYYBhqD+Dv
	ppFpIfR4MnYRh9A4sRgC2SoTYf/K44Eq7zScWKq1lfvJdYscybKkFhOLdUQ5ZfnKFir5lyOwesq9u
	Q3gCn5RMSR8XHa/56P398nLmcSUXLK8gPAGAhVv0zbtzZXD9PsRiYwEOQiw1Bz4XBe5iaMRcIP7oq
	jqCulMcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb0X-0000000EZeh-1du5;
	Mon, 29 Jan 2024 23:25:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb0U-0000000EZdg-08Z8
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 23:25:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 88DEB625BD;
	Mon, 29 Jan 2024 23:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4E9C433F1;
	Mon, 29 Jan 2024 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570735;
	bh=rlXD8wrR7LGaE3yPipo4oss7yBMRHRL+ZqlHjIj2kt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bm5vgGd8iLgqVAS89ky5CprUejORrrO+L2Fm2jCGiGp9VUCRfnTu3zsHrnPsqtld/
	 GxZX0GpHfKiJtELlkp//qvfy+Iumzg2up1xNCtSSH96om1ftwi/oHPyzuNe8oZQdPS
	 FVh7JCk3yR8dHonw8oFafOdyX2eu5cEadJF1NwFhWQTA3YD9WIjfeTfBKqWjttbUp2
	 yZwdUq0oPF2A/f8W0vp7FkRZXx5Sc+i3DX+NXwp/mcouZV/6Az6J2ugDuWlE9EDosr
	 LuWkKwPhPn4vaMObQ6+6Y8YPEZepYVK7x5GzIQFzGSW6U4iJcePs0HWzVO/oxRMOUT
	 m5ciZiseX3ZIQ==
Message-ID: <6f0aed31-b9a9-4655-9c8c-839f978b40d9@kernel.org>
Date: Tue, 30 Jan 2024 08:25:31 +0900
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
X-CRM114-CacheID: sfid-20240129_152538_146860_EDD537AA 
X-CRM114-Status: GOOD (  19.34  )
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

s/save/safe

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

I think this is OK but I will need a little more time to fully convince myself.
So let me look again at the code to check all the calls contexts.

-- 
Damien Le Moal
Western Digital Research


