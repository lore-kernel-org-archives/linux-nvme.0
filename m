Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA5CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 09:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PgoIpCFV9nbO2K9pX6LtyH4pyLyEyHerXvs2IKGq8PE=; b=bOO0P6rlz22aTuVR/EA3meNAPO
	Kn5zgMMWpD6dB3qOrfwfh5PmEvvkyEctgNP7yqf7SMDCpkwMsSYcNetbHdJZumspBpthFnRh1eGx6
	ARn/o6YUblTODMnVJln6oJwjIekudCTCNNmZFmVpIZUwL9k7Qcryn4Ev1MzICXpXOfddJiMrxHAzl
	OAQZjpUSxsqG+FhJTIC/piwWXvf5Vi61v3x9B1eW2q5M41TTxHlMzzjMOPjB3WO0K8ZNGDTa7IsQw
	Nr3dcxC1nSOJA3w7/YjR4wGl8KxjskgbHgSdsyhcAgpcYTVPWUPZJJdH9q7Zek4CF8Bc1EsIjxOol
	NScYPe5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTgtO-004m5v-Lf; Mon, 14 Mar 2022 09:21:30 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTgtL-004m50-Hp
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 09:21:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647249687; x=1678785687;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Cd7FLoAa/6MbNTMK+2Yj2V4WVbLZ91RoXOCIOk7PSpc=;
 b=EBVgqP6PI/9ntwKOBhMJpcxA0HcjO49Ph0oyBfnlXIwWYa9ncOR6SMgL
 kTIRPXoEHINb+cdLGfHkiQQVocm5gQdBeVXiblXTO6hjp3WNjUAhCuTCV
 mHtPkIoqlX5e8fNMjWaGY/tiU55SyVkLVYt4ySvEFCHcakxfVMYBfiKgO
 Ic9uXqCeUnhEpa+hpgWV3YjTkfGbpFssxxZWJYi6bIiLhr0AqYM1BPgnT
 BHS+5sQJds0sWT4wRh49NdrszjUO9JU3+D6XCDrDKoMld4tH91+wFO5Qp
 Hj3oB/+E5z0LiocoBW8uf/o04pGR7wsFxGcGVs+KSsQrFLBLeKukR/vBV g==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; d="scan'208";a="299435630"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 17:21:25 +0800
IronPort-SDR: aABAqvLxYQxMaEvQQktskpJuktFotUkgpjGgdiOnn6WLthEolJduCuyguFjB31HxHSzIeY9Cv+
 9yVFgfinRVEjjQA3s8F4a8APClLRk0/dIPPAwC4hjB7Yp/t5Tc/WO31j3fV0SbdlFYRoTzG8mr
 LIxhb7U1xzBXtyTOoagDAq+ctDiP9eqjFvXaex4TroQVsuLKFt48C0nGBmUMe/gQK6Hcrp71it
 ddAodsDrE5O0VLIz+chYIPRaf4e3l6tp9gsCT8rbDTak4vdRU4dGiyQjj87sSFSljP0CQwmLZe
 4ObhyN3LdaF5YOISFXC/18M4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 01:52:33 -0700
IronPort-SDR: vOijz1EjObigFqAbWPe7VWp/wtmWKFsl0+sRjtZ0tYblCHGyJnE5dlI4GUutFY9N3d1ipYPvnm
 c7+fMb81eDVBsxq5DxrupeYdMbSrJErBlWuRIAQecD17sSW53rVQOJPSZnNlltgLtgm+Oxhw5v
 S81G/UhUvzLXKXS4mwhkDlAhgBKhfMk/HOR8Tk3GHd1r7JJL4AcjMlgOBs9N7o/FxPThRkmtB/
 jehvmUsKCwmuA7VDTXfUa53dA5+UmLgc4kGlt/tG4pMxirYmPyQHMphhoLrHDQiB8u1Igbdk3t
 h/g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 02:21:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KH9yX41dqz1SVp5
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 02:21:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1647249683; x=1649841684; bh=Cd7FLoAa/6MbNTMK+2Yj2V4WVbLZ91RoXOC
 IOk7PSpc=; b=VCJpjAo1zour5yvaS91JMT22+/rx90tpFQ/L5y84lVTWmLXUDY8
 ejV+luzKm80Ji3RqqeuM6gTwRFXVXlxyv5hW/P3p9nRWeNqrfgQ2Nks1moX3LPX2
 s+AGAV4CRVYtsSmp3Ar05PQxM/tBTKq8SgGIONLo9LrhrxXMzeYOMPSFXOAZzbiQ
 ls45u4xuxfjEz5CzKJXe/uVeKrlvOuEIf2OHp8dkEMjV3FPs7Q6XApMo9Pya93oJ
 7cRvV0jnPPkvZX07Oy3HB7aEtpNK8aQKbh4kw1dx+gdNjPJoiNhe+HS40Mtmk20B
 KbN2OCbk8BYY4nkMWDihkx8he/u6bPUdOjA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id RgQnPPL1eyO9 for <linux-nvme@lists.infradead.org>;
 Mon, 14 Mar 2022 02:21:23 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KH9yT2kjZz1Rvlx;
 Mon, 14 Mar 2022 02:21:21 -0700 (PDT)
Message-ID: <7c90bf68-b088-3d91-f24d-b90fe59ffc1d@opensource.wdc.com>
Date: Mon, 14 Mar 2022 18:21:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <johannes.thumshirn@edc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, Jens Axboe
 <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
 <20220311201608.275384-1-p.raghav@samsung.com>
 <07484796-d692-6247-427f-20d0e9ac6193@opensource.wdc.com>
 <6929490b-5a73-5dd3-d5a4-afe9d3c9b347@samsung.com>
 <20220314084449.GA5866@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220314084449.GA5866@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_022127_764127_69D94041 
X-CRM114-Status: GOOD (  15.38  )
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

On 3/14/22 17:44, Christoph Hellwig wrote:
> On Mon, Mar 14, 2022 at 09:36:35AM +0100, Pankaj Raghav wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 51c08f206cbf..cde33f2a3a5a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1855,8 +1855,7 @@ static void nvme_update_disk_info(struct gendisk
>> *disk,
>>  	blk_queue_max_write_zeroes_sectors(disk->queue,
>>  					   ns->ctrl->max_zeroes_sectors);
>>
>> -	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
>> -		test_bit(NVME_NS_FORCE_RO, &ns->flags));
>> +	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO));
>>  }
> 
> This creates a race window during revalidation where the zone will be
> set writable here only to be set read-only again a little later.

Then the only good solution is to have the RO flag set before calling
device_add_disk(), no ?

-- 
Damien Le Moal
Western Digital Research

