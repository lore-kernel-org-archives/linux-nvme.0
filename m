Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730EEC00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPocolZqD/RBzodYbqaDEnqe/9/xVODADIf2bWXaGos=; b=A+Oi/DKjW5mXnnYiHwW7BpL+wS
	ueoVXMxGggfX5blhSEjzlKUQ5Sy01p4j1MBdXrUFYnOQbQgq93lxx5XZsW6KstUAdaHhZj6EVGH++
	8UEiRnWl8GROu3w8R0/nl7EjCchrzu9St+tGN5+/8useW11/XdntXXbXhQUZQD2ZhXCIUnoSxnE3o
	P6ckqksNqNYKI6I90X46XUwlz1V+FDBkB4WbWPwhqIINGlO0aOqiG4Y9zE1WHdPcwjjyGhN1ZKSkJ
	16Ye//ds3wwXA+8eO+rXI8m4xoFDjsOjlIloBg0ZMhapbVcuI6RXRWN/dBN7UXOsDI0A5NWJiOFG8
	HrnOWecA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLpJn-00DFbc-K9; Wed, 10 Aug 2022 17:16:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLpJk-00DFZM-D2
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 17:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151788; x=1691687788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tLjnPCdY0CPud0gZoWqOOs4dR6XNnOxfEo9SNWG799Y=;
  b=MIjYdi0dpN2vTJ4vH3khhXnXYItxqSbvPFrwnUXfzPXCVASl8XsWks++
   rWGgMQmnKLVdX28GAG8+yU0s4wWwZcUqJalyZ9Gsf8pEJOnPGcVczaoJ2
   4sfMFbLk17VuKC8xu2lGxH/mJkc7I4DzzHBNRoGd5RHVihHDy5qFP/b6B
   op6RvpegATs50epn7HfyhApoDCBfJuNSa6dIHoktw+m+7FX2TjeslnBU6
   1jEKb98Cm01URLc87BBI0IXWpUp+cSj4qbNcgStntX5wl1QPnmMGFcCSw
   wXtJgYbXJwORgNPr5ScGXxnqLBrWma/AtidnjjaGTK8eyXjmTdMEjuAZR
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="206863124"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:10:45 +0800
IronPort-SDR: quUW1KqAsMHhIGDzdTN8Q2D/vlF8PJdP70u9X4mxxpakWqjgy0mYS12pdbPuJU3wQPr5/+BQlE
 GoYR+iDCCZFqVf5v5yo2Polz5MJNuneKh0kLXUgrrkz66k+QZ4qAxlBX2B1OuyGW/VCq+JKl7S
 Pl2q/tT8jUdinSoOb5ZUPt+PhOQYepWOvayyJvAR1MSMXQMsOKL2PpPEaKSLK2ted/Z2bKPwB0
 1L5jTyY0gopqZAAgt8Pabog5lzdakcz4CIqmZ+xFHS+bctmVTvezizyQb2ZvTXr5wRcalckemu
 eMmpi9cjRRRzlibVws8epz0q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:31:40 -0700
IronPort-SDR: NS8aM7fRgPHhqRJkFnHKgf/jrh2aIWF5Md0oZW365QkdHEPjJenq5Is3DV9iivmRPdPSWA6CrV
 /1o9R/IAE7qsY8RjHES0qgNs/F0iI/LGZiroPBZwwchb65TCgKOaP/Q2nKtkElLo48/WsHZE/q
 eXQKIurnHR+DcjAbv9PiW07x2nYhm6La27/cVkPM3Idh1gwo3nwMTBbVaROysWfw/yGjoIZGaL
 o/jO/gGQkLn0OP9cbKKT5IIOLLBewuS/iBx4NrqUM8Qew6SJAxLdQlXHpM0XF1GHpM7XUXAk9q
 dAg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:10:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xKJ4JMcz1Rw4L
	for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 10:10:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660151443; x=1662743444; bh=tLjnPCdY0CPud0gZoWqOOs4dR6XNnOxfEo9
	SNWG799Y=; b=mTBmzjOr4h1LBCukLQPRjySe6bu7paraQ9i+Drxv3pb2NYIa8R8
	KTyqSPOkdKaLIoYzm6b2MdvfM49mbNBEJ9ml+HiWAcTD5KT3IsAvbuB5cWM2wDDX
	MlULNVXPmpcJfh5MRYGWgstx5yPIdF4N2yD9/xktCVu1B7Nzcu+5V+uNf1X6RY4N
	OJIUZIJiDTF8Xp4MTZ3sZ1EWOy8VnGApB3av9ZYl2B5hhXpR6a6PQh/+0ZDgFrhI
	Xtbe+yqFDVua6mE8E0yixb8VyM94Ijv/Zxv1saGPMO+fJ0mguEQh/mueK4Qq3Ymq
	MuqL0Zsd4YSx8YTmtq3M3x4acKdxLmwHq5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1-uYwSxPQIm6 for <linux-nvme@lists.infradead.org>;
	Wed, 10 Aug 2022 10:10:43 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xKG5Ytmz1RtVk;
	Wed, 10 Aug 2022 10:10:42 -0700 (PDT)
Message-ID: <4a045887-6d44-661d-24d2-4f0cf039a058@opensource.wdc.com>
Date: Wed, 10 Aug 2022 10:10:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
 hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 bvanassche@acm.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094811eucas1p17a2ac191899bba7938de6b9e3a55352f@eucas1p1.samsung.com>
 <20220803094801.177490-9-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_101628_554642_4F50004B 
X-CRM114-Status: GOOD (  19.91  )
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

On 2022/08/03 2:47, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> non po2 support is added.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-zoned-target.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index 95b132b52f33..9325bf5dee81 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  				return -EINVAL;
>  			}
>  			zone_nr_sectors = bdev_zone_sectors(bdev);
> +			if (!is_power_of_2(zone_nr_sectors)) {
> +				ti->error = "Zone size is not a power-of-2 number of sectors";
> +				return -EINVAL;
> +			}
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
>  			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  		}
> @@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			return -EINVAL;
>  		}
>  		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
> +		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
> +			ti->error = "Zone size is not a power-of-2 number of sectors";
> +			return -EINVAL;
> +		}
>  		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  	}
>  


-- 
Damien Le Moal
Western Digital Research

