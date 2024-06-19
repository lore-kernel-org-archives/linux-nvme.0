Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252CBC2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VHQhN1szDWrDWl9R/voChBxS4nnD7Vlm4eiYbJkz4qY=; b=f4bK8SMAVAx5ik6Jvn0ZRQ8LGL
	gv9HrIMW/ea6UBjivDY+QNbcft+1K2BCWU4NuPX3xN7e63qyHZPjW/TxqclfTx42rjFhZjeTC60id
	EkQcjwSz2ZNHJkc/20wKy4EDSIRcEUUfu3NsgLoAiS6feVe8yhYhtL6jBkf/4LKa2i1zulF4bcJkP
	kX3bOP0AhBZWEEb44NkCykV5AE3nnqdVuBowlP/QBVSl6squJ1fjmJh/WgRjPwZYmHknqunP5IU73
	mDO7QI2qAXJtPqPUmRM+aAzzpyzruQ7aOjWU8MwALTHKhqtyiSkQo28eC32MGit4GC2L0Ypm6PHeK
	v5ge2pCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsKX-00000000kME-1icX;
	Wed, 19 Jun 2024 10:14:17 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsKV-00000000kKu-00LY
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:14:16 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52a559e4429so841424e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 03:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718792053; x=1719396853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHQhN1szDWrDWl9R/voChBxS4nnD7Vlm4eiYbJkz4qY=;
        b=l9Dw5/mdwdJTu8rnCk8z+lEWeJnm7y2S1kinvh+OaSv7fuMXstx5DzB1rI5S8ZvLuy
         yGI/3lqyycM5I7iZkDVx5/9ZuWa6aEq/Ac6Mauy97Ycn3lD+LqGU5FPjGq4eLH3bYqv3
         LjvLj/it5dqHYAFvA8OugmJ0A6iovC1sBQ/p2sWwpINnq+LwWL1Wto8g2uNPdsPlKamn
         /N6F2v+PvD38zUX0P3T401siIrM3KUMnOMmcoD5Fpt7vTVDWOxgEypmqsEDWQ343H3gQ
         i9lU4n69UY+31XYnNmyS3FUouZmh5CbogBbRhBziUp57uZgTmngU8vXzZA74/gGGuvXR
         M3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXarmkNLSyXqLJz+7GXjSeNmv86ey6MXZlXs8pEoWJJ7f27kHFi+lRxHJQ/q2cCtVOH5bxAYHmC36GiQ4WHJUdPyYNn2IcrvBuZTMxxbOw=
X-Gm-Message-State: AOJu0YxbwPVu+ejcwd7+xUQ+ReyEz9QkyMlRK7o9JsDbR6lpFJ5CyYmF
	0pKkQ+N3OCD8pWQOty1eb8p1Cj1shuPsplLwFQzDD1SaZEdGq34x
X-Google-Smtp-Source: AGHT+IGYs23kOvqE2e/iOibeZmfygpRTYPgOH9wu4dtGOI6bRghWqGJIFpXVm4oOJNs/euEwTLBwmw==
X-Received: by 2002:a2e:8199:0:b0:2ec:18c7:169d with SMTP id 38308e7fff4ca-2ec3ce7e201mr10567511fa.1.1718792052409;
        Wed, 19 Jun 2024 03:14:12 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-363c795febfsm901506f8f.104.2024.06.19.03.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:14:12 -0700 (PDT)
Message-ID: <5928a2c0-43ff-434b-bfd8-01fe5ff792ac@grimberg.me>
Date: Wed, 19 Jun 2024 13:14:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240618120345.64761-1-hare@kernel.org>
 <20240619053015.GB29159@lst.de>
 <e8d5e591-0f19-4cc8-b7a4-9d6a5687b019@grimberg.me>
 <f30bff6b-5c9a-46e4-89df-1a1df088faeb@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f30bff6b-5c9a-46e4-89df-1a1df088faeb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_031415_064571_CBBE5818 
X-CRM114-Status: GOOD (  22.96  )
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



On 19/06/2024 13:01, Hannes Reinecke wrote:
> On 6/19/24 10:57, Sagi Grimberg wrote:
>>
>>
>> On 19/06/2024 8:30, Christoph Hellwig wrote:
>>> On Tue, Jun 18, 2024 at 02:03:45PM +0200, Hannes Reinecke wrote:
>>>> Add a new module parameter 'wq_affinity' to spread the I/O
>>>> over all cpus within the blk-mq hctx mapping for the queue.
>>>> This avoids bouncing I/O between cpus when we have less
>>>> hardware queues than cpus.
>>> What is the benefit when setting it?  What is the downside? Why do you
>>> think it needs to be conditional?
>>
>> Not entirely sure.
>>
>
> Hehe. But I am :-)
>
>> Hannes,
>>
>> Can you please show what is the hctx<->cpu mappings before/after this
>> patch? Please use different queue counts so we can see the pattern.
>>
>> Can you please show any performance comparisons for low and high
>> queue counts?
>>
>> I'm not entirely clear what exactly "spreads I/O over all CPUs" mean.
>> Every nvme-tcp queue has an io context that does network sends and 
>> receives
>> (unless it goes within .queue_rq() context when possible). Does this 
>> somehow mean
>> that now a queue io context will run from multiple cpus at the same 
>> time?
>
> We are having on connection per queue, doing a 'queue_work_on()' for 
> each queue, based on the value of 'io_cpu'.
> That cpu should align to the set of CPUs per associated hwctx, otherwise
> we need to bounce the thread from one cpu to another.
> Case in point on this AMD machine I get this blk-mq mapping:
>
> queue 0: 6, 7, 8, 54, 55, 56
> queue 1: 9, 10, 11, 57, 58, 59
> queue 10: 42, 43, 44, 90, 91, 92
> queue 11: 45, 46, 47, 93, 94, 95
> queue 12: 12, 13, 14, 60, 61, 62
> queue 13: 15, 16, 17, 63, 64, 65
> queue 14: 0, 1, 2, 48, 49, 50
> queue 15: 3, 4, 5, 51, 52, 53
> queue 2: 18, 19, 20, 66, 67, 68
> queue 3: 21, 22, 23, 69, 70, 71
> queue 4: 24, 25, 26, 72, 73, 74
> queue 5: 27, 28, 29, 75, 76, 77
> queue 6: 30, 31, 32, 78, 79, 80
> queue 7: 33, 34, 35, 81, 82, 83
> queue 8: 36, 37, 38, 84, 85, 86
> queue 9: 39, 40, 41, 87, 88, 89
>
> - default behaviour:
>
> nvme nvme1: mapped 16/0/0 default/read/poll queues.
> nvme nvme1: queue 1: using cpu 0
> nvme nvme1: queue 2: using cpu 1
> nvme nvme1: queue 3: using cpu 2
> nvme nvme1: queue 4: using cpu 3
> nvme nvme1: queue 5: using cpu 4
> nvme nvme1: queue 6: using cpu 5
> nvme nvme1: queue 7: using cpu 6
> nvme nvme1: queue 8: using cpu 7
> nvme nvme1: queue 9: using cpu 8
> nvme nvme1: queue 10: using cpu 9
> nvme nvme1: queue 11: using cpu 10
> nvme nvme1: queue 12: using cpu 11
> nvme nvme1: queue 13: using cpu 12
> nvme nvme1: queue 14: using cpu 13
> nvme nvme1: queue 15: using cpu 14
> nvme nvme1: queue 16: using cpu 15
>
> So just queue 12 is using the correct CPU; all other queues are
> scheduled on cpus which are not part of the hwctx map.
>
> - wq_affinity behaviour:
>
> nvme nvme1: queue 1: using cpu 6
> nvme nvme1: queue 2: using cpu 9
> nvme nvme1: queue 3: using cpu 18
> nvme nvme1: queue 4: using cpu 21
> nvme nvme1: queue 5: using cpu 24
> nvme nvme1: queue 6: using cpu 27
> nvme nvme1: queue 7: using cpu 30
> nvme nvme1: queue 8: using cpu 33
> nvme nvme1: queue 9: using cpu 36
> nvme nvme1: queue 10: using cpu 39
> nvme nvme1: queue 11: using cpu 42
> nvme nvme1: queue 12: using cpu 45
> nvme nvme1: queue 13: using cpu 12
> nvme nvme1: queue 14: using cpu 15
> nvme nvme1: queue 15: using cpu 0
> nvme nvme1: queue 16: using cpu 3
>
> All queues are scheduled on a cpu which is part of the
> blk-mq hwctx map.

OK, I think I understand what this patch does now, thanks (this should 
appear in the patch change log).

The change log really needs to improve here Hannes,
The wording "spread the I/O over all cpus within the blk-mq hctx mapping 
for the queue" is very misleading. It is actually addressing a incorrect 
selection io_cpu selection for certain cpu topologies which leads to 
running different queue threads on sibling cpus, which may lead to 
suboptimal performance. And please add performance comparisons of this 
change. And lets remove the module parameter, iiuc this change is 
universally better.

