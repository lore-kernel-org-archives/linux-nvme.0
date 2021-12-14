Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD79C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uqDKFOjL518Rw0qKC8GdkHWPrKAV0v728uMbwXAqP9c=; b=L/ylB70a4a6WkkwV6NL3TAmF2q
	MSpIyCIYIeyWgGf3VjaKDQAOpve9o3v+UqOXRwPGm9HeEaLP1V9nj5LsiGe3y+39t9gRm51A/UgpU
	EvGORCfGb6R1HDpFOaF9Q2TPCgFsOyZ+NRBbAlXxpj7UJjd9346e85/HFntl+BbeogxUZ9oxTd8oR
	+WVx6z7Rbr9KPUj+pZ1GZl5BY94SrMycVVZ2j/4MGgTgbteNfwPuhiCut1TuxaY57NQ9OjisiQw2n
	L78hZ10Zdxh04zqVHu4ogn21INvfr68FoJHwHvP5p77VjvSCpSfWVHjQDxY0kp3vlo7uESeyWYKY1
	URU61ePA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mx5b8-00DcqN-8W; Tue, 14 Dec 2021 11:03:54 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx5b5-00Dco9-7F
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 11:03:52 +0000
Received: by mail-wr1-f43.google.com with SMTP id j3so31762840wrp.1
 for <linux-nvme@lists.infradead.org>; Tue, 14 Dec 2021 03:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uqDKFOjL518Rw0qKC8GdkHWPrKAV0v728uMbwXAqP9c=;
 b=BaqizzYS3/d1LE0NxV71Cy7vchxNW8c4y9oJQNcqBsGFVT1eow28KG/zxX7u5JocOA
 i+saEFtJ0K6vKb+zhbozCzabd3A8iFLYHdKAXGVq4i//55dYwGSZ2BXOe++y7yovlGeX
 7fl2E9NrjIKVNTXjwH49ERFYhDtYzDSDtafah7lgfH9J7lpx1mOymKVZ9kiNX8khmqcI
 fAGj8DsWO5QywOcTmbtIJhGww7uTG68eN2LJrl2gvcfrTLP5Y52W285AUFqjQf505hss
 GzTTu0xcAaNvRaSaqHeB3KGe0nMF5zcxIdrRhdAvf35ZW9ZjBkhH0ah8Tk2DpAs2xaT2
 8v4A==
X-Gm-Message-State: AOAM533O31DubXlRWWfRcShsig9HOq3P1zTCTA5ljbph4mb8L8meyus0
 DwPCylY7qGYbGqANt7kN+Qnao0D/sSU=
X-Google-Smtp-Source: ABdhPJyK5zlCYMqJ2gky8Kq8alUxESDwo7D8zs2+Dgk2pSPENAGbGmoa8wwQf3LSOLwBMjoLQZnuFQ==
X-Received: by 2002:a05:6000:cd:: with SMTP id
 q13mr5101348wrx.488.1639479829639; 
 Tue, 14 Dec 2021 03:03:49 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id i3sm12333153wro.117.2021.12.14.03.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Dec 2021 03:03:49 -0800 (PST)
Subject: Re: [PATCH 3/3] nvme: add KConfig options for debug features
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-4-chaitanyak@nvidia.com>
 <c467d85d-77da-fdff-53e9-938a7bf01763@grimberg.me>
 <492750cf-b031-5709-0836-c28e475c29fd@nvidia.com>
 <6a1d326e-ce96-ef9e-f09d-7ebdc9ef6084@grimberg.me>
 <8dfd8447-426b-21e5-c988-43877fc851dd@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <916e5eeb-8cda-b369-f216-6f7edefebb7e@grimberg.me>
Date: Tue, 14 Dec 2021 13:03:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8dfd8447-426b-21e5-c988-43877fc851dd@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211214_030351_295488_2283E143 
X-CRM114-Status: GOOD (  39.84  )
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


>>>>> Add KConfig menu option to enable and disable gencounter debug
>>>>> feature that uses config NVME_DEBUG_USE_CID_GENCTR.
>>>>>
>>>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>>> ---
>>>>>     drivers/nvme/host/Kconfig | 10 ++++++++++
>>>>>     1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>>>>> index dc0450ca23a3..dfa2609b7006 100644
>>>>> --- a/drivers/nvme/host/Kconfig
>>>>> +++ b/drivers/nvme/host/Kconfig
>>>>> @@ -1,4 +1,14 @@
>>>>>     # SPDX-License-Identifier: GPL-2.0-only
>>>>> +menu "Debug (Enable driver debug features)"
>>>>> +config NVME_DEBUG_USE_CID_GENCTR
>>>>> +     bool "Enable command ID gen counter for spurious request
>>>>> completion"
>>>>> +     depends on NVME_CORE
>>>>> +     help
>>>>> +       The NVM Express driver will use generation counter
>>>>> +       when calculating the command id. This is needed to debug the
>>>>> +       spurious request completions coming from a buggy controller.
>>>>
>>>> This is not just to debug - it is also to protect against such a
>>>> controller. What is the purpose of this config option anyways?
>>>> The main distributions will (as they should) enable it anyways...
>>>
>>> I can rewrite the text and rename it to "driver features".
>>
>> It is not a feature.
> 
> that is what I thought, hence I kept it under debug.

It is not debug, I mean it can certainly be used for debug, but
it is protecting against kernel-crash (or worse) with such controllers.
The fact that a buggy controller can crash the kernel (or worse) has
been raised on this list by users multiple times in the past.

>>> We are protecting against such a controller which is not stable
>>> (buggy), i.e. it is doing things which it shouldn't be
>>> doing at the first place.
>>
>> Yes, this is exactly what we are doing.
>>
>>> Consider a case if controller is not
>>> buggy then it adds instructions in the fast path which are not
>>> needed at all.
>>
>> We keep repeating this, if the controller assumes _anything_ on
>> the command identifier then it _is_ buggy, period.
>>
> 
> Completely agree on this.
> 
> What I mean buggy in this context is not related to assuming anything
> with command identifier population, it meant controller that is
> causing spurious completions -> buggy. The controller that is not
> able to process non-seq command ids and assumes anything is out of
> picture for this patch-series (for that nvme-cli skip approach is
> fine), see below.
> 
>> Again, the fact that the controller is buggy is perfectly fine
>> really, that's why we have quirks.
>>
> 
> A controller which is suffering from spurious completions needs
> gencounter to debug the issue, using quirk and masking gencounter
> should be avoided in this case.

Well of course, the quirk is for controllers that don't suffer
from this but happen to break because the host is doing something
unexpected with the command id (even though it is allowed to).

> 
>> What happened to your nvme-cli argument? that would make it
>> specific to that controller.
>>
> 
> That is completely different issue, the nvme-cli argument tries
> to fix the issue with a controller that fails to process
> non-sequntial command-id such as Apple ctrl and needs quirk.
> 
> This path-series has nothing to do with that issue.
> This patch-series is only focused on keeping the fast path lean
> and allowing user(s) to configure gencounter in the environment
> where :-
> 
> 1. Controller is stable.
> 2. Able to process the non-sequential command ids
>      (hence no quirk needed) and does not assume anything about the
>      command id population unlike Apple controller.
> 3. Does not suffer from spurious completion problem.
> 
> For this controller, user can disable gencounter and keep the fast
> path lean.

I understand, although I'd argue that a vendor may tell a customer
to disable that globally... That is not necessarily something we want
to allow.

> 
>> The host side cost is very cheap as shown before.
>>
>>> A controller(s) that is used in the production environment goes
>>> through qualification process from vendors and from the consumers
>>> to make sure they are stable, something like spurious completions
>>> detection is a basic part of the qualification,
>>
>> I don't think that assuming that a production controller does not
>> have any hidden bugs is a great practice, and controllers evolve during
>> their production lifetime.
>>
> 
> That is why we should keep it configurable and let user decide.

OK, so this allows a user that is absolutely set on shaving few
nano-seconds to sacrifice a level of protection against buggy
controllers. Is this a real use-case?

For that, I guess the config option is fine, but this at the very least
needs to default to y.

