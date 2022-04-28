Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD24C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5V99+plMhQNgsXvKWxOmrgupGvKlMjvlNB0+vQlQDc=; b=qB3C404hYNxoNJWZRabPdCS1T7
	iP9kZ95+ceV243UDfWIHly5+51oL0dafbwzDMek5UBtaLTNI1VKdB/CEgmw5C73g2PXPffLt0Gtx3
	ITZCz0emaz7P1xUUBPpF8UvW0diwoovfih3IjWLwmhphklgJffx0iVfXofjZzL3u7Pg5Or3R20KfJ
	ata6xTKa/0HabNcIn9Zz+yZgE3UKBdD6CGuZFVxijZfmHzHRXdTXueyCBrvJMIWGhY7h4C807Bl4y
	vWpAikBs4HV9UINruyo1TTfy4ScyWHAbEk3PpiOidjP0HL4POawv+/VH4qf6YC0eaEoO670oSzjym
	zcmZKURA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkBvs-008ZBo-5L; Thu, 28 Apr 2022 21:44:16 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkBvo-008ZAJ-TR
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 21:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651182252; x=1682718252;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=m/acreNIl2rWYjlVezvJCF1GJU64s3Qgnn+Km+O6eew=;
 b=GgkH2z4gk/AMA6HIK1Xu5ycsrsl9Ts2chFHJCiacQQNe8O5DkOxh9Xhn
 gIe1ZyudMjI4CvjmOKu8wjzYQeUylhdo9j0HmmMzqVQbMVk2zuv/gCMBY
 Opunp/ZCq4Ih26bBlyfx1lC/T6i0sBBJMoKH6QY3Wbni08rK3hmoWE+oo
 io2uRigC9/nrzul5kxkORAmCQzuUoUDGIvosgOAwsG7u7Ba/RXziP5mvp
 fPLYuq9GWzjinKdx8HyJlExtQygNrrVdCRHthLOT3Nz0p7U5II5UnpbEC
 xd3WHeuCeKDzxE4EOKAxmnXnsDKcWjx0841KaD9dV5LON+Tue71gJrYKM g==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; d="scan'208";a="197940448"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 05:44:06 +0800
IronPort-SDR: NlHteplCf4M5vpxwH7XG78cy+c/VQ/ifr5EIP+5Wbz3c8B7H9xf1qxu7yorqYsuxhsw6KOuRez
 d9CxLfym2eHaaA3i3yD3rxQ/U1T1VIWytBdoFowY2278tJLPJAWbiIHEa1wG0YfWb3oEvaGgha
 +MFvhsbOA4KNumnN5czYKvgsUh+1w2cMVoOvhpb+qjY1qVIwv8PdkmZMwe6o6EoH9CtvqYMAe5
 QuhuKhWsTgmkvL1KB1v7w/dqDPb7jkn55CoIKk5GA4LrjWlhfcmYKYERyzJzNJL0Zs2ef0MjHw
 mkckNeIw4hHZUXYE4tW504/H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Apr 2022 14:14:15 -0700
IronPort-SDR: n8Uu1MHvZ0ePsdDOWvN1Fj5O4gFcm73LSuf1II3HTYjuvp9eeKG7bxzUuz5cNKrrUVEwgW4psz
 ac9LAPtVeVOtfcmuQ+cbKyzOvXiQabbH6kpfu2CPX64623ehnNSdEcalh5J8a6H/9xJ94vY0cg
 Vt9xaeGgddu6QSd4Pam+vwBnr4jo+l2p01X0IRf+9ijH5AVx0j359x7QwWNRZmgo9sXVp6XK1N
 9yd4yfRdYcpG8PNsZaLbmw8quor3L7MzoiZiGDBwtpaJduDKZwVPvPxpUeYtQRVGa7eEe7kjpc
 itQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Apr 2022 14:44:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kq8Jk2xj1z1SVp1
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 14:44:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651182245; x=1653774246; bh=m/acreNIl2rWYjlVezvJCF1GJU64s3Qgnn+
 Km+O6eew=; b=P7Z2ssSysU3MXGjLqOpjIgw3LkMvOLPFsZ5/L/hy8zTXh7RRhg5
 oW7hJpKY5xehv6PCj5aAjux8iBygbEnlV6pT61szKcFi3rCbccmLZRC1mYDrsL9w
 5JjAtxFSVU6nXK85++NGprWHqgYwmhFNOvKCxx/jlLeOdAbLXCvijl/CpAN9syTf
 uL0rhmb3+rt+C1w/CE2rhsYUt7mNpL5EBJi00FmBRkg8jYpAkhDP+NtofLGylSHU
 IdqnZobibaJqdqpH2JChH3JY23wQeJdMZHT5/1cFVjlUHop8+7zb5n39efSFkKX2
 cNB3p+K+aur3vqxw7TEWidzO8wXpFiJo6QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id KJL4fq6rwvhC for <linux-nvme@lists.infradead.org>;
 Thu, 28 Apr 2022 14:44:05 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kq8Jb59qtz1Rvlc;
 Thu, 28 Apr 2022 14:43:59 -0700 (PDT)
Message-ID: <ce56cb7d-f184-aad1-4935-5f622e7afe5d@opensource.wdc.com>
Date: Fri, 29 Apr 2022 06:43:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, naohiro.aota@wdc.com,
 sagi@grimberg.me, dsterba@suse.com, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
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
 <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
 <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_144413_045087_A0C218ED 
X-CRM114-Status: GOOD (  27.89  )
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

On 4/29/22 02:34, Luis Chamberlain wrote:
> On Thu, Apr 28, 2022 at 08:42:41AM +0900, Damien Le Moal wrote:
>> On 4/28/22 01:02, Pankaj Raghav wrote:
>>> From: Luis Chamberlain <mcgrof@kernel.org>
>>>
>>> Today dm-zoned relies on the assumption that you have a zone size
>>> with a power of 2. Even though the block layer today enforces this
>>> requirement, these devices do exist and so provide a stop-gap measure
>>> to ensure these devices cannot be used by mistake
>>>
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>>  drivers/md/dm-zone.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>>> index 57daa86c19cf..221e0aa0f1a7 100644
>>> --- a/drivers/md/dm-zone.c
>>> +++ b/drivers/md/dm-zone.c
>>> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>>>  	struct request_queue *q = md->queue;
>>>  	unsigned int noio_flag;
>>>  	int ret;
>>> +	struct block_device *bdev = md->disk->part0;
>>> +	sector_t zone_sectors;
>>> +	char bname[BDEVNAME_SIZE];
>>> +
>>> +	zone_sectors = bdev_zone_sectors(bdev);
>>> +
>>> +	if (!is_power_of_2(zone_sectors)) {
>>> +		DMWARN("%s: %s only power of two zone size supported\n",
>>> +		       dm_device_name(md),
>>> +		       bdevname(bdev, bname));
>>> +		return 1;
>>> +	}
>>
>> Why ?
>>
>> See my previous email about still allowing ZC < ZS for non power of 2 zone
>> size drives. dm-zoned can easily support non power of 2 zone size as long
>> as ZC == ZS for all zones.
> 
> Great, thanks for the heads up.
> 
>> The problem with dm-zoned is ZC < ZS *AND* potentially variable ZC per
>> zone. That cannot be supported easily (still not impossible, but
>> definitely a lot more complex).
> 
> I see thanks.
> 
> Testing would still be required to ensure this all works well with npo2.
> So I'd prefer to do that as a separate effort, even if it is easy. So
> for now I think it makes sense to avoid this as this is not yet well
> tested.
> 
> As with filesystem support, we've even have gotten hints that support
> for npo2 should be easy, but without proper testing it would not be
> prudent to enable support for users yet.
> 
> One step at a time.

Yes, in general, I agree. But in this case, that will create kernel
versions that end up having partial support for zoned drives. Not ideal to
say the least. So if the patches are not that big, I would rather like to
see everything go into a single release.

-- 
Damien Le Moal
Western Digital Research

