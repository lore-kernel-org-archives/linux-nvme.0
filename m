Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDAEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 01:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9R92iLzDRpZs2de/6adyht+HTTmZ/xSQxBDMi4pdoMQ=; b=GWzCZvInikxbo6m/9SWraiEpit
	jhDIleYJ+ZJ+MpBWjJGD8bmUvj3nDy19xOflYtkz4ACjlnCMM9fKmDHAo9mlZ4mPC8PhHBQ8+H5ES
	XyE+cBhdK0RnYuP3pBpeL9uvHD2Q4dvA/iM0DbOjim59PeuTB017Hu71gpyaQqrU939bt7LlhJ6mJ
	Zz6g/8oKototr5Im8aMOj1XyMQmMe7t5XtC0dK4Ulj8oJEKpsW6nVLIBAZZWCTMKhkA93BhPAxdGs
	/Ohuksf/+KdD7UCowhxULAp1c5SnaiSBQy4meMxRqwP44Wp3RyrhFgvC1Q0dRMdXD8fGHCEblSnqy
	T6fGl8Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntffA-009ZyK-Ip; Wed, 25 May 2022 01:18:12 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntff6-009Zxe-Om
 for linux-nvme@lists.infradead.org; Wed, 25 May 2022 01:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653441488; x=1684977488;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SotFiXAT6gZtGz5cJ9d7N+HBiN2KWbHN93uEjW2mOjo=;
 b=lnvnUwjbImxauAlakWieVUIwqpbILETLfn5uuE4xTwuG5ACT6peVVV1R
 rHWH3k0ykWZ9aaOBB04TYYrIstYWkIFjp5irPip4nHTRyE3q9h4k/k9oV
 9lC1DMYnBQrDOJwx4CHx/SyeTdE+w3rOxlIde7Jc8nS8TG4rn8dbgK9FW
 jUMSl0QqXPZ2Os0ntMZAO7sDuzEmSGnFCu2x77xqCRQGaPgtXmk/am1WA
 3NQhz8Oa+mWJ59FtkWNT9rFxbfgBDpTI2QRXsNW6P/EyYRFNB9MPoJ05j
 Fxj79B2fmTJO76oisJdSme/InnXhTZ4UEa02YcPUFpruAziE3KjMVqVmp g==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; d="scan'208";a="206213772"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 May 2022 09:18:05 +0800
IronPort-SDR: T7iKXVwUaTqzsJHy1v/GsymBzJC3FM4fyLIGLY6s6fg5Zd5iA4oj6k0LIjQ6jlHQD/ZP1R31wP
 340+C23bUp+RbZzBOJ6ekGhdE9ama9kIDBVkNFhsJEsN5i/4yvCYdfJy/rSfSCUCvmJCDJ1Bh0
 PucDC6y0FJcwF6Pu6ZVdklb6hfPiRZqRWbkuUX7Ta/VzJBGpgcsim4O3kgWne3cR1SlkitADjA
 uIUQSDunXAStyev654MHYWwjwB3SWAElRdUb2WxyYwEgRoI0+0uqQJKPWxNTZtueolIa4V7lRc
 FrmfCZIrIstytP2qDp9DUi5q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 May 2022 17:37:37 -0700
IronPort-SDR: WpUdguuuaAiX1iG3iR+pDEBnQgdpxgPF7cHWx2V2sRZwgpLhYpHsLIYxvuJja01vnq2CHh0Uim
 1O1lL/Bl95t21AbzrP8mitHVamMvwblwIffhk2Zk0Ay8beiSy0O8FmNF9wKfCKkieg3oORsKWh
 crtUa23J4Px8jT9vdvFrKoTztzufb2tPl0yJf/Twt18vQLUgcf6rYYd3RYi4mw2eCnlcWamQ83
 WZNj3paSPGSU/L6mfK85zP+wQyCCnGWIREyPdKwpf95Z+4aJ7j07mTO8guswN4q6AZQq/PLFkM
 OAg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 May 2022 18:18:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7Cqd21YPz1SHwl
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 18:18:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653441484; x=1656033485; bh=SotFiXAT6gZtGz5cJ9d7N+HBiN2KWbHN93u
 EjW2mOjo=; b=mIbRHI/qtbqYz3CiW+sWbevgSqiBiKOU//qGs2Dxr1ZQes9GaHc
 3/rNhjmFlhQKxJf0P6r6DHj237xKqYrXkPPDiYcZjkAoVhwZDWGjJdy6HYOE+Uj0
 HH8FCAp/QL1sOXuthN45Ho6sdJRCHacgQEibkPjCtOgJxGJkY58kteOo0mMcGxMg
 qPqOnMIvGdx2fw/H1iK9W7JObsJ4xtLBFw4BZLN1ztFG5EW1V9Vq9/9HYTT+RcKq
 TFCEgvQmKZHfGefUoZ53Fp8695tRa30FjSo+vLSspXDpzbsrM13s+beVfhDho7PR
 2IrPcs638lDTX8ZJjvBkBqZ98U8++f7J3Mg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id G4BmLgpK__Ea for <linux-nvme@lists.infradead.org>;
 Tue, 24 May 2022 18:18:04 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7Cqb6tDHz1Rvlc;
 Tue, 24 May 2022 18:18:03 -0700 (PDT)
Message-ID: <67126351-b143-609d-7f26-f0596250a2fd@opensource.wdc.com>
Date: Wed, 25 May 2022 10:18:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: nvme: split bios issued in reverse order
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
 <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
 <Yo0xE5g3bowmF3H0@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0cpUNdb3mu+9pHG2oDfBmgmmCMQAo13axqO=jL5fwr_QJA@mail.gmail.com>
 <Yo1AOXKXkmrnnvou@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0coj1vAKRgf5BHAvjWeNgwj0JXyfDm6kFN48ZMpfdoHA7g@mail.gmail.com>
 <4c78726a-5c37-f1f6-014d-259bb9bdf252@opensource.wdc.com>
 <CAHex0cre2RAqVH1BFHgb2KWCr-YfZWmrZwtv8w9qpU5Cd9iejw@mail.gmail.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHex0cre2RAqVH1BFHgb2KWCr-YfZWmrZwtv8w9qpU5Cd9iejw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_181808_937425_F4CF4E1E 
X-CRM114-Status: GOOD (  22.46  )
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

On 5/25/22 07:01, Jonathan Nicklin wrote:
> With the drive exercised as follows:
> 
> app: fio
> engine: libaio
> queue depth: 1
> block size: 128K
> device max_sectors_kb: 32K
> 
> A 128K user IO is split into four 32K I/Os which are then issued in
> reverse order as follows:
> 
>              fio-12103   [001] ..... 89587.120514: nvme_setup_cmd:
> nvme1: disk=nvme1c1n1, qid=2, cmdid=12328, nsid=1, flags=0x0,
> meta=0x0, cmd=(nvme_cmd_write slba=192, len=63, ctrl=0x0, dsmgmt=0,
> reftag=0)
>              fio-12103   [001] ..... 89587.120515: nvme_setup_cmd:
> nvme1: disk=nvme1c1n1, qid=2, cmdid=12327, nsid=1, flags=0x0,
> meta=0x0, cmd=(nvme_cmd_write slba=128, len=63, ctrl=0x0, dsmgmt=0,
> reftag=0)
>              fio-12103   [001] ..... 89587.120518: nvme_setup_cmd:
> nvme1: disk=nvme1c1n1, qid=2, cmdid=12326, nsid=1, flags=0x0,
> meta=0x0, cmd=(nvme_cmd_write slba=64, len=63, ctrl=0x0, dsmgmt=0,
> reftag=0)
>              fio-12103   [001] ..... 89587.120518: nvme_setup_cmd:
> nvme1: disk=nvme1c1n1, qid=2, cmdid=12325, nsid=1, flags=0x0,
> meta=0x0, cmd=(nvme_cmd_write slba=0, len=63, ctrl=0x0, dsmgmt=0,
> reftag=0)

Yep, expected. This is the same as doing libaio with iodepth=4 and bs=32K.
Your max_sectors_kb is really very small though. Can't you increase its
value ? (max_hw_sector_kb tells you the device max but other limitations
may apply, e.g. prp vs sgl)

> 
> On Tue, May 24, 2022 at 5:44 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 5/25/22 05:32, Jonathan Nicklin wrote:
>>> On Tue, May 24, 2022 at 4:29 PM Keith Busch <kbusch@kernel.org> wrote:
>>>>
>>>> On Tue, May 24, 2022 at 03:37:56PM -0400, Jonathan Nicklin wrote:
>>>>> On Tue, May 24, 2022 at 3:25 PM Keith Busch <kbusch@kernel.org> wrote:
>>>>>>
>>>>>> On Tue, May 24, 2022 at 12:12:29PM -0400, Jonathan Nicklin wrote:
>>>>>>>
>>>>>>> The command lines you have are for read operations. The behavior seems
>>>>>>> only to appear with writes.
>>>>>>
>>>>>> Huh, I'll be darn...
>>>>>>
>>>>>> I think it's because the writes are plugged and the reads are not. The plug
>>>>>> appends requests to the head of the plug list, and unplugging will dispatch the
>>>>>> requests in the reverse order.
>>>>>
>>>>> Thanks for confirming! That's about where I got to. Do you have any
>>>>> ideas on what might explain the difference in behavior between
>>>>> fio/pvsync and fio/libaio? And, why does this not seem to occur when
>>>>> only one nvme queue is present? Perhaps the in-order cases are an
>>>>> indication of not being plugged?
>>>>
>>>> I actually didn't see a difference between libaio or psync, and also io_uring.
>>>> They all plugged and reversed the dispatch order. Do you have a scheduler
>>>> enabled?
>>>
>>> Nope, there's no scheduler in the way.
>>
>> If the drive is exercised at QD=1, e.g. psync() and libaio with iodepth=1,
>> then plugging does not matter as there will be no merge (so no at-head
>> insertion in the plug). Commands will be executed in the user submission
>> order. At higher qd, if merge happen while plugged, then order will be
>> reversed (libaio with iodepth > 1 only).
>>
>>>
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research

