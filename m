Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E177D74956
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 01:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kGTbvOlkl8NN9lF6u3rA7N7VkATyiMKw0698JsFPWOo=; b=oPiAyhCOZihUq9sz20me1a174V
	AezllvA8VKL/SqiRUjl41BGpTx91JzT7/9QJo46tEd/Wj8u/5/98vjGZYwLmDSlGOiSho7BqGD0rv
	Z8z3ZpXWxu/SOxkKD+b4smubiVljsgK8WPcToLbW7AIqB/g6VMYkgI2bcz4fC0W3WmioTN8V3frKj
	nVIdTg3bX8Ilwv0RZCFpjuZQMD303LhX9vOh8phCLHUWS4a/KbpHz8hU33s7yMfw1a0EvvgVleONx
	tkiJVw/kbf9jUpgJgf1w7Jw+mkcdMLiWe6RAoGPIzUhHNhxCw9CI9rocbFPJ1So6osmJ68b6IN2v1
	s8HeTTyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5xlG-0000000GS1P-2204;
	Wed, 30 Oct 2024 01:44:38 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5xlD-0000000GS0C-0Sv4
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 01:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730252671; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kGTbvOlkl8NN9lF6u3rA7N7VkATyiMKw0698JsFPWOo=;
	b=fwBPO1BPW+mcf4xk6wQGDE2KhHoZ5LLbm9ucDCV1k/kMb/VJ9bgLvRmDErFMauFZL7Od7e/+vYwIBI4vHySLY9wmokGZiSn1syL8toJ0cE0He9Wah/1CRdQnQNFbluD82XGvObP9gBQ5U1pICWG4kY5zjNZEL9ACQDFvS6Em3Q8=
Received: from 30.178.82.27(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIC.YRE_1730252667 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 09:44:28 +0800
Message-ID: <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
Date: Wed, 30 Oct 2024 09:44:25 +0800
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
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_184435_801447_602E9FB9 
X-CRM114-Status: GOOD (  12.33  )
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


在 2024/10/30 03:52, Chaitanya Kulkarni 写道:
> On 10/28/24 23:46, Guixin Liu wrote:
>> 在 2024/10/29 13:04, Chaitanya Kulkarni 写道:
>>> On 10/28/24 18:49, Guixin Liu wrote:
>>>> Make nvmet_wq visible in sysfs, allowing for tuning the it's attr
>>>> through sysfs.
>>>>
>>>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>>>> ---
>>> do you happened have a usecase for this?
>>>
>>> -ck
>> Sometimes, in order to respond promptly to certain events or
>>
>> manage commands, we need to reserve resources and partition
>>
>> the CPU cores. For example, if there are 4 cores available,
>>
>> we can initially allocate them by dedicating one core for
>>
>> management while the remaining 3 cores are specifically for handling IO.
>>
>> Best Regards,
>>
>> Guixin Liu
>>
> I'm aware of exposing tunables through sysfs and it's benefits, my question
> was do you have a setup where this setting is needed currently ?
>
> I've always been asked to for the usecase on a patch when we expose
> something
> out of kernel that is solving the problem in the deployment ...
>
> -ck

I need serverve some cpu core to do other things, such as handle events

and managements, so that the nvmet_wq can't running on all cpu cores,

currently, I restrict it by setting the cpumask of nvmet_wq（that's why

I expose nvmet_wq to sysfs）.

Best Regards,

Guixin Liu

>

