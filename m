Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD5BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 21:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVKXrDMcXWBoLcyEd2wAmmD8cE4/lc61gvmeF3+340s=; b=IdLhYVF2vNnkiYMJLE47MP0vb9
	wSlj60H+/UdcXy51TouI+vCVtPX0qyHtkCVMlYev2zZxhQaPiD+Gph4Il/64RyysOp7Co4hJhalYx
	592sjeS3CudCjEEIkomr/o/7zAHNJeESZfMfUUWs2nDzW3KEmrHdA+JGGMnJ6DjeW0IO+j6MgtOE2
	Ns0t0eaiYxnos6t17p7NpeMcbalzLOPQtLYx2WWpQhnvpUNbovfy3os5PjeRRKXVlpphRLDQ1sbnJ
	lv9b2chokh+Dwfk53/7aSr1Pvdt0hg8udX4LU9HC926+LDBtjAtroaW8ik1oM407wRkrsiq+qLXYh
	FTxqVFqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkBpJ-008YPz-OS; Thu, 28 Apr 2022 21:37:29 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkBpG-008YP4-Dp
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 21:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651181846; x=1682717846;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ks/UYFZ4BEuJfvHdflvtNX42llFGKlgREEMC26vTdf8=;
 b=oEoQup05xlKd1b1k7cY5zbQ/gKu+BIgGevABHyc3ihxtzpZDkbug45jW
 1U7WLapOth4Pggv/JlFgfyT2u5IUUHHOS/Ng8hgWyz4LgbwLBFCkc+aZL
 vJ273e9WLJN4nhQ9NgxOgKux4t2iDxNebCz/NDo745AyXJkpXuKGQzVBd
 gzZyNiETlyW89kx1lIOaHox99U36c4UohCWKbnhc114ejiu886+0Y6d3i
 EPPSLvrs2GRnaZ6PZZvEaZk6pvQ8iBhzdvflTY20+eabjGVsDJAri5Amq
 Ge4/Wdj1Q3yeChqaCqsrmdFxZz4a9hsBJIDjWhT0Sex+UsFVbuQkUGFF6 g==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; d="scan'208";a="303310803"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 05:37:23 +0800
IronPort-SDR: /Gbxf1yc80TOysL5tyPoSitGykZ2clh9Zea3HD44FnDrh01N2xrKb1Z9uugYR/kNTzJneEk4Xl
 vb79GHTlwlxxt0jHxZm73AObVMpWH89RlWa64qHzc9otZR9/Ow5updGjQCUwUXBmvhO0s/6xYO
 6M02YqcfkSNZQ3ycYUnjLFLslVrznkShL2noX9VARgq8M1YkLLo3RoIKNZnSWcDYUx3sLhAlbZ
 xuBRY2cg7yyUVw+Pr4Hj6rWNPtuo+keO1SuweEHqC97MvGPWIWKVwvU6emVLH8SGRX9a1rRId6
 J+hSa14G++q15z55kZUpxBMC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Apr 2022 14:07:31 -0700
IronPort-SDR: 2abgA+siSuUY/VUW9FQCfRRRuM339zal8SVmjjBkkjJDjJQWhRgaerryMD9srS8lc+lLGxSedC
 7P/1sqYz9pINlweheD9vwxm6+c4pRQDiDpbCL/UVSPATTPq2YqSgvm0f6PD1AaR8zrt0I1zoay
 VWbFJAfTm9XQldmkCxJ8rin5FA/oqQsfFUOs0+/HoakuDnvVHmyWe61+1IJWAEhFSDcEVfzD//
 FkPegkqiACGHN8xHQDIfCa/1azT88RoPnSbaIv/ZYAp4DZuEmgZ0A1b2vtFta9i4QvlaZKaJ2Z
 PKc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Apr 2022 14:37:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kq88x5CL4z1SHwl
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 14:37:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651181841; x=1653773842; bh=ks/UYFZ4BEuJfvHdflvtNX42llFGKlgREEM
 C26vTdf8=; b=Pia8U2+MTp2QRDkEB4f2LrGB1ac2qZfAErgsCBWCFKjMxrXVn/Y
 bwkaAOoOvDD9yplFQBQeoOJVsSLVROSZs/aY7852UH4Hkft/gJ8l5Vevs96ehApm
 H01Pi7zw03XrBAhpZA+8aNjI4XPTSKE/B53mqI7jTUhf+kO3QzvvSihGG5g4JCrn
 J7FkLjqy1G9aN6QLiRcqwX03ov+vXozvTOfikx/Qr8m+XOlL3cwYuWTPPQFKLuuT
 dLexhqGOTQGF+oDQFcdirmTE+zKbH/a93K/4NbxqEWezpvNJTnGI1pJhScoN+3RX
 JtdhbfwQOwWUwz6SrnP4PdT/zkoQdrOf4pw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 1ufDskgGVFus for <linux-nvme@lists.infradead.org>;
 Thu, 28 Apr 2022 14:37:21 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kq88w02gHz1Rvlc;
 Thu, 28 Apr 2022 14:37:19 -0700 (PDT)
Message-ID: <a6d1c61a-14f2-36dc-5952-4d6897720c7a@opensource.wdc.com>
Date: Fri, 29 Apr 2022 06:37:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
 <20220428074926.GG9558@test-zns>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220428074926.GG9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_143726_627008_A98F01B1 
X-CRM114-Status: GOOD (  15.20  )
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

On 4/28/22 16:49, Nitesh Shetty wrote:
> On Thu, Apr 28, 2022 at 07:05:32AM +0900, Damien Le Moal wrote:
>> On 4/27/22 21:49, Nitesh Shetty wrote:
>>> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>>>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>>>> The patch series covers the points discussed in November 2021 virtu=
al call
>>>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>>>> We have covered the Initial agreed requirements in this patchset.
>>>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>>>> implementation.
>>>>>
>>>>> Overall series supports =E2=80=93
>>>>>
>>>>> 1. Driver
>>>>> - NVMe Copy command (single NS), including support in nvme-target (=
for
>>>>>     block and file backend)
>>>>
>>>> It would also be nice to have copy offload emulation in null_blk for=
 testing.
>>>>
>>>
>>> We can plan this in next phase of copy support, once this series sett=
les down.
>>
>> So how can people test your series ? Not a lot of drives out there wit=
h
>> copy support.
>>
>=20
> Yeah not many drives at present, Qemu can be used to test NVMe copy.

Upstream QEMU ? What is the command line options ? An example would be
nice. But I still think null_blk support would be easiest.


--=20
Damien Le Moal
Western Digital Research

