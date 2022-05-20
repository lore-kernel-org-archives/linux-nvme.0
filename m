Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB0CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 06:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sSs33JWw+8kLpW0PdKujbpudpiU5M3x2LISKDbKZ5QA=; b=wxB85H9JpCPXy3spk5sNVJH2S3
	Ah1ZykCr4WtAzfEuERno3HV+S9woljuTmJXWxhn+E6lAxTDbAi230dGATeQLlQJzAGoUyzY+bBlUS
	nVXQSoOe8BwenEwGFcKH+GGZtkRxxR0R5N3xQ/b/vSET4KH7oE/8F/8WYDrY0FSvZlx/jkII0qSs5
	F3tMO2Sz6oX64QLP2j7xogUFlRl4wfg/7QAhziPj+pn767nDWogVp/92OnzPd22xzE+4YZRRkEozP
	CP24y/sjH0YYspKo9PAydiPDB0MFjc5AW8Hr0TJhnIlcoN0B321Ng8ECaSlW8CJRc0RljQjqoI94M
	5CF3fy2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrwKb-00Ap00-9R; Fri, 20 May 2022 06:41:49 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrwKX-00Aows-Ic
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 06:41:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653028906; x=1684564906;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ERGO0BicII1hfeSBY5CHGEqJyFEVzDz3Fun/2WvjKlQ=;
 b=D1wl3+aJJa05L3Wulljeb4q56tMKLN31TXDTmGJB2GA74S4jDmVhbhab
 5g6hwsPU93S5+wABkUpgYRJWcJuQ1NhmXyT4PB1jAbjUnwa5iEjSFJ38g
 XV1MtTQ8seSv6T/V1zlByCxP8kbhL1XFT57Iie7WezHCjcXEddmQOenQa
 cK6IiSU3pmoLaIcBi2pfGci8lHr+wIClYoimVwNhG4R6l4j/ASiU/sBZ9
 vKk21vnZCpVVZWTOvm/08FDLsJhqvvwtS2fRLJMttJrUYg1hMUU/BbgRi
 CQLA9QdlXSnX9Q8thnZ8ylDfCi0IyqbC8D1HWoFejJtkTu7kOnSEdpYRb A==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; d="scan'208";a="201736865"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 14:41:41 +0800
IronPort-SDR: UnJcREHoEsAB2uLlPrBTsrbFMhIGDCNuilsQHJ2x79gBXBSxKAt4vU2AG7Ac46S07gpPv+TQ98
 TSNftRHR2XMxHXcbO+d+daeOirx05Ux2M1DDynpjhbvlpVz7lhY6s+RRtSHPL2NRokjlrZRvBP
 Tj9sAfyGM6u5X5YCti6fc15eYiQkvs/CwACSLr+SXXHQxUAiEAqbPqlhhG0OhMKiUgBnIKwnb0
 Uft+O/DtLw5IVE+eQ/yvrxDeypXcugFaAcKwyPYkiCyzTjHfWNGvTcW/uRVVf3mZYpbP0r/Iws
 wm4pffWkKGk26dJd9rch7ZwY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2022 23:04:25 -0700
IronPort-SDR: +JUEZButna12qOWZvtq3Yc++rfsjMXzgTNH70O34wBahzSqxPA4+uKlRlIP24xHZ7CNiKZ6BfX
 t5Y1B2Pf2LKbgyADzhEsFIpwM8U8NaLmMJjH6l1sul/vK5gsZiy3F6e98mxPB/h7Soq61QqkUs
 x9QmWzQJPWuy+tkWj5G6p74ER+Bpkj7oqc/MXpEiYCT7eDPJas1avHB7coAFJTaOoHodJfEu01
 tRQNvnQ4lNRMwNbzPqBioWVKLxGXpmG+TU8CkvAb2vqqAKYpTug+AC+ewtwAef0wqWB2V26Wlq
 7I4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2022 23:41:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4HFJ2ctcz1SHwl
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 23:41:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653028899; x=1655620900; bh=ERGO0BicII1hfeSBY5CHGEqJyFEVzDz3Fun
 /2WvjKlQ=; b=WcZfmN40Q/nQ7cnBNDuPUoAgJ3ynE7bfBCKKkbIzlvfYBu41ur6
 0kL00xpfBgpyJVRy6Jl4DrfXpJT8y636ijvCj7PCnNt3gyaH2vLkae8y5Z91mg/U
 xbemCfwagpoA1c6UqhOwBhy+JV4rp7QS8cDhib8sItdjCh9LzRf5xZ0wFY5ovV2H
 eYRnf0DROLKYgcszUf8OXinleIaMRF4xKD0861/KwtoyaQYpnl02quLN14jqSFdZ
 m8opXNtKnguofY/Bq25QoRD1TXv8O8h1kJr1n+Wx9l2R37Ctlt8R4MTyzVkws3p4
 M0LiX4Eh5yQWcacWIwaHwdOK7jBZXOVlN8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id y5PSrXF38iXi for <linux-nvme@lists.infradead.org>;
 Thu, 19 May 2022 23:41:39 -0700 (PDT)
Received: from [10.225.163.45] (unknown [10.225.163.45])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4HFC1ffTz1Rvlc;
 Thu, 19 May 2022 23:41:34 -0700 (PDT)
Message-ID: <be429864-09cb-e3fb-2afe-46a3453c4d73@opensource.wdc.com>
Date: Fri, 20 May 2022 15:41:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
 <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
 <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
 <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_234145_775975_3777847C 
X-CRM114-Status: GOOD (  30.32  )
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

On 5/20/22 15:27, Javier Gonz=C3=A1lez wrote:
> On 20.05.2022 08:07, Hannes Reinecke wrote:
>> On 5/19/22 20:47, Damien Le Moal wrote:
>>> On 5/19/22 16:34, Johannes Thumshirn wrote:
>>>> On 19/05/2022 05:19, Damien Le Moal wrote:
>>>>> On 5/19/22 12:12, Luis Chamberlain wrote:
>>>>>> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>>>>>>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>>>>>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrot=
e:
>>>>>>>>> I'm a little surprised about all this activity.
>>>>>>>>>
>>>>>>>>> I though the conclusion at LSF/MM was that for Linux itself the=
re
>>>>>>>>> is very little benefit in supporting this scheme.  It will mass=
ively
>>>>>>>>> fragment the supported based of devices and applications, while=
 only
>>>>>>>>> having the benefit of supporting some Samsung legacy devices.
>>>>>>>>
>>>>>>>> FWIW,
>>>>>>>>
>>>>>>>> That wasn't my impression from that LSF/MM session, but once the
>>>>>>>> videos become available, folks can decide for themselves.
>>>>>>>
>>>>>>> There was no real discussion about zone size constraint on the zo=
ne
>>>>>>> storage BoF. Many discussions happened in the hallway track thoug=
h.
>>>>>>
>>>>>> Right so no direct clear blockers mentioned at all during the BoF.
>>>>>
>>>>> Nor any clear OK.
>>>>
>>>> So what about creating a device-mapper target, that's taking npo2 dr=
ives and
>>>> makes them po2 drives for the FS layers? It will be very similar cod=
e to
>>>> dm-linear.
>>>
>>> +1
>>>
>>> This will simplify the support for FSes, at least for the initial dro=
p (if
>>> accepted).
>>>
>>> And more importantly, this will also allow addressing any potential
>>> problem with user space breaking because of the non power of 2 zone s=
ize.
>>>
>> Seconded (or maybe thirded).
>>
>> The changes to support npo2 in the block layer are pretty simple, and=20
>> really I don't have an issue with those.
>> Then adding a device-mapper target transforming npo2 drives in po2=20
>> block devices should be pretty trivial.
>>
>> And once that is in you can start arguing with the the FS folks on=20
>> whether to implement it natively.
>>
>=20
> So you are suggesting adding support for !PO2 in the block layer and
> then a dm to present the device as a PO2 to the FS? This at least
> addresses the hole issue for raw zoned block devices, so it can be a
> first step.

Yes, and it also allows supporting these new !po2 devices without
regressions (read lack of) in the support at FS level.

>=20
> This said, it seems to me that the changes to the FS are not being a
> real issue. In fact, we are exposing some bugs while we generalize the
> zone size support.

Not arguing with that. But since we are still stabilizing btrfs ZNS
support, adding more code right now is a little painful.

>=20
> Could you point out what the challenges in btrfs are in the current
> patches, that it makes sense to add an extra dm layer?

See above. No real challenge, just needs to be done if a clear agreement
can be reached on zone size alignment constraints. As mentioned above, th=
e
btrfs changes timing is not ideal right now though.

Also please do not forget applications that may expect a power of 2 zone
size. A dm-zsp2 would be a nice solution for these. So regardless of the
FS work, that new DM target will be *very* nice to have.

>=20
> Note that for F2FS there is no blocker. Jaegeuk picked the initial
> patches, and he agreed to add native support.

And until that is done, f2fs will not work with these new !po2 devices...
Having the new dm will avoid that support fragmentation which I personall=
y
really dislike. With the new dm, we can keep support for *all* zoned bloc=
k
devices, albeit needing a different setup depending on the device. That i=
s
not nice at all but at least there is a way to make things work continuou=
sly.

--=20
Damien Le Moal
Western Digital Research

