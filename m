Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FEDC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 21:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q4vpJrZYfecfUfqVBm13RZwseFmulXWO9Yw5vjnwbFA=; b=f4UZzKdWKdOjuEeQEH0Klpk2aj
	4GbLQFXSX2xezzMPRKW97XdHVsS7j4QCrJqRhbOYEo2zDS6gC0jaw/HPGAfj0dWhKvA4uwiirwCXD
	LETlrRyc1JYmfs5pxhVuXdvoSeqA8qiSqi2mW8l5dJWTOSJDwhCQ9ge4vpH2XClq2xi6B62d0CAxk
	pmB72xATlIFwBVQO0N2s0t0Cz46cokzlkY7G20JwHqE864jWa1Fpc6d4SqvLHY2RloiUwjqoY16wx
	/Fp58TNiC26CVk0I5JhPF8eEmYaEj/HNGpiDogX6bGJFjkkxDDUpJdwwjkJmodi4jMen/oSOhIAXY
	WspoGplg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS469-00AZl4-Dl; Wed, 09 Mar 2022 21:43:57 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS466-00AZkB-Vy
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 21:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1646862233; x=1678398233;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UOCaRwRejX2MRt5Kznnykwz4zyvkKUYyeuiz314ZHuc=;
 b=TC/nu1t1ybcviC12nbXgRl9PfocJVrjwERsJAouOvbG+t8+DE78WkDJx
 8J9sHUiyrA7hbiIVRGbMu+ORSCylHxXBHpe4F8cjElTSMLUi5Zsj3o9NV
 FF8IKNVvcO8H2oN9tLz+8xOQqkpE77Jihw8ruw0gteAzfriA7w/19RsJu
 z8YdjoY9YRXrT46meT0iyBi96Ahv/lhLyzs38GWPHGxTT7QCrJNTnFis2
 30ZwzpVYb0/rvP/77qjXAoAMmNA9IRXj7+4HyWkH2Wi+3u6V5MECvYjph
 uvDRses4TNn9G3IPr0Bb9TiSZAvTZQXToXePT6osYHiEHR05UCwh/ioki A==;
X-IronPort-AV: E=Sophos;i="5.90,168,1643644800"; d="scan'208";a="194893769"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 05:43:51 +0800
IronPort-SDR: wA7rpnR2ShNSMLWScq/L97C272gKc0oTOzSfvXBRMugyLYZ1jDUAuW9+98Z+8vMFO9TcfSwKPi
 hBfs3Fvjhin3FHHpHxyBdI8neJsbHfQ+64MfYgTc+dz2NqhgV2icpuwptn3cqT+0YpeyaGuCgb
 JddyP1mPGzzSoqil1QKlLcBAKu+MKv55Z+1vdaEX+ZjciWsQrgiarUhvdN0pjvNMbau4CR+W5u
 D5jXwOcIsRsE0EpYylIVlWv/nNsJt8XilgSHTY1FunLmGbjwqEr0Gd6iw0tIRW+er14FXutAtH
 cFIbxJYaUtx8Osf3IabLK3zW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 13:15:07 -0800
IronPort-SDR: uJdCEnqqUwHOtx+m6xv5K64NFnD1RJnVSr9R3BuElSUxng8aMFGiYSm1SjyqQWSlCm5oePYYin
 HkvD7bpD9CMoZ6rB4XSn433pA1lGeBM+1iWo2BUd/OcEkJytYYM0qfOH+trCXb0hK0X+xf1iQ/
 WnIpxb9+bp4+zWdFrGFw+7ffJJgLbRHzRnFZtz0lnw2Jew1Y3vtX+2WzKi+JbWouIXHja2NTvN
 oVcvYPjHJIizTI5ta4+MZs/yle/Goy9t+bpYGeuriN9rwmbUJL3sH9cwksXpkP+pdYM2G2yhk/
 8m8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 13:43:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KDQgX5gslz1SVpB
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 13:43:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1646862231; x=1649454232; bh=UOCaRwRejX2MRt5Kznnykwz4zyvkKUYyeui
 z314ZHuc=; b=OrKRk04VdQjcp4cBqOeoeTG+SknDdGAhlc1vdJsxcgcUAkWWOOS
 v//pN74y8/OiWDRIMFpUl8KyrNrTBBFcfW4nxdBw9mX7oZXULbAYXBKyNinQoyqc
 KzQuX/EQso1djgS68tQKshxZeL2ettHmwZiOAB/+ss0XIarXYJw2jNwKHLrmHqWs
 QJXoE5NnAjEpRm9lYmBy5guFKlWnAPzPsF1D4nBNKBw8gom8Ut4bjfRDCM5m1+BZ
 89iFKbQikWXDLzSFqBIvx46sPmBNUyQKddEiJAyv/G6MPLFo3VE2f5itUh0wUn3L
 JelQitTKJJCijuMjJ0fRchxCoJKKlXKsXtw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 1HuA2FiJ2NlE for <linux-nvme@lists.infradead.org>;
 Wed,  9 Mar 2022 13:43:51 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KDQgT0yxcz1Rvlx;
 Wed,  9 Mar 2022 13:43:48 -0800 (PST)
Message-ID: <bdb92eac-59ef-3ba1-16cb-31219e3a264b@opensource.wdc.com>
Date: Thu, 10 Mar 2022 06:43:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to
 NVMe ZNS devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <matias.bjorling@wdc.com>, jiangbo.365@bytedance.com
Cc: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
 <20220308165349.231320-5-p.raghav@samsung.com>
 <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
 <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_134355_087986_F31791A4 
X-CRM114-Status: GOOD (  33.09  )
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

On 3/9/22 23:33, Pankaj Raghav wrote:
> 
> 
> On 2022-03-09 05:04, Damien Le Moal wrote:
>> On 3/9/22 01:53, Pankaj Raghav wrote:
>  
>> Contradiction: reducing the impact of performance regression is not the
>> same as "does not create a performance regression". So which one is it ?
>> Please add performance numbers to this commit message.
> 
>> And also please actually explain what the patch is changing. This commit
>> message is about the why, but nothing on the how.
>>
> I will reword and add a bit more context to the commit log with perf numbers
> in the next revision
>>> +EXPORT_SYMBOL_GPL(nvme_fail_po2_zone_emu_violation);
>>> +
>>
>> This should go in zns.c, not in the core.
>>
> Ok.
> 
>>> +
>>> +static void nvme_npo2_zone_setup(struct gendisk *disk)
>>> +{
>>> +	nvme_ns_po2_zone_emu_setup(disk->private_data);
>>> +}
>>
>> This helper seems useless.
>>
> I tried to retain the pattern with report_zones which is currently like this:
> static int nvme_report_zones(struct gendisk *disk, sector_t sector,
> 		unsigned int nr_zones, report_zones_cb cb, void *data)
> {
> 	return nvme_ns_report_zones(disk->private_data, sector, nr_zones, cb,
> 			data);
> }
> 
> But I can just remove this helper and use nvme_ns_po2_zone_emu_setup cb directly
> in nvme_bdev_fops.
> 
>>> +
>>>  /*
>>>   * Convert a 512B sector number to a device logical block number.
>>>   */
>>>  static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
>>>  {
>>> -	return sector >> (ns->lba_shift - SECTOR_SHIFT);
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +	return ns->sect_to_lba(ns, sector);
>>
>> So for a power of 2 zone sized device, you are forcing an indirect call,
>> always. Not acceptable. What is the point of that po2_zone_emu boolean
>> you added to the queue ?
> This is a good point and we had a discussion about this internally.
> Initially I had something like this:
> if (!blk_queue_is_po2_zone_emu(disk))
> 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
> else
> 	return __nvme_sect_to_lba_po2(ns, sec);

No need for the else.

> 
> But @Luis indicated that it was better to set an op which comes at a cost of indirection
> instead of having a runtime check with a if/else in the **hot path**. The code also looks
> more clear with having an op.

The indirect call using a function pointer makes the code obscure. And
the cost of that call is far greater and always present compared to the
CPU branch prediction which will luckily avoid most of the time taking
the wrong branch of an if.

> 
> The performance analysis that we performed did not show any regression while using the indirection
> for po2 zone sizes, at least on the x86_64 architecture.
> So maybe we could use this opportunity to discuss which approach could be used here.

The easiest one that makes the code clear and easy to understand.



-- 
Damien Le Moal
Western Digital Research

