Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0B7C02193
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YFnj24VvreG7lG3Pu3vMo/s91BwtpspZy+voBLJyXRE=; b=WxD60CZYWcwr0FUIfApViqe64v
	jfqbGWtIbqZ9eimFmdMpHzZOb7fW88yuyb90W80qz7gTtb58lFfjTeukuZHA14maModxBUcp3goGz
	ugWo7BHdmQSqigIPLacg1bO7JtCRklPt8oBj2AM8ZqiC9o7NX2/iwtGgOmgHt5s7uc0i+qzl4AiPm
	Xbr0oZAY2hbj6jv4PU8xYyMNKpwDY4vqQfq+ROCFaRiAzDVIhFLZiH3HyH3zIFvyYy/lmcY86LQ4s
	Qhhf+18fB43xY+KoxhbZkHbqG1H0vR1UnN6XwFWKsQmwyOydJx9OgnUNHrxSIEXnSYzQtLokSR0I1
	0L1sRHvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1gN-0000000GMxr-36I0;
	Mon, 03 Feb 2025 19:00:31 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1VB-0000000GKK1-2IVw
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 18:48:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1738608493; x=1739213293; i=linux-kernel@simg.de;
	bh=YFnj24VvreG7lG3Pu3vMo/s91BwtpspZy+voBLJyXRE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=yiR3wKc6N+LWPS067T1xEU+aA9y6KP4KMhzLXslFRPH5jN6atOAmeUyGOgDt1upX
	 DFQ6lPL12Tqm8w/ieZPfdA4Mr2jaIs9TubQ473itbQKpz/EDdEjauO+Cp0NfAOnEV
	 rOr/mf/M+4LQL6VAJvL4D4nnvce8HLDS7/Kw7ybPL7TrFfkmW5ffeT45Iw0RYDOR1
	 7Fj+B8NAg4UjJMRVwHvwJPOL5o6Ddlqlo3/0H9uPQfUElW6zi2j/v4oby8T0pPDnh
	 7pf008CFkuGUCcSImsUOtwYuZ4V4GZYcup4dvVcCVD0a+Cm/xiIKEwhC7idDPrsjE
	 fViNGSeWiFU1q+0Sbw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([87.158.47.249]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLi4W-1twgrk40Dw-00J9ey; Mon, 03 Feb 2025 19:48:13 +0100
Message-ID: <4270c0e3-161e-42d5-a6d3-f16b7fbcdc00@simg.de>
Date: Mon, 3 Feb 2025 19:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
From: Stefan <linux-kernel@simg.de>
To: "Dr. David Alan Gilbert" <linux@treblig.org>, bugzilla-daemon@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Thorsten Leemhuis <linux@leemhuis.info>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bruno Gravato <bgravato@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
 <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de>
 <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de> <Z5jTKTfKUeLm4uJT@gallifrey>
 <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
Content-Language: en-US
In-Reply-To: <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f9RM+83asFATTdzAoEoXNJJMSOExToxSRQTNr1E6qWGNJeaLQyF
 S57KAWJOB+/4BcEw0KqA8LEijhiaROxGbBCO9oNzEdB+I5IZMFZjuAyPDC0tKYdxmsazgxp
 ysc7W1hd9y19As35jwU7UbrBmNWD/rCMXhFwW/te2drR5fFK78p63usD/fHv29p60YV9224
 FwJ7Qv93NOltqeL7F9e6A==
UI-OutboundReport: notjunk:1;M01:P0:2xs3pvJSyk4=;JuSnkWSq5ZJcSuUA2ef0ZXq5+QD
 VPYJJN6027rReFn8B88BuG1vvhSS2i+1Q590jL+YMsbv7HIs30TjWnI1UrkeEgIPXei7gzJSa
 ORpYgs/q6c9PXLtzgVfLKBkXV6m9HlJGxWwj6TX0zkKeDURd/wStDyWdbDAwykSd87amuYb34
 /oQDSM17OH+9UTQv8Ms1neV/XX0sGioTuE8PDdPK4Dieeq91lQ/feXYiJ3J4CYHWARBL1qhZn
 TkfTsks7/lpSlxOMEgYUWs61eBNFiBHP0BhO2e7jqKT5s37EN8iLKMtDLzGAStFWOKdIpHQgS
 k2TBu7gqeQg5F9Eam+GfAegQmCxOVjJu3j+eyKLDjUp0rFPtbOBGN+Y/upciBTODiC1WrPEAv
 qw+SkljIZHPZvO7K0yk/M7g/QVtvuRwgbJ1Prqmyy7f58y4UFrR9tXXERjszjj+f9ENN9Aj/C
 SjOcYyXWil7G0B75UoP0yfe6DUdAoDsV82Zn4VvgLNdU5GKXXwXBjXmgHSmUhO2n25lFt56P0
 u7eL+V7IVCV5ti4fzx/l55ObG5lznIx3Ha+5unIGJZYsK9BKWqx6Kd+vJtM7wX9uRUak9DGqG
 cmGPxo2yPn20bSUb/rBIjo5J/FHzm8zmrguObQ75kIDZTKJ+B1HVnuXQi8ABqoQ5bCYF6wTyE
 hDTaMpQKV5ACXYbwugpE1Bru1j87KCqsg7rkMv1jrJvTDHwkSOmJd8iUHy2jDp99apx5/JshS
 YKQ/EDUJxIBregjnsTm62ZFrqtEc5xLeTvs6Xpjvz/W1iZJ80ylymKNeXzwwCByhE2ZCxNdQU
 THznIZPBG6in2X3qNwkvDuK9f0Kaff/AmroN0YpDbRBlFTHfEplHJQdvHoymJ5PtjIt5xVCG3
 iluRtHgEwPGXjIrmLMG9iwC0Jp+HBWF6Hw0mS4GpDbnLSi11eqAVAt22p7aQsj07o7XvEg8NN
 Ja+OZsugjjk+X+L9gyixyMgoyL5W8KR1bYsvPZxEw4rk67gzgn7xeDEMOx7QOJvkS78gggD+Y
 azdgNNG8q+zB7TlVYpce8orMjIc7ljh/Rt38fV5b6Jnveh0fKD4z+um5KLudCb8mkr/ue1UxE
 08nLbAlUgxFlJJyEqlg8HwMeVeYVNWnesqUJ6eRLumNd0633xJk6K67vNHtQbISYfLNyByt7w
 bXYc80U+6zrwnpQWgAjU7TToOuD90Uq5m3/P7HFqK8SMaAKF26255VoCAPBukSRZkAg3YNZKt
 BL5HyeAW1qZy4JMcTOrrl3nGu5dEaaoodslX3koylONNCHGnA+Cw8m0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_104857_881973_0738E2B1 
X-CRM114-Status: GOOD (  18.39  )
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

Hi,

just got feedback from ASRock. They asked me to make a video from the
corruptions occurring on my remotely (and headless) running system.
Maybe I should make video of printing out the logs that can be found an
the Linux and Debian bug trackers ...

Seems that ASRock is unwilling to solve the problem.

Regards Stefan


Am 28.01.25 um 15:24 schrieb Stefan:
> Hi,
>
> Am 28.01.25 um 13:52 schrieb Dr. David Alan Gilbert:
>> Is there any characterisation of the corrupted data; last time I
>> looked at the bz there wasn't.
>
> Yes, there is. (And I already reported it at least on the Debian bug
> tracker, see links in the initial message.)
>
> f3 reports overwritten sectors, i.e. it looks like the pseudo-random
> test pattern is written to wrong position. These corruptions occur in
> clusters whose size is an integer multiple of 2^17 bytes in most cases
> (about 80%) and 2^15 in all cases.
>
> The frequency of these corruptions is roughly 1 cluster per 50 GB writte=
n.
>
> Can others confirm this or do they observe a different characteristic?
>
> Regards Stefan
>
>
>> I mean, is it reliably any of:
>> =C2=A0=C2=A0=C2=A0 a) What's the size of the corruption?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block, cac=
he line, word, bit???
>> =C2=A0=C2=A0=C2=A0 b) Position?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e.g. last =
word in a block or something?
>> =C2=A0=C2=A0=C2=A0 c) Data?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pile of ze=
ro's/ff's junk/etc?
>>
>> =C2=A0=C2=A0=C2=A0 d) Is it a missed write, old data, or partially writ=
ten block?
>>
>> Dave
>>
>>>> Puh.=C2=A0 I'm kinda lost on what we could do about this on the Linux
>>>> side.
>>>
>>> Because it also depends on the CPU series, a firmware or hardware issu=
e
>>> seems to be more likely than a Linux bug.
>>>
>>> ATM ASRock is still trying to reproduce the issue. (I'm in contact wit=
h
>>> them to. But they have Chinese new year holidays in Taiwan this week.)
>>>
>>> If they can't reproduce it, they have to provide an explanation why th=
e
>>> issues are seen by so many users.
>>>
>>> Regards Stefan
>>>
>>>
>


