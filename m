Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF52C43334
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jul 2022 07:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VVI8npOEGe5tO/udmJvFICtsIfMpa9lX4aydEcHk/R8=; b=P3CqXStku78svFX+JM6lpiP4Sg
	IqoK7h8p7Pp6gmFjh4wEeZFVo8cD22t9OSu0P43jeqoicnvuxdofPGl2XPT7xExcjTBf8pQFOGDAO
	OEj4J9xu7sfGiaK+6h1nIAIGykFrQEiCRkPvM9tdLelYUOPQxSYBJrwXER4mzxq0yvFwRFWO1wf30
	35ovjxj8fqqJ/3yMKt4TiKpu/Y6Yh8Ct1EX/rqyJRWfGldBcLM6malFC24rI26l9UpOIgRfREXrwq
	WSFkaNkIr4N66U4J2VYDzKDXtTwFTWUrrIDOa0t48AX95Drg5IQk3EmhzYVuVfpYuZ+Skkt4sOMAC
	yHqL0NuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Lw6-00EYZe-LP; Thu, 07 Jul 2022 07:28:30 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Lw3-00EYUj-Ga
	for linux-nvme@lists.infradead.org; Thu, 07 Jul 2022 07:28:28 +0000
Received: by mail-wm1-f52.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso10175499wmq.4
        for <linux-nvme@lists.infradead.org>; Thu, 07 Jul 2022 00:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VVI8npOEGe5tO/udmJvFICtsIfMpa9lX4aydEcHk/R8=;
        b=pb5YHFEfTNcCylgcj9T+H+3F40hyeytXvgTgvcWM0NAMLJKJsn8XJTUIh2Oe3x47cJ
         KPSZ6v/4AvOjr3OPaFW+iuyu9D2NQrjwC3482KGloTwKAou5SDce3IhrJIuUL3EHu1fH
         Kt60d3TWd4FiLgqgVq6SaIhMflImV5pZFfkIqYyq6ZTI0/r0CTl5yTT1bP4BjVe7PazD
         Wh8RP5e6+qgyOeG9DfivaqfjdYvaIpGEj178C6rf2gt3fwX1KzhjzIb0nl6V3hiN8K1U
         drawv+zuGTUHDgP1MuACwFmJpFTTvHgleRCxcSH++mE57mbH+hdothk/pN+hACBNNgQu
         Sdog==
X-Gm-Message-State: AJIora+D6UQF4lq52nfFCoLl70H9y2i/ay/ElemBsvuAHePzAWJE8MHt
	Z8uowhPJPn3XwieHO5xsEgSXCjEsIqk=
X-Google-Smtp-Source: AGRyM1sTj4WPOZuLo4cv7u8yFyb8NRjaD+uG2mjCteI506sayaF99ruHwkad25iWl5f/zL3oHELaUA==
X-Received: by 2002:a7b:c2aa:0:b0:39c:9039:e74b with SMTP id c10-20020a7bc2aa000000b0039c9039e74bmr2773680wmk.127.1657178903595;
        Thu, 07 Jul 2022 00:28:23 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id ay26-20020a5d6f1a000000b0021baf5e590dsm37511413wrb.71.2022.07.07.00.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 00:28:23 -0700 (PDT)
Message-ID: <6c79d36f-1e74-c3b9-bded-0b1f7223dead@grimberg.me>
Date: Thu, 7 Jul 2022 10:28:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one cpu
 on host side
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
 <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
 <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me> <YsOKnb7MWLCeJxBE@T590>
 <0a8099e6-6e28-da1f-7b4b-0ea04fa8f9d6@grimberg.me> <YsY64iMxnLtucKsP@T590>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YsY64iMxnLtucKsP@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_002827_598331_12F38DFF 
X-CRM114-Status: GOOD (  23.16  )
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


>>>>> update the subject to better describe the issue:
>>>>>
>>>>> So I tried this issue on one nvme/rdma environment, and it was also
>>>>> reproducible, here are the steps:
>>>>>
>>>>> # echo 0 >/sys/devices/system/cpu/cpu0/online
>>>>> # dmesg | tail -10
>>>>> [  781.577235] smpboot: CPU 0 is now offline
>>>>> # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
>>>>> Failed to write to /dev/nvme-fabrics: Invalid cross-device link
>>>>> no controller found: failed to write to nvme-fabrics device
>>>>>
>>>>> # dmesg
>>>>> [  781.577235] smpboot: CPU 0 is now offline
>>>>> [  799.471627] nvme nvme0: creating 39 I/O queues.
>>>>> [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
>>>>> [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
>>>>> [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18
>>>>
>>>> This is because of blk_mq_alloc_request_hctx() and was raised before.
>>>>
>>>> IIRC there was reluctance to make it allocate a request for an hctx even
>>>> if its associated mapped cpu is offline.
>>>>
>>>> The latest attempt was from Ming:
>>>> [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
>>>>
>>>> Don't know where that went tho...
>>>
>>> The attempt relies on that the queue for connecting io queue uses
>>> non-admined irq, unfortunately that can't be true for all drivers,
>>> so that way can't go.
>>
>> The only consumer is nvme-fabrics, so others don't matter.
>> Maybe we need a different interface that allows this relaxation.
>>
>>> So far, I'd suggest to fix nvme_*_connect_io_queues() to ignore failed
>>> io queue, then the nvme host still can be setup with less io queues.
>>
>> What happens when the CPU comes back? Not sure we can simply ignore it.
> 
> Anyway, it is a not good choice to fail the whole controller if only one
> queue can't be connected. 

That is irrelevant.

> I meant the queue can be kept as non-LIVE, and
> it should work since no any io can be issued to this queue when it is
> non-LIVE.

The way that nvme-pci behaves is to create all the queues and either
have them idle when their mapped cpu is offline, and have the queue
there and ready when the cpu comes back. It is the simpler approach and
I would like to have it for fabrics too, but to establish a fabrics
queue we need to send a request (connect) to the controller. The fact
that we cannot simply get a reference to a request for a given hw queue
is baffling to me.

> Just wondering why we can't re-connect the io queue and set LIVE after
> any CPU in the this hctx->cpumask becomes online? blk-mq could add one
> pair of callbacks for driver for handing this queue change.
Certainly possible, but you are creating yet another interface solely
for nvme-fabrics that covers up for the existing interface that does not
satisfy what nvme-fabrics (the only consumer of it) would like it to do.

