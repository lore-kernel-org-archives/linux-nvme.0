Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD45AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YD5d2G1dkPAvxZK3dGgIzBtvm6sOZtqRmFfMOg5VGyA=; b=kprG+otsQL7xsB
	8PYtqCUhIlCghULy2DS1OGcJmm/xIK6Y6Q/VTodMSaeVVkzKqNr15CZZntvoZHTx0K1dxUILNYZB5
	QD6C9K0301dvCvHmIxJm6FrCkmhaoBc5whGE6ZQjBxIDvrPMPcn9DDLIbXZKPxdd/bo6d9X7ZEp15
	T5O/La0Zh0wcyWlL5Xy3+QEwbmU0And7sy54H/Cl3dOb1rYP6+hP9ejWkmMCnWE/CqdQe9FOZvPDP
	B4FESr3uMQukStaHJHkfLm61nx9MFAu0tzSRCdd5ebo4rPEPQGXLb+Ly/B7P34JXclxQvg8Bzj/D0
	dj3wThSJcF+aWgTp5/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRxXT-0092S6-LE; Wed, 09 Mar 2022 14:43:43 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRxWh-00927M-45
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 14:42:58 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220309144252euoutp0203c648dfe49100887327fbcee62b8096~avYBqebSR2734327343euoutp02a
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 14:42:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220309144252euoutp0203c648dfe49100887327fbcee62b8096~avYBqebSR2734327343euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646836973;
 bh=YD5d2G1dkPAvxZK3dGgIzBtvm6sOZtqRmFfMOg5VGyA=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=HfckMAX+z49YBOezMlBjoQMctfLbY8jbmDUQjyYlSy5ULjsT3XBaZqEqEJL4orbgR
 BP/8ts/GbwF6wdiK9QWV+Pxxtq/jMRQ1lWeCMjwnu476l2WWbOdmRUSG43ZBoivCKJ
 uQzJBAmavqijyMeKRSH6b5Dh/xS+fNbLZsCNlfgo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220309144252eucas1p2ec1d5de65177cf870145096de8eb1221~avYBVJw_U1920719207eucas1p2e;
 Wed,  9 Mar 2022 14:42:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id CF.54.09887.CECB8226; Wed,  9
 Mar 2022 14:42:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220309144252eucas1p124afc2916b9f5845830d2e0c0893b1ad~avYA_PSfx2862928629eucas1p1w;
 Wed,  9 Mar 2022 14:42:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220309144252eusmtrp219fb4a2029eb4906a92d390fe2395c24~avYA9a4OL0784707847eusmtrp2W;
 Wed,  9 Mar 2022 14:42:52 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-7d-6228bcecfc44
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 52.E5.09404.CECB8226; Wed,  9
 Mar 2022 14:42:52 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220309144252eusmtip1f44a014003811ef31ecc3a7f1bf3d768~avYAvarsL1616816168eusmtip13;
 Wed,  9 Mar 2022 14:42:52 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 9 Mar 2022 14:42:46 +0000
Message-ID: <c76d8778-626f-ea60-47d6-3c785a4fb8a9@samsung.com>
Date: Wed, 9 Mar 2022 15:42:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/6] null_blk: Add support for power_of_2 emulation to
 the null blk device
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, kanchan Joshi
 <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch
 <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <matias.bjorling@wdc.com>, <jiangbo.365@bytedance.com>
CC: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi
 <joshiiitr@gmail.com>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <91d1f4c8-946d-c6b2-d30e-f9af4424221f@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7pv9mgkGTTdUbFYfbefzeL32fPM
 FitXH2Wy6DnwgcXi/NvDTBaTDl1jtNh7S9ti/rKn7BYT2r4yW9yY8JTRYs3NpywW616/Z3Hg
 8fh3Yg2bx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2QCUa73P6vF5k5xH+4FupgCuKC6b
 lNSczLLUIn27BK6M6e+uMhes5K9oPHuOqYGxnaeLkZNDQsBE4tT6lexdjFwcQgIrGCXmXtoD
 5XxhlPhw7w8ThPOZUeLZ1qPMMC0nfz1gA7GFBJYzSnSuyIEretH5mBXC2cUocWzlcyaQKl4B
 O4kNS26zgNgsAioS2w/OYoGIC0qcnPkEzBYViJB4eeQvWL2wQIJE+8VJYBuYBcQlbj2ZD3aG
 iMA5ZomLHZNZIRITgVbvMu9i5OBgE9CSaOxkBwlzCrhJNB9eCdWrKdG6/Tc7hC0vsf3tHGaQ
 cgkBZYnX620gnqmVWHvsDNjLEgLnOCXeT9nKCJFwkbi+4xoLhC0s8er4FnYIW0bi/06IeyQE
 +hklprb8gXJmMEr0HN7MBLHBWqLvTA5Eg6PEsQNHocJ8EjfeCkLcwycxadt05gmMqrOQgmIW
 kpdnIXlhFpIXFjCyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMc6f/Hf+yg3H5q496
 hxiZOBgPMUpwMCuJ8DaFaiQJ8aYkVlalFuXHF5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpa
 kFoEk2Xi4JRqYKpeu3j9++SDK48Z2LPKVYgcil1le62V9eafh9Kc+/p04nZ4ZNkzy+vuay9T
 9v5pw3nbWzhLt0msV0n/tFWU4/6brqek/4dc2yPZzZKwJH8Lr8BNrse1z90WvH6/r07j5b+M
 nT6nZ3QfviF3117+1Vkx0YfLFQPdr27ULk5ZsfZKuNXvuRP/Ptq/ekalukP9vUt/rU7tfne6
 a+J0qw8rvla88P6yxKzdhk01cU1rrmWAwkOhx3lr2SPPzubIPfdZbdGb6IrT2y7a8E7N6Zyw
 NMXk7o7O7DXbv6xo8f//fHn8jh2rD3mvapbYkLBBLmunkVHQq1+853J/nLj57UVEmJdkkNOB
 Zs51DJKuK9gyd3gosRRnJBpqMRcVJwIAbs5+h+IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Xd03ezSSDOafY7NYfbefzeL32fPM
 FitXH2Wy6DnwgcXi/NvDTBaTDl1jtNh7S9ti/rKn7BYT2r4yW9yY8JTRYs3NpywW616/Z3Hg
 8fh3Yg2bx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2QCUa73P6vF5k5xH+4FupgCuKD2b
 ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M6e+uMhes
 5K9oPHuOqYGxnaeLkZNDQsBE4uSvB2xdjFwcQgJLGSWuPLjJDpGQkfh05SOULSzx51oXVNFH
 RolNK05DObsYJV7Pec4IUsUrYCexYcltFhCbRUBFYvvBWSwQcUGJkzOfgNmiAhESbcumMIPY
 wgIJEjdefmcCsZkFxCVuPZnPBDJUROAcs8TFjsmsIA6zQD+jxJIpP1gh1v1mlFj6YhGQw8HB
 JqAl0dgJdh+ngJtE8+GVbBCTNCVat/9mh7DlJba/ncMMUi4hoCzxer0NxDu1Eq/u72acwCg6
 C8l9s5DcMQvJpFlIJi1gZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRmB62Hfu5ZQfjylcf
 9Q4xMnEwHmKU4GBWEuFtCtVIEuJNSaysSi3Kjy8qzUktPsRoCgykicxSosn5wASVVxJvaGZg
 amhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXApBkUEXT/HcPXuqPbXs1+fTKU
 6Rzbbs91cRarjs26VM0q45sscOJ7lPHPBfoS0Sumq/kzOc1dOcfwieonbpXs3omSaewL1hwV
 mCWVvfyu1xeRee4Pb+h1aC2b8vgrZ9kxn8nz3K/eid/04fy555qC/AG2u646GkyLmL0jddL+
 1Ya3eph6WHassEnYsfHiE85Fs/OZHrBleMxI2PnSJyvSzCHsuKtQS4jiSYWT6841/OITvJG6
 KWia3a7ttZ4TK67pv/giapJeur7iRX6tPsP6aMtZq+IvRrSV5O19Jn874fGKPBXWXNMzL5d4
 2mleeu7whTtAIYvBw/Mi80e+L7KfSrkbFj4sn3HvU/I11aeTVyuxFGckGmoxFxUnAgC5iPvd
 mAMAAA==
X-CMS-MailID: 20220309144252eucas1p124afc2916b9f5845830d2e0c0893b1ad
X-Msg-Generator: CA
X-RootMTR: 20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac@eucas1p1.samsung.com>
 <20220308165349.231320-7-p.raghav@samsung.com>
 <91d1f4c8-946d-c6b2-d30e-f9af4424221f@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_064255_526285_0C05DDB3 
X-CRM114-Status: GOOD (  27.58  )
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



On 2022-03-09 05:09, Damien Le Moal wrote:
> On 3/9/22 01:53, Pankaj Raghav wrote:
>> power_of_2(PO2) emulation support is added to the null blk device to
>> measure performance.
>>
>> Callbacks are added in the hotpaths that require PO2 emulation specific
>> behaviour to reduce the impact on exisiting path.
>>
>> The power_of_2 emulation support is wired up for both the request and
>> the bio queue mode and it is automatically enabled when the given zone
>> size is non-power_of_2.
> 
> This does not make any sense. Why would you want to add power of 2 zone
> size emulation to nullblk ? Just set the zone size to be a power of 2...
> 
> If this is for test purpose, then use QEMU. These changes make no sense
> to me here.
> 
I see your point but this was mainly added to measure the performance impact.

I ran the conformance test with different configurations in QEMU but I don't
think QEMU would be a preferred option to measure performance, especially, if we
want to account for changes we did to the hot path with a indirection. 

As ZNS drives are not available in retail stores, this patch also provides a way
for the community to reproduce the performance analysis that we did without needing
a real device.

> A change that would make sense in the context of this series is to allow
> for setting a zoned null_blk device zone size to a non power of 2 size.
This is not possible with the block layer expecting the zone sizes to be po2.
A null blk device with non po2 zone size will only work with the emulation that is
added as a part of this patch.

As I said before, once we relax the block layer requirement, then we could allow
non po2 zone sizes without a lot of changes to the null blk device.
> But this series does not actually deal with that. So do not touch this
> driver please.
> 
If you really think it doesn't belong here, then I can take it out in the next
revision.
-- 
Regards,
Pankaj

