Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F727C27C7A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VKVBrbvbP9Oupg0joHd510erKz/6C9X7ZSFzGxfVxCs=; b=UsggBtSD8aYuWScuwYeG9QC/C2
	hDjezqeItvd3DfrJRIZas2I+7vJiIwLHvFa4npEiL0AAhh2xfbzs5vy8faoTNdHTMTkXJMR1vTJ2Y
	McTiq7ig1vpIRTRtHpKr3sL/psDqzcfrxJL5PmgfOQGaT8M9N735dt/MThtCPMgmG2/ayEqCN5g08
	zoOeE12h5p7YkZMy970WFz9SCkfxBc///5xM/fMZ8qOknq9zaqqSwTAlQoYRWCLnBYbGlh6zt404p
	tkrmewFE63Yo0tQQOEHiWdy+AXQfHYf5m16FPj0rL7p+2ZytMeCGsKzuQ+d1MmNl3WVh9NLY4iOF5
	KMy7G32A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWb3X-006Fus-36;
	Thu, 17 Aug 2023 11:20:47 +0000
Received: from mail-lj1-f170.google.com ([209.85.208.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWb3V-006FuP-0h
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 11:20:46 +0000
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b70357ca12so20683601fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 04:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692271243; x=1692876043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKVBrbvbP9Oupg0joHd510erKz/6C9X7ZSFzGxfVxCs=;
        b=f4irDvDE5qr4915hFbD9KQAtTZw+Vbubcf+TZv2fBX0iuSypTaMBvpuNM0W5mQArsH
         nelT++zKxke5JVlU0uI8AKXiaur9ZeJ1eWpZEKDeKxzV/IexQT4zH/YadxccBlrHdWMb
         qVnLdectXov72YFfLZ/OpkoJxDhETWa+V77Dp8rfx5LHHxFItVmMfvD4Dp0CWwcLqVKQ
         jPf8EtEyTQ1ns1Osi5C70j9SjMcaaYTocPvxgwzCev/fILy+IvjcHkICKytV828Hlgru
         0LRCro/qXIMCVOFAz/MO5oaYkeYIBUKtUTE3vanaAAitmOQPGsQKzHk46cslRlGx8hrX
         7pjQ==
X-Gm-Message-State: AOJu0YzO1ya/Es9xbvdZcevrd313O7UjadCF93JFm21tRPSrMRx8m+1a
	h4j/VK5oUWJl4RSUWwrGVyY=
X-Google-Smtp-Source: AGHT+IF+CTJPaNtiofCAHgQVASPWlCRrfB+TpFFSuMO/8IfBvLL0CT1ercX68aytlDZcU6yu04Q03w==
X-Received: by 2002:a05:651c:1506:b0:2b9:a156:6239 with SMTP id e6-20020a05651c150600b002b9a1566239mr4734088ljf.1.1692271243257;
        Thu, 17 Aug 2023 04:20:43 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906379300b00992b8d56f3asm9910883ejc.105.2023.08.17.04.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 04:20:42 -0700 (PDT)
Message-ID: <effe2141-2f4b-ef06-786b-4344509c1271@grimberg.me>
Date: Thu, 17 Aug 2023 14:20:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230810132006.129365-1-hare@suse.de>
 <05b7479a-5243-00fb-4a5a-a063bce65378@grimberg.me>
 <48e9b2a7-fcaf-acfe-0819-3a484bf90dc3@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <48e9b2a7-fcaf-acfe-0819-3a484bf90dc3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_042045_277482_BFEA5CF1 
X-CRM114-Status: GOOD (  20.47  )
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


>> On 8/10/23 16:20, Hannes Reinecke wrote:
>>> nvmet_tcp_install_queue() is driven from the ->io_work workqueue
>>> function, but will call flush_workqueue() which might trigger
>>> ->release_work() which in itself calls flush_work on ->io_work.
>>>
>>> To avoid that check for pending queue in disconnecting status,
>>> and return 'controller busy' until all disconnects are completed.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/target/tcp.c | 14 ++++++++++++--
>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index f131b504aa01..97d07488072d 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -1845,8 +1845,18 @@ static u16 nvmet_tcp_install_queue(struct 
>>> nvmet_sq *sq)
>>>           container_of(sq, struct nvmet_tcp_queue, nvme_sq);
>>>       if (sq->qid == 0) {
>>> -        /* Let inflight controller teardown complete */
>>> -        flush_workqueue(nvmet_wq);
>>> +        struct nvmet_tcp_queue *q;
>>> +        int pending = 0;
>>> +
>>> +        mutex_lock(&nvmet_tcp_queue_mutex);
>>> +        list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
>>> +            if (q->state == NVMET_TCP_Q_DISCONNECTING)
>>> +                pending++;
>>> +        }
>>> +        mutex_unlock(&nvmet_tcp_queue_mutex);
>>> +        /* Retry for pending controller teardown */
>>> +        if (pending)
>>> +            return NVME_SC_CONNECT_CTRL_BUSY;
>>
>> Overall I'm fine with the approach.
>>
>> That will most likely be the case for a controller reset or a "reset
>> storm". Maybe it is better to keep it at some reasonably allowed pending
>> to say 10 or something... The whole point is to not let the removals
>> accumulate and continue creating new ones...
>>
>> Can you please test this with a host that does a loop like:
>> while true; do nvme reset /dev/nvme0; done
>>
>> And let it run for some time...
>> Or even better create a test that does this for 100 iterations
>> or a log/short variants of this?
>>
>> The same would be needed by nvmet-rdma btw.
> 
> Retested with the reset loop; no issues found after 327 iterations.

Interesting, did the host see a NVME_SC_CONNECT_CTRL_BUSY  during the
test?

