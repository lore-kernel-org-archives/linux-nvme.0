Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6B6EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5cHAlu3wlDPkcsIRxP0pC/qLWsIolHiA0p40N7QDq8=; b=Y6haiXHc/ULmjjwzho8fIb8Gwm
	SBeK2h9eFfUfSgQ7waFO64V4zEL1vTfOvAZn+oEkj6fTGtEm8LgHupnr7gK7p0pxcSxMeLFd8V2cf
	ESGqUuU+1W6Q7bunxx/IymbILXnMpPdqDcuysLtDZx1f78avYAxPTT251IHkNRb0/Mu/gSHEzq3N9
	JPo2syjL8f+T3mJtUsBjMxF7IZ0xbCmrVeeCY7XciqlPM8nPOXvxzezQyjI7nnFpnQ+YMT87vqCWV
	Y/z7BdMynaRiqtsYvtYihN7hfNWZD2HlTnNd+HBdGx2+w3ztAbkK+AXlCpeOzHEKodkmOwEyEKat5
	TZ2GkbsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWbPf-006IX9-0n;
	Thu, 17 Aug 2023 11:43:39 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWbPb-006IQX-2Y
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 11:43:37 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3177d3bdfb3so1388097f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 04:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692272613; x=1692877413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5cHAlu3wlDPkcsIRxP0pC/qLWsIolHiA0p40N7QDq8=;
        b=TBG2J3EtfY2Eb/sUIIMOfzFkhlbz9K0jO2xNUvmT53YaNmTz/lNstA0L1ezydrGnw5
         FImLl5i8q0iY8VA0Yc5AoQmJK+ps6u6q9+ZLSvzp05MOmuBsvbLEGt1o+qx4jj/9lonL
         JqxofWcPmCJaUC4VfiQkXCm4ydTGrj5cKJlq6+gz7CFdqbExzltLJZL85Jdld3WyypGo
         /VcCJ42kDSwZ87KnmsakHm0lGbc6bSoOQ3TD39kz8LHRGZ6TPgHSxw2DV4SkP+aDNCKF
         U+94WRz5F2HRjYaPbYfpnSw7PFJ8NBjLy4B9dYBCrfNezbvzvzxLLh7GcBY5FS/5KcXu
         Vbkg==
X-Gm-Message-State: AOJu0Yz8foZ/q2Fj0lnvX5EA9tWMT1IVIvN9hiwhikXzfs+iwhTylDt3
	3sPtkhL5jEz59rZMprNGTW4=
X-Google-Smtp-Source: AGHT+IEyc5AOB6gO+TJN7fHJz+umgQBK9lKB10GFEhvuLoL7Rufik25RSbDAq8rxXtHNFhtWX9SEzw==
X-Received: by 2002:a5d:53cb:0:b0:317:5af3:ca98 with SMTP id a11-20020a5d53cb000000b003175af3ca98mr4049854wrw.6.1692272612876;
        Thu, 17 Aug 2023 04:43:32 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b11-20020adfde0b000000b003197e3520ddsm11465369wrm.109.2023.08.17.04.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 04:43:32 -0700 (PDT)
Message-ID: <991c763f-4e16-8737-13ca-4784ab073b83@grimberg.me>
Date: Thu, 17 Aug 2023 14:43:29 +0300
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
 <effe2141-2f4b-ef06-786b-4344509c1271@grimberg.me>
 <b2e12d07-c894-8af4-9433-8308939a96a5@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b2e12d07-c894-8af4-9433-8308939a96a5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_044335_828119_E1A14B48 
X-CRM114-Status: GOOD (  19.72  )
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


>>>>> nvmet_tcp_install_queue() is driven from the ->io_work workqueue
>>>>> function, but will call flush_workqueue() which might trigger
>>>>> ->release_work() which in itself calls flush_work on ->io_work.
>>>>>
>>>>> To avoid that check for pending queue in disconnecting status,
>>>>> and return 'controller busy' until all disconnects are completed.
>>>>>
>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>> ---
>>>>>   drivers/nvme/target/tcp.c | 14 ++++++++++++--
>>>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>>>> index f131b504aa01..97d07488072d 100644
>>>>> --- a/drivers/nvme/target/tcp.c
>>>>> +++ b/drivers/nvme/target/tcp.c
>>>>> @@ -1845,8 +1845,18 @@ static u16 nvmet_tcp_install_queue(struct 
>>>>> nvmet_sq *sq)
>>>>>           container_of(sq, struct nvmet_tcp_queue, nvme_sq);
>>>>>       if (sq->qid == 0) {
>>>>> -        /* Let inflight controller teardown complete */
>>>>> -        flush_workqueue(nvmet_wq);
>>>>> +        struct nvmet_tcp_queue *q;
>>>>> +        int pending = 0;
>>>>> +
>>>>> +        mutex_lock(&nvmet_tcp_queue_mutex);
>>>>> +        list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
>>>>> +            if (q->state == NVMET_TCP_Q_DISCONNECTING)
>>>>> +                pending++;
>>>>> +        }
>>>>> +        mutex_unlock(&nvmet_tcp_queue_mutex);
>>>>> +        /* Retry for pending controller teardown */
>>>>> +        if (pending)
>>>>> +            return NVME_SC_CONNECT_CTRL_BUSY;
>>>>
>>>> Overall I'm fine with the approach.
>>>>
>>>> That will most likely be the case for a controller reset or a "reset
>>>> storm". Maybe it is better to keep it at some reasonably allowed 
>>>> pending
>>>> to say 10 or something... The whole point is to not let the removals
>>>> accumulate and continue creating new ones...
>>>>
>>>> Can you please test this with a host that does a loop like:
>>>> while true; do nvme reset /dev/nvme0; done
>>>>
>>>> And let it run for some time...
>>>> Or even better create a test that does this for 100 iterations
>>>> or a log/short variants of this?
>>>>
>>>> The same would be needed by nvmet-rdma btw.
>>>
>>> Retested with the reset loop; no issues found after 327 iterations.
>>
>> Interesting, did the host see a NVME_SC_CONNECT_CTRL_BUSY  during the
>> test?
> 
> Nope.

So you are not stressing enough?

Before (5+ years ago), multiple reporters, including myself ran a
similar test and got to OOM after enough time.

If you are not exercising the busy return, you are not getting to a
point where you need to back-pressure...

