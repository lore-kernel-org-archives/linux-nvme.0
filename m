Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AA7C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fif73QROHw+43p8Nz1olMRFpRtb4iDfSX7kXTa/7BnI=; b=vp+/57M5CSeLRyRswzy9wyomY0
	es/dN/d11slLl7/4CklvDQFDy1C3omVK//5TfD3mS6zU0i7gJXEz1SBVHHxNqIKwZAyYB/fI9s6hc
	p8rRjMZcJolzQtfHuL0/el0qwtVLbgpf39MANR5wgSw6+ju7CSMx2IwY69OVluFf8Qgvhdeham8Ld
	vIKs2CN630fpTaI3OqlpAN4y/FKsM+n9UAEbx3DsFR+hfclZI61d6iPr/oHT1V8bsd5TOIZOP6CDh
	vOssEAqyj6i9sOa70onmkdf6Gb+7644e/evzsXIeyxrP7VsAF6jkA5YADT3bVCNDV9Pi98KgUZmHr
	JC5mwhMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5oX-0000000BI3j-03B2;
	Wed, 03 Jul 2024 19:38:49 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5oV-0000000BI3N-09G8
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 19:38:48 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424f2b7385bso5216085e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 12:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720035525; x=1720640325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fif73QROHw+43p8Nz1olMRFpRtb4iDfSX7kXTa/7BnI=;
        b=s5/5nlsbc+XZ5BVDO676jKvjscd76XnzV/1K4lsVE8eg6Rp/zZyphN0nGSk3RqqEL/
         mDBmiiJ7EsRSORo8F1CIMxAQ0MJ9B90KFa34sGm7keuj2WWobwNJTvYS2iU+2SV/sVol
         VdnL2qfYsZ+Sgycxc6Ox16NeB2jtSHuVMzddt/dKARMPMPJNWLHRVDN+gaXj+ljfcL+6
         O/xFtTIJ51LpgbjV7rsGc9HKAXOjmaHiLW454hNM+vXmyHlVJYrHxjRbzuv0JFARo7S6
         QdeSfIpYZ5/vk02AUzfqcUJs3/F7dsN9d/JI3lpCOz3qYwzdoRPoFUkGHh0Lc6Kp+aiS
         e86w==
X-Forwarded-Encrypted: i=1; AJvYcCVA8I4jks8Q3s8/OQQarYfS1a784+ePruKGgtynlhQS8M3Zf4gwp7KlXeKabrDBBYYfi/bG9t7yoZjzwmTo6Rm3z+wQTWKJW/Bg6V2yG94=
X-Gm-Message-State: AOJu0YyKYvJf32DVTyKKAa3Jgaykg/4q02Glualzv/GuIW7srpWBB+Hi
	goAf6RPcuraF+8yTcSY2AD7tFgpO5wLtUBAMHxmUEIHI+hpPpOnw
X-Google-Smtp-Source: AGHT+IHepxsVjRMgdaykEpKBjpvzsl3Y2QApy/7N7BMMDxqaoXVProsKSI/NefbR6aYtRJ9VCLsN+w==
X-Received: by 2002:a05:6000:2c4:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-3677569cfacmr9684765f8f.2.1720035525166;
        Wed, 03 Jul 2024 12:38:45 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679b8be0f5sm93998f8f.5.2024.07.03.12.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:38:44 -0700 (PDT)
Message-ID: <34d22ad9-1d10-44df-a131-c9aea18fde0c@grimberg.me>
Date: Wed, 3 Jul 2024 22:38:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-3-hare@kernel.org>
 <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
 <11c0b02b-03a3-4097-948b-651b14baa0cf@suse.de>
 <9bc9d94f-a129-4c6e-ac9e-d0eb8db341b0@grimberg.me>
 <dc849cb6-8bf3-4363-9bd1-9b13138c0fb7@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <dc849cb6-8bf3-4363-9bd1-9b13138c0fb7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_123847_112286_4B04DF7C 
X-CRM114-Status: GOOD (  29.42  )
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



>>
>>
>> On 03/07/2024 17:53, Hannes Reinecke wrote:
>>> On 7/3/24 16:19, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 03/07/2024 16:50, Hannes Reinecke wrote:
>>>>> When 'wq_unbound' is selected we should select the
>>>>> the first CPU from a given blk-mq hctx mapping to queue
>>>>> the tcp workqueue item. With this we can instruct the
>>>>> workqueue code to keep the I/O affinity and avoid
>>>>> a performance penalty.
>>>>
>>>> wq_unbound is designed to keep io_cpu to be UNBOUND, my recollection
>>>> was the the person introducing it was trying to make the io_cpu 
>>>> always be on a specific NUMA node, or a subset of cpus within a 
>>>> numa node. So he uses that and tinkers with wq cpumask via sysfs.
>>>>
>>>> I don't see why you are tying this to wq_unbound in the first place.
>>>>
>>> Because in the default case the workqueue is nailed to a cpu, and 
>>> will not move from it. IE if you call 'queue_work_on()' it _will_ 
>>> run on that cpu.
>>> But if something else is running on that CPU (printk logging, say), 
>>> you will have to stand in the queue until the scheduler gives you 
>>> some time.
>>>
>>> If the workqueue is unbound the workqueue code is able to switch 
>>> away from the cpu if it finds it busy or otherwise unsuitable, 
>>> leading to a better utilization and avoiding a workqueue stall.
>>> And in the 'unbound' case the 'cpu' argument merely serves as a hint
>>> where to place the workqueue item.
>>> At least, that's how I understood the code.
>>
>> We should make the io_cpu come from blk-mq hctx mapping by default, 
>> and for every controller it should use a different cpu from the hctx 
>> mapping. That is the default behavior. in the wq_unbound case, we 
>> skip all of that and make io_cpu = WORK_CPU_UNBOUND, as it was before.
>>
>> I'm not sure I follow your logic.
>>
> Hehe. That's quite simple: there is none :-)
> I have been tinkering with that approach in the last weeks, but got 
> consistently _worse_ results than with the original implementation.
> So I gave up on trying to make that the default.

What is the "original implementation" ?
What is you target? nvmet?
What is the fio job file you are using?
what is the queue count? controller count?
What was the queue mapping?

Please lets NOT condition any of this on wq_unbound option at this 
point. This modparam was introduced to address
a specific issue. If we see IO timeouts, we should fix them, not tell 
people to filp a modparam as a solution.

>
>>>
>>> And it makes the 'CPU hogged' messages go away, which is a bonus in 
>>> itself...
>>
>> Which messages? aren't these messages saying that the work spent too 
>> much time? why are you describing the case where the work does not get
>> cpu quota to run?
>
> I means these messages:
>
> workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 32771 
> times, consider switching to WQ_UNBOUND

That means that we are spending too much time in io_work, This is a 
separate bug. If you look at nvme_tcp_io_work it has
a stop condition after 1 millisecond. However, when we call 
nvme_tcp_try_recv() it just keeps receiving from the socket until
the socket receive buffer has no more payload. So in theory nothing 
prevents from the io_work from looping there forever.

This is indeed a bug that we need to address. Probably by setting 
rd_desc.count to some limit, decrement it for every
skb that we consume, and if we reach that limit and there are more skbs 
pending, we break and self-requeue.

If we indeed spend much time processing a single queue in io_work, it is 
possible that we have a starvation problem
that is escalating to the timeouts you are seeing.

>
> which I get consistently during testing with the default implementation.

Hannes, let's please separate this specific issue with the performance 
enhancements.
I do not think that we should search for performance enhancements to 
address what appears
to be a logical starvation issue.

