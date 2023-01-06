Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29211C4708D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O0vKYWVrbysRXN3WiAachQ21fCqrVz6K6uLz7NEo2oU=; b=0Cw1AZAeucahYIIC3uJ8sPZqsE
	48Lhh6lA+5Stjjvktb8eBT77B4qbYouLnglzrldF+Tyk81nQoxV2lyDA1rmpCcfMPWDTRU/1WEsGe
	GX56h2z18lT3jvzdXKcWnjIrH42Xb0sGcVswA29mdhOdoIrOj9iFQRW5zNI3DJ9N6oyiLr0Rjx3Gm
	X4PYJqPr+U6AftaYzDj9KSQPyplzSVc0KyZcF3azCsWEiFvSTZ5xCSkkGqAnne/PWrIBk1R+nJ4aR
	G/sAlt3SJM2KS2v2I2wvLINKzolyDjRNKQCKloG72WXYVel4GdSzsviEqxotspA8xPuFXk5KQEw4+
	C/T55tQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDkXW-007deh-II; Fri, 06 Jan 2023 11:05:34 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDkXS-007dcn-Uh
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 11:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673003130; x=1704539130;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6ppI2ADbPh92LEZhl0iWNA6l1Q71OYI1WvrdKjfPvkU=;
  b=IONp3L5YqPSwhZCWibv0urllZxfiu09wjMvF+RMj5Xof2N4jyauX/PGS
   p/0HuiXxzkaqq8WQCutqb8FnGr/bwp3fFRya7OXiJHwikOkFDYMnkzIqG
   TanlQFNooilWU1qL/gxQl3/s1ZeMnm2HdpF25DzBRAMwl6Vx3GiwtzmuA
   FB/xfQ1WwzgBe0M07BZeM2DKSbD5/UA9DGKQiZhPyqUILbodqcg+4Zo0h
   rbxSode2IwiT8kyUlIdBKc3QNtIR5eS5tdicB12BKDsrtlevphjwBdv58
   25JGr/VkJPyqRTI9tfo5zx3x9EaHkrEe/4pBkrHDD60Jsf8Zumca58YoS
   A==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="324460838"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:05:26 +0800
IronPort-SDR: 2JSU2ptUkpZJjbVk7kHNlgKkzB3sl+7Xn6oeFOtcuQ/8TQaCkAVrRwJ10DePfPBtWJd7M8Tcb7
 1+zHzx0edqAgU/bx0ULZ62ZwPo6EqWCOSzEY7rS6oyvg7BaMBPjQh+fgxZLuOaAgouDGhzwKST
 ZjKpWoOKdAFqgIC1un+8+yYSUB0vau2J/Klim+42ph0N+GiHmJor5/rHZv5A+ttkipjbWpx/8+
 9VabrNy4/r/B/eauRv7L7CZZDGaf+Ud5rNLR05bYli5adIWMmCEeM682adS2KEhJqGYfcgMNrD
 Nbo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:17:37 -0800
IronPort-SDR: 1qWUO+RPgoqLfjRV//LoHIePHrwxLpq+hTdPOpvdl0p4WA7gQbmejGRL7QLjqRDRRUD8V2gwgt
 d3GCRA0kEYJiINMPB5hSQF2pCJrZKPlnql3RH5IZf5/AR7hdAh1zYDXuN0W4gUyNM+DIfvS3uy
 VXbKEz/9XFIS/QEqOaBSy1L699TKB7JjQAL7T2ehkdDfZXSvUuf8pW2Y16ZVtzHj7wVPg1z/dl
 5wJMm/72Nxn3fuz7NEu8cAjx4MXvwR2eFtaB6OpeF+rpVduTFyxQT+CSLccEmNSIaTWVraXWaA
 vkI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:05:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL923rwSz1RwvL
	for <linux-nvme@lists.infradead.org>; Fri,  6 Jan 2023 03:05:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1673003125; x=1675595126; bh=6ppI2ADbPh92LEZhl0iWNA6l1Q71OYI1Wvr
	dKjfPvkU=; b=eY8kjWzmn9wZSzKEZAguHx/VZkReXQs5zaH7Rf1ksAOkIUiIG2D
	Sg8x+oX4b1xCUJhHpLmSurhvFw4PsDvpxYaXaZHbf8U1z2hwdgSI957H33SmYv9F
	rp/kavzKuh0+qbO+Zt+W7u5BUkI0R+9gpeI/oWL6oAWZkZ2C+/Ni4qbZUDsXo7w5
	/VDhEjNCH7zNK1nDCaq84+J6R2IM9I5KbiWbDFUIKeOFqOjiufofDZroMMGIEgO/
	xecfYhJeEGLPjqyZ6JENptrcgojcXfqk0DYRVEwu97W9sXK640ZVGBrN49yDT0EK
	WvAlPZbEwx1ayzySGTS7Oh1UyII9ualn1hQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h4ThA5BG-B1F for <linux-nvme@lists.infradead.org>;
	Fri,  6 Jan 2023 03:05:25 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL8z4YCqz1RvLy;
	Fri,  6 Jan 2023 03:05:23 -0800 (PST)
Message-ID: <c9cdd392-f4b6-1500-30b5-7a04bdf83786@opensource.wdc.com>
Date: Fri, 6 Jan 2023 20:05:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/7] zonefs: use bdev_zone_no helper to calculate the zone
 index
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
 bvanassche@acm.org, snitzer@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083321eucas1p15e9087bcc62bc6a4f5a61467e1c98698@eucas1p1.samsung.com>
 <20230106083317.93938-5-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_030531_074404_0A1E1805 
X-CRM114-Status: GOOD (  24.13  )
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

On 1/6/23 17:33, Pankaj Raghav wrote:
> Use bdev_zone_no() helper instead of opencoding the logic to find the
> zone index.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/zonefs/super.c  | 8 +++-----
>  fs/zonefs/zonefs.h | 1 -
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 2c53fbb8d918..c2ddc62e99dc 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -487,7 +487,6 @@ static void __zonefs_io_error(struct inode *inode, bool write)
>  {
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	struct super_block *sb = inode->i_sb;
> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	unsigned int noio_flag;
>  	unsigned int nr_zones = 1;
>  	struct zonefs_ioerr_data err = {
> @@ -502,8 +501,8 @@ static void __zonefs_io_error(struct inode *inode, bool write)
>  	 * size is always larger than the device zone size.
>  	 */
>  	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
> -		nr_zones = zi->i_zone_size >>
> -			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
> +		nr_zones =
> +			bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);

This is a number of zones, not a zone number. So this at least needs a
comment to make clear. Otherwise, I find this confusing.

I would also prefer you hold on this patch. I am about to post a big
series reworking many things in zonefs. That will conflict.

>  
>  	/*
>  	 * Memory allocations in blkdev_report_zones() can trigger a memory
> @@ -1420,7 +1419,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	int ret = 0;
>  
> -	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
> +	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
>  	inode->i_mode = S_IFREG | sbi->s_perm;
>  
>  	zi->i_ztype = type;
> @@ -1804,7 +1803,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * interface constraints.
>  	 */
>  	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
> -	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
>  	sbi->s_uid = GLOBAL_ROOT_UID;
>  	sbi->s_gid = GLOBAL_ROOT_GID;
>  	sbi->s_perm = 0640;
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> index 1dbe78119ff1..703bc4505b29 100644
> --- a/fs/zonefs/zonefs.h
> +++ b/fs/zonefs/zonefs.h
> @@ -179,7 +179,6 @@ struct zonefs_sb_info {
>  	kgid_t			s_gid;
>  	umode_t			s_perm;
>  	uuid_t			s_uuid;
> -	unsigned int		s_zone_sectors_shift;
>  
>  	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
>  

-- 
Damien Le Moal
Western Digital Research


