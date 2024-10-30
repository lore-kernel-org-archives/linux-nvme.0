Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A177D5CC9A
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Ntuf+ie0RIrAlXIX/l2iRqRzApLQnXohpYRWmOSbXo=; b=F7AAerC9EYTit1lwxJnza/n5HO
	ZTdxO6S+0SPLeHjpWxjdPfvIQkCzKrELL5Wq7PFYhyYYINi/w+1wnFPrGfkDT7tR42kF2I6LlrJsw
	B+Yj0ij+ZvTox1582LoyC5Az0lIbHNIGonTW0C+k/2oBT78fY8qvbFIxlUpiXWH5BN7i3MNnvOuKH
	UlN6ua9RJ6XM9wuW6MPgi4ANGYNNAZqLb2u34x1IT0avVqNWDZDOvSFFosfMV2mrYBb4Tny37+QkL
	ayJduZ9fw75gv9K4YESIFkqFCNrnKkWLZmnZvAdREjOX45W2VHhbq720HRceYxjOCeHVniQuxqXiY
	c4lKslqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t675D-00000000BY0-05X3;
	Wed, 30 Oct 2024 11:41:51 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t66kZ-000000006ve-2sh1
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 11:20:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730287226; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0Ntuf+ie0RIrAlXIX/l2iRqRzApLQnXohpYRWmOSbXo=;
	b=ALmblJ+cr/9jU++ED2VYE5yDF8yyOnKf23klJ1OzqLfcP55y7AHiaA5tJ8O3xjYeHzkqoIjVRKJplL4oGefmQbkflYn1i9VxceSHuuh89HiZPbogBjcJ7u3bvw0x/skI/tQ4vlR1VgKauDBhtfMfcmHBk96VONKCRznUZAuewzQ=
Received: from 30.178.82.27(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIDnaBa_1730287223 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 19:20:25 +0800
Message-ID: <d34e59db-66b1-42bc-93da-fa1ddcf658ed@linux.alibaba.com>
Date: Wed, 30 Oct 2024 19:20:22 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
 <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
 <e666ea1d-2b6b-45dd-8903-2269e2143c95@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <e666ea1d-2b6b-45dd-8903-2269e2143c95@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_042032_250843_D53B2A58 
X-CRM114-Status: GOOD (  19.49  )
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


在 2024/10/30 14:33, Chaitanya Kulkarni 写道:
> On 10/29/24 18:44, Guixin Liu wrote:
>> 在 2024/10/30 03:52, Chaitanya Kulkarni 写道:
>>> On 10/28/24 23:46, Guixin Liu wrote:
>>>> 在 2024/10/29 13:04, Chaitanya Kulkarni 写道:
>>>>> On 10/28/24 18:49, Guixin Liu wrote:
>>>>>> Make nvmet_wq visible in sysfs, allowing for tuning the it's attr
>>>>>> through sysfs.
>>>>>>
>>>>>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>>>>>> ---
>>>>> do you happened have a usecase for this?
>>>>>
>>>>> -ck
>>>> Sometimes, in order to respond promptly to certain events or
>>>>
>>>> manage commands, we need to reserve resources and partition
>>>>
>>>> the CPU cores. For example, if there are 4 cores available,
>>>>
>>>> we can initially allocate them by dedicating one core for
>>>>
>>>> management while the remaining 3 cores are specifically for handling
>>>> IO.
>>>>
>>>> Best Regards,
>>>>
>>>> Guixin Liu
>>>>
>>> I'm aware of exposing tunables through sysfs and it's benefits, my
>>> question
>>> was do you have a setup where this setting is needed currently ?
>>>
>>> I've always been asked to for the usecase on a patch when we expose
>>> something
>>> out of kernel that is solving the problem in the deployment ...
>>>
>>> -ck
>> I need serverve some cpu core to do other things, such as handle events
>>
>> and managements, so that the nvmet_wq can't running on all cpu cores,
>>
>> currently, I restrict it by setting the cpumask of nvmet_wq（that's why
>>
>> I expose nvmet_wq to sysfs）.
>>
>> Best Regards,
>>
>> Guixin Liu
>>
> Can you please explain your setup ? e.g. transport tcp/rdma/fc, device
> backend file/block etc ?
>
> so nvmet_wq's CPU consumption is so high, that it doesn't have bandwidth
> to handle events and managements ?
>
> Can you please explain the workload and what kind of events and managements
> handling is needed where you need to restrict the nvmet_wq with CPUMASK ?
>
> The only reason I'm asking that I've not seen this scenario so far in
> the many
> many deployments since we've added the nvmet_wq and I'd really like to learn
> about scenario.
>
> -ck

Sorry for the unclear explanation.

The transport is tcp and the backend is block.

This is just a solution level thing, in some complicated scenarios, we 
deploy multiple

missions on one machine(hybrid deployment), such as:

1. Dockers for function computation.

2. Real-time tasks.

3. Monitoring, and handling events and managemets.

4. And also nvme target server.

All of them are retrict to their own cpu cores to prevent mutual influence.

There is no problem if nvmet_wq running on all cpus of course, but for 
strict isolation,

we need to do this retriction.

I dont know if I've given enough detail.

Best Regards,

Guixin Liu

>

