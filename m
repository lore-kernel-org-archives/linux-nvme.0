Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC549C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pENXS6MAo/LOM2IxYpbwar1jhezhD85FIwo/k3i+s/I=; b=ihbSkA/IS1ED9cv9GO12qn6yZT
	1aW0uiAkLiAN7CtRpyDzGzAJzJGDCGsMSsDF5Qz9ka50UNiMIwNHW7GJHES8MVdaOSKLTqPJHx+jx
	A+a5MABYDQKxRFsUefdWurAJ5OI8P09hdA8eqJIWDEKPZKp3iZ3TSnWbo9OCzDOACzDbZuqal/naH
	OLophR1auxuzsb/bVl5iyVuJEYv3sMps/7GIL7Pw0lc1lCaOFZIpwQnXjqLd78viZoH3BCu4szPfq
	hICwci/bSbkd88NeS80pst0ySQlrA4OECz6AsB1Ygo9mnYfBZDXSiTlJ8TmN8IpHmTMCnga7vsME8
	7nWGTCjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA8z9-004biy-1x;
	Mon, 04 Dec 2023 13:27:43 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA8z5-004bZ6-2U
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 13:27:41 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b2a85c99bso4324955e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 05:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696452; x=1702301252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pENXS6MAo/LOM2IxYpbwar1jhezhD85FIwo/k3i+s/I=;
        b=svkj0CGn9mJrdn2tiYd+tyozbvMFXWL8eAo2OZuTXZct6P0CLqTu3hP3bECJhXGWXW
         PzIjDO4md7FX9EutZmx71TRdSFqoqhaVNHqoA9jXh57MeWGg1vSpSkQyjDqRwSicJmQt
         GRE4KmyX32LpguFFtbQIXHj1WB14Z3uZqLrdoZtgIO55Yed0HZ/lcidGZg7ssCC2wXGj
         0jfh/bA/9nmc2M0SpvTx/ulS6UHAAlYIhXn/GfNq8CrsMhZdwrteCWLk2QRSbsyoJgQJ
         Sgyot1xoptpGKm5zqP1eZ3V+6sm4DTcKVqwGb8oCBznBsWwGixsyv6W+RNe1mJsbS64A
         KBQw==
X-Gm-Message-State: AOJu0YzcLi25SquxlH1lQW5YL2YBGln7yKnenjU/40tINO7MdgQZ4wD6
	xKc5ZdxRJ1XB5H7XclrvAcU=
X-Google-Smtp-Source: AGHT+IEZDDdLnVv1ai3BTHeeNxgd98GZGE4gQobRDzmlqMe+90sA80qF5yqERxw9FilctM/RxXl21A==
X-Received: by 2002:a05:600c:257:b0:408:3836:525f with SMTP id 23-20020a05600c025700b004083836525fmr22262324wmj.1.1701696451414;
        Mon, 04 Dec 2023 05:27:31 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b0040b3515cdf8sm15048573wms.7.2023.12.04.05.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 05:27:30 -0800 (PST)
Message-ID: <c0721f45-0615-4d06-9be2-b0edb2713dc7@grimberg.me>
Date: Mon, 4 Dec 2023 15:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
 <691e717b-daf0-458c-bbd7-be6c8ffa8f7e@suse.de>
 <16908ba7-73d1-0cb4-6724-caaad7468d37@grimberg.me>
 <116f765d-a94e-4da7-ba81-9f9c7dec04b7@suse.de>
 <349c1dbe-82c3-f5e8-2158-211772e73771@grimberg.me>
 <b7b72df8-917c-4d4e-8440-47f85c50973d@grimberg.me>
 <765a21bd-e876-4e0f-a5ff-dd25fa7265fa@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <765a21bd-e876-4e0f-a5ff-dd25fa7265fa@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_052739_808314_1CF8FCB7 
X-CRM114-Status: GOOD (  35.45  )
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



On 12/4/23 13:37, Hannes Reinecke wrote:
> On 12/4/23 11:30, Sagi Grimberg wrote:
>>
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> there have been some very insistent reports of data corruption
>>>>>>>> with certain target implementations due to command retries.
>>>>>>>
>>>>>>> None of which were reported on this list...
>>>>>>>
>>>>>> Correct. I can ask them to post their finding here if that would 
>>>>>> make a difference.
>>>>>>
>>>>>>>> Problem here is that for TCP we're starting error recovery
>>>>>>>> immediately after either a command timeout or a (local) link loss.
>>>>>>>
>>>>>>> It does so only in one occasion, when the user triggered a
>>>>>>> reset_controller. a command timeout is greater than the default
>>>>>>> kato (6 times in fact), was this the case where the issue was
>>>>>>> observed? If so, the timeout handler should probably just wait
>>>>>>> the kato remaining time.
>>>>>>>
>>>>>> Nothing to do with reset_controller.
>>>>>> The problem really is in nvme_tcp_state_change(), which will 
>>>>>> blindly start error recovery (and a subsequent command retry) 
>>>>>> whenever the local link drops.
>>>>>
>>>>> That is incorrect. A link drop does not trigger a socket state change.
>>>>> a state change is triggered for specific socket states
>>>>> (see net/ipv4/tcp.c for description of socket states).
>>>>>
>>>>> These are a set of states that describes local and remote sides
>>>>> shutting down (or a TIME_WAIT). The cases where the host
>>>>> triggers error recovery without the controller acknowledging it
>>>>> (in case the link is down) are FIN_WAIT1/2, and these happen
>>>>> when the user triggers a controller reset/disconnect.
>>>>>
>>>>> In the other circumstances, we'll see a TCP_CLOSE/CLOSE_WAIT/CLOSING
>>>>> which should indicate the controller acknowledged the shutdown.
>>>>>
>>>>
>>>> Ah, now. It's really neither.
>>>> Complaint from the customer was that we are retrying commands 
>>>> without waiting for KATO. Actual claim was that we're retrying 
>>>> more-or-less immediately.
>>>>
>>>> So, the problem here is not the first command running into a timeout;
>>>> the problem really is with the _subsequent_ commands running into a 
>>>> timeout (cf my comments to patch 1/3).
>>>> The first command will set the status to RESETTING and start error 
>>>> recovery, all fine. But all _other_ commands will be aborted directly,
>>>> causing them to be retried immediately without any delay.
>>>
>>> This is still unclear to me.
>>> The default io timeout is 30s, which is 6 times larger than the
>>> default kato. So effectively we are hitting a case where we waited
>>> 6 kato periods, and with your patch we are waiting 7 kato periods?
>>>
>>> There is a disconnect for me here.
>>>
>>> Can you please clarify:
>>> 1. what is your kato?
>>> 2. what is your io timeout?
>>> 3. was the controller RESETTING state triggered from kato? or
>>>     from io timeout?
>>>     if the latter, it indicates that kato is higher than io timeout,
>>>     otherwise the transport is perfectly fine, and this is essentially
>>>     a controller io that is taking longer than the host io timeout?
>>>
>>> Do you have some trace that points out how a command is sent down to
>>> the controller (successfully arrives to the controller) the network goes
>>> down, and the io is retried before kato expires?
>>>
>>> What is unclear to me here, is how kato expires, but the controller
>>> continues to process commands.
>>>
> 
> Argument here is that there is a race window between command timeout
> triggering (ie the call to nvme_tcp_timeout()) and scheduling of the
> 'err_work' workqueue function. If you have a burst of commands all
> expiring at roughly the same time the first command will set the 
> controller state to 'RESETTING', and schedule the 'err_work' workqueue
> function.

Yes, that is correct. It is also the keep-alive itself that can
trigger the timeout handler. In fact, it is the more likely one
because it will by default have a lower timeout than IO commands.

This is a part of where I lose the trail here, because I'd expect
the keep-alive to expire far before any of the IO commands, especially
with the latest changes to expedite the keep-alive execution pace.

> The second command will timing out _before_ err_work is scheduled,
> will see the RESETTING state in nvme_tcp_timeout(), and directly
> complete and retry (via nvme_tcp_complete_timed_out()) without
> waiting for KATO.

That is something we probably can address by analyzing the controller
state a bit deeper. We've always failed IO commands quickly in the
timeout handler because these commands can be part of the ctrl setup
sequence, which means the error recovery will not run and fail the 
commands on their behalf reliably. I also think there were issues with
issues in the teardown stage (shutdown or disable).

> That is the issue the customer had been seing, and that is what is
> causing data corruption on their end.
> 
> This patchset is an attempt to fix this issue.

In your patch 3, you take nvme_keep_alive_work_period(), which is
either kato/2 or kato/4. It is not clear to me why these values
were chosen other than "the issue went away".

Also, what happens if kato (which is user configurable), is arbitrarily
long? This means that IO failover can take say 60 minutes? Do you think
its reasonable? This is where I'm concerned about the unconditional
delay.

I think that the idea was that an appropriate delay would be indicated
by the controller, rather than being determined by a user controlled
variable.

Regardless we should limit to exactly when such a delay is actually
needed.

Plus, I haven't seen anything for nvme-rdma and it is unclear to me
why this is a host specific to tcp.

> We'd be happy to pick up this thread, it just had been pushed back
> internally as we put in a band-aid for that customer in our kernels...

Well, my assumption is that we want this addressed upstream. Just a
matter of how.

