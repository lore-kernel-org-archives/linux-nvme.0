Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1DBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 09:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kPOAFOHA1fVd7tp/9pTb38jX6/JX6EU/oEnxKTd8K5Y=; b=svS7vv/40JbLZHwdKmP0tQXqiw
	V0fgO0fb2emwq6ysBstLizCup0yC1RM0D2+SoN08IMl5wh61C0NfnKzgAtyFysqo06Ir3gmWXHlSZ
	dc6+74uHaDHV8FG7636I0lF4MJHBw7YdZKbNACRAbs4Vo0X3499j1jcwkHVySzSUNSg0s3gS1ZEGg
	kHKi1XIK6tT3WQg45SU6I28OXxA3EzMY+J2U3qNzBuj3v0T0Do3z4VWR/fqYubCv6kpsdq6JNVEJx
	iinwp5Ii+doRvn8b2Onx0PZ9IOuTG+y2UfpL51TJFQ30KkxVj4qUtPZO/Ki69rUBHZoW+IuGnGTFG
	qCXajuGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwhd6-008dGA-Kz; Mon, 13 Dec 2021 09:28:20 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwhc1-008ctb-3R
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 09:27:14 +0000
Received: by mail-ed1-f45.google.com with SMTP id x10so32494614edd.5
 for <linux-nvme@lists.infradead.org>; Mon, 13 Dec 2021 01:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kPOAFOHA1fVd7tp/9pTb38jX6/JX6EU/oEnxKTd8K5Y=;
 b=Ghupbhv8nrQmOieG61zj7v2uIdJ5wXwP5m7e48EZPByS/GXbMaV6vwc4ku+D9D4jIn
 ZVwD3l6aUb2LyQ2j+WjRlZHhVQM5sO1I4Ia9RbkdAyaTrJhFKm8/T0Re+hIcRiSI6Pnl
 MhL790MkYWYcG3HLA3SB+MIQIS8DBRGmXTF4e5RZbAZMEGlADOTFHH4S7U0/6+VxHFg7
 MaAb2PaqgDt+BY7/avs4NGtxFKms+tH7wmWnJyImfxG55zX9DxPX7ypt6XDeTL++1eGq
 CukSKzPzw5bw47XlprVqL7zPaTagd+q5kPyq2BSdwrYb0w77jzqFtLbh5WrucM9s7vUT
 Ohjg==
X-Gm-Message-State: AOAM533QVxuHngZ1v+Hu/ovz+odR6TCqVqOpnCiRBcACgg80HnTAHFf+
 +zLTKN66c2klJKWOE+rj1AjnfT/hMHI=
X-Google-Smtp-Source: ABdhPJwlQ2clEsvbEFCt7CykB7m6Y7l3UkFDsEBmnAfW9j2HTZ9X5ZsdN75sBlR3Z74osscc+gjIdg==
X-Received: by 2002:a05:6402:5244:: with SMTP id
 t4mr62705937edd.27.1639387630825; 
 Mon, 13 Dec 2021 01:27:10 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id co10sm5847409edb.83.2021.12.13.01.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Dec 2021 01:27:10 -0800 (PST)
Subject: Re: [PATCH 3/3] nvme: add KConfig options for debug features
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-4-chaitanyak@nvidia.com>
 <c467d85d-77da-fdff-53e9-938a7bf01763@grimberg.me>
 <492750cf-b031-5709-0836-c28e475c29fd@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6a1d326e-ce96-ef9e-f09d-7ebdc9ef6084@grimberg.me>
Date: Mon, 13 Dec 2021 11:27:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <492750cf-b031-5709-0836-c28e475c29fd@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_012713_191545_E72925E8 
X-CRM114-Status: GOOD (  31.60  )
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


>>> Add KConfig menu option to enable and disable gencounter debug
>>> feature that uses config NVME_DEBUG_USE_CID_GENCTR.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> ---
>>>    drivers/nvme/host/Kconfig | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>>> index dc0450ca23a3..dfa2609b7006 100644
>>> --- a/drivers/nvme/host/Kconfig
>>> +++ b/drivers/nvme/host/Kconfig
>>> @@ -1,4 +1,14 @@
>>>    # SPDX-License-Identifier: GPL-2.0-only
>>> +menu "Debug (Enable driver debug features)"
>>> +config NVME_DEBUG_USE_CID_GENCTR
>>> +     bool "Enable command ID gen counter for spurious request
>>> completion"
>>> +     depends on NVME_CORE
>>> +     help
>>> +       The NVM Express driver will use generation counter
>>> +       when calculating the command id. This is needed to debug the
>>> +       spurious request completions coming from a buggy controller.
>>
>> This is not just to debug - it is also to protect against such a
>> controller. What is the purpose of this config option anyways?
>> The main distributions will (as they should) enable it anyways...
> 
> I can rewrite the text and rename it to "driver features".

It is not a feature.

> We are protecting against such a controller which is not stable
> (buggy), i.e. it is doing things which it shouldn't be
> doing at the first place.

Yes, this is exactly what we are doing.

> Consider a case if controller is not
> buggy then it adds instructions in the fast path which are not
> needed at all.

We keep repeating this, if the controller assumes _anything_ on
the command identifier then it _is_ buggy, period.

Again, the fact that the controller is buggy is perfectly fine
really, that's why we have quirks.

What happened to your nvme-cli argument? that would make it
specific to that controller.

The host side cost is very cheap as shown before.

> A controller(s) that is used in the production environment goes
> through qualification process from vendors and from the consumers
> to make sure they are stable, something like spurious completions
> detection is a basic part of the qualification,

I don't think that assuming that a production controller does not
have any hidden bugs is a great practice, and controllers evolve during
their production lifetime.

> hence we should
> allow user to configure genctr than forcing additional
> instructions in the fast path and keep this pattern for future
> such cases.

I personally think that given that the worst-case option for such
a bug is possible data-corruption then we should not make it optional,
but I won't insist on it if others think otherwise.

> Maybe I didn't understand, can you please explain what are the
> benefits of having gen-counter where controller is stable?

The benefit is that the host code does not "assume" anything
about the controller.

> I'll wait to send V2 if you can suggest any other way
> (than kconfig something like module param, I'm not sure) so user
> can configure genctr calculations, please let me know.

As I said, the nvme-cli skip-genctr argument is perfectly valid in my
mind.

