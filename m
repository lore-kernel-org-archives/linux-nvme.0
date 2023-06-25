Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC06EB64DC
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Jun 2023 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qwfLjyoUz3ZDqsKQEVoGFsXw4nHaaBvsnDikn6HJhJo=; b=BAeU5sL0k9TJeHfsHjLFokMBIu
	MIWLohyIvESiOdqEboiloUt3/F93xM1vN4NjCwI3iGnhhIobxRH8XdoqbYL8iPTFC34NzR4AJzxd5
	Y+hdcbphRh73SRKrCIHk9oW3lyYt8AwWXhyTsCAdsjtCSI5cZEZ8g8cggW6f4AocTl4EWY2S6srq2
	KdPbkst427o5cUw+xKV1cwf/XzLqQI8L/M1XSM8uzt0052XBLUqkHbBw6VG0CEjW7d6DEtiEjnaRP
	wldqnPkkqGyIxWdck3KDFXv74q6Zlw4v3Zh6V0ixkAIu7fRwVS6b4F5QBKvKf3w/A/U3X9GW0ig7i
	O/4yMb/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDKoo-007Rep-0c;
	Sun, 25 Jun 2023 08:09:58 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDKol-007Rdw-0H
	for linux-nvme@lists.infradead.org;
	Sun, 25 Jun 2023 08:09:56 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-31114d47414so618498f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 25 Jun 2023 01:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687680588; x=1690272588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwfLjyoUz3ZDqsKQEVoGFsXw4nHaaBvsnDikn6HJhJo=;
        b=NHnAiJ/R5LidtupcLIaAmPFHGlxyObp+DvDAVlkf3baj/oga8BCI5jsnG1TfdtnqRP
         8Kocc0VSShSJXzkUNGQjSzLp8WxgchKdsjuzsfMdVjbSo/uFuOtnNL9CCb7APlKP0QDi
         uE+ZeM9iXwQXOV0zOAW2s/UdU49PhZl/Arb2eN3xNhlmBHVHqLRyT1QIkpfQ0JBRTU1b
         aYq7IfHS1iDTzHkqaiOeRkTW2OawsHe3Exv5dDbcEKFmUY+roCHZ26AwrICgXhqtyRDH
         YOX8ld1UMsau/leD2T1LwR+MmYbLYVwM329bSySeteMYcAG9bcam/hTPmNYO7gMGDIMX
         lOSw==
X-Gm-Message-State: AC+VfDz21OxOxc5+HF1egLpUvpf/I6pCDxF5dPkGdebmSSVsmDJgkT2E
	ZS5hLjLz/dPxngVcDOiUzAk=
X-Google-Smtp-Source: ACHHUZ5FjGgKnKoBXfpyo3JNxXwqBqUImEJ7SWTVZRMv+JkraYho9UCyjCeDUcSyrIuSt63wjnkAuA==
X-Received: by 2002:a5d:468d:0:b0:30a:d0a0:266e with SMTP id u13-20020a5d468d000000b0030ad0a0266emr24109094wrq.2.1687680587578;
        Sun, 25 Jun 2023 01:09:47 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm3980931wrv.74.2023.06.25.01.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 01:09:46 -0700 (PDT)
Message-ID: <643f1f34-e88b-0e79-3834-62884b614008@grimberg.me>
Date: Sun, 25 Jun 2023 11:09:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
 linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
References: <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_010955_127262_31A691BA 
X-CRM114-Status: GOOD (  23.66  )
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


>>>>>> The point was to contain requests from entering while the hctx's are
>>>>>> being reconfigured. If you're going to pair up the freezes as you've
>>>>>> suggested, we might as well just not call freeze at all.
>>>>>
>>>>> blk_mq_update_nr_hw_queues() requires queue to be frozen.
>>>>
>>>> It's too late at that point. Let's work through a real example. You'll
>>>> need a system that has more CPU's than your nvme has IO queues.
>>>>
>>>> Boot without any special nvme parameters. Every possible nvme IO queue
>>>> will be assigned "default" hctx type. Now start IO to every queue, then
>>>> run:
>>>>
>>>>    # echo 8 > /sys/modules/nvme/parameters/poll_queues && echo 1 > /sys/class/nvme/nvme0/reset_controller
>>>>
>>>> Today, we freeze prior to tearing down the "default" IO queues, so
>>>> there's nothing entered into them while the driver reconfigures the
>>>> queues.
>>>
>>> nvme_start_freeze() just prevents new IO from being queued, and old ones
>>> may still be entering block layer queue, and what matters here is
>>> actually quiesce, which prevents new IO from being queued to
>>> driver/hardware.
>>>
>>>>
>>>> What you're suggesting will allow IO to queue up in a queisced "default"
>>>> queue, which will become "polled" without an interrupt hanlder on the
>>>> other side of the reset. The application doesn't know that, so the IO
>>>> you're allowing to queue up will time out.
>>>
>>> time out only happens after the request is queued to driver/hardware, or after
>>> blk_mq_start_request() is called in nvme_queue_rq(), but quiesce actually
>>> prevents new IOs from being dispatched to driver or be queued via .queue_rq(),
>>> meantime old requests have been canceled, so no any request can be
>>> timed out.
>>
>> Quiesce doesn't prevent requests from entering an hctx, and you can't
>> back it out to put on another hctx later. It doesn't matter that you
>> haven't dispatched it to hardware yet. The request's queue was set the
>> moment it was allocated, so after you unquiesce and freeze for the new
>> queue mapping, the requests previously blocked on quiesce will time out
>> in the scenario I've described.
>>
>> There are certainly gaps in the existing code where error'ed requests
>> can be requeued or stuck elsewhere and hit the exact same problem, but
>> the current way at least tries to contain it.
> 
> Yeah, but you can't remove the gap at all with start_freeze, that said
> the current code has to live with the situation of new mapping change
> and old request with old mapping.
> 
> Actually I considered to handle this kind of situation before, one approach
> is to reuse the bio steal logic taken in nvme mpath:
> 
> 1) for FS IO, re-submit bios, meantime free request
> 
> 2) for PT request, simply fail it
> 
> It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
> always set for PT request, but not see any better approach for handling
> PT request.

Ming,

I suggest to submit patches for tcp/rdma and continue the discussion on
the pci driver.

