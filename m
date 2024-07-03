Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1201C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KC7r2Rr2eb4uce3O9K2gxu5+InZY0x2LJMd6OQ1M/qI=; b=r8IJF3awgai/MzD9fs1EWTHS3g
	wUG1q3hQxoiPM4+NG8IxU6N0+YBhQaQmGkEi9OM3dhHLGpk1iuoNTHozVKw7qwkwLZKi2KhoO6LAl
	xpQgSot9on74I9OBWXtDDKLv3CK3AX8t/pVD+gjsVb/2A9ZfaYbXbv36tMztNqbu8NKKBlNbNxjzy
	Un2tc7YhedAIu1Et28HdXqZay5Bs3+XhV2QBWQlawbCggl9s8sttO8YquYlwhRlPjWulPc6h36Kii
	Dj6JjhTrIZA2+W5A6FB1DZ9+LmhiXrvxUq7mk2jaNbxLotxU4T4SUylVrdHxrm5l6KaxkEdNr4YWv
	wTAbZ50A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1WH-0000000AbWY-13tO;
	Wed, 03 Jul 2024 15:03:41 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1WE-0000000AbUN-1tIV
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 15:03:40 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42111cf2706so6040085e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 08:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019016; x=1720623816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KC7r2Rr2eb4uce3O9K2gxu5+InZY0x2LJMd6OQ1M/qI=;
        b=qVsp6RNmKozkj7xkewIgicZIHHjHYP/mCGQMCRw1WJ5ZhLr2fRbj2Lf3MVQ8jCDjnV
         f24X1z5UhKDyrdm30XXeGsmuF93UmkSG9S1ApPjhH/xj8ZwjdtEomipN6blj2jQJANBk
         xxSSRuIQWNkPDMYnn7t19uQL/v0se8NlyEGIbz9a6bG/eFTKDZjGaj1p1UysHlqVzDgu
         0lBefcZLL3QicftYJEEGIEaw88dyAGmnkpjmFPNf9hvs3EoEjMfwc0SvWH5Pj8+J39qA
         Mmwb3WdAlkeRIpzcwe1wWYOaVjY2Vgn+pbpYgllfU8cn6/ysAeuFIneQY8dH0jOq7n+7
         vQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHYdQHug1papzfHk5GWSBJhFgoUeBGKyn6Ku+sJLF6mOOWspzZg/zrLgt8CibbIpyS656VuckR32EZzxQfSIqjE0l+jo88EjeroKaJcdc=
X-Gm-Message-State: AOJu0YwtiQFtDzy1Np7Y+9zOKY9OMmnghecoUsOie8iJhfUNVe1Tp7s6
	ws8tPA9YwLbVexNwpomZIfs8LaflKkd1dfRodKlxxuuv3l0cpUom
X-Google-Smtp-Source: AGHT+IEziwGDiyHr+dyewgJ5X8Ocvtz95KpkEo3AxEqNcaRgSTjsq+dBQfuTd6t5JgldUH8cDpBypQ==
X-Received: by 2002:a05:600c:3b05:b0:425:69cb:548b with SMTP id 5b1f17b1804b1-4257a15ac67mr82305235e9.4.1720019016182;
        Wed, 03 Jul 2024 08:03:36 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097c2asm243236615e9.38.2024.07.03.08.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 08:03:35 -0700 (PDT)
Message-ID: <9bc9d94f-a129-4c6e-ac9e-d0eb8db341b0@grimberg.me>
Date: Wed, 3 Jul 2024 18:03:34 +0300
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <11c0b02b-03a3-4097-948b-651b14baa0cf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_080338_564632_F7774121 
X-CRM114-Status: GOOD (  25.72  )
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



On 03/07/2024 17:53, Hannes Reinecke wrote:
> On 7/3/24 16:19, Sagi Grimberg wrote:
>>
>>
>> On 03/07/2024 16:50, Hannes Reinecke wrote:
>>> When 'wq_unbound' is selected we should select the
>>> the first CPU from a given blk-mq hctx mapping to queue
>>> the tcp workqueue item. With this we can instruct the
>>> workqueue code to keep the I/O affinity and avoid
>>> a performance penalty.
>>
>> wq_unbound is designed to keep io_cpu to be UNBOUND, my recollection
>> was the the person introducing it was trying to make the io_cpu 
>> always be
>> on a specific NUMA node, or a subset of cpus within a numa node. So 
>> he uses
>> that and tinkers with wq cpumask via sysfs.
>>
>> I don't see why you are tying this to wq_unbound in the first place.
>>
> Because in the default case the workqueue is nailed to a cpu, and will 
> not move from it. IE if you call 'queue_work_on()' it _will_ run on 
> that cpu.
> But if something else is running on that CPU (printk logging, say), 
> you will have to stand in the queue until the scheduler gives you some 
> time.
>
> If the workqueue is unbound the workqueue code is able to switch away 
> from the cpu if it finds it busy or otherwise unsuitable, leading to a 
> better utilization and avoiding a workqueue stall.
> And in the 'unbound' case the 'cpu' argument merely serves as a hint
> where to place the workqueue item.
> At least, that's how I understood the code.

We should make the io_cpu come from blk-mq hctx mapping by default, and 
for every controller it should use a different cpu from the hctx 
mapping. That is the default behavior. in the wq_unbound case, we skip 
all of that and make io_cpu = WORK_CPU_UNBOUND, as it was before.

I'm not sure I follow your logic.

>
> And it makes the 'CPU hogged' messages go away, which is a bonus in 
> itself...

Which messages? aren't these messages saying that the work spent too 
much time? why are you describing
the case where the work does not get cpu quota to run?

