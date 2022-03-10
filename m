Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14C7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 23:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lJFMeUYIbBCT/htBHkRk6rojz++heD2gJHWX7EB4Fu8=; b=RdTyagKxnM+3XTrJzlBfU34OZr
	m72enrgMQXrC9fWUoIoYKXA8V5CerXrsaAXePox7F/u33NogqT3kqqlQ3UEFFzR024BlkBfsriLcJ
	HIAnThatMMdfMmGoJyHpPs4JWXfAD+Q59+AqaYeaCMRzDowOa3VVQyjhhQDj5yYzNdviq1befUDOZ
	M3zY4APtxkuBojGMjr0g/GpY++kXz5tA2ZvApIHreoGqNsP97P3I8At8YgeM4QL0LBrrHVG5PxSk0
	+7dicQHsgRVP/PcHk0AqGgDsRO49wIrKL3dgM7O3vV68ruFniYNpHyDgFDnCvgObiGtj6yDbD27t8
	HmqJG5Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSSVl-00ELmt-LX; Thu, 10 Mar 2022 23:48:01 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSSVi-00ELmM-8P
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 23:47:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1646956076; x=1678492076;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=N2kQeAyoMoxkHPLdFc15XbRSGH7Gf7dXx1eFHNmcejE=;
 b=LMdNnzQoeg+Lq3oLlymFjxJKXF0Eq0nacMYqxI9z7xN6DXbdV55GiInx
 P10hGdYrYj7jWP+vMGvCeYc+NPdQFj/89rgB+QASmgPMtMOIdSbxCUtzi
 7uEhu9lN9iuwsNLsmqXvMnSqnWMs9yBBAhpDfZdSFS1EC2oaycNzbUT62
 Q4hFSEp2kpoinD3dkX+U8SMI+jFu6BYxepl8VVpPE+sTZiAhFMK5zdbw5
 LSAEof30sVhb2CtoC7JkAnl9ck6+yyiIDs6r0xR6UVuiLMkf5BFXbEwke
 huB+6XvnsR2tymDGujAIXp86ZbOa9p9bIbdsk5809QprlxMhobRJ7if9N A==;
X-IronPort-AV: E=Sophos;i="5.90,172,1643644800"; d="scan'208";a="195014660"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 07:44:38 +0800
IronPort-SDR: d2uyAG8f7aoQrrkdUh3AK/jDgLKSsbvqjZRppwv4wx1yohGibg/7dyNUmyQdfSlpMNrqqOwZUR
 lDdHK6nBeXzOtgPGx6Pylxi2ju5hqsxM0EYSzrBqtYYpetqQHGqclK4Q/hrBmTQiczAgrIcV7A
 VktIoqcOuHQEIa1VfINkjLr2YnfRe1blGLby3F0ZqP526M4guuHwPb/40zkVFfxlum3OuySob/
 7v21tpBOEW/tXJ9ByJmGK4BcL0M78dyALC2Om+U7c3v4qVjLYFEXQ5OomCZaaqgOfNqwJ3esTW
 dZz51at4nm/3rDuEtrkhqaUQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 15:15:52 -0800
IronPort-SDR: Q2HupE8/IbQddmi4xTNB0SM8KK9KtxWegAisegT/vH3R9cwsvWk7oWyDi8rjf2LXrmikva6ulY
 qgwXRypuS1rul0QPvPfJfvyRQfd8S8hQXlOJqnDyJZ992Gnqda+8uju6OYoh/i9wZ/bd0JFanQ
 MaNirZLWwvqzYddFaPG6hSOLLAB48WJSRRxbgUYQymtK5yoNxZCojntpe45c2rHGaaa+gdO/OO
 8Q2JYZr1n6iH8aQXiWN+fbPyRgFjbEMFEzhEknBsHMtce+hi68k8am6SZ9dUtr2CpmItDcL1fn
 E1M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 15:44:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KF5JQ6yw6z1SVp9
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 15:44:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1646955878; x=1649547879; bh=N2kQeAyoMoxkHPLdFc15XbRSGH7Gf7dXx1e
 FHNmcejE=; b=qjHXq3x8b0H2zGEjGF/RmhPhMugvxHtoADVqVl3vuTVNhIrDeMw
 IrRgV8X9BM7Rdu0Pa2ekkvQJdO4BRKbXZgTT10KUU3IxWhotBqYgTpb2n9Kd7rik
 T1tRl2m005gak15TRWWPlLOZCHA9itnSRoOtE29KFrSv/9aiE9itcoHfePUwkpuA
 VVmUSv2cgAw0LrmT7X9ZDcyfnh0OTkgNvWKB9AaMlLT6YEHcngjWZvzsExJEklK5
 abTFjo6wc2Kqc8eHACs7Ix3MuVRncM7IPPlQwzbDUpAruApn0JWLPwadjku8Wh7A
 fDrkuiUNLFtrNstmKFa2G4XUKzhwnXgu4uw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id xLbsls5_Y_Ym for <linux-nvme@lists.infradead.org>;
 Thu, 10 Mar 2022 15:44:38 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KF5JM0jbgz1Rvlx;
 Thu, 10 Mar 2022 15:44:34 -0800 (PST)
Message-ID: <ddf396a7-0a4b-9949-4067-a19f8787b480@opensource.wdc.com>
Date: Fri, 11 Mar 2022 08:44:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 Keith Busch <kbusch@kernel.org>
Cc: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
 Pankaj Raghav <p.raghav@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
 <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220310150730.GA329710@dhcp-10-100-145-180.wdc.com>
 <20220310151628.awfihyvsjc7hawnz@ArmHalley.local>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220310151628.awfihyvsjc7hawnz@ArmHalley.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_154758_317503_F708E263 
X-CRM114-Status: GOOD (  23.35  )
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

On 3/11/22 00:16, Javier Gonz=C3=A1lez wrote:
> On 10.03.2022 07:07, Keith Busch wrote:
>> On Thu, Mar 10, 2022 at 02:58:07PM +0000, Matias Bj=C3=B8rling wrote:
>>>  >> Yes, these drives are intended for Linux users that would use the
>>>>>> zoned block device. Append is supported but holes in the LBA space
>>>>>> (due to diff in zone cap and zone size) is still a problem for the=
se users.
>>>>>
>>>>> With respect to the specific users, what does it break specifically=
? What are
>>>> key features are they missing when there's holes?
>>>>
>>>> What we hear is that it breaks existing mapping in applications, whe=
re the
>>>> address space is seen as contiguous; with holes it needs to account =
for the
>>>> unmapped space. This affects performance and and CPU due to unnecess=
ary
>>>> splits. This is for both reads and writes.
>>>>
>>>> For more details, I guess they will have to jump in and share the pa=
rts that
>>>> they consider is proper to share in the mailing list.
>>>>
>>>> I guess we will have more conversations around this as we push the b=
lock
>>>> layer changes after this series.
>>>
>>> Ok, so I hear that one issue is I/O splits - If I assume that reads
>>> are sequential, zone cap/size between 100MiB and 1GiB, then my gut
>>> feeling would tell me its less CPU intensive to split every 100MiB to
>>> 1GiB of reads, than it would be to not have power of 2 zones due to
>>> the extra per io calculations.
>>
>> Don't you need to split anyway when spanning two zones to avoid the zo=
ne
>> boundary error?
>=20
> If you have size =3D capacity then you can do a cross-zone read. This i=
s
> only a problem when we have gaps.
>=20
>> Maybe this is a silly idea, but it would be a trivial device-mapper
>> to remap the gaps out of the lba range.
>=20
> One thing we have considered is that as we remove the PO2 constraint
> from the block layer is that devices exposing PO2 zone sizes are able t=
o
> do the emulation the other way around to support things like this.
>=20
> A device mapper is also a fine place to put this, but it seems like a
> very simple task. Is it worth all the boilerplate code for the device
> mapper only for this?

Boiler plate ? DM already support zoned devices. Writing a "dm-unhole"
target would be extremely simple as it would essentially be a variation
of dm-linear. There should be no DM core changes needed.

--=20
Damien Le Moal
Western Digital Research

