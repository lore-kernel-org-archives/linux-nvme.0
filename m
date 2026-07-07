Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED1EC43458
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 01:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzSDU5v4QNXrloVmtzmO/cT0fybuWxbNH85fBrZ3rjA=; b=36s43aQQvYOm3fqkxVMlXWdkOC
	Ozn2z1plEsxPuCaAxZDXKONjKK+JOTQECApH23kIU4f/JpBmNR4BwHoNi0x3E6W/wpx5YQcBFzUqV
	l+qAq/bzJMa8/iHhxC6lIEmqjdwzhtMZo297ffvgEdz9G53AJIneld4lp2ERUa2YgvNnYY+CAORNf
	7j18jYm9hcaJX5714QvAprgmW5d11aw839AUY6EvEfybdftzCQVQk8BhcWRfM90bJzvQG63+XDRTp
	D3Z4nOwu27teNJWcYNrv18XcYUEWnQmuPGVivsgt/u5H+qpp4JDuMZM5fZnt3r2BtxOCbuYsmXDGB
	XKwcXeAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgupU-0000000DtJn-1Aoa;
	Tue, 07 Jul 2026 01:42:32 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgupR-0000000DtJ9-0xr8
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 01:42:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783388547; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HzSDU5v4QNXrloVmtzmO/cT0fybuWxbNH85fBrZ3rjA=;
	b=eTGafDIm0hZ1cflaAP+k2RcsYnqbm4hpcQWRkGhvv9n1JBNnEIUiw931kL4a7CxXRVQ8bmRA45e+9iTDo1+haYNb8uSyYv7GQypmk9ahb3/OoD6nJM3ytFfRckbGtcuxpVSUuAvVvWaznP8XhwUSfSrw0qt6y2DLYd3UdLb52E4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X6b0tSK_1783388545;
Received: from 30.178.83.41(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6b0tSK_1783388545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 09:42:25 +0800
Message-ID: <fbd64f1b-7970-4136-9dc5-d7db474ae87a@linux.alibaba.com>
Date: Tue, 7 Jul 2026 09:42:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: add namespace-level debugfs for reservation
 state
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.com>, linux-nvme@lists.infradead.org
References: <20260622104418.2070277-1-kanie@linux.alibaba.com>
 <5b2a11e8-bb66-4111-9090-bcdbb0458fcf@flourine.local>
 <f0c00d47-0f33-4c9a-84ea-2fb82cd4d102@linux.alibaba.com>
 <1b56186c-9e5b-4e9a-813e-74e4d1511738@linux.alibaba.com>
 <78c97eb1-a69e-4f14-977d-f3950db1a0e2@flourine.local>
 <551ef1f7-ceec-4e4d-9555-0661ecbcc845@linux.alibaba.com>
 <akuji5egnkVWM5u2@shinmob>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <akuji5egnkVWM5u2@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_184229_435903_4E40AC98 
X-CRM114-Status: GOOD (  10.53  )
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



在 2026/7/6 20:57, Shin'ichiro Kawasaki 写道:
> On Jul 06, 2026 / 18:28, Guixin Liu wrote:
>>
>> 在 2026/7/6 15:59, Daniel Wagner 写道:
>>> On Mon, Jul 06, 2026 at 11:10:41AM +0800, Guixin Liu wrote:
>>>>>>> Example output with two registered hosts and an active holder:
>>>>>>>
>>>>>>>      $ cat /sys/kernel/debug/nvmet/testnqn/ns1/reservation
>>>>>>>      enable : 1
>>>>>>>      generation : 2
>>>>>>>      notify_mask : 0x0
>>>>>>>      rtype : write_exclusive
>>>>>>>      holder : hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
>>>>>>>      registrants:
>>>>>>>        hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
>>>>>>>        hostid=22222222-2222-2222-2222-222222222222, rkey=0x2222
>>>>>> I expect blktests will make use of this interface eventually. The parser
>>>>>> for this wont be dead simple, sure doable but not simple. If you see a
>>>>>> way to make a bit simpler I wouldn't mind.
>>>>> How about this:
>>>>>
>>>>> 1. One holer, multi registrants:
>>>>>     enable=1
>>>>>     generation=2
>>>>>     notify_mask=0x0
>>>>>     rtype=write_exclusive
>>>>>     holder=11111111-1111-1111-1111-111111111111,0x1111
>>>>>     reg=11111111-1111-1111-1111-111111111111,0x1111
>>>>>     reg=22222222-2222-2222-2222-222222222222,0x2222
>>>>>
>>>>> 2. No holder, multi registrants:
>>>>>     enable=1
>>>>>     generation=1
>>>>>     notify_mask=0x0
>>>>>     rtype=none
>>>>>     holder=none
>>>>>     reg=11111111-1111-1111-1111-111111111111,0x1111
>>>>>     reg=22222222-2222-2222-2222-222222222222,0x2222
>>>>>
>>>>> 3. No registrant:
>>>>>     enable=1
>>>>>     generation=0
>>>>>     notify_mask=0x0
>>>>>     rtype=none
>>>>>     holder=none
>>>>>
>>>>> 4. Reservation not enabled:
>>>>>     enable=0
> ...
>> Hi Shin'ichiro:
>>      Does this work for you?
> Hi Guixin, yes, I think it is good enough. If this is sysfs, "one value
> per file" and "array by files in a directory" would be guided, but this is
> debugfs readonly data. So, it sounds reasonable to put some data structure into
> a single debufs attribute file. Uevent like key=value format sounds good. It is
> a bit wacky to use comma to hold both host id and key for a holder and a
> registrant, but I cannot think of better solution.
OK, I will change this in v2, thanks.

Best Regards,
Guixin Liu


