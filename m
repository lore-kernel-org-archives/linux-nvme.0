Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94463C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZAOQdaO893AEBxNp4scHhRgpjNbo2I+fYq/hsWNdKq8=; b=ZQ94dk3F1d4izdaygxNqAej103
	nmeYw8D8vQdVrY/+oO11nD0//GvKERzF2BmkuuiHZXG5re1TYV536LmExaPmzHySi2JkvXlvYwROc
	afs74OmVxdKaZdtqmbqidcXbSsa3N34pdqCWcX2ONdZxcqlQO6o+i5kkUDcEGrD6/q7ZgiXdgxjn0
	htcdTaVB68ixmFCu+tXtxoOrBpobGb5R6PTPESUdIkP1rFsENExujYLC7+hDICN5GVzpf965Pxmlg
	6QRirb/iirNKuHsqpVgbDYPxRDmlyQSdRFSipvtT/lTHAQQPYoTh1M5i9QBTcJV5rEAzzAJayXybi
	VV/OjXfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o25tw-005nxl-MF; Fri, 17 Jun 2022 06:56:16 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o25tt-005nwz-5o
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 06:56:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655448972; x=1686984972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1h2b47a7yQ4psgtiKa1vXTHgS2gxDIb5ubjtosDpiqE=;
  b=k+Vt48OnvEp5CofEytC2DcRniZ4I4Tc1LttqCN9bXuZY1hH5EDGLWnb+
   mLdA4Swe8HYRCqF07RZHFrdPt9TLFBbVgzrveDmHPpludmwkPZxx67r/T
   JGA9JWdzZLA8T/z+XN2N9nXti+YCuErbYxRX576Ynmpd2Tc7d4Tg+PXnT
   e+IiyBgzdgZWZnWc8uW/WxfGg2EnqYyZOtjVkibejx4BGO6ZMQ9gBpaQ4
   h3QdcqRbLheYUkiX9oSvS44gd0R4WW2P6YyQxjtA4k0J0kHHTeQhyCgkI
   DkTOOB9BhgS6h79Po4yqhAk9cZHJ3hP+Ccw1lgbTtRKdpffIrdN5cvtAY
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="315489585"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 14:56:09 +0800
IronPort-SDR: g88isA0WB9g3Q5IJs79lwSPRCmUk8WGO3WPGdFi7IdWxi00q2cOhf05M0s0M34//mPpDBuQoxx
 TdY1Ad5xFWfdPbYIfVsirAqhowwhDHYsChlIIQ3nOLjvpb4EB7fe2imnLFtxOgHJmUedkFTh8s
 N0E36E+WF98CK2UKeIF2So8VS9nIWwTx4egBpGiyjOw/En+fk3qfhB2rVF9j0SdHZ1AvP4lxHv
 T0A+Xp6YAB0i/T39hTZrJV0kHt+/o85ubujYjDhL9wRfCn3BGSvXRdkMzLgQcFNwGcuaggfWZe
 FVLYOddaX0yE3/bjPyut1NBT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:14:21 -0700
IronPort-SDR: TWs5dzl3bOFUTGvUv+rT6feFZS42cpw8UdS+2pSNmVa7OL74P3GQdM1yiKQT5A46i8QcrT0tCw
 +Ix1DAMI6aXS4OWuPEgvhlNa2l+9UBRWmv/iN42f3/bE1YQO3qVFj60Q+M/w67VSeaYFMXUFai
 //x3KyKFDc0uH8DE2p7MWxFIc9rkTieCn0xqKFtO2b9vJrgKe1SVcItMsts3rN//FpUDER4mB/
 beaLHDXxXztoxwJDXziDzntlXMNK/eGCMUjDbjmlshSA9ow/bz65FXZdvAO8+avszOWBnDAJmK
 brs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:56:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPVF45GRSz1SVp9
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jun 2022 23:56:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1655448968; x=1658040969; bh=1h2b47a7yQ4psgtiKa1vXTHgS2gxDIb5ubj
	tosDpiqE=; b=qb4uByFslHtWJFQLrX4pZEaeaByJ2HyAnP5lEzdw+xJi78+6C67
	cyE2RaOL4UPO8ORVwyNBoOYSLfE2zidPKU7qQlwqN5gwY1xnWPmQms2FDDmui/Jl
	y120tMEcjY//Y5sHO9hcNLRlqnYlTyfBSVvEwIiOVMeOrdpEPBfRw9pBEXWMJltV
	XxWJss40VSYQ3IKD4TVJZdK3M+EwYfGEVMNYcw/Zc3q6tU0CvHAD1YAVv6sVSqXu
	waMYiUBQm/0gE2eIaS0zd7pXlgDCN8hvvGkVFESzFOyzPm21obezuNCiM7viNfer
	K9czul0nBRZB/kInTzDv6qx1JI/pjf2um9w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pmhVbTkRf0ZK for <linux-nvme@lists.infradead.org>;
	Thu, 16 Jun 2022 23:56:08 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPVF05H8mz1Rvlc;
	Thu, 16 Jun 2022 23:56:04 -0700 (PDT)
Message-ID: <f4cf6348-dd94-aa82-7519-318248c51151@opensource.wdc.com>
Date: Fri, 17 Jun 2022 15:56:03 +0900
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
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
 <20220615101920.329421-14-p.raghav@samsung.com>
 <63b0cfb6-eb24-f058-e502-2637039c5a98@opensource.wdc.com>
 <0b819562-8b16-37b6-9220-28bf1960bccb@samsung.com>
 <0c4f30f2-c206-0201-31e3-fbb9edbdf666@opensource.wdc.com>
 <4746a000-2220-211e-1bd6-79c15c18a85c@samsung.com>
 <e0dc08fd-cd00-240d-edc4-5799d51aa5a8@opensource.wdc.com>
 <a945def3-ba5a-7539-e96a-43ade0ae674a@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a945def3-ba5a-7539-e96a-43ade0ae674a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_235613_304670_B180208B 
X-CRM114-Status: GOOD (  25.70  )
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

On 6/17/22 15:40, Pankaj Raghav wrote:
> On 2022-06-17 08:12, Damien Le Moal wrote:
>>> I think this is a cleaner approach using features flag and io_hints
>>> instead of messing with the revalidate zone function:
>>>
>>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>>> index 135c0cc190fb..c97a71e0473f 100644
>>> --- a/drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -1618,6 +1618,9 @@ static int device_not_matches_zone_sectors(struct
>>> dm_target *ti, struct dm_dev *
>>>  	if (!blk_queue_is_zoned(q))
>>>  		return 0;
>>>
>>> +	if(dm_target_supports_emulated_zone_size(ti->type))
>>> +		return 0;
>>> +
>>
>> This should be in validate_hardware_zoned_model(), not here.
>>
> I am not sure about this comment. We need to peek into the individual
> target from the table to check for this feature right?
> 
> if (dm_table_any_dev_attr(table, device_not_matches_zone_sectors,
> &zone_sectors)) {
> 	DMERR("%s: zone sectors is not consistent across all zoned devices",
>         dm_device_name(table->md));
> 	return -EINVAL;
> 	}
> 
> So we call this function device_not_matches_zone_sectors() from
> validate_hardware_zoned_model() for each target and we let the validate
> succeed even if the target's zone size is different from the underlying
> device zone size if this feature flag is set. Let me know if I am
> missing something and how this can be moved to
> validate_hardware_zoned_model().

Your change does not match the function name
device_not_matches_zone_sectors(), at all. So I think this is wrong.

The fact is that zone support in DM has been built under the following
assumptions:
1) A zoned device can be used to create a *zoned* target (e.g. dm-linear,
dm-flakey, dm-crypt). For this case, the target *must* use the same zone
size as the underlying devices and all devices used for the target must
have the same zone size.
2) A zoned device can be used to create a *regular* device target (e.g.
dm-zoned). All zoned devices used for the target must have the same zone size.

This new target driver completely breaks (1) and does not fit with (2). I
suspect this is why you are seeing problems with dm_revalidate_zones() as
that one uses the underlying device instead of the target report zones.

Based on this analysis, validate_hardware_zoned_model() definitely needs
to be changed. But device_not_matches_zone_sectors() is to check the
assumptions (1) and (2) so changing it for your new case is wrong in my
opinion. You need another set of assumptions (3) (define that well please)
and modify validate_hardware_zoned_model() so that the defined constraints
are checked. Using a target flag to indicate the type of zoned target is
fine by me.

-- 
Damien Le Moal
Western Digital Research

