Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87EBC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 06:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BOPKouWA51cTP9BCGJvW5/8F5lMHzGOGO5/YruljFIE=; b=H8XWM8ffBg1fNX+HAymiPp3T9g
	OS2VeUbNRaxhNgAArGcckX0fScf75PXHM1CIfRIhm4Pm9bxXu8eni2Cul56PQT3dzubhM+y/xWVyr
	AkJe90cnYlePYukKOFRipt6Jpq/CxiKOf7siQXN9lNH7JMKc8mxKHsvx42K4NanBtdYObqsBvDent
	XTL4bT9ZTdlE3ZuoyI93rS/k4UjW+m6kVBh1fjg8izQtKGU7UUNPSh/moxSuy+2K4kGxEnp2e7ASz
	rXTpTB4FgIOZlku3vmGjoOEqdABOERPHEWzTa8iJiyrTus6Ss3+DM5UnYHOqoX4ges9axQ2iIWATC
	/mw9FeOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o25DM-005i4W-SF; Fri, 17 Jun 2022 06:12:16 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o25DJ-005i2Y-6F
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 06:12:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655446332; x=1686982332;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EL0OFV/UiqDMNfEqXjfHFETPeL++FywuFfi93t89YZY=;
  b=BXRjPTfB2rw2L76KON8DH8cLFpHIZZB3AsIFGyESG5fSAPMIlGSRr3es
   /FD0OZtoNocSGU0YoO6y4kTTVfFEyUGsaz7RAprNwCx1a/IeMBCichFM8
   lqat3xzrPmGntIi5WFunQWRQCrICA6DQoCSaeUyhvKxgTEMuRvUsYiZ4q
   Ef27sIwW3T+sfk+auj/XdI2q7g9SWhYBzkr5nROJcbIp1NZcnh2RK4kN/
   DulMPsVYljMueyJzEzKwP+MR4Gk/79c8BkJmPVw1OaHe9qpRj8SMvnZwh
   Veoba9Bn9HKchP9Ju6eg/OSaDCkf1ffJwpE6iw2QqWqV5tVy23kbgouLL
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307708018"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 14:12:08 +0800
IronPort-SDR: EAvQbehW3XOntaYwyESf7okpq3spvXM8ljx2CicdKtFKT8Kx7466wLqqlt83n1gbTAeUk6diaY
 NJuWusEh71CiPOekt9lT/7tSQE5pIYpGFqLJvCrkBNaRGa5H1pQCrH2AAEmJbi00lSSGzgXYxl
 /NVof1vxTZvclzf/Xe3JlYPztBt22Ui7cD0ik7+sSuufqBdLO8XfAcIMc5E7g1jj4ozvWowAJy
 vZdmoG/sy0xF0z4vvKTtPnkEd8cPpQjABIfGkE5ihss+7TDJUyi/WiUYYrJwngROs2tzWitkEK
 rowyU5vkkttPfO5dn3voW/EF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 22:34:43 -0700
IronPort-SDR: 1msgecx1XFGoRBqZHPNxkH4YvalTRzUawH1HWPn1sLJ4RiXj4j77Bx5AlcXFLoL5fQWoS5QHmN
 5LMia8492ztTTwMMgYrIXOakCw+yAH0eDmGe4GJBy4krHrRpDgwwxqhkfRPvT9NDsmVfMon049
 m8f53B0lwsqKEVDoNPOxYXolEFMZ+reW7to0zEFw+R5W/R3rTVmFFGcsEcuHZ+KTlyJs8q6mkR
 RdicdVlRl+jrFRCyGAASmLklTXVy87TB0JS7ExjTPMcw4pklS32F5MyQvvnZ+gEAHrWl04zFXI
 jXk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:12:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPTGH6tQJz1SVpC
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jun 2022 23:12:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1655446327; x=1658038328; bh=EL0OFV/UiqDMNfEqXjfHFETPeL++FywuFfi
	93t89YZY=; b=haPzVZ+EA9+08nZb7DejF+3otLtsqHYIOMJlBcuUoti8/+t+kEk
	CJccWSLZ0f3sIfDjWk6X4KrlyQ+YWdhrWYROs7oGpAkYfWPzn90e0Hh/PIlDGDhp
	FLWkSltPG2jXz/XfoprveejaSMGU1bHNMlnXYXuekUpv0NYXhfxrzSKOwfBhzR/z
	1iySnblfgBeHYoFB89z6ZpLg4ZSuAPRoj6++587xLvxqW+g/PpwtiqjnNvxDNojO
	TtW0crFYSc1n+BvX9R1GUfJHIInVl8d7SCfbDGSg6RWmJLqgFJZDcrYvs5dPZKYf
	Cqa9XbFOThD4/E3eolRYJhonMe5/1GPRqmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fsZSazmokrIO for <linux-nvme@lists.infradead.org>;
	Thu, 16 Jun 2022 23:12:07 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPTGB6TbPz1Rvlc;
	Thu, 16 Jun 2022 23:12:02 -0700 (PDT)
Message-ID: <e0dc08fd-cd00-240d-edc4-5799d51aa5a8@opensource.wdc.com>
Date: Fri, 17 Jun 2022 15:12:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 axboe@kernel.dk
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org,
 jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
 dm-devel@redhat.com, jonathan.derrick@linux.dev, gost.dev@samsung.com,
 dsterba@suse.com, jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 Damien Le Moal <damien.lemoal@wdc.com>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
 <20220615101920.329421-14-p.raghav@samsung.com>
 <63b0cfb6-eb24-f058-e502-2637039c5a98@opensource.wdc.com>
 <0b819562-8b16-37b6-9220-28bf1960bccb@samsung.com>
 <0c4f30f2-c206-0201-31e3-fbb9edbdf666@opensource.wdc.com>
 <4746a000-2220-211e-1bd6-79c15c18a85c@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4746a000-2220-211e-1bd6-79c15c18a85c@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_231213_392097_15231C0B 
X-CRM114-Status: GOOD (  28.42  )
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

On 6/17/22 14:45, Pankaj Raghav wrote:
> On 2022-06-17 01:49, Damien Le Moal wrote:
>>>> Why do you need to change dm_set_zones_restrictions() at all ?
>>>>
>>> When the device mapper is created, the q->limits gets inherited from the
>>> underlying device. The chunk sectors of the target and the device will
>>> be the same but we want the chunk sector of the target to be different
>>> (rounded to po2) compared to the underlying device's chunk sector. This
>>> needs to be done only for the dm-po2z target and not for other targets
>>> that uses npo2 zoned devices (like dm-linear). So to perform this
>>> operation in a target independent way in dm-zone.c, I chose to always
>>> revalidate npo2 zoned device and update the chunk sector and nr_zones in
>>> dm_zone_revalidate_cb based on the zone information from the target.
>>> This allows to set the limits correctly for dm-po2z target.
>>
>> But DM revalidate will be called for the target AFTER it is setup (after
>> its gendisk is added). So how can DM revalidate see the incorrect zone
>> size ? If that is the case, then the target constructor is broken or
>> missing something. DM revalidate zone is generic and only allocates the
>> zone bitmaps for the target device. There should be not need at all to
>> touch that function.
>>
> I think this is a cleaner approach using features flag and io_hints
> instead of messing with the revalidate zone function:
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 135c0cc190fb..c97a71e0473f 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1618,6 +1618,9 @@ static int device_not_matches_zone_sectors(struct
> dm_target *ti, struct dm_dev *
>  	if (!blk_queue_is_zoned(q))
>  		return 0;
> 
> +	if(dm_target_supports_emulated_zone_size(ti->type))
> +		return 0;
> +

This should be in validate_hardware_zoned_model(), not here.

>  	return blk_queue_zone_sectors(q) != *zone_sectors;
>  }
> 
> diff --git a/drivers/md/dm-zoned-npo2-target.c
> b/drivers/md/dm-zoned-npo2-target.c
> index dad135964e09..b203be808f09 100644
> --- a/drivers/md/dm-zoned-npo2-target.c
> +++ b/drivers/md/dm-zoned-npo2-target.c
> @@ -187,6 +187,12 @@ static int dmz_npo2_end_io(struct dm_target *ti,
> struct bio *bio,
>  	return DM_ENDIO_DONE;
>  }
> 
> +static void dmz_npo2_io_hints(struct dm_target *ti, struct queue_limits
> *limits)
> +{
> +	struct dmz_npo2_target *dmh = ti->private;
> +	limits->chunk_sectors = dmh->zsze_po2;
> +}
> +
>  static int dmz_npo2_map(struct dm_target *ti, struct bio *bio)
>  {
>  	struct dmz_npo2_target *dmh = ti->private;
> @@ -233,12 +239,13 @@ static int dmz_npo2_iterate_devices(struct
> dm_target *ti,
>  static struct target_type dmz_npo2_target = {
>  	.name = "zoned-npo2",
>  	.version = { 1, 0, 0 },
> -	.features = DM_TARGET_ZONED_HM,
> +	.features = DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONE_SIZE,
>  	.map = dmz_npo2_map,
>  	.end_io = dmz_npo2_end_io,
>  	.report_zones = dmz_npo2_report_zones,
>  	.iterate_devices = dmz_npo2_iterate_devices,
>  	.module = THIS_MODULE,
> +	.io_hints = dmz_npo2_io_hints,
>  	.ctr = dmz_npo2_ctr,
>  };
> 
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index c2a3758c4aaa..9f3a4d98a22a 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -283,6 +283,15 @@ struct target_type {
>  #define dm_target_supports_mixed_zoned_model(type) (false)
>  #endif
> 
> +#ifdef CONFIG_BLK_DEV_ZONED
> +#define DM_TARGET_EMULATED_ZONE_SIZE	0x00000400

Make it general: DM_TARGET_EMULATED_ZONES

> +#define dm_target_supports_emulated_zone_size(type) \
> +	((type)->features & DM_TARGET_EMULATED_ZONE_SIZE)
> +#else
> +#define DM_TARGET_EMULATED_ZONE_SIZE	0x00000000
> +#define dm_target_supports_emulated_zone_size(type) (false)
> +#endif
> +
>  struct dm_target {
>  	struct dm_table *table;
>  	struct target_type *type;
> 


-- 
Damien Le Moal
Western Digital Research

