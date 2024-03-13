Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD419C54791
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xerf5lAkrdn3WDT3a6f9a4F8CnvAHOMqMPpltxFmxZA=; b=xce6V+zBlxvkxxkimaRw3Brix+
	zWSKgB/ucTMvPNk8vVArg4pGmZYi00q5RBlQOI7+3YmATY75YLQXOexFL7sXP0XD0AvAxFp3HgogD
	Z9w087s3pUmUpOBkKVPQ/HmERJv9IjYhLwDxZ7S6a6BpNnfhLsmgfp2KKtgymo0Vmn+eEhTqfeU8V
	/w9N7kJFVroWBbi7IYUeTzMg64DyotV+uwB4Zod0nf0aJLTrVzjvcixWp/zRN5XkArDz2Yg5JGdjt
	JSciWclIftJh0CiA7/ELfePKV4tNtoP4oUhK9lX4rlQaXAQF5JSqJ6BnmWpKSdXsCvEtZEwsLiz1f
	zuJZdIIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNE3-00000009ysA-268q;
	Wed, 13 Mar 2024 11:56:51 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNDz-00000009yqQ-0JKp
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 11:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710331002; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Xerf5lAkrdn3WDT3a6f9a4F8CnvAHOMqMPpltxFmxZA=;
	b=SrbXiYjnpJfS8vcHFqLjHEZ3rquIOuP/DZnkPZxHOxBFmKqTLHzB8KKNDehDe/U1nOvpiZbOAqQdUW/jG+G5nBnLPaPWe/8amYUJ2fKY5cdwaanpWQwk0tPoMPqSkGP6rBMpJVS3DbUgZcMRVjJ1AlNrCkdGifowXM+eaFNRCng=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2P9uXd_1710331000;
Received: from 30.178.91.12(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2P9uXd_1710331000)
          by smtp.aliyun-inc.com;
          Wed, 13 Mar 2024 19:56:41 +0800
Message-ID: <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
Date: Wed, 13 Mar 2024 19:56:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
 <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
 <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_045647_650049_607FE97C 
X-CRM114-Status: GOOD (  18.16  )
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


在 2024/3/13 17:54, Sagi Grimberg 写道:
>
>
> On 13/03/2024 5:42, Guixin Liu wrote:
>>
>> 在 2024/3/13 05:31, Sagi Grimberg 写道:
>>> So I understand from you that there is out-of-band mechanism for 
>>> fence guarantee?
>>>
>>> In any event, Christoph reminded me that preempt and abort is 
>>> mandatory, so we cannot
>>> get away without doing it.
>>>
>> Agree.
>>> I suggest to introduce a per-ns-per-controller percpuref, with an 
>>> xarray that is rcu protected.
>>
>> I will implement it in v9, and I also think that we should a 
>> time-limited wait.
>
> If it is time-limited, and you didn't manage to wait, so you need to 
> fail the preempt and abort
> action (without DNR set so the reservation holder can retry if it 
> chooses to).
>
It can wait.
>>
>>>
>>> btw, I also think that reservations on nsid=0xffffffff should also 
>>> work. IIRC there were at least
>>> two use-cases that would have benefited from reservations on all 
>>> subsystem namespaces.
>>> It can also be a lot more lightweight to implement that (outside of 
>>> conflicting reservations checks). 
>>
>> You mean one host can reserve all of namespaces by sending one 
>> reservation command?
>
> Yes. The use-case is to have the reservation in the subsystem level.
> The spec seems to imply that this is a valid reservation request.
>
>>
>> Well, Could you please tell me which two use-cases?
>
> Don't remember for sure, but IIRC I've seen people run oracle rac with 
> all namespaces in the
> nvmet subsystem is exposed to DB hosts, and there were many namespaces.
>
>>
>> I think this will make the target code too complicated, because the 
>> reservation situation on each
>>
>> namespace may different, we should handle it one-by-one, and if 
>> failed in middle, we should revert
>>
>> the handled namespaces.
>
> Not sure why you'd assume that, this would be a subsystem-wide 
> reservation, which should simply
> cross-check individual namespace reservations for conflicts. Sure it 
> adds complication, but I think implementing
> it on every individual namespace is a naive implementation.

Well, this is strange, a few years ago, when I tested SCSI reservations 
with Oracle RAC,

I did not observe any "all LUN" reservation commands being issued.

I also researched LIO and SPDK, and found that neither supports "all 
LUN/NS" reservation commands.

When a host issued a reservation command without carrying a specific LUN 
or NS ID, both returned an error.

Best regards,

Guixin Liu





