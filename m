Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F64C25B07
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 17:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sW1stY1hkGdCr1zV+MhXBdYgSkumoXAD5Z+KrXdjcWs=; b=hxZx5M+mCaB7yLzVoT3Ib2ocXx
	sZTMgDXacY3K7chVQ4WahG3G2I+ws+fv3bRXBMvOg6O7XZECdsH8hM2qy8O7IHZy6Adr5C4x9aecV
	mM4FacKe+6UAG57cdAhHhu7JnTVH5wDHOLuttjafgoYoNw4AEC1EOF5/OYes4nrDqOsACjEUJgIOu
	tY+SNvR7mW02w22d7sigR3qhp0HrevBSvbwX4ZLPy2BhjUOTCoTmTuMAzeR/slhdLCPmmdplgzugr
	882m5j7nFm6K+Fjn5oEBoTKbcdbmmDkKsQmbpFvQXNv+FNfu0YLvs4i0l9FANfvf2qpw141eEShkU
	pL2JtZBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLpK8-00DFkx-Ml; Wed, 10 Aug 2022 17:16:52 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLpK4-00DFiI-A6
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 17:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151808; x=1691687808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZrG3QXHf6OeZyZRRDOE430GTJ+vsvuzlYkLafNLMIzY=;
  b=kFhcmkfPz+imfp3HG2kkn5IxJ9Kk0NGyhg+yaIr1rzE/dJZSi/Scj3W+
   T479+cudTkwq+pyaUP1e/UD7Z7P6Xq+4+moQpImcQSvlCsDD02O8uAwDm
   TvbAYzlqQjPm7UpZbYQS5MejreIJKXWkurR6b+I+EErkpjk0dwJtAqbvq
   8h3OarkJMVjYeOwI9A9cM3+sA/3m28DAbCr/uU6H6VGoSlvf2p4R/icOk
   OY+p4TlQLDA0JY4uzLVM7N4BXjn33zbc7kkBm0aIEADngle+vui2G/SJu
   DdoMVrimslHPt3wGUw7sITB/x976ge6htEQ7pMbKMQ+eTagNIm8lUGK6v
   g==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="312649612"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:16:45 +0800
IronPort-SDR: VPPJsluuPnI+JYEhn+c768+6D7nxfC47ZHJwE2q7QkOvfipBCOENRUMgioPiGLhCiasWaLVdgJ
 bL2QGIK+zuNHjKPgPEn2oSJIMeB+i3oLfkPtz5iGOLbzw6prl3rBEEL75XCxx0PIDg+Ad0m+x/
 4N3XBNQBCQn6YDPCQq1QyQhjiKrYbuBIJBFUbJMYoJgrrDlt4LWWcJiveO0SJUZiIr9VfTWyZ6
 1xRdp7hUQmk/0yot20Falz0S8gBD75vB71zC4gcI/qmGug0dZgj9cuGZaDZUziBV2Vl08e4Vex
 hGMfLX+RUtGwz1mqyvhaMpR3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:32:21 -0700
IronPort-SDR: cLxKFnxjR9/ctQ3cpQBKjgKK/E3Pon4Al6PcTgSA2M4550W0x3jsaHDgLWIcGq69cMPSfV7Osy
 cQ9CJfpb5UzdipLfBeGlyc37Pc9tXHRamN+riQc8+wvLCyItaBffzRHaxVH9qSUGW1UmwegujT
 cuHx9IoKlfBYLSHvtN44nJ02zlWLl1Mg9aQog/MuyJvIkOKMM4N+iGlM4tmZi/KydeVDdB7drE
 2b2Lb5grixnAMCQdvNhysbd2/+O3X1+yEX2J+asmFeL8Q9gYFyjnKq0a2Hm+2JM52JnzuoQtg0
 7p4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:16:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xSF3dlzz1Rws7
	for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 10:16:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660151804; x=1662743805; bh=ZrG3QXHf6OeZyZRRDOE430GTJ+vsvuzlYkL
	afNLMIzY=; b=q8E5j2biq7+aqtAPZCbX3uzABdCPq3/W5AC6e3lSgeyurt33e66
	2TKqgrRhJBz924jF27EslwtHBD+j9JFqfG7kSTu2r9qKbwG3fQ9f5MLkt0bGDFzL
	7J8aO0Jt4kYGSI9+bBsk00OqjgLIM4+Ir8bqlCCzhVKjT7bhrPKe0TqbywLC98ru
	q+eF4mGZgxDhd1iVzqOwjZj9Bm32j8o9mkFInce7Iwe/IPJ0E9Hcmc75Q+0bD+86
	s8pe4eRc+n6iu+kkii5juFTDKLjw4Rb7R0KaF5tUz1k+c/VMdnMVczCqTmOibpQN
	5AAE9asQpxtUlD4zvMoDqsvew5bHTZH27wA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VPjCjDVj1jpt for <linux-nvme@lists.infradead.org>;
	Wed, 10 Aug 2022 10:16:44 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xSC1pJVz1RtVk;
	Wed, 10 Aug 2022 10:16:43 -0700 (PDT)
Message-ID: <3ee96421-94b2-12d8-9aa2-83d4f7027694@opensource.wdc.com>
Date: Wed, 10 Aug 2022 10:16:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 12/13] dm: introduce DM_EMULATED_ZONES target type
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
 hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 bvanassche@acm.org
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094815eucas1p2dfab477daf4f2eb05342d756fdf7f14d@eucas1p2.samsung.com>
 <20220803094801.177490-13-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-13-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_101648_481349_D018EFEA 
X-CRM114-Status: GOOD (  26.91  )
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

On 2022/08/03 2:48, Pankaj Raghav wrote:
> Introduce a new target type DM_EMULATED_ZONES for targets with
> a different zone number of sectors than the underlying device zone
> number of sectors.

"zone number of sectors" is strange. "number of sectors per zone (aka zone
size)" is simpler and clear.

> 
> This target type is introduced as the existing zoned targets assume
> that the target and the underlying device have the same zone
> number of sectors. The new target: dm-po2zone will use this new target
> type as it emulates the zone boundary that is different from the
> underlying zoned device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

With that text fixed, looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-table.c         | 13 ++++++++++---
>  include/linux/device-mapper.h |  9 +++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 31eb1d29d136..b37991ea3ffb 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1614,13 +1614,20 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
>  	return true;
>  }
>  
> -static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
> +/*
> + * Callback function to check for device zone sector across devices. If the
> + * DM_TARGET_EMULATED_ZONES target feature flag is not set, then the target
> + * should have the same zone sector as the underlying devices.
> + */
> +static int check_valid_device_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
>  					   sector_t start, sector_t len, void *data)
>  {
>  	unsigned int *zone_sectors = data;
>  
> -	if (!bdev_is_zoned(dev->bdev))
> +	if (!bdev_is_zoned(dev->bdev) ||
> +	    dm_target_supports_emulated_zones(ti->type))
>  		return 0;
> +
>  	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
>  }
>  
> @@ -1645,7 +1652,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
>  	if (!zone_sectors)
>  		return -EINVAL;
>  
> -	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
> +	if (dm_table_any_dev_attr(t, check_valid_device_zone_sectors, &zone_sectors)) {
>  		DMERR("%s: zone sectors is not consistent across all zoned devices",
>  		      dm_device_name(t->md));
>  		return -EINVAL;
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 04c6acf7faaa..83e20de264c9 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -294,6 +294,15 @@ struct target_type {
>  #define dm_target_supports_mixed_zoned_model(type) (false)
>  #endif
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +#define DM_TARGET_EMULATED_ZONES	0x00000400
> +#define dm_target_supports_emulated_zones(type) \
> +	((type)->features & DM_TARGET_EMULATED_ZONES)
> +#else
> +#define DM_TARGET_EMULATED_ZONES	0x00000000
> +#define dm_target_supports_emulated_zones(type) (false)
> +#endif
> +
>  struct dm_target {
>  	struct dm_table *table;
>  	struct target_type *type;


-- 
Damien Le Moal
Western Digital Research

