Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7465C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SReMDhxOS553gJDTUKq+4WqsfciBjqtx1E8/Y5+TcwE=; b=vKsksnd16Ch1813ltAh/ELRg3t
	v5CmmYZjODJlwxjHMN/HIOUAGD4NQWaCedUHLp6X+bYVfQToeD4S4NuvyntsFb+Be96JSX1vT8EJE
	p2rr9mtlkbIv0UB2sdrHZU3coIakP2giyvxVOra6gPhoLv0FXX/9KkFzMNOmoybsdXHTLb32GxZt/
	LXH2QvArE2641K0qnREsS/cDcXPxOukdOzcSp9AJmbJkZoyPMTrtvAZlTu3TMkvmRyTgW2NKnPjZ8
	ralb0ENB8bcsROLRyP5iIvZeAnfmTb9p7JOY6f/nB/nX020KSo2LcdFiZOWT2fX+bg8V9wYn+AIcY
	xqDKSWZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlUya-0015Z1-1l; Mon, 02 May 2022 12:16:28 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlUyW-0015XI-Co
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 12:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651493784; x=1683029784;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=Mmb6FF+PbRqpffm582WWKWb30Gfw5wn7OBAUJ+Olo/w=;
 b=KYXZDutPhyqc1LouAKbzCDres9KVFogZwfcl6hO9x6ldPChYYLIeig19
 ZxDX41k/n5auUwHwxfLF/CZnP0tsVHeT3UzSuvwtaZaWKEfqx1mtZABIn
 tA8/0J93JqQ9Ae1kxSlFJjG8H8WoHT43j+4WLeyfM4oWiyPs/at+WoYxD
 AGpFXog2VeMv+EOA+4XH4kvb2MMPFRAaQ4Iy+kWYHz7aIkC9cvu78Z6be
 47YCeOD75re8QpnZ9m1hsRcRuYkuon6/dCFVMlp6alzJIrmxq4mwLjhUA
 EaTMi5Opb7i78QGp2hpGdCBFgbGu+8qY2AHxMAeymWNt/XNlF0BEkmn3Q Q==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; d="scan'208";a="200215692"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 20:16:23 +0800
IronPort-SDR: kcHQmVk/InUSmV1GPNDcj0h1B3788gebrMWyX1jQ9FOsSYVAeL6WQmSBEnploPEV3cfkSBntzB
 IfLEkuHENAES5qvU6eFGgIXr7elwWV7towaeBLJ6ZSJx6sJr8TvgUMZ38OCqoT2k+7DBFznXoL
 XalbqCJB53HqDJoxjMoOPSQc6k50hUd8gk0HBet5+LJJLsQ/+Gtc1HfHZ/2FQHoeZPtrMT1Hf2
 V+Rci8A7TmefdpL7kUsMVL4dxKkMb5u/SPESF99kT4VOAgnfz/un8sjwW3UytPJg8WA8bdg3cO
 L76Kcs/xytAQFm9u3nUfWWvU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 May 2022 04:46:26 -0700
IronPort-SDR: +sX/68OgLohDgfs/DPitZZqZpEzLrYIBd4oFwbklASkrBLNGkqRh2CrO5gWXt2TbAOReU4mSIL
 I7bjcmeJgot/dqk8F95Vqqv66fNLx6lzMuRg+pIwF5Q5oeZ9cGPp+27xBiCS9lTuLmyH/5MfKF
 lGHF9ciYslmZARGtbrTW693gK44v0Zq+mPCgcG9TOzp0quqe1/70Woq16BDy5zcYrtH2kdQZFC
 R6FQb7Hs5K/OYiNVzTbaGxxVaoz2jv0t7h2pw7EVuLQ51hbH9hIqi4Ekvs0U+c5iM+0/Y74y/l
 3aQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 May 2022 05:16:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KsMWp2tqJz1SVp0
 for <linux-nvme@lists.infradead.org>; Mon,  2 May 2022 05:16:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:references:to:from:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651493781; x=1654085782; bh=Mmb6FF+PbRqpffm582WWKWb30Gfw5wn7OBA
 UJ+Olo/w=; b=ir7xhRFBi2/RFJ2rJ+hllCYGYFtpqylm1j10dApznRoPZPQ28hl
 bFxjt2sR2vMty9t3G8wk1ut6OemckQ8U6VMIRq2VtOg2zfhifar1rB3x3pahn9u5
 zKexf+Sa6EI9PM/Q/jNnMWJTbKRs8jVb7l2ABZ45qOS6mFJxUp7ra6bl/WVe8u7h
 8z2yJwAfAoRPRdFULR6BmBI62hIlyIst9jFWTuwVQIYuqcb7gMG2xTRk/ZRHa/gS
 CkxghkjsBn+XD0zoVQxS52pTzTTXLffRpGReZo/arHkuA29TTc9sn2cO1zNb3Bgk
 PGASNSJNbtoqjhKwhhdSRGm0N7v7RpbLNJw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id E5b2RmtWGlf0 for <linux-nvme@lists.infradead.org>;
 Mon,  2 May 2022 05:16:21 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KsMWn2C5Wz1Rvlc;
 Mon,  2 May 2022 05:16:21 -0700 (PDT)
Message-ID: <84da2486-7a20-f3c7-43e9-60a29c7429fc@opensource.wdc.com>
Date: Mon, 2 May 2022 21:16:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [dm-devel] [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-fsdevel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <260b95e8-74bf-9460-cf0d-7e3df1b1a3c7@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <260b95e8-74bf-9460-cf0d-7e3df1b1a3c7@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220502_051624_586359_3B150EB1 
X-CRM114-Status: GOOD (  16.51  )
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

On 2022/05/02 21:14, Damien Le Moal wrote:
> On 2022/04/27 21:49, Nitesh Shetty wrote:
>> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>>> The patch series covers the points discussed in November 2021 virtua=
l call
>>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>>> We have covered the Initial agreed requirements in this patchset.
>>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>>> implementation.
>>>>
>>>> Overall series supports =E2=80=93
>>>>
>>>> 1. Driver
>>>> - NVMe Copy command (single NS), including support in nvme-target (f=
or
>>>>     block and file backend)
>>>
>>> It would also be nice to have copy offload emulation in null_blk for =
testing.
>>>
>>
>> We can plan this in next phase of copy support, once this series settl=
es down.
>=20
> Why ? How do you expect people to test simply without null_blk ? Sutre,=
 you said
> QEMU can be used. But if copy offload is not upstream for QEMU either, =
there is
> no easy way to test.
>=20
> Adding that support to null_blk would not be hard at all.

Sorry. Replied again to an email I already replied to. vger keep sending =
me
multiple copies of the same emails...

--=20
Damien Le Moal
Western Digital Research

