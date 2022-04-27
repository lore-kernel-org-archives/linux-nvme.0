Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7E3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 23:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cc4Wlvlr1vTHdrdVcS7HefpaBj/DJ+6JsawpNa7erTI=; b=l04+d6PUO7KHp8zyGG1hUWf233
	qGTc7TrIKbaFFELqDMqQAwbS5EaMQ/8i7jm1LWqoiPXVih5Xf+boP8+caL19oNB5hLm5FWLk5+651
	cJ47J7q1f3nzHlJ7eocrNua5fVFeyAVAYB6keY8htqEeCv181/j7qZjrom7u1asGA0MMspTT9HiHv
	MNilwRKfzpmSpmWmgsur5A9nCecolfEdznbAGY9/0HerU/kiO03PxjOw+B2dPoedqgLuV/zw+Lvlv
	0Wm7JbrOhnLeFvqc7Kv8bzqf2yLHxZvctJTqUQvg7NYYsTau3H/jCtCSwN/z9zxkXHAIzdVE68yQM
	c0lvbzBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njrJB-003ymf-Kb; Wed, 27 Apr 2022 23:42:57 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njrJ8-003ykU-Bt
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 23:42:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651102972; x=1682638972;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=b4PQ+YojFt/Da7JedNLqXswRcZ1DtIMcbUQc3b82khE=;
 b=EDU75NmarpZNGwIrwefSGWrl+B3i/S1epOt4iiI6ZsThVVZV5eTjvC6+
 fWvCjzEuNpGMrB2Rn9lRr4SoxHZzGIp/FngTHdYdIShLKhmSl2bpd2NK4
 cqIsxk5sLJULvM8xkWSw3WIlbH1xwbb0SF1fiW39j2w6m0xV3lmzWqjOx
 WSXoXRCNxNvBhkAtEdACTbPhoRETwz+/d7QSf8r3DS25CPlEuoL+vi8oC
 fhtUZ9p4+pLTMI77zVX7j2xPF1HFKemJtQrCfKiCwrTQUHiNiUzODCgaX
 ab3S7V+g3wGAXMwJyyl3lzB84zcLnO/HcnJKWQS/P/Q4sHWmCPl//sOwY Q==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; d="scan'208";a="199002719"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:42:47 +0800
IronPort-SDR: CTlLUyF8H4H3ixa2FAFvyUpQtIZD4z5etfBchtpokLsaoHQOUqR7spPmmYAy8owjMTFqdRcmkh
 L/KTluBfHd8nyB0hi+mlC8Ei4LtvIH3fCQQ9F1CR2nnpCFxEk8+iHZY/7MRYaDVoGE+a8fKShz
 PdxfCU15/u/IZCfOFNj9mBULH2qZY/4qlloC64OmKcAYYeznvZu8Z9h+v38rpGQ1aYw9ohPTGy
 TZsc7seGnXzuEhAr0VeKxGBHgHFEq2PI1HDb0TzrzynbMX7huDFbwAdHlHVcTXCkrmvMfHdk5H
 rNBFQQbkrasjTYC56FI0GK9Z
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 16:12:59 -0700
IronPort-SDR: OBcUwdEz9DixK/cGGBY1OyK6L03RkAWoUWk0gZeOVhyuRxJtyt3fhVjZ175qs0eQYXj2WIVxHH
 ufv0ZO1w4l2F1fkzPVNJLqHd567npSaumN26Wi28XeZxvi7Nj/zjW+iN+awVk2676JqDQ4MasY
 w3SgbXtvhQS9Y3FkM9PmGEWJaJ+LAa7TfGFMNyE4kobv9t2Ev4uySrVpmTv8mhGEGFDFyVC5Lj
 Xm0JFLAYDzG8uuDFMiEPvJqUOR9Z94Xx+FRvQ62V0Hx3cj7q+U9FD6eSp+hlqSrf2QAQ/fYEoK
 1qI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 16:42:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kpb09122Zz1SVp0
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:42:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651102968; x=1653694969; bh=b4PQ+YojFt/Da7JedNLqXswRcZ1DtIMcbUQ
 c3b82khE=; b=aG9U+mpCYTqXLYVrB1nXg30+hvfUJ189J7XQSSmBmeZkvjsxkwu
 zAaurumWJ7fm9SJv5J2FbjspgmG5JAqDow1JiX6iGFfC9Of0kykaaFX4ZDKBNjn7
 c1vaCSsv8uCxbA0qKU1vQr7sjo2GKuQXZlvDLVoxWtDsD0Z1sjM+p8Nwc0CEll4E
 D6XCio2WwJ24l1FBaPYbvh0rG1180xMBAGWn41A2ZxbXvt8f3tjQGcCajxa+bHT1
 FmppUurtfeoO8TjI45cH5MPXNN7fFivo3PY5cobe5YbA6m03HnTor8+NQEiSRl8I
 0/HpjutNT+lHDztsGZq4Q/AuoqjjlZcpVwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id E0UShzYKunxX for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 16:42:48 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kpb025hPwz1Rvlc;
 Wed, 27 Apr 2022 16:42:42 -0700 (PDT)
Message-ID: <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
Date: Thu, 28 Apr 2022 08:42:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
 johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-17-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_164254_446313_60211E34 
X-CRM114-Status: GOOD (  20.39  )
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

On 4/28/22 01:02, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Today dm-zoned relies on the assumption that you have a zone size
> with a power of 2. Even though the block layer today enforces this
> requirement, these devices do exist and so provide a stop-gap measure
> to ensure these devices cannot be used by mistake
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zone.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 57daa86c19cf..221e0aa0f1a7 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  	struct request_queue *q = md->queue;
>  	unsigned int noio_flag;
>  	int ret;
> +	struct block_device *bdev = md->disk->part0;
> +	sector_t zone_sectors;
> +	char bname[BDEVNAME_SIZE];
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
> +	if (!is_power_of_2(zone_sectors)) {
> +		DMWARN("%s: %s only power of two zone size supported\n",
> +		       dm_device_name(md),
> +		       bdevname(bdev, bname));
> +		return 1;
> +	}

Why ?

See my previous email about still allowing ZC < ZS for non power of 2 zone
size drives. dm-zoned can easily support non power of 2 zone size as long
as ZC == ZS for all zones.

The problem with dm-zoned is ZC < ZS *AND* potentially variable ZC per
zone. That cannot be supported easily (still not impossible, but
definitely a lot more complex).

>  
>  	/*
>  	 * Check if something changed. If yes, cleanup the current resources


-- 
Damien Le Moal
Western Digital Research

