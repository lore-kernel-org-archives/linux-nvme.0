Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48903C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 03:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X7AZcTRsLzuE+kLUMT8xlUKerV7hOb9WVt3rUj5Y0yk=; b=TZVCfS+CLXBIjWkzQJQBXbz6lQ
	cFR/MI+gh5eCV0uqkcARoJcNvBrJjC5WGlvMGtGjxurpMdeA45YtTIGsaLlfugpIkkAONfaZC3mpz
	sUoS2Rt7bhnZBEHjfTbKRqDBSzfDFEBfQ2Dd3G3FCLFTy4bNtExi2xUgsXHCRqgPSOLQohq96SJjx
	VtzMBSlvGsB1rsTg0OlMufmBmyt4ZYDl1FVoAKRu137fspvGndBkdcafIktjj1/dA9BODa1lYcXO+
	qvkQa0inISmaRnrb1195xq3WoqXr47ok0y5ikeS/46Ipo1bhxe/xFEI7LE2cGtCQb3c+q6BEtLAvq
	ENUYTFeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu0b-003Qc9-Ak; Thu, 28 Jul 2022 03:16:21 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu0Y-003Qad-Ib
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 03:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978178; x=1690514178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dgNNYral1PZUbj2wWm9r5vHUxNg+nAHsDtFwSnOitJs=;
  b=O+hyOmS4NgfwxjMV10djzj0Nv8lVhyIg0UpmTPph+890FMqW6WejFosa
   7m9yu2NUzoCCSytcaxyf7sHSoe09KBWqphSbTkCN0EpYyGL1QFvIzRrUO
   2xOxnHVzF5t8sKo79mrCSaa0o4QWy5KOC4ZKWEOsGiYzG+HZFunHErD+y
   fhFOxhDfQxCY7hOGFqjjF3WcbEcdTVOHSioUiqGjW+EXD103Na6smHDU+
   L3Ud7ERkA4eqL8pJvhhd61CMm+i4K/Zc8zkaWJ9bblciQPM+7EJWWMITw
   nJrmacZAbac6tWG5AVSxgHUDKEdfmNvmjppnBCV3iJBbczy0PE1f1rFy+
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="212066999"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:16:17 +0800
IronPort-SDR: vwBa/4/IcD8a9rfOoKRJzhq5cJQkHzK9b0kgs3Xa2ATfSP5bi+hc9BSD/IEDVRvJpB94QNuyRq
 XCg6nR5UHB8kDTLDVMBND3v9TGClOMOutr0GCj4iQ53kVFmM2Y90vHbkvuh5oBHKyoWVTusVzw
 oJ4HQoexh0ZSx7CzKHDX7kTTXU8xBS4wDatsUB3PhT7oqpjLARgzoJ6cF/9Lv2837fzx0SIYka
 mhguGjw+QERL2Qmb839mOyr8ZQIp+zR6FRPg9HYugYUoKoktqLRcqB7iFWXSFARSZTx9jsT8dH
 ylyNlI/6422TM/WCF4G5Mee5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:32:25 -0700
IronPort-SDR: X2l0v3WnajQSXzRbQtUCJ1ppFNDv5YJTKMlzOtPs3mafsTB8gTGFo8vh276JcPWnLwkOd55f7v
 gbusiWR45D2rAUnG9oGEx6EXBRGTF0htFAR0V/7CeKifxhJ9VKs5Pc4y9DT0QdAKgcridOva4K
 RVSK+fBRXkEN6rDZTy+ADNxuYLkw9jJ+0JvA7NMtwHMX9b26ScmfQnpdlaEKq9IqFpDTn32wtc
 NLGPris89LW5od7dOewj59ugImEyGUfRQQlvQnES5OCFm1B2vg9Z4+96VPvXQQcUGfEfgFRYat
 W3Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:16:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbQT3hTwz1RwsB
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 20:16:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658978175; x=1661570176; bh=dgNNYral1PZUbj2wWm9r5vHUxNg+nAHsDtF
	wSnOitJs=; b=R5e6i4Wx+Zk8ZxQNatmOznoYtBAQxg1SGYYWl4r16bvw6kCtOhF
	7nrOJa+fZNOBHginYxEkSfjIbEU7ZCHImAGv75zKkw+mdVvNi1LiV1JZ+RXDhJBU
	KD9I2zCAiS3ng1e6ssvmAQQrFP2K9lTPdmKxM9ZuIxqn3nOUGWn2z3OTj85uMTMo
	C2clIlBIqA5TToS3VWHZHXyaLnC90i8zh8XZBRXWi4Gqatwd6N9+aKzvZm0iYgpJ
	uTOp3HRi4GQauMo/lIWh+MqQ/RSBNMXdyGodC5gDUUKb+kqdjhkaA231ZreRltkh
	eO8mYYd/AkkfjnKASL9e8TZW/5ocqmCCUTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7z-S45w9VNyd for <linux-nvme@lists.infradead.org>;
	Wed, 27 Jul 2022 20:16:15 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbQP5Dsvz1RtVk;
	Wed, 27 Jul 2022 20:16:13 -0700 (PDT)
Message-ID: <cf96b0e4-dbb1-350b-602b-a72682fca2fb@opensource.wdc.com>
Date: Thu, 28 Jul 2022 12:16:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 06/11] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
 snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162252eucas1p25be8b79231334fa0c759c2475859e93b@eucas1p2.samsung.com>
 <20220727162245.209794-7-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-7-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_201618_672615_B6ACA144 
X-CRM114-Status: GOOD (  22.11  )
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

On 7/28/22 01:22, Pankaj Raghav wrote:
> The zone size shift variable is useful only if the zone sizes are known
> to be power of 2. Remove that variable and use generic helpers from
> block layer to calculate zone index in zonefs.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  fs/zonefs/super.c  | 6 ++----
>  fs/zonefs/zonefs.h | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 860f0b1032c6..e549ef16738c 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -476,10 +476,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
>  {
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	struct super_block *sb = inode->i_sb;
> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	unsigned int noio_flag;
>  	unsigned int nr_zones =
> -		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
> +		bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
>  	struct zonefs_ioerr_data err = {
>  		.inode = inode,
>  		.write = write,
> @@ -1401,7 +1400,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	int ret = 0;
>  
> -	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
> +	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
>  	inode->i_mode = S_IFREG | sbi->s_perm;
>  
>  	zi->i_ztype = type;
> @@ -1776,7 +1775,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * interface constraints.
>  	 */
>  	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
> -	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
>  	sbi->s_uid = GLOBAL_ROOT_UID;
>  	sbi->s_gid = GLOBAL_ROOT_GID;
>  	sbi->s_perm = 0640;
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> index 4b3de66c3233..39895195cda6 100644
> --- a/fs/zonefs/zonefs.h
> +++ b/fs/zonefs/zonefs.h
> @@ -177,7 +177,6 @@ struct zonefs_sb_info {
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

