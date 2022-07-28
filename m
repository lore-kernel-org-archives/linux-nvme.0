Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACA0C19F2B
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 03:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6z2rFVZjl8HOEcoHWD0wKU5S2w3W47O1PL+WRAnB+fQ=; b=TOiK81aj/Ph4bi60orgStringP
	aLAn/9lWt5VZ94Hkmai1U0p/jofQiZ0BNkIHpqN/zJKVM48hbZoYTVZu+f1/kadd2wg84g0wKUS3/
	3ppRYeCcyHNHuLlVyYlgedf9oywN18XsIHQX+lWd7hEwtlbwu00Fa6a0Wz3PY2GdCi3x8DmCP/51T
	P5f1dwdPvjy4lnmyTFTKdP3/CDhyVuXZr8PYL6WJoITelw6yvsPb6DKNaWGhinJEPX5y/pn295Hde
	lCUcRjlJzR+i+FOOjVNObspAIJFMAsU/9Tcqkz7s2XDdcwrPLSnJedrA03jsXI2RqXlKYRcuw9VdQ
	aKjgxYSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu6r-003UGC-DM; Thu, 28 Jul 2022 03:22:49 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu6o-003UET-Q7
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 03:22:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978566; x=1690514566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1akqneWlsZLozCUh+myPMpEWIgDgWs2xBscRax+3MdE=;
  b=bcfPAVdtEEtiX+bU886B6ocwpKqAvaVZ+6e1PjKX20CB0aQ5IyZESiiJ
   SgJVc+0Az1UHgW73FMTsPd1P6rRNEVSrUpidLoXfPmWdWIff7kbFntwNA
   RLosM1YAAqfRCEMinNPf3P8BVBTQ2uZo9LPX7ognnrf6RXqEY5XqlueEW
   u7NwwdX1RwpiIO1Nh9elKoB4UijpW6WO7CJQlI+qzMh1OyPHKPrRZx5Eh
   DGU5iND1vAHTbYxfD6aajYgmvFLnlNOly6fL81TTNDin5lPMmu+vpnwao
   fj2iQDklk5bKcCP6eR7j+bJmZRYkQ1nntQaqUx7RXrnwgGjqjs8zhBH6l
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="205666956"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:22:46 +0800
IronPort-SDR: Kx8p3O4ufTHybzFNc32q7T3mQzQf6E9+D84JHUE14JaqIUt86+7ygeCa4iE/lBJx3XB6n6oV9+
 t21hVOGjLl6/6VpogNn+4MEOt1WvhGODlV34LNxuFFjJSoCLZwWLfxY55zG9bZO4qvL0kPEaug
 tonH7q0lxtryslbnNOxnp7M5PZlrDO8GzXjipPJBSMzjoT1wLSQ0zAVme7ate/lNM5WFr2bLCb
 AU9nif7YPvIlvv01y6JSZr7Mrn8ypR5geBI2SjNaT11q3uW7yRIHKlSiuilLUQoQDRs2S2TSml
 767sxX0zw9YItn49HDH9ecrv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:43:57 -0700
IronPort-SDR: ILr0B0lubiOXOvghiZI+mSgn7ONt5VXiP3boEpvrPQAJqm/Xdm+ETEfzJZcMUNzNLxCQl2mk93
 aiqzXtGq9cgqet1NN0p1ut0iI/xNNXn+98Vc/1D7y10+vptkei+DSy+LPeV+Ffru237kjjwGGF
 R3hB/O9HTQksWIyPM2WP0Fi0y3fuWeEe6ih77zNoS5fGTeuOpw92N7vAjMJuvgscXH9TAMU2KV
 vcsaTT445kh6zdLnoYUa4U7ho6eS4LKbDG+TAMlHIXsoEFxh6j/XS9/+q7gW0/E6w9L/2J32KV
 71w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:22:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbYx5BD6z1Rws0
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 20:22:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658978565; x=1661570566; bh=1akqneWlsZLozCUh+myPMpEWIgDgWs2xBsc
	Rax+3MdE=; b=lu0v0dDr5OjA4RfR6tW/P8zHqZa/w4O7FepoGRuP++wwOOR0Ld2
	CwpFNztwjTX8HN/4kWtEg4LufRxMpsl1wrKI4GS+k/KFUTXAcJ6h/cNTS9OtmaDd
	pVb0IZJzMlaUBAsET1ZejCqvUerTl80s4Fc+LWCoww5YzTA8YG+yjj+jfIYKOOE+
	Wwqc3u8Xd4601rqzmxoWy+lyvc5qoNdsLEUsQOAseEWbsC1KTuA7afJK7lArDWWr
	hJ4MxuUjeSzC2LW5gIy7z6ygwaq4j9809Uo9p/U+zsJWpDx6wupaerRBG/CS2pf4
	VIsRYlabon4sUKblHPS1Qjw6SpUr2tSP1lw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HoY-O4M-nL7l for <linux-nvme@lists.infradead.org>;
	Wed, 27 Jul 2022 20:22:45 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbYt2Q7Fz1RtVk;
	Wed, 27 Jul 2022 20:22:42 -0700 (PDT)
Message-ID: <65a336f0-ecd7-e9d5-2646-37cf9f157d53@opensource.wdc.com>
Date: Thu, 28 Jul 2022 12:22:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 09/11] dm-table: allow non po2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
 snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8@eucas1p2.samsung.com>
 <20220727162245.209794-10-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-10-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_202246_980301_28FD9B0C 
X-CRM114-Status: GOOD (  20.79  )
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
> As the block layer now supports non po2 zoned devices, allow dm to
> support non po2 zoned device.

Please rephrase "non po2 zoned devices" here and in the title to correctly
refer to the zone size of zoned devices. Because "non po2 zoned devices"
means absolutely nothing. Let's be clear please.

> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-table.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 332f96b58252..534fddfc2b42 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> -		if (start & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_aligned(bdev, start)) {
>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)start,
> @@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  		 * devices do not end up with a smaller zone in the middle of
>  		 * the sector range.
>  		 */
> -		if (len & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_aligned(bdev, len)) {
>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)len,
> @@ -1642,8 +1642,8 @@ static int validate_hardware_zoned_model(struct dm_table *t,
>  		return -EINVAL;
>  	}
>  
> -	/* Check zone size validity and compatibility */
> -	if (!zone_sectors || !is_power_of_2(zone_sectors))
> +	/* Check zone size validity */

The comment is not super useful now given the trivial test.

> +	if (!zone_sectors)
>  		return -EINVAL;
>  
>  	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {


-- 
Damien Le Moal
Western Digital Research

