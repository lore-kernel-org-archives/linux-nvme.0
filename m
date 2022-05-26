Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E6FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 May 2022 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ORn2rXXFBLsZtlCNe7msJU0mRoDnmgOxZEYFeAReKY=; b=N+89v1hbGRovpaxBLPVZvopN2C
	jHwe8SUXcK+3x/0MgHnv+CJ8ZLS0erIu1Izkr9YoHd3TQrN9juTMJCQiLQxqjyPRQBplXM9Jggykd
	lBlLtBld635EOd9O7XsKAiRFwddAvSxYv9G45s+xGQj7bD+dY9nGn+OFkcItmznISzneaFRubz51d
	kb01qVkQvXutU3CdGFf+u4ghUh1M/eyEQocCJk7wv4Nr6ITXo8q80VAuh2FuYt2Sp+4AjCLFELuE8
	Hy92SMN5Bo0EVEhH1BTMcw35tBjW9oMBhPjUrZIgb165gNNAWRdRnSW6fA7WDO78tu5WUDxZwoW7d
	ci7SoYEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nu8oS-00E3k6-Nf; Thu, 26 May 2022 08:25:44 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nu8oP-00E3i2-QN
	for linux-nvme@lists.infradead.org; Thu, 26 May 2022 08:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653553541; x=1685089541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2fzV6PB7rIH8hutqjCCcvjaAmPuVZ2KddaphMUepXFc=;
  b=LwEhS9MxbKLxidC+gQpmq1bh5z9JDR/SU4kLsMSNhJRiMMSL5XNl8lNp
   89sIpyXGHlxIDuvPCb8iW00YFW1aHPDgsRR7g5oEEEiPzaw8WR1EbaIZB
   1RQkoL4pDG9fE66IfZX7DnUhOxMoO2F0Rr7Sgm1jyOGSOOhdzfdJ4TD6d
   qxszCsLZXoLQXU2cOLqtlu75cUz01EAjNNC2Bslel3Bj/i+imNsMnW0po
   TAaL8RDHi2wHq3rb/u6AUPBdfZkHtzzpt1UwndfnofIc3nMpGrka66oky
   YlGzHmyRhZ8P/UH3MMi3JSti2lVdzc3NY3dFF5Ub0pZZyWTvzzurkSYpT
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="200265525"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 16:25:26 +0800
IronPort-SDR: RR76+zBhozkYGZ/XpIWTN9otD2I9tKy5S141BVUcGDPTlhDepKKx27+vO4kXpl1VmCvCAdlugi
 A2jmgTUTC8Kxd7eFO6zbRXm5CidTMk5ScJvRbJj7xsRAYXqKJvhm2ytIYmNT219fe+/EMaTShG
 i7qVICQLB9ZzG9N2GuDszg9HUwY1ednaRn0boE9hZu/lbUq8l6t8poJ32pkBcpPKYc08QtyEqa
 QDW1jt76YiLzYokYQiFtS85t1zr0fKvM++T4mOMx1OV87/k5nq+5upKLZtHTY+ZDHBqgMNcdfI
 rWhAcUUf4Zfg9j2PT4M5NjH9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 00:44:54 -0700
IronPort-SDR: Z/aVV2AwvHhrqmyN6HcMCQLhhLe3kL4tx70DPc8vzT7+53/FElzgJNMqahHLamC7g97z0AO/P9
 hc5K200FUOijuhOFDDUY1emOx7Eem2sqk1tBJaZ2pYDfEicoKA1izuu99Pc09aql9MMVwq25iK
 HTc3S46OAtRFjp+JGcAPoFSAoGkDT/ksYHacie2XwKmy9sxbD0hLmHJ54/2B0A854mpPGQ0x1I
 z0RH7XvGv++8C77h2h2zeCPaRMmaJgjAVaR5dQsXGtFO1GUUvssQBAYdTmCgRR7lGjKHhiu9bQ
 PRw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 01:25:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L81GC6SkJz1SVp3
	for <linux-nvme@lists.infradead.org>; Thu, 26 May 2022 01:25:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1653553522; x=1656145523; bh=2fzV6PB7rIH8hutqjCCcvjaAmPuVZ2Kddap
	hMUepXFc=; b=E/mS7YlrPtM583nIEsFkcK8t8wBnxJ9gbQuIHuaW989C2ArGadQ
	PQzaKgmCUFhyRqoJoFsaHo3T5pJ7kBgFbo2L8h1HUgFndIx4ndzPFwb+gvOPsPph
	SIuHCLYTWe0vbGbpb/FOzwLexJUY8+l/5MRTI48fTaHbluKGdy+NF2qnDKfZxtYd
	f3jrh/ltG3OHVGXz+Iev615zk3fi+Vwx9hBVf514Z8N569EILYy2kIrip61CN3t/
	rqyUVXIbF/n/EqWU6It5hMpFIun5CgLTlp10jbOCRV7dO8Df+wEqqMs5Q1Wh1GTg
	0t7M5fp7Ze+jyp9o/kxbt17xuKDQjrEibLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nVNrcaZUQxSW for <linux-nvme@lists.infradead.org>;
	Thu, 26 May 2022 01:25:22 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L81G76Gmcz1Rvlc;
	Thu, 26 May 2022 01:25:19 -0700 (PDT)
Message-ID: <3c04e29f-2c99-c350-bc87-0c0633b4d19d@opensource.wdc.com>
Date: Thu, 26 May 2022 17:25:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v6 8/8] dm: ensure only power of 2 zone sizes are allowed
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de, hare@suse.de
Cc: dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, jaegeuk@kernel.org, gost.dev@samsung.com
References: <20220525154957.393656-1-p.raghav@samsung.com>
 <CGME20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789@eucas1p2.samsung.com>
 <20220525154957.393656-9-p.raghav@samsung.com>
 <9703ca4c-33cf-cb3a-b46b-6b0e5537cfd6@opensource.wdc.com>
 <0bb57f61-9a33-0273-4b89-2cdf042e56dd@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0bb57f61-9a33-0273-4b89-2cdf042e56dd@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220526_012541_969337_86CBB709 
X-CRM114-Status: GOOD (  33.90  )
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

On 2022/05/26 17:12, Pankaj Raghav wrote:
> Hi Damien,
> On 5/26/22 01:13, Damien Le Moal wrote:
>> On 5/26/22 00:49, Pankaj Raghav wrote:
>>> Ensure that only power of 2 zoned devices are enabled for dm targets that
>>> supports zoned devices. This constraint can be relaxed once non power of
>>> 2 zone size support is added to the DM layer.
>>>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>>  drivers/md/dm-table.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>>> index 03541cfc2317..2a8af70d1d4a 100644
>>> --- a/drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -251,6 +251,12 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  	if (bdev_is_zoned(bdev)) {
>>>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>>>  
>>> +		if (!is_power_of_2(zone_sectors)) {
>>> +			DMWARN("%s: %pg only power of two zone size supported",
>>> +			       dm_device_name(ti->table->md), bdev);
>>> +			return 1;
>>> +		}
>>> +
>>>  		if (start & (zone_sectors - 1)) {
>>>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>>>  			       dm_device_name(ti->table->md),
>>
>> I thought the agreed upon idea is be to add a dm-linear like target to
>> emulate power of 2 zone size so that we can keep btrfs and f2fs running on
>> this new class of device. So why this patch ?
>>
>> The entire series as is will fragment zoned block device support, which is
>> not a good thing at all. Without the new dm target, none of the current
>> kernel supported zone stuff will work.
>>
> I have mentioned this in my cover letter:
> The support is planned to be added in two phases:
> - Add npo2 support to block, nvme layer and necessary stop gap patches
>   in the filesystems
> - Add dm target for npo2 devices so that they are presented as a po2
>   device to filesystems
> 
> This series is targeting the first phase where we have stop gap patches
> and add support to the block and nvme layer and in the next phase we
> will add a dm linear like target for npo2 zone sizes which can be used
> by all the filesystems. This patch makes sure that we can't use npo2
> zoned devices without the proper support that will be added in the next
> phase in the DM.

Personally, I do not want to see a kernel version where zone support is broken
for some devices. So I definitely prefer everything in one go or nothing.

> 
> Even though we decided we would like to take the direction of DM, I am
> still awaiting reply from Christoph who raised concerns about npo2 zoned
> device support and Mike Snitzer about this approach. That is one of the
> reason I split this effort into two phases.
>> The zonefs patch is also gone from the series. Why ? As is, zonefs will
>> break if it is passed a non power of 2 zone size drive.
>>
> I think this was my mistake. If you agree with the above approach, then
> I can add a stop gap patch also to zonefs npo2 zoned devices. This way
> all the zone filesystem support goes via DM for npo2 zoned devices. I am
> proposing this so that initially we always have only one way of
> accessing a npo2 zoned device (via DM) from **filesystems** until we add
> native support.
-- 
Damien Le Moal
Western Digital Research

