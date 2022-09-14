Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A6BC6FA82
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2gDVRq3srDI2R1bWASYe9RkJbghch99up4dL59sZFF0=; b=vx2CWFsHH1k9tA4AfR+Bk9PVNk
	K+6OsONNWS35Xdbe5D0lDbkXKRc9uJedk05pRDaj8IcoSucwhWf8qXjuW/yy0nR+3KORRapu+N3jB
	CdiCxbffsHUg1wavEc5U4tX+pqxEkZSCW+ekPcVn/6F3vHYVaI07HFMBR08+/AF2/5XiwBeddVzQE
	BBP9ZH6KuJzTbO2zy/sBQThVslhASuqqOSwFHaSDSH0TB/jtewtMjK7FQgVwk/qCgMU0ZSeQDEBx8
	xj5ljz0o7jiTtrxNK4DKeBOMm1n6uCZNEAO+UdP4QWKrhRUWBqgIAPl6n1PS/drpSNtkl3PMM84A9
	9YOYkJLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYUMB-003utB-PD; Wed, 14 Sep 2022 15:31:19 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYUM7-003umR-O1
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 15:31:17 +0000
Received: by mail-wr1-f41.google.com with SMTP id t7so26258831wrm.10
        for <linux-nvme@lists.infradead.org>; Wed, 14 Sep 2022 08:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2gDVRq3srDI2R1bWASYe9RkJbghch99up4dL59sZFF0=;
        b=ETKVXlNKhY2zEnR+ExnEQnPtor58UIgAbDl9ESgFv80kCK6GY90L7Oy/p0fMu7uNlb
         i9Bxzcg5x6Gmk1jM7z3hmgo75pNKU5O5kHIbd4ATk3MGIsu0gFym8BNs2dGA+J/Pr3Tw
         6/VseJ7u8OfIuYi4SlIUMqz8jgOF3cRdypeooXojBBLmRSlS96O9xH9xfU26G6BP0xTZ
         MPlymGpv7cvFEjROJqNOPZ6s9e14TIb8TP/qb6EE+CoxpjXQzMr3yE29oTgEolwKBQY1
         NzR9KUyBi2ii5JhisFYpfeZ4k4PvEPnRsMt9Yo+CcE7inVNfxUlYDG2tyXlz2gz6xv/Y
         zDBg==
X-Gm-Message-State: ACgBeo0ykD04xwvGHierZG2HzjQi9d3yb+i9a/Lj7wPn9En+L0Tib4BW
	D1PolY1fAFD46oN4jezeWas=
X-Google-Smtp-Source: AA6agR5Z4buPH2WWVRa81VXm19Pd1HVjJgz347zKT8XSpfCzKWIxiwH/V82U4zEXp8lw6jL2AM7xAA==
X-Received: by 2002:a5d:4745:0:b0:228:d9ec:6b5d with SMTP id o5-20020a5d4745000000b00228d9ec6b5dmr22235483wrs.257.1663169471502;
        Wed, 14 Sep 2022 08:31:11 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c4f5600b003a83ca67f73sm20120871wmq.3.2022.09.14.08.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 08:31:10 -0700 (PDT)
Message-ID: <0d34d7e9-b5e1-149c-aefd-aa3bf182ad94@grimberg.me>
Date: Wed, 14 Sep 2022 18:31:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
 <403e19c8-fec9-2d5c-157c-cdcb4fc2fbf0@grimberg.me>
 <27194422-3759-928e-c88e-c5d10feeba5b@gmail.com>
 <bf83b747-e6b5-57fb-0de7-e2fb646633aa@grimberg.me>
 <73b6631a-1ec5-5a46-8f2a-f816acdeb97d@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <73b6631a-1ec5-5a46-8f2a-f816acdeb97d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_083115_801893_509BC7E1 
X-CRM114-Status: GOOD (  34.32  )
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



On 9/14/22 18:00, James Smart wrote:
> On 9/14/2022 3:29 AM, Sagi Grimberg wrote:
>>
>>> I was thinking this rather than the new option... The bit would only 
>>> be set *after* the first successful link-side connect, thus the 
>>> initial nvme_start_ctrl would not send the reconnect event. Every 
>>> reconnect thereafter would.
>>>
>>> -- james
>>>
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 2429b11eb9a8..43c8b6590164 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -4814,6 +4814,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>>>
>>>       nvme_enable_aen(ctrl);
>>>
>>> +    if (nvme_discovery_ctrl(ctrl) &&
>>> +        test_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->flags))
>>> +        nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
>>> +
>>>       if (ctrl->queue_count > 1) {
>>>           nvme_queue_scan(ctrl);
>>>           nvme_start_queues(ctrl);
>>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>>> index 127abaf9ba5d..ff1dd8f999b0 100644
>>> --- a/drivers/nvme/host/fc.c
>>> +++ b/drivers/nvme/host/fc.c
>>> @@ -2947,6 +2947,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl 
>>> *ctrl)
>>>           goto out_delete_hw_queues;
>>>
>>>       ctrl->ioq_live = true;
>>> +    set_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->ctrl.flags);
>>
>> Isn't this set before calling nvme_start_ctrl()?
> 
> frick - sent the wrong tweak for fc:
> 
> this should be:
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 127abaf9ba5d..630d8e50f29c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3201,6 +3201,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>          if (changed)
>                  nvme_start_ctrl(&ctrl->ctrl);
> 
> +       set_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->ctrl.flags);
> +
>          return 0;       /* Success */
> 
>   out_term_aen_ops:
> 
> 
> So in all cases, it's now set immediately after calling nvme_start_ctrl. 
> Won't be set on 1st call but will be all on all reamaing.

I would rename it as NVME_CTRL_STARTED_ONCE or something. I feel that
every name we choose would be kinda ugly, which is why I opted to
relying on nr_reconnects that the transports maintain.

But again, all of this is orthogonal to the connect parameter question.

>> But this is orthogonal to the user argument, is there a specific
>> reason to why not add an explicit argument requesting that?
>> Because every userspace that will setup a persistent discovery
>> controller will need this event?
> 
> Well my aversion is to remove relationships between user-space and 
> kernel.  It seemed very odd to go to user-space to then set a custom 
> option and this handshaking looked like a lot of work vs just generating 
> a reconnect event on a discovery controller.
> 
> In my mind think we should be doing one of the following:
> a) generate connect and reconnect events generically. If they are 
> handled, great, if not that's fine. Handler is free to filter by device 
> attributes as to what it does

I can understand this approach. A persistent discovery controller that
reconnects, needs to send an indication to userspace universally because
someone always needs to rediscover as a result.

What do others think? Martin?

> I assume there's some issue here that you saw with the original attempt 
> as reconnects may post while connects or reconnects are still being 
> handled.
> 
> b) go down the path of the rediscover option - but the kernel routine 
> should never require it to be a discovery controller. If the option is 
> set, send the rediscover event. Removes events that won't be handled.
> The filtering in the lib to only set the option on devices that the lib 
> cares about can continue.

The fact that the event is called rediscover semantically means that
this is the discovery controller. It would be weird coming on any other
controller, even if userspace happened to ask for it. If at all, I'd
prefer to fail the parameter for controllers that are not discovery
controller, which is strict, but at least not resulting in a weird
event...

