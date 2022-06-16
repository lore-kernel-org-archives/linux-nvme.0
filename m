Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548ABC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jun 2022 23:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B6pQ04MxGOEoYL74lS9TaHed/5YozFxjIO3/Bq61Jmo=; b=44Av+/5TuBP6q81db5HQDay8Zy
	RL6O2T+0grw/p9fy2s4y+RhMepBJahQ0s0EQDnCRcu8BDl1O0Vd9OaML2//Pl7H/vqa3G3560/2Fc
	NlrWE9onjsdxdFhK70tzHXdUAV2nocJinvMU37U9ATloLHTyCre5XhciyEr/IODxBy3JXcqBgluTO
	+sKK++KHdptOkwsgfLKBmB24u5X0Bjf+19QRmuU61y9G8BHNmaSIfmDvk7G8MRPg8Ety7MSuZTURJ
	UpbZHkDmpWRsvlzlXFeEr+DA5ElB//S5wT8C76+41E678QeAHSw4W5S2BCqNwKkgI/TX0CePLYvPp
	TjFK1KQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1yzz-004lMr-Bq; Thu, 16 Jun 2022 23:34:03 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1yzw-004lM1-Lw
	for linux-nvme@lists.infradead.org; Thu, 16 Jun 2022 23:34:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655422439; x=1686958439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=miOh0Krt3dHgfQ++Q3+hZ/C+eYxh5MtrLlarE6QmQps=;
  b=MbOBgmYxcyX10iXCellmmhpKAN5z+dirRteYxv+Fy4avh8pCP21A/1jC
   sVaJj0IW1mCJyZ4pHvdvpnlNGdCRzBG3b8AvF18LfCh4on/iDKWKZqXWK
   mulXzFrAWoLUdd2tGREPptBlbHx9dNEdtVKHtbcVs8auSNEgr4RNz/NSO
   2BWvGJDVhbEfaFbwkRYcfsEZiKIVp6MDly6BwSMdDmZucVSUuHnp23PHp
   +OWhVmQlpObYObjIOC4Y5L79zEf6h2zqt+xpFhoTnCsYkTC/pS1aB+BnX
   Sz7TOHWa1zSPNBSrHXqC45Y1gysCgQiM222AkJHD9N8bUmx31w+DeRHjf
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208231349"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:33:57 +0800
IronPort-SDR: kAzccEQ1MfuzNBPFz3x8KACfRbyzg8CiWvpOEnl9X4zVbkdwL2tLVa9Q/6TbSqZaVRAHls3wq+
 uZJq52j2kk2WxtZRnbjW2Gg5LvvpQr6/WUi64b7FogQLhzTy9cXOl15DP8lINawcN3TVFyl8Fw
 dWg8itGpiYnIW0yxMGzhWgvgTuFZo1BWx0eNslRIXsFvvbnQ/k8LVO57pUWf5E3sFLOuf5sw0U
 amV2tV0LeS6CNXH3bB5mSEkfTBxravSaLbozI3I3zLxQRhZIHwqNp/hGD8nAvt2REtu8DH7BaZ
 FGFVREgC7s0BtVL+WmBLL6ZM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 15:56:34 -0700
IronPort-SDR: YjdAAT4/LdilfCtxSRw7mxIEzkPryzZ9576LI/zGKeH1EwO3gHiBKEBvq1cTWvKvUx591GeWMv
 OSqdGnQjAmYFfjxLqwmuNq3llfV9hgBW51IPsNZfgghwB33RnLpvs6aSd6AIxeOxIQbeN0dGG3
 gMRBgcJ8MqMnFuknk35YVrrP/vQkiP3pnM3dxQm919aZF9TlJz5xHshc7AKaJx8NJYj9NwIeNx
 tKeaA6Mtkw4M/vKeQWooqyqg7upY6p8BUyz94SvvJb9xL/nxrHekgHZwdId2EtLj/Bl71jezV6
 6e0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:33:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJQt0PgKz1SVp9
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jun 2022 16:33:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1655422437; x=1658014438; bh=miOh0Krt3dHgfQ++Q3+hZ/C+eYxh5MtrLla
	rE6QmQps=; b=GNW+HIaCLj8DR3T1xtWhCOnJdyz1RYvuJcv8sV9geJELsRRzJTC
	vYTiTPl9snDofRWoUWEpiEc+inLDkhZa3DY5hgtXLJSHqZ33bYFOq+f8JqjTSbNp
	L6JEfP8Ka9SF+BNZotyJRK7IkzIvwSq6UQQvUq0mCa/IEjmFxm79yjI0uwzEWuzN
	0KFwAcstLRBiP6r29hgcA+11HBs6K1tg2gYUJKxix6v+Icvg0Y4qW1rggo4Cksq4
	g1NPbP9PsOfuHpq2ZJ/UD+0Zy9CGOgzfrSBCiOgoe4hpTOsVTYWC8MReMIdN3JUw
	KdSlwqj+UjliYOPpmwe1MCseOC9ihifXY1Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NkpzO6nVD6yX for <linux-nvme@lists.infradead.org>;
	Thu, 16 Jun 2022 16:33:57 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJQp1Ntqz1Rvlc;
	Thu, 16 Jun 2022 16:33:54 -0700 (PDT)
Message-ID: <8883fed1-cc5a-889d-6668-cb8039fbf09a@opensource.wdc.com>
Date: Fri, 17 Jun 2022 08:33:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH v7 12/13] dm: call dm_zone_endio after the
 target endio callback for zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 axboe@kernel.dk
Cc: bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, jonathan.derrick@linux.dev, Johannes.Thumshirn@wdc.com,
 dsterba@suse.com, jaegeuk@kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b@eucas1p1.samsung.com>
 <20220615101920.329421-13-p.raghav@samsung.com>
 <f7b586a3-5370-f3b9-72dc-f9bea0b63f1f@opensource.wdc.com>
 <8d8501e8-9e39-8b02-d248-48f778a95d96@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8d8501e8-9e39-8b02-d248-48f778a95d96@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_163400_785536_90ECBC18 
X-CRM114-Status: GOOD (  25.60  )
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

On 6/16/22 21:24, Pankaj Raghav wrote:
> On 2022-06-15 13:01, Damien Le Moal wrote:
>> On 6/15/22 19:19, Pankaj Raghav wrote:
>>> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
>>> uses either native append or append emulation and it is called before the
>>> endio of the target. But target endio can still update the clone bio
>>> after dm_zone_endio is called, thereby, the orig bio does not contain
>>> the updated information anymore. Call dm_zone_endio for zoned devices
>>> after calling the target's endio function
>>>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>> @Damien and @Hannes: I couldn't come up with a testcase that uses endio callback and
>>> zone append or append emulation for zoned devices to test for
>>> regression in this change. It would be great if you can suggest
>>> something. This change is required for the npo2 target as we update the
>>> clone bio sector in the endio callback function and the orig bio should
>>> be updated only after the endio callback for zone appends.
>>
>> Running zonefs tests on top of dm-crypt will exercise DM zone append
>> emulation.
>>
> Thanks. However, I am facing issues creating a dm-crypt target with a
> zoned device. Steps:
> - cryptsetup luksFormat <zns-device>

luks format is not supported because cryptsetup does not write the
metadata sequentially. I am working on fixing that. Use the plain format.

> 
> is throwing a bunch of IO errors with the following error message:
> Device wipe error, offset 32768.
> Cannot wipe header on device <zns-device>.
> 
> I can observe the same behavior in both v5.18 and next-20220615 with
> cryptsetup 2.4.3.The same step is working correctly on a normal NVMe device.
> Am I doing something wrong?
> ZNS info: zsze 128M and zcap 128M with 50 zones
>>>
>>>  drivers/md/dm.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>>> index 3f17fe1de..3a74e1038 100644
>>> --- a/drivers/md/dm.c
>>> +++ b/drivers/md/dm.c
>>> @@ -1025,10 +1025,6 @@ static void clone_endio(struct bio *bio)
>>>  			disable_write_zeroes(md);
>>>  	}
>>>  
>>> -	if (static_branch_unlikely(&zoned_enabled) &&
>>> -	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
>>> -		dm_zone_endio(io, bio);
>>> -
>>>  	if (endio) {
>>>  		int r = endio(ti, bio, &error);
>>>  		switch (r) {
>>> @@ -1057,6 +1053,10 @@ static void clone_endio(struct bio *bio)
>>>  		}
>>>  	}
>>>  
>>> +	if (static_branch_unlikely(&zoned_enabled) &&
>>> +	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
>>
>> blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))) ->
>> bdev_is_zoned(bio->bi_bdev)
>>
> Ok. Even though I just moved the statements, I think this is trivial
> enough to take it along.
>>> +		dm_zone_endio(io, bio);
>>> +
>>>  	if (static_branch_unlikely(&swap_bios_enabled) &&
>>>  	    unlikely(swap_bios_limit(ti, bio)))
>>>  		up(&md->swap_bios_semaphore);
>>
>>


-- 
Damien Le Moal
Western Digital Research

