Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C54C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gaP5w0WmO/BebCNFZntsO+CPAvXO89ZzwU0nrSMDmXQ=; b=wr5O7xMZFEjW6k/hB6Z7+wawac
	R3GT35VX+JeMBhfIwzZl5FtQoQMFBN7ch7lIhQ3X6BeribN5v2dwl1dlyKyuuimxEixPvWvC6LZJv
	cmWAskAtvvYUkG1mvhNRZaFZw1Ud/1bmeJjrm+d0kvl52LXrXMby+Wqdbkh00iuqzweEF8fcUZgvk
	pAeAQth589k13ucHO+4kASA2yP5MeMyL6Ci7bYH32v8NwsoeeStqgdxcJcd7PbaU7JSPXv5bN1FcQ
	+LsQddeooFOYWa3t+F2BBzPQCinrORLqhb1cL2ftvIdBwEPD7ISWoO3yDzDegPoX0R7XDgruuvRw2
	HXEVk6Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOCJ4-00000002D7K-2bng;
	Mon, 01 Jul 2024 08:22:38 +0000
Received: from mail-lj1-f176.google.com ([209.85.208.176])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOCJ0-00000002D6h-2sZc
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 08:22:36 +0000
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec5d86e759so2435441fa.2
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jul 2024 01:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822153; x=1720426953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaP5w0WmO/BebCNFZntsO+CPAvXO89ZzwU0nrSMDmXQ=;
        b=C8MsFxXWqHEhj2Gr+1LR6MBczkoSuhk3NsR7sq/M6ZS0ZH3dTVg4WWQtiZ4bF2o9Cp
         SxchCwBw97bpCSin4e6NWZtqG5VbezM4e7U+PF8BDec+BcOq9irGqB2boQBOz8bb4UIi
         CtRp2s4R9Dfx8SR+/6pqNUFOSUDSdNV0AHEK1SMiSu1GYi26Lb79EpwCbH9imaCPk/0M
         LMn6osr7u8ibI3cblIv+EsJJlIGtSKaM/u6Nvm03GL3bDW/9BIyWBUXc/RfoKZgNzfeb
         pkOsuOWiCj8XH/YKbm6p7yhvEwkDTq+HEG1iMDIZBxquhQeE7vutmrbO31fpG9OYEy6J
         zaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSU4G4kSlLWXiPBaMW02ODkfbVkf/tTHpbTDdl1Sj+vd+hwjL8At/Yr04J35obHSa/gOSIgrG/dwomBiH5waqj5DK4DnCWC8UTjiKe0mE=
X-Gm-Message-State: AOJu0YxNz+b/nMxAqvLWUP0X50cVzMbsVuQjaJUTrRcO77TA4fVR6TnE
	smSlczoGUaXLczgA785TXFaXeBZEZ2szD/RqLGG4HBlYPb+HMVI1VF2Ciw==
X-Google-Smtp-Source: AGHT+IFuX/aRh+/2oeCaBxwgLCJAgVDmsxLq+dFmpsqq5OOpdob4L+PPh5M5IZYik62pZtZDjvVrxw==
X-Received: by 2002:a2e:8e90:0:b0:2ec:31d9:16e1 with SMTP id 38308e7fff4ca-2ee5e6e745emr24732201fa.5.1719822152602;
        Mon, 01 Jul 2024 01:22:32 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256f55c4b5sm128104555e9.43.2024.07.01.01.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:22:32 -0700 (PDT)
Message-ID: <f9828eb4-39be-498b-8b90-2cb7ce42d3c7@grimberg.me>
Date: Mon, 1 Jul 2024 11:22:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
 <20240701074245.73348-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701074245.73348-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_012234_765314_C7499E04 
X-CRM114-Status: GOOD (  26.66  )
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



On 01/07/2024 10:42, Ping Gan wrote:
>> Hey Ping Gan,
>>
>>
>> On 26/06/2024 11:28, Ping Gan wrote:
>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>> TCP use kworker to handle IO. But if there is other high workload
>>> in the system(eg: on kubernetes), the competition between the
>>> kworker and other workload is very radical. And since the kworker
>>> is scheduled by OS randomly, it's difficult to control OS resource
>>> and also tune the performance. If target support to use delicated
>>> polling task to handle IO, it's useful to control OS resource and
>>> gain good performance. So it makes sense to add polling task in
>>> rdma-rdma and rdma-tcp modules.
>> This is NOT the way to go here.
>>
>> Both rdma and tcp are driven from workqueue context, which are bound
>> workqueues.
>>
>> So there are two ways to go here:
>> 1. Add generic port cpuset and use that to direct traffic to the
>> appropriate set of cores
>> (i.e. select an appropriate comp_vector for rdma and add an appropriate
>> steering rule
>> for tcp).
>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow users
>> to
>> control
>> these UNBOUND workqueues cpumask via sysfs.
>>
>> (2) will not control interrupts to steer to other workloads cpus, but
>> the handlers may
>> run on a set of dedicated cpus.
>>
>> (1) is a better solution, but harder to implement.
>>
>> You also should look into nvmet-fc as well (and nvmet-loop for that
>> matter).
> hi Sagi Grimberg,
> Thanks for your reply, actually we had tried the first advice you
> suggested, but we found the performance was poor when using spdk
> as initiator.

I suggest that you focus on that instead of what you proposed.
What is the source of your poor performance?

>   You know this patch is not only resolving OS resource
> competition issue, but also the perf issue. We have analyzed if we
> still use workqueue(kworker) as target when initiator is polling
> driver(eg: spdk), then workqueue/kworker target is the bottleneck
> since every nvmf request may have a wait latency from queuing on
> workqueue to begin processing,

That is incorrect, the work context polls the cq until it either drains it
completely, or exhaust a quota of IB_POLL_BUDGET_WORKQUEUE (or
NVMET_TCP_IO_WORK_BUDGET). Not every command gets its own workqueue
queuing delay.

And, what does the spdk initiator has to do with it? Didn't understand...

>   and the latency can be traced by wqlat
> of bcc (https://github.com/iovisor/bcc/blob/master/tools/wqlat.py).
> We think the latency is a disaster for the polling driver data plane,
> right?

If you need a target that polls all the time, you should probably resort 
to spdk.
If there is room for optimization in nvmet we'll gladly take it, but 
this is not the
way to go IMO.

> So we think adding a polling task mode on nvmet side to handle
> IO does really make sense; what's your opinion about this?

I personally think that adding a polling kthread is questionable.
However there is a precedent, io_uring sqthreads. So please look
into what is done there. I don't mind having something like 
IB_POLL_IOTASK (or
io_task threads in nvmet-tcp) if its done correctly (leverages common code).

>   And you
> mentioned we should also look into nvmet-fc, I agree with you.
> However currently we have no nvmf-fc's testbed; if we get the testbed,
> will do that.

There is fcloop, you should use that to test, same for loop. We don't want
the transports to diverge in functionality.

