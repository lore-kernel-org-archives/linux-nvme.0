Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B870C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fIoquENYXWJoHN1A2Mrf3K7o57gEP0X/sUWlRZqWpBc=; b=kV0nkO8HJE3PM69jOb7PrpuU3o
	M6dwZ0oJHSl2Csxb14MLK6VgIOx/lTXpE/2Ewp74QWNHIJCJ/I+0eFB/SwCLvZIuQebkt84tC4t6D
	JJMWEszEpXndw9ayhpZoBjGBU4u9CUVyHzLTTy8B+pM41kFz8WnRjCP0iZ+uFTJt2/gKTFIvWNyli
	rii50SyVShcNHx6aLhf6Y+ZpxOl4XEDjqWhbKDC0zXOkTCUwgqvRIk+J1mKj+vleALlDOYtWoJEDw
	OKf1ppdZFvmd44wm0NPioJv5RFKPt7nyrT2mVDo5235e+ncK3FpOCr5vX7dVsbOBVSRKTvI5bE7i3
	5RQ/umRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQCOw-000dsl-2E;
	Wed, 17 Jan 2024 20:20:42 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQCOt-000drV-1m
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 20:20:40 +0000
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so109614139f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705522837; x=1706127637; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIoquENYXWJoHN1A2Mrf3K7o57gEP0X/sUWlRZqWpBc=;
        b=hPd/mn8mVtHjmP8v7WyF4WTq4cic7Evw98HnsHyBh47K8KOjM+ByyOVP3pK5G4fGKq
         GGvd0AttbojwA02ttsJpxhcDzIWMtVAj3QVsUao2nSukHt12ilRk7u2fINSEUvKk5WVn
         fXzPR9dCNSR/vBzNd+kfNGm3u+WkoP4Xjbvm92lO/JQ6Zfseq8Tj8BfpoihN+Gh5Gxdk
         sRc13Rk8jw7JMvkClsVwYGbt7TqyWWgPVcCKK8QDCjSZmrkszUSab63IaAa/qYVJbGK7
         cW2oNeE5zVs/9R27AdbpEIaaxKIoMnyU63qXuftpB8L6xIIB23Yo94C7A21rDRSUpO93
         +nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522837; x=1706127637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIoquENYXWJoHN1A2Mrf3K7o57gEP0X/sUWlRZqWpBc=;
        b=n8Uoxzv8/6VyjlSBec0isYpyhNFcAEhhTcrJLiPBBzob0Tjs4YkB2zPyyuSckALxeA
         3Hc0sltCQjguCeb0SUYxYUFEtVlxDDq48/R2cZkQ/aKORgkQzNgTOVOQhKOBiZWTWP12
         vnRANGL7zH5L8Ef95vrxfomc63wZJOR4G7B0jc7AFDexKcSneWU1M1yUy7Ho53v/ertF
         7Fk/gTrcr12w0XaTwPB7JXXy8DeXZcOUB79VW8YN9S8nSs1Fahj1Fr0Iy3Uk2KG+HEOX
         R1k5Sl9tBIQngr38h7jaOMl4PVJGWYL+/ol6Rz7G53umc9o01TPPE1lHAs4rBQe1J58F
         ff3g==
X-Gm-Message-State: AOJu0YxgPMFQKo8th+7WyJaG7riMqGhEbiH20T6+yg9Ww/MP55Hp5UcQ
	5BuPjf/Sz+euRlIZaMviMe+qwJUQKSrI4cJB/r06FgOcxOubNw==
X-Google-Smtp-Source: AGHT+IHNkGqCG/5i9QmTvp4l6I+DJ3/KFjMRzkufzIiVW/B+nmPmgokmhshaLBC+7Igp1Tt+BbP61g==
X-Received: by 2002:a05:6602:2c95:b0:7be:e080:6869 with SMTP id i21-20020a0566022c9500b007bee0806869mr17304148iow.1.1705522837427;
        Wed, 17 Jan 2024 12:20:37 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h14-20020a05660208ce00b007bf021d13ebsm3628383ioz.49.2024.01.17.12.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:20:36 -0800 (PST)
Message-ID: <9f4a6b8a-1c17-46b7-8344-cbf4bcb406ab@kernel.dk>
Date: Wed, 17 Jan 2024 13:20:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
 <39dfcd32-e5fc-45b9-a0ed-082b879a16a4@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <39dfcd32-e5fc-45b9-a0ed-082b879a16a4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_122039_587941_D8242D15 
X-CRM114-Status: GOOD (  13.32  )
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

On 1/17/24 1:18 PM, Bart Van Assche wrote:
> On 1/17/24 12:06, Jens Axboe wrote:
>> Case in point, I spent 10 min hacking up some smarts on the insertion
>> and dispatch side, and then we get:
>>
>> IOPS=2.54M, BW=1240MiB/s, IOS/call=32/32
>>
>> or about a 63% improvement when running the _exact same thing_. Looking
>> at profiles:
>>
>> -   13.71%  io_uring  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
>>
>> reducing the > 70% of locking contention down to ~14%. No change in data
>> structures, just an ugly hack that:
>>
>> - Serializes dispatch, no point having someone hammer on dd->lock for
>>    dispatch when already running
>> - Serialize insertions, punt to one of N buckets if insertion is already
>>    busy. Current insertion will notice someone else did that, and will
>>    prune the buckets and re-run insertion.
>>
>> And while I seriously doubt that my quick hack is 100% fool proof, it
>> works as a proof of concept. If we can get that kind of reduction with
>> minimal effort, well...
> 
> If nobody else beats me to it then I will look into using separate
> locks in the mq-deadline scheduler for insertion and dispatch.

That's not going to help by itself, as most of the contention (as I
showed in the profile trace in the email) is from dispatch competing
with itself, and not necessarily dispatch competing with insertion. And
not sure how that would even work, as insert and dispatch are working on
the same structures.

Do some proper analysis first, then that will show you where the problem
is.

-- 
Jens Axboe


