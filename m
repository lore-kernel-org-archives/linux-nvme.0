Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818C8C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 00:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9RKOUucqaL7v/JeBSyrYSaVxgMAgA93pbXDTioPk9lk=; b=qr5Y8ZQEq2scP6t2Gxy3qIuknW
	ejyzDhop6bkRcVVguBMujVLfTHpzDJVGtrAWAwBsd4BAtHFYlIl1jxTxVqEiZEYXsiXExQGYOaueC
	aFHK6Wu00MuQ5+tfFMcAxEGqXLXGV1CDwoY+/Xx/wW/Bl7yd+zBVYtzQVYgf7IMQpWV2ojvpTfqGm
	ZZpeTPe+e6sHLP6pTdA6S2VzFeoQESHfQfcLdi9TFVBLyNvyWSyhNrYQyzempfwNwGhCN6vjsH4dP
	FNusyfnH0yc1wjNqMTNBW85cXvCocyctHVOEueTDf4UxLfoDMyVQW1ivMcpnOCMcGgOPtjvbz3T9A
	yXq3btFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSTKu-00EQg1-9y; Fri, 11 Mar 2022 00:40:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSTKr-00EQdj-Aa
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 00:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1646959250; x=1678495250;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uXLuAp2wrVE9Lf4/vMHVGw+C8AKUb+KXzoUZDDQvp9Y=;
 b=Y029vCWQVe3KONuv1d4tCsyD0fDePxueMfcZkG2ucCWE9yg38hswAujk
 83CtDJvpGla60YSOlGRK6vLqlXDZxiWsPtMrlBGCIjnMSMwPe62lBxUv8
 a7HBq9NgMOfBpwKr1/u9jVeLERmOEmXLmhUgpzAiQuMzyxGibHwca9qOg
 NjRc2ZZGJYXRyyupwTHEdl9zuYACmNkHi5EtoRgUjh+c4kjheLjPVyPHH
 eZcg69DIwVzBvdZa2mupw73kj2h8tIEszUK1f5UZDl2PFPUcCVq7AxSWM
 w5QSm4p1ebCkejpwNS0oQJvzSxtWod1BxOLREpHnFxoA7MmY7g7wlAzzX A==;
X-IronPort-AV: E=Sophos;i="5.90,172,1643644800"; d="scan'208";a="195960661"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 07:50:53 +0800
IronPort-SDR: 5RC4OronkV8pr+HuxjL2mF7IK/6iJJJvhGWvlqCX4PN4jiVS2WjtMJQVzo5oeTr+6aCK4XpJzc
 7nr0yFTkWt8PT5kQCmJmfmdXT2LbM6bODMjB/QnNefuAkSkfHu18KtsM5pymwocRHlzdwcznO4
 eKGWeMyndNwiPQAyACEhnFnuJkO5bnbNDKS5xmkagL3Ilv6p0r3aTmPyYXarbbCHq4may1gSp0
 P9IN4zks+1HJNwF/I7IXqqPjHYuWSNCI0jLKhjKqQBU3yhcv1EyCXMbr9snb8DrzKZZrtq3oba
 R1l5vV8qVjNKAh2SuomVandL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 15:22:06 -0800
IronPort-SDR: K4sz13ypKk6qelbMPN/1D2MQI3kEk2lKN4uTyP18QvFv+9Z107uGpHIo91X3xiq5/f68Lro65+
 KmORzAX7FGW+Qo+BXUv6w7JGFOXRCvzb5NYctRa1g1fXn2mQJ+UUEUJBDoKVNd/ho7wF0G6JXC
 lJNlOsU3Zu5KW0LB+KVt0AfstZH+bQbgmR1yCMdkdN4i1jRREv4eVsRAYQbSfiLy1j6J2U43mL
 NE4lB9mLqRiUwQfF9qytxXgPna3qYTJhqZVfONVlstGWVImIl4YkDInUyUWX/CbuvOP9MQjo2S
 dx0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 15:50:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KF5Rc2wpfz1SVp6
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 15:50:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1646956251; x=1649548252; bh=uXLuAp2wrVE9Lf4/vMHVGw+C8AKUb+KXzoU
 ZDDQvp9Y=; b=eqtCZ6tkJ8fcbwnzadn5uybmJsHM4y7hARxil5ISVFq760B/QH4
 QitR8k04rjBAlk2asCKyCHcgTFJf8IF2UffpJmbNTKTLejQP2mC8gVb/Gie5WzzW
 1M6W2R5x1/nlu34eI3Zo2f+dn9/DpUskL41lyywnBTRQAwkqopSbHsRVIP5FAVTQ
 Tfh9A9AsKx3JwtpcZWod/TfWROw4oSPoKjufJlmj/rQ1vNd3jz/BRpNnJtEHl00W
 6fN6s3fG+C9ozYdOq+YM7ECe/3JFleHTgeSa6LyCQDjUdBeE4z4iB+Kk7gof8Iut
 3R3B1jFeXSKp9uYtR/NCFZMprXIeF4+Om5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Ss0JzIESxAoM for <linux-nvme@lists.infradead.org>;
 Thu, 10 Mar 2022 15:50:51 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KF5RX6Bjrz1Rvlx;
 Thu, 10 Mar 2022 15:50:48 -0800 (PST)
Message-ID: <b95a7400-8338-a696-5742-fcb8fc2693b0@opensource.wdc.com>
Date: Fri, 11 Mar 2022 08:50:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to
 NVMe ZNS devices
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <matias.bjorling@wdc.com>, jiangbo.365@bytedance.com,
 Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
 <20220308165349.231320-5-p.raghav@samsung.com>
 <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
 <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
 <bdb92eac-59ef-3ba1-16cb-31219e3a264b@opensource.wdc.com>
 <YiphB2Me63kD7T5t@bombadil.infradead.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YiphB2Me63kD7T5t@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_164049_458096_98C61BF4 
X-CRM114-Status: GOOD (  24.31  )
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

On 3/11/22 05:35, Luis Chamberlain wrote:
> On Thu, Mar 10, 2022 at 06:43:47AM +0900, Damien Le Moal wrote:
>> On 3/9/22 23:33, Pankaj Raghav wrote:
>>> On 2022-03-09 05:04, Damien Le Moal wrote:
>>>> So for a power of 2 zone sized device, you are forcing an indirect call,
>>>> always. Not acceptable. What is the point of that po2_zone_emu boolean
>>>> you added to the queue ?
>>> This is a good point and we had a discussion about this internally.
>>> Initially I had something like this:
>>> if (!blk_queue_is_po2_zone_emu(disk))
>>> 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
>>> else
>>> 	return __nvme_sect_to_lba_po2(ns, sec);
>>
>> No need for the else.
> 
> If true then great.

If true ? The else is clearly not needed here. One less line of code.

> 
>>> But @Luis indicated that it was better to set an op which comes at a cost of indirection
>>> instead of having a runtime check with a if/else in the **hot path**. The code also looks
>>> more clear with having an op.
>>
>> The indirect call using a function pointer makes the code obscure. And
>> the cost of that call is far greater and always present compared to the
>> CPU branch prediction which will luckily avoid most of the time taking
>> the wrong branch of an if.
> 
> The goal was to ensure no performance impact, and given a hot path
> was involved and we simply cannot microbench append as there is no
> way / API to do that, we can't be sure. But if you are certain that
> there is no perf impact, it would be wonderful to live without it.

Use zonefs. It uses zone append.

> 
> Thanks for the suggestion and push!
> 
>   Luis


-- 
Damien Le Moal
Western Digital Research

