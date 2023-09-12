Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C311CA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 13:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wpY+1cScNDtzQ5FdsvWwoqNRBpFcbux0N379eM/j1mk=; b=w+EYkxX452gdrWnNTcDFvJj127
	XGA1kJVmfcl3Ylr/a4vz7S00DuWfGQeMVL4I229oHuT7ihigPvQ1F6Qv0Ld9h9g2/+zIXbWde8INA
	HC15/pY2f+3BQes9Vh78wnih+pul2Zrwm4lKXFi/CLzFJ6rsV1ar1c05VSpoVC+FvLh1hHqoNaQMI
	k3jiYHsU43j2HAs5nmjHI8uoDIGt4yG4RTMG5c04srablwCmA5M9wPqlAuCB5VPpb5ZD6NxV9X4tg
	KmkWFcxhZzsSUkvleHltek9YdX04hJRGuAdXxWcMatsIYykt1ecHLsXGwoYc5DFVNsSutmF2Pilde
	09ldIRpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg3gU-003SfF-1l;
	Tue, 12 Sep 2023 13:44:06 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg3gS-003See-1i
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 13:44:05 +0000
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52e5216024aso1142411a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 06:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526240; x=1695131040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpY+1cScNDtzQ5FdsvWwoqNRBpFcbux0N379eM/j1mk=;
        b=pmN8Twr3i5M23TYjonctbVlRcV5mxv9ff+Dsk+U0/T4K0vdnM8Orgid27mBcd0qvXJ
         BBAqN7hUdFGGeeitC1XR+X/xbrCzxZlfdukZkms+RANyDLc2bfTYl3WtdX14jwpGhVbN
         pPTUi772Z4aWhFwzjtAUEo9qO3F4TGLMBTJohod7IGQBygve/WOu/18kgDQXAwEJw+2s
         YoJktw2o4U7iJTan0J5qP/o0s5xUWkWVBcQtg1jxO4Z3TdEBP9tgyR48fDFzW/o3cAtl
         BHhhUCgCUAdr0iOjPpVocpoEBMTLBOh9VnHh7DoaJVNFu0Rw1/J6REaWOKvZ1BazDhnG
         0evA==
X-Gm-Message-State: AOJu0Yzyabxm5Y4e2LTwch8/dNsWoA9Pt64CLzMK1gYpSAWjdjAGEki9
	oezT0n7Up8zSak+m9kh1G0I=
X-Google-Smtp-Source: AGHT+IEL6p9kkxyFalurJNdK39wIL+zSi8VkiKTJWCbOmVLOOFx1hZjOMgtuzNf8gj22lQJPMLvPKA==
X-Received: by 2002:a05:6402:42c5:b0:51e:34d8:f4c7 with SMTP id i5-20020a05640242c500b0051e34d8f4c7mr10727063edc.2.1694526240032;
        Tue, 12 Sep 2023 06:44:00 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7c6c7000000b0052328d4268asm5955338eds.81.2023.09.12.06.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:43:59 -0700 (PDT)
Message-ID: <349c1dbe-82c3-f5e8-2158-211772e73771@grimberg.me>
Date: Tue, 12 Sep 2023 16:43:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
 <691e717b-daf0-458c-bbd7-be6c8ffa8f7e@suse.de>
 <16908ba7-73d1-0cb4-6724-caaad7468d37@grimberg.me>
 <116f765d-a94e-4da7-ba81-9f9c7dec04b7@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <116f765d-a94e-4da7-ba81-9f9c7dec04b7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_064404_567833_07575D2C 
X-CRM114-Status: GOOD (  25.54  )
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


>>>>> Hi all,
>>>>>
>>>>> there have been some very insistent reports of data corruption
>>>>> with certain target implementations due to command retries.
>>>>
>>>> None of which were reported on this list...
>>>>
>>> Correct. I can ask them to post their finding here if that would make 
>>> a difference.
>>>
>>>>> Problem here is that for TCP we're starting error recovery
>>>>> immediately after either a command timeout or a (local) link loss.
>>>>
>>>> It does so only in one occasion, when the user triggered a
>>>> reset_controller. a command timeout is greater than the default
>>>> kato (6 times in fact), was this the case where the issue was
>>>> observed? If so, the timeout handler should probably just wait
>>>> the kato remaining time.
>>>>
>>> Nothing to do with reset_controller.
>>> The problem really is in nvme_tcp_state_change(), which will blindly 
>>> start error recovery (and a subsequent command retry) whenever the 
>>> local link drops.
>>
>> That is incorrect. A link drop does not trigger a socket state change.
>> a state change is triggered for specific socket states
>> (see net/ipv4/tcp.c for description of socket states).
>>
>> These are a set of states that describes local and remote sides
>> shutting down (or a TIME_WAIT). The cases where the host
>> triggers error recovery without the controller acknowledging it
>> (in case the link is down) are FIN_WAIT1/2, and these happen
>> when the user triggers a controller reset/disconnect.
>>
>> In the other circumstances, we'll see a TCP_CLOSE/CLOSE_WAIT/CLOSING
>> which should indicate the controller acknowledged the shutdown.
>>
> 
> Ah, now. It's really neither.
> Complaint from the customer was that we are retrying commands without 
> waiting for KATO. Actual claim was that we're retrying more-or-less 
> immediately.
> 
> So, the problem here is not the first command running into a timeout;
> the problem really is with the _subsequent_ commands running into a 
> timeout (cf my comments to patch 1/3).
> The first command will set the status to RESETTING and start error 
> recovery, all fine. But all _other_ commands will be aborted directly,
> causing them to be retried immediately without any delay.

This is still unclear to me.
The default io timeout is 30s, which is 6 times larger than the
default kato. So effectively we are hitting a case where we waited
6 kato periods, and with your patch we are waiting 7 kato periods?

There is a disconnect for me here.

Can you please clarify:
1. what is your kato?
2. what is your io timeout?
3. was the controller RESETTING state triggered from kato? or
    from io timeout?
    if the latter, it indicates that kato is higher than io timeout,
    otherwise the transport is perfectly fine, and this is essentially
    a controller io that is taking longer than the host io timeout?

Do you have some trace that points out how a command is sent down to
the controller (successfully arrives to the controller) the network goes
down, and the io is retried before kato expires?

What is unclear to me here, is how kato expires, but the controller
continues to process commands.

>>> And that error recover does _not_ wait for KATO, but rather
>>> causes an immediate retry.
>>
>> We can't blindly wait for KATO. If the controller saw the socket
>> closure, there is no point waiting kato.
>>
> Agreed. So we should be marking out FIN_WAIT1 as that one requiring us
> to wait for KATO.

You can't do that, that will wait on FIN_WAIT1 for every queue.

