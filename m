Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0250AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C000H/nQUTQfaHct5PNkMTjj4hJBbSe2TpfUD4UNZWA=; b=kE8dWLitOBiIzKsIcwMmT2R3cp
	0jUkhoYYuzkk5p3KLcak5csFbQHULtYrsQo5pXF370iAqeTd7rHgYou5qAkqrNCO3ts55vDnnnJEK
	rKiPNh8ljKz/fiN2u2htzmOqUaoSjozCgTZDQ7LaGV5aqxYF+Wz/0/qg/acSmGMpUFNSfglAWUIO4
	e+YMey27KYLkZzYxqKDUSrqXE9DUDN2GzX3Zz1Cf0acycdcIBt0xlNk/LI/3sRg75EOdQu86Kbmqz
	MbPIw0EAH60WGQywfwpfNjUjx4yzHCdOdg+/E0qMsyy7wyB/EAdIn7+A/ToZWrUAY0t4gx35+457V
	ctgeg52Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlvca-006nML-83; Tue, 03 May 2022 16:43:32 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlvcW-006nIz-Rr
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 16:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651596207; x=1683132207;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gtowxbHk/V4v64RtsKyaAcMJzf5VQm5Xqlz1mGZPWVc=;
 b=Vm46hgYbW5X8fSv2qdC1g6XIAUcjahhx3Edu8HjM9zgp2JH0DM/8+uC7
 ohEmKcbH9MUPjW+8DT3abXhdoYvwaPNojXOlBzuIqq9ellSlnBK3jGWIz
 YBm4AoctUTdSdeaJeTbGG435xgf3MbbH1gktrTevFhxN5EkAsKtJk+yno
 7IT/fIP2F9RNs0NEpR/viLIikeAZitGCDr5oGE2QvE+wx8r6gqO7OnSKD
 bPLSFJjpQeZs7CALH/5C4ZsvE0rdB6UJ2LYA2cU70WRofeuf5UFFvS6Ah
 GE2/mMggHs2d5m1BC1TjndiOI8ffikYEfes5pyNeWVPuekQcAHiw9Fili w==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647273600"; d="scan'208";a="199436009"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 00:43:23 +0800
IronPort-SDR: cBTD7M98g+kKvmq5AshZv6v1d3WGPR56vdFrK0sgivRMpC1Vmt1SW4fEOWgjtqQdOgjYzllBJq
 0GxEQuAyd4pq5RdsD+Ni7qrG16x5AIvEckSipPADMs/vGvDg6WuyrLzJyi2RmbWVThU7wihRx/
 70dyLjdCcq+qV19WYS5kCMDleTa+x5wkikNTZKaQyKyV+S0cqZYvYpy5WLqpRt8XeAlGRyCqFM
 +5m76NznISEA9jL6r837BObDql9uYC7kDbOh/gtUZNHoYh5u8Tyv0pEzbZbNqibZAqGHHh2cSi
 wuBTrGkvIblhrqP5AVI4isbL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 May 2022 09:14:08 -0700
IronPort-SDR: D7q54/qgCwo1JAA0/r5MN4pQ8EeQALoFb9wZzkMkicUc8kNhjwQnA6F6b0wBzipLjgBKZTZE7w
 LuIH/JdgkP/OrJp3tLhVxn18FY1TGPQ4ASLcc6OOSXIz2THweA2NO4vrVf5yc2Pou5kuRY8jH+
 MLKeoKHG48bVc2JAsB7RgSiP5BST/b+nbc6+ZrUfwm+MExfoPEwg+eLeoB7IDbsHg3L5Tw64fM
 32SZNrQW2ANSflBuhC6ouS25BmCs30W51RHZOUVf0jyZlLZXlIuaoYNA/EdfJ35c7Dv8w0fpHt
 Pv8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 May 2022 09:43:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kt5PS2r7hz1SVp1
 for <linux-nvme@lists.infradead.org>; Tue,  3 May 2022 09:43:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651596203; x=1654188204; bh=gtowxbHk/V4v64RtsKyaAcMJzf5VQm5Xqlz
 1mGZPWVc=; b=kcyTVUQijJjNqFplnGo8HKlYc0HiINJOmX4zf5eOserrUbRTMOn
 YXMVAlSIZ2bMCoOrQDR4Jmy+RLEs296UujzAbqNHOInGBSH4H6nIzo26tog37ggh
 CaNs7bGBi+CPrY1jX/gw44Ven3i5IGGJMhCDv1WNXpnf6m1Ub1SWFzbsaFkwMSNj
 X971wrkoCJlGbG8weHoPBvT7RQivmhR8IZQG7bXL4fxwgm5u5apTjuD2LnPkTh4+
 rs/RucYrAJOLR9JTudxvxCVF2DWjlNMHqDOYstMeaMvYAZ8dGc5UQGUdZKdUhQBd
 j1Z6U+4LPn5mXtJBrWjQwFUsHEwYVvWKPUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 8WgIfcSrpyIE for <linux-nvme@lists.infradead.org>;
 Tue,  3 May 2022 09:43:23 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kt5PN0Cqnz1Rvlc;
 Tue,  3 May 2022 09:43:19 -0700 (PDT)
Message-ID: <2c275ab0-c813-22ae-16e3-b16885d06c4c@opensource.wdc.com>
Date: Wed, 4 May 2022 01:43:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 01/16] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Pankaj Raghav
 <p.raghav@samsung.com>, jaegeuk@kernel.org, axboe@kernel.dk,
 snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org, naohiro.aota@wdc.com,
 sagi@grimberg.me, dsterba@suse.com, johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 jiangbo.365@bytedance.com, linux-fsdevel@vger.kernel.org,
 matias.bjorling@wdc.com, linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895@eucas1p2.samsung.com>
 <20220427160255.300418-2-p.raghav@samsung.com>
 <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_094328_943180_E74214B3 
X-CRM114-Status: GOOD (  21.35  )
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

On 2022/05/04 1:37, Bart Van Assche wrote:
> On 4/27/22 09:02, Pankaj Raghav wrote:
>> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
>> also work for non-power-of-2 zone sizes.
>>
>> As the existing deployments of zoned devices had power-of-2
>> assumption, power-of-2 optimized calculation is kept for those devices.
>>
>> There are no direct hot paths modified and the changes just
>> introduce one new branch per call.
>>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>   block/blk-zoned.c      | 8 +++++++-
>>   include/linux/blkdev.h | 8 +++++++-
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 38cd840d8838..1dff4a8bd51d 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -117,10 +117,16 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>>   unsigned int blkdev_nr_zones(struct gendisk *disk)
>>   {
>>   	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
>> +	sector_t capacity = get_capacity(disk);
>>   
>>   	if (!blk_queue_is_zoned(disk->queue))
>>   		return 0;
>> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
>> +
>> +	if (is_power_of_2(zone_sectors))
>> +		return (capacity + zone_sectors - 1) >>
>> +		       ilog2(zone_sectors);
>> +
>> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>>   }
>>   EXPORT_SYMBOL_GPL(blkdev_nr_zones);
> 
> Does anyone need support for more than 4 billion sectors per zone? If 
> not, do_div() should be sufficient.
> 
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 60d016138997..c4e4c7071b7b 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -665,9 +665,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>>   static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>>   					     sector_t sector)
>>   {
>> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
>> +
>>   	if (!blk_queue_is_zoned(q))
>>   		return 0;
>> -	return sector >> ilog2(q->limits.chunk_sectors);
>> +
>> +	if (is_power_of_2(zone_sectors))
>> +		return sector >> ilog2(zone_sectors);
>> +
>> +	return div64_u64(sector, zone_sectors);
>>   }
> 
> Same comment here.

sector_t is 64-bits even on 32-bits arch, no ?
so div64_u64 is needed here I think, which will be a simple regular division for
64-bit arch.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research

