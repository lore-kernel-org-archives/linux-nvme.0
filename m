Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C052C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lMSh0vbpM0/1rsdKNHZOmWv20oqAHQojb0ejpD9Sifc=; b=d13YZxLqYIpGvy86O7tf8MC8Zv
	VI/oejwyCmAW8MJscoe+tQX4UiIvJdhxbV9aj0FN6zVUxKTXR85t7JTCg/EwzSaR41WtAL3UNRnVZ
	RB1Wk8NxlcgMfK865RP/90wbxMtbTKCGHw9nhbrnjqJ0L2LNwPNEfFsNr0bWgr6WFKP4+VfjRYrs+
	6TFEU5I2rI+Zml6RZWoyf5sFcPBCwU0cbeTQOGpUGCI4s6JGNmVXa2OZG+NC7KBfGjnOoroLCL+ok
	atJVkkPHg88/YrbyiqWcTGd+Zakt6dC/RBwEQR3y0+8NDF6juqZuUxnxCo4BDg6e9+3w9C+uJxZy4
	MVX7dKyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1RiA-00ELXz-BN; Wed, 15 Jun 2022 12:01:26 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1RdQ-00EJZ6-3f
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 11:56:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655294191; x=1686830191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hMa4C7BG2EJNxLf+4Ft9gsUe2natn5jOe4xtSlQ7Na0=;
  b=nG6EqiAwEOY0U+GAjKdH2hh/H+wvVmF4o+fc6Mu0v+AR+fPQUp2+w1DE
   lt5fjGOdqeTSqChBqVIxNjGwtHrcl8qBmhzhlcGYrlCcF0MDBdELgQiBU
   hYqY7KNWWKOJM00UCB0up8YYAEbOwLYfARhIcywA+72/2Q542nc/FHNiJ
   l58jtmpBRfU9Xkzs7D28FELPjHAwb+aTvgH4g+dzmjCWVS0y5BUKg1BNx
   PvrFY3Tp4IFwEO0ld+NoxpFHtp2SQmn5tJCf4xuc93mSPzr8tbgWnM0Hw
   K1Ko3S1hbV3RRdLGp9DtEGe8Yfuh4/+vMVQOMZZOZx7sfXmtQu65DCElE
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="315294825"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:56:30 +0800
IronPort-SDR: y850PRSH7LXJ83NkUsjJK0mDVoHTb8mC1KTaQai5NCLVfbFnwrWrGdpr+t0AjfnlIwl1T4fvHT
 mtdFnA0DZ3XSaMMsBrRZ2tEfw2FkQQvLr+akZADXn7WjJL4m5v0pQ5xpVUZNeriTMFlg+c50Js
 FSRswy5s9fQieiUjYkU+QWdbC5tjAfK/IUlLgW4vEmBGzZ/bGRk9nfGc65p/Pcg1/fjgfGLlMp
 OjTZxDZZsL9Pn6bThEKP5Z+WWKuC9kjyQh1mY/2gCDFdRYvaPCyeGbTExzRn4zixvZyvyKOQCp
 sGRxjUtc9L7QYHabdznDab9a
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:19:21 -0700
IronPort-SDR: SeIL2osaGOoXIKEpx04B6vGiLS9wcICXPYSS9groXY4aas7AHpE9notj4o2FOVNdQmWxc4QT51
 kxE6GctrjpMynwN25gaUVJ09TQ8KhTKDVqXe7KwTHJH8gcSohD9Ym2A9gh/fWlhXoEGZZ/r6l0
 XbbWkJFVv7bMDGGQfw443o08Rr+kZBQoyoDBW3OYA/vkfFEDOy3ytkU6OnKVgb//HvbrjnbFBe
 BGE1eZLuH42Vjk7TuEvam/NRzsGJDl1xxL5+xyBSsf8clk/+1GIbctFDYpwBPjhlmJyhrb7MYS
 ZF4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:56:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNP0Y2MfQz1SVpC
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 04:56:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1655294188; x=1657886189; bh=hMa4C7BG2EJNxLf+4Ft9gsUe2natn5jOe4x
	tSlQ7Na0=; b=O1jVeGEiQVMCIS3Ud8cDz9MljRd9D9VkkVpPn8F4R/P/kyxOED6
	Nc12uVtcHw2LN2OIzYkqi6KYWbqHf+lTYHEgMoug1B6Hcrnd+IhpD1UQTufyUFLK
	YuRWZWOu0FQ7+9HMX9pimVOfk14bQ1wsAkI7yjCT1I92CluihrxNC6lZxZn+6e/p
	0QPs6Tds08jxxz+9d0cu+H2qFI+8l0NOroHVmXW57ZoNcd+YSIT2s8Z7YRsrO6eY
	2X8s0YXwbZNIPF/FtVgKBsP4FMrW+zRwxfFvLTkHaT9tZpFq/I5QYXlRF4RWrl0A
	stCWrg2hE+aFog4dpZeKIBkLNK5jjv3o7og==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3g5UDgQ5gWes for <linux-nvme@lists.infradead.org>;
	Wed, 15 Jun 2022 04:56:28 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNP0S6n1Sz1Rvlc;
	Wed, 15 Jun 2022 04:56:24 -0700 (PDT)
Message-ID: <4bafa68f-46b3-7a76-de70-377a0f9cf130@opensource.wdc.com>
Date: Wed, 15 Jun 2022 20:56:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 06/13] null_blk: use zone_size_sects_shift for power of
 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 axboe@kernel.dk
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org,
 jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
 dm-devel@redhat.com, jonathan.derrick@linux.dev, gost.dev@samsung.com,
 dsterba@suse.com, jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 Damien Le Moal <damien.lemoal@wdc.com>, Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101945eucas1p16fa264e81d9b6027ff131dd311ed91e2@eucas1p1.samsung.com>
 <20220615101920.329421-7-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615101920.329421-7-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_045632_256981_61E37BDB 
X-CRM114-Status: GOOD (  24.89  )
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

On 6/15/22 19:19, Pankaj Raghav wrote:
> Instead of doing is_power_of_2 and ilog2 operation for every IO, cache
> the zone_size_sects_shift variable and use it for power of 2 zoned
> devices.
> 
> This variable will be set to zero for non power of 2 zoned devices.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/null_blk/null_blk.h |  6 ++++++
>  drivers/block/null_blk/zoned.c    | 11 ++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 8359b4384..3bc7cbf25 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -83,6 +83,12 @@ struct nullb_device {
>  	unsigned int imp_close_zone_no;
>  	struct nullb_zone *zones;
>  	sector_t zone_size_sects;
> +	/*
> +	 * zone_size_sects_shift is only useful when the zone size is
> +	 * power of 2. This variable is set to zero when zone size is non
> +	 * power of 2.
> +	 */
> +	unsigned int zone_size_sects_shift;
>  	bool need_zone_res_mgmt;
>  	spinlock_t zone_res_lock;
>  
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index daf327015..5f929944b 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -16,8 +16,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
>  
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>  {
> -	if (is_power_of_2(dev->zone_size_sects))
> -		return sect >> ilog2(dev->zone_size_sects);
> +	if (dev->zone_size_sects_shift)
> +		return sect >> dev->zone_size_sects_shift;
>  
>  	return div64_u64(sect, dev->zone_size_sects);
>  }
> @@ -85,9 +85,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
>  	dev_capacity_sects = mb_to_sects(dev->size);
>  	dev->zone_size_sects = mb_to_sects(dev->zone_size);
> +
> +	if (is_power_of_2(dev->zone_size_sects))
> +		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
> +	else
> +		dev->zone_size_sects_shift = 0;
> +
>  	dev->nr_zones =	DIV_ROUND_UP_SECTOR_T(dev_capacity_sects,
>  					      dev->zone_size_sects);
> -

white line change.

This patch should be squashed with the previous one.

>  	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
>  				    GFP_KERNEL | __GFP_ZERO);
>  	if (!dev->zones)


-- 
Damien Le Moal
Western Digital Research

