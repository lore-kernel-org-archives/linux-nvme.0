Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27F2C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IL3I2VC9Ztv1pk0xbZ/Eoy+k4QIkWLL01eX5Z3aiZlU=; b=EmRFtdLdhdVLDMUMjS046sw7rv
	UoA6YArb8TRgbOX/C2qbhTqIkkLeJ/omNo6aPAmbRK3EUB1b5ECpf/OrQtjGdX25deflzI4n0lZYB
	UJFiE5ZmdI4HicU56Osz7ooTa6wU2DtM8WXm/KBULyMy+1bxsB6SfklAQUsbKgCy/y5B4p+CPy9Se
	BzeZyaT7q/fakxlvzeAk3sSTiC8nS5T4EDXpvcF/Gn+5YkvqWtNnsqF3N8Ju7wXIepMZ2XdOBsOup
	6JoNba74PWEw5OUeG6veBsU6Jbk69BCH1PhdYJbtocXdUPcwZdgwXVV4BK1X7e7NL7SYX/2DpDZWm
	z8Rf7qTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGGMc-00Aev2-Pt; Tue, 26 Jul 2022 08:56:26 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGGMZ-00AemG-QD
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 08:56:25 +0000
Received: by mail-ed1-f50.google.com with SMTP id c12so9546898ede.3
        for <linux-nvme@lists.infradead.org>; Tue, 26 Jul 2022 01:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IL3I2VC9Ztv1pk0xbZ/Eoy+k4QIkWLL01eX5Z3aiZlU=;
        b=uGDuCX04qf90aHRHXQMSvpb45NiHC3kkynlEKPosmWSYq69FN7dJF0Ngy8iz+EXfrx
         vJakJEhwsV43HRnru5DUqGMI8IP1h3ryrQmPDh80fs8ciGmTOn5jdVugQfoO2Ow1ihH5
         GFi6hXB5WUd21xAdZK4SACfDiQKo6p7mUdHTSPp2gnMgaFldG+UtJaPEnAx5aRf8CK6V
         NZfzh8U2F8X9yyrDr7Fy3fyoC/P67xVh5KQHKnKsYecnPg3uZJ3tjmaYRfyrXKl9jxtT
         jBZFNq34/1dub2rRuX1NHYcuJCoZ0z4kjxmZPtktMh6x35NnBDwbpkwoL+l9kOONgWj4
         E7oA==
X-Gm-Message-State: AJIora838fm5hLoQhzLZxVVyvqYCz5esT7LgiYu6ukYIkDXpl3UfnMlE
	dL1Xa6POu3Pu1C2MLkorK/oxoBUtaSw=
X-Google-Smtp-Source: AGRyM1vwr6uJJEcno016UfHChNmuVhNtBmgvr4KWwXvqieAbTOyOBzA03ISCpv51m++pveWQqW5V9Q==
X-Received: by 2002:aa7:de85:0:b0:43a:d89f:1c7b with SMTP id j5-20020aa7de85000000b0043ad89f1c7bmr17261129edv.17.1658825781116;
        Tue, 26 Jul 2022 01:56:21 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id p12-20020a05640210cc00b0043c83ac66e3sm267703edu.92.2022.07.26.01.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 01:56:20 -0700 (PDT)
Message-ID: <5bd886f1-a7c6-b765-da29-777be0328bc2@grimberg.me>
Date: Tue, 26 Jul 2022 11:56:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
 <6c79d36f-1e74-c3b9-bded-0b1f7223dead@grimberg.me> <Yt9L9iGrkhDnK9aq@T590>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Yt9L9iGrkhDnK9aq@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_015623_886450_B8D180F3 
X-CRM114-Status: GOOD (  32.85  )
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



On 7/26/22 05:05, Ming Lei wrote:
> On Thu, Jul 07, 2022 at 10:28:22AM +0300, Sagi Grimberg wrote:
>>
>>>>>>> update the subject to better describe the issue:
>>>>>>>
>>>>>>> So I tried this issue on one nvme/rdma environment, and it was also
>>>>>>> reproducible, here are the steps:
>>>>>>>
>>>>>>> # echo 0 >/sys/devices/system/cpu/cpu0/online
>>>>>>> # dmesg | tail -10
>>>>>>> [  781.577235] smpboot: CPU 0 is now offline
>>>>>>> # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
>>>>>>> Failed to write to /dev/nvme-fabrics: Invalid cross-device link
>>>>>>> no controller found: failed to write to nvme-fabrics device
>>>>>>>
>>>>>>> # dmesg
>>>>>>> [  781.577235] smpboot: CPU 0 is now offline
>>>>>>> [  799.471627] nvme nvme0: creating 39 I/O queues.
>>>>>>> [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
>>>>>>> [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
>>>>>>> [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18
>>>>>>
>>>>>> This is because of blk_mq_alloc_request_hctx() and was raised before.
>>>>>>
>>>>>> IIRC there was reluctance to make it allocate a request for an hctx even
>>>>>> if its associated mapped cpu is offline.
>>>>>>
>>>>>> The latest attempt was from Ming:
>>>>>> [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
>>>>>>
>>>>>> Don't know where that went tho...
>>>>>
>>>>> The attempt relies on that the queue for connecting io queue uses
>>>>> non-admined irq, unfortunately that can't be true for all drivers,
>>>>> so that way can't go.
>>>>
>>>> The only consumer is nvme-fabrics, so others don't matter.
>>>> Maybe we need a different interface that allows this relaxation.
>>>>
>>>>> So far, I'd suggest to fix nvme_*_connect_io_queues() to ignore failed
>>>>> io queue, then the nvme host still can be setup with less io queues.
>>>>
>>>> What happens when the CPU comes back? Not sure we can simply ignore it.
>>>
>>> Anyway, it is a not good choice to fail the whole controller if only one
>>> queue can't be connected.
>>
>> That is irrelevant.
>>
>>> I meant the queue can be kept as non-LIVE, and
>>> it should work since no any io can be issued to this queue when it is
>>> non-LIVE.
>>
>> The way that nvme-pci behaves is to create all the queues and either
>> have them idle when their mapped cpu is offline, and have the queue
>> there and ready when the cpu comes back. It is the simpler approach and
>> I would like to have it for fabrics too, but to establish a fabrics
>> queue we need to send a request (connect) to the controller. The fact
>> that we cannot simply get a reference to a request for a given hw queue
>> is baffling to me.
>>
>>> Just wondering why we can't re-connect the io queue and set LIVE after
>>> any CPU in the this hctx->cpumask becomes online? blk-mq could add one
>>> pair of callbacks for driver for handing this queue change.
>> Certainly possible, but you are creating yet another interface solely
>> for nvme-fabrics that covers up for the existing interface that does not
>> satisfy what nvme-fabrics (the only consumer of it) would like it to do.
> 
> I guess you meant that the others(rdma and tcp) use non-managed queue,
> so they needn't such change?
> 
> But it isn't true actually, blk-mq/nvme still can't handle it well. From
> blk-mq's viewpoint, if all CPUs in hctx->cpumask are offline, it will
> treat the hctx as inactive and not workable, and refuses to allocate
> request from this hctx, no matter if the underlying queue irq is managed
> or not.
> 
> Now after 14dc7a18abbe ("block: Fix handling of offline queues in
> blk_mq_alloc_request_hctx(), it may break controller setup easily if
> any CPU is offline.
> 
> I'd suggest to fix the issue in unified way since nvme-fabric needs to be
> covered, then nvme's user experience can be improved.

That is exactly what I want, but unlike pcie, nvmf creates the queue
using a connect request that is not driven from a user context. Hence
it would be nice to have an interface to get it done.

The alternative would be to make nvmf connect not use blk-mq, but that
is not a good alternative in my mind. Having a callback interface for
cpu hotplug is just another interface that every transport will need
to implement, and it makes nvmf different than pci.

> BTW, I guess rdma/tcp/fc's queue may take extra or bigger resources than
> nvme pci, if resource are only allocated until the queue is active, queue
> resource utilization may be improved.

That is not a concern what-so-ever. Queue resources are cheap enough
that we shouldn't have to care about it in this scale.

