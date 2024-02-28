Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D31C5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 03:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkoh+Wpo8OQQpFqDNxTg4P5xeSCDDGzH0oL3+AC+nNw=; b=S9B8KivpYWa4SRM3T3PGNEvuvp
	MMU85m0DgOWIcBgwb2Mtzhs2jEBW53pRfIX0eP9TzbajkWnU54+x87/oyOboOHjni7S8qg2+kgqws
	8w0Rl8lDHNPy2359XCeWGdbiUC4eV0Ptfd3QPyAjepv7oSTVAil2gNNkHfX6ALHZ2jGE6/NQi+p9t
	kWoh692p6dMb+NCIFqmiV7T9qpdPi3QlgtP0sDXO7mK3+A1dPlfG7Epx/mbDCcWSbbCNlWgPJr8Xd
	BpSxV7xN69KKmdT3CccZwhHZpRjsYawrQtp7QIyArjYgoIx8b7/PKlN3guY4g2APKonRGsDePu0Z+
	xPYdpZXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfAoA-00000007sJX-2bix;
	Wed, 28 Feb 2024 03:40:38 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfAo7-00000007sIm-0EoC
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 03:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709091631; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zkoh+Wpo8OQQpFqDNxTg4P5xeSCDDGzH0oL3+AC+nNw=;
	b=njdh25btaIDk5Ima2zZM3HOTwGGCM84cNVNd9r2aLybLY1b/YYlAI0UAw4pdjCZR+LzHxp+MMFbkSfF5uhAaFZ3Po2KergCqb7d6nCWcHgSnPfBJwubJfCtSRKkYAXp0gFgRuXfM5SB9Y4g6siU67vnLjPWSJ0u00OQ/BmYSv4w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1OQXEn_1709091627;
Received: from 30.178.83.72(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1OQXEn_1709091627)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 11:40:28 +0800
Message-ID: <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
Date: Wed, 28 Feb 2024 11:40:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <Zd6msstIWsNQMPfK@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_194035_823610_9E21F886 
X-CRM114-Status: GOOD (  14.05  )
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


在 2024/2/28 11:21, Keith Busch 写道:
> On Wed, Feb 28, 2024 at 10:21:57AM +0800, Guixin Liu wrote:
>> 在 2024/2/28 08:40, Sagi Grimberg 写道:
>>> Hey Guixin,
>>>
>>> On 01/02/2024 4:32, Guixin Liu wrote:
>>>> This patch implements the reservation feature, includes:
>>>> 1. reservation register(register, unregister and replace).
>>>> 2. reservation acquire(acquire, preempt, preempt and abort).
>>>
>>> Overall patchset looks in decent shape to me now.
>>>
>>> I do have one more question though.
>> My thanks for your patient review.
>>> You say that this patchset implements preempt and abort, however I don't
>>> see how this is actually implemented or even how can it be implemented
>>> at all at this point.
>> Yes, the nvme target does not do any useful workto abort command, the
>> comment of nvmet_execute_abort() says that
>>
>> "we are not required to do any useful work, and we couldn't really do a
>> useful abort",
>>
>> so I don't know what to do about preempt and abort, and the NVMe spec says
>> that the abort is best effor.
>>
>> My statement here may be a little inaccurate.
> I think you may be mixing up the NVMe "Abort" command with a different
> command, "Reservation Acquire", where RACQA is set to value 010b,
> "Preempt and Abort".

Sorry, I just want to explain that I dont know how to implement "preempt 
and abort"

either.


