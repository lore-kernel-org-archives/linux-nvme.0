Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2986CC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 10:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Blh8R+DZHQqg0VNsYqLFshvKMxOUOp6tWfK4aXPYcns=; b=s/1pjMV7B7ihEakDIiG8APa0fg
	LFW9hmDs046vUVQAbpqxn/0pbCPgHpvDYaWWwDTm+S9BGV8G+kL7/1eYl39TDvCW+r0ZmUCVg7RjZ
	B9iAWoqR8/stMU73ZqSNF+z3g2JyOxeZoATsLDKiwIWJ/gzsDG9P5wuPotjNy3FYCMO/WGTSr3BEB
	pEVo3ZuvH7UBfPYx0HQL1yP9n0JObFhhmugVJt2HOUKeFrfpYm+vBPHv5/XKjcky4K0/O5AXzZGoD
	szVq26nwkrvcoBne3sFtsIm56kmUrcFk6GVIOix5AyxmcuZzfyzZjYmk+FEk/Tk7xkzhJTTuho9pO
	wSQ2TkUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6EK-003XrP-1D;
	Mon, 04 Dec 2023 10:31:12 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6E0-003Xp3-1S
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 10:31:10 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a19b04d54b8so67684366b.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 02:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701685847; x=1702290647;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Blh8R+DZHQqg0VNsYqLFshvKMxOUOp6tWfK4aXPYcns=;
        b=WXSCGOPvB1kiwLPEpckpEyZL26czU8kc5pnABJh9aM/sLctRINy3tOB53qNiWM3Y+4
         QI291IdkU6Segnyj0hYRyxo7bYCu4bgVgV6FDWd665f+590ddQyikcPFk7pt1Zer4UYF
         7FupmojEVb4L5h4X+FgV0K/O6WtmaBviMAJYAvSKD+LPLn2AEQUMWGZBZRMLMXK8Hjl0
         F/JzitvK7yB08bk7glFs0Vddv00hWAOntYjr56k5sjLPA9nQ0lB55tNIdyfwwz/qFc9L
         Rh2Uc2ui9YnnfD/f74wkOIOcEpeWjYVIygloOF0r3kDlEnYV6Y4qJTaD/H/PSL4o4z47
         NDWA==
X-Gm-Message-State: AOJu0YwJeHIXTJo/d+JWgRBB3nt4BzhLsBOmcXCc5glDKKG39uMfVR9o
	n1vcSV6bGzaAMZk1sk1yjilxctl3LG8=
X-Google-Smtp-Source: AGHT+IHd/YWvOtjIDR3s9n+aZ6XudDIIFlg+aXr+r4kFaT6nwVgbT3r6yhr/ID6OVI2Faw+lDgxnHA==
X-Received: by 2002:a17:907:390:b0:a01:b9bd:87a with SMTP id ss16-20020a170907039000b00a01b9bd087amr8157373ejb.7.1701685847300;
        Mon, 04 Dec 2023 02:30:47 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id uz14-20020a170907118e00b00a0104d5758dsm5104334ejb.50.2023.12.04.02.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 02:30:46 -0800 (PST)
Message-ID: <b7b72df8-917c-4d4e-8440-47f85c50973d@grimberg.me>
Date: Mon, 4 Dec 2023 12:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
 <691e717b-daf0-458c-bbd7-be6c8ffa8f7e@suse.de>
 <16908ba7-73d1-0cb4-6724-caaad7468d37@grimberg.me>
 <116f765d-a94e-4da7-ba81-9f9c7dec04b7@suse.de>
 <349c1dbe-82c3-f5e8-2158-211772e73771@grimberg.me>
In-Reply-To: <349c1dbe-82c3-f5e8-2158-211772e73771@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_023052_488118_BAFB3355 
X-CRM114-Status: GOOD (  28.25  )
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


>>>>>> Hi all,
>>>>>>
>>>>>> there have been some very insistent reports of data corruption
>>>>>> with certain target implementations due to command retries.
>>>>>
>>>>> None of which were reported on this list...
>>>>>
>>>> Correct. I can ask them to post their finding here if that would 
>>>> make a difference.
>>>>
>>>>>> Problem here is that for TCP we're starting error recovery
>>>>>> immediately after either a command timeout or a (local) link loss.
>>>>>
>>>>> It does so only in one occasion, when the user triggered a
>>>>> reset_controller. a command timeout is greater than the default
>>>>> kato (6 times in fact), was this the case where the issue was
>>>>> observed? If so, the timeout handler should probably just wait
>>>>> the kato remaining time.
>>>>>
>>>> Nothing to do with reset_controller.
>>>> The problem really is in nvme_tcp_state_change(), which will blindly 
>>>> start error recovery (and a subsequent command retry) whenever the 
>>>> local link drops.
>>>
>>> That is incorrect. A link drop does not trigger a socket state change.
>>> a state change is triggered for specific socket states
>>> (see net/ipv4/tcp.c for description of socket states).
>>>
>>> These are a set of states that describes local and remote sides
>>> shutting down (or a TIME_WAIT). The cases where the host
>>> triggers error recovery without the controller acknowledging it
>>> (in case the link is down) are FIN_WAIT1/2, and these happen
>>> when the user triggers a controller reset/disconnect.
>>>
>>> In the other circumstances, we'll see a TCP_CLOSE/CLOSE_WAIT/CLOSING
>>> which should indicate the controller acknowledged the shutdown.
>>>
>>
>> Ah, now. It's really neither.
>> Complaint from the customer was that we are retrying commands without 
>> waiting for KATO. Actual claim was that we're retrying more-or-less 
>> immediately.
>>
>> So, the problem here is not the first command running into a timeout;
>> the problem really is with the _subsequent_ commands running into a 
>> timeout (cf my comments to patch 1/3).
>> The first command will set the status to RESETTING and start error 
>> recovery, all fine. But all _other_ commands will be aborted directly,
>> causing them to be retried immediately without any delay.
> 
> This is still unclear to me.
> The default io timeout is 30s, which is 6 times larger than the
> default kato. So effectively we are hitting a case where we waited
> 6 kato periods, and with your patch we are waiting 7 kato periods?
> 
> There is a disconnect for me here.
> 
> Can you please clarify:
> 1. what is your kato?
> 2. what is your io timeout?
> 3. was the controller RESETTING state triggered from kato? or
>     from io timeout?
>     if the latter, it indicates that kato is higher than io timeout,
>     otherwise the transport is perfectly fine, and this is essentially
>     a controller io that is taking longer than the host io timeout?
> 
> Do you have some trace that points out how a command is sent down to
> the controller (successfully arrives to the controller) the network goes
> down, and the io is retried before kato expires?
> 
> What is unclear to me here, is how kato expires, but the controller
> continues to process commands.
> 
>>>> And that error recover does _not_ wait for KATO, but rather
>>>> causes an immediate retry.
>>>
>>> We can't blindly wait for KATO. If the controller saw the socket
>>> closure, there is no point waiting kato.
>>>
>> Agreed. So we should be marking out FIN_WAIT1 as that one requiring us
>> to wait for KATO.
> 
> You can't do that, that will wait on FIN_WAIT1 for every queue.

Hey Hannes,

Can you comment where this went?

I'd like us to see how to progress to resolve this (assuming this
is still an issue).

