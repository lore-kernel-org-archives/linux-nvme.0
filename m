Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9139C369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QdI9zAXM1EXk6JfijMSDnvKDuolz6Ggda+w8j/WGZE=; b=rkzdyiUQUQGKTrEeZZfc78JJgV
	6QYIWDQVzBVejqbSUTR81Xq9iUNrLKy3kIS5NQ6kl+LcLHaclbrPt9qybWX8befEwzuQg3jp5gX8q
	tw9UFWTqdaGZHXhbonbAsFmg3nhRfKKZoyf+iI1n5MhCLWEhIjGPiF4djuxwkmCRfAT7wFmso2dw1
	XwCG4DEPG37QPsN7uYNqkLFx2WWtdF/7ZOdCiqj9cdt/UVNddOyUI6UAEv2w93m+4GA8kf4B66FtZ
	xPql20Et3V3q+mL9tJ0pDj3QIInEMIy85roYWtskkSW2z02k0qhVn3HVlDEZR7tjYFEL+Zzeu3xri
	nZSXBMTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAA1r-0000000DOK9-1eou;
	Wed, 30 Apr 2025 16:11:23 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAA1o-0000000DOJk-2jSg
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 16:11:21 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-223fd89d036so3625ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 30 Apr 2025 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029479; x=1746634279; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8QdI9zAXM1EXk6JfijMSDnvKDuolz6Ggda+w8j/WGZE=;
        b=DjhoC6IexVL8Fd2ViNNxu/6aCPCUjnKB4nrb+iVcVd5yo5vXY3/cwO2+MNpl1NkWkN
         hL9TrrvXxKXTD7OrzgjXpf+cQCThUbm88d1zO3te+sZm1T6zwj3AlmvT00QF9zqSZoFy
         W71EfEQH2xRkXXebj2jxkNjo7+RzHkBnQdvQL/zAbaRbwl2/d9/jbp6ofO/v26kwOtYY
         h0fWRIxKnjhg72Larl7epa/LpV6W4nMpcnP90yTvkDmvW2CLKWviTywV6YBiPnq8fRFE
         nOB/V1+SYYkUBjqq5Cg+AjYhcwIvvOioCF/afn7VMl0UmX7WaE6B2UU71olNqf7wNLUc
         5tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029479; x=1746634279;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QdI9zAXM1EXk6JfijMSDnvKDuolz6Ggda+w8j/WGZE=;
        b=njKeF7pps/ctYG3U3o4YeBWQIfKAT9LjZMqNxLmrSZ3nVzNolU5LffGReK1GTQKPoN
         X0TV8xS/bPdyQRuHGLyjYfKE12MEae/fyAlnKl478BLNO6cTi7JUVYy/GO6LMa1Yg0hD
         6Y98NZL1wOX56URQzIch0p6CqZHRNG/rOeXef+Aph9+2D6YwlOjK9RvEaTfnze/Qc7JK
         swCnghtsAHYvbJVFP6JSn7rofzMtd23tml3xYQ23WYt5IY4/pgBDc2HymXTsN2zI9w+q
         7JSv3pAW5xmgIG6Dev/zzI/sD4dDgGUmcTDEqwN7vKqijJmCgnhZ1FkNHfSjubSTulDC
         JZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCW1AJEQCo2qvxMRhNd34q+UHpnRW1ZUCnpszbqN0PkaRqWP86050hAB2P1vQbLOwa6rORaRbcDSR5Ca@lists.infradead.org
X-Gm-Message-State: AOJu0YzQd3aQH38x8ZaaVaqwvp8z0vLUFhqkmPmm1Wp4w8GEeicaUxTS
	JwQS/w5nB/+7Ws133DT9KuQKI5nAqnMG5GdyrCK70/k88fhPBp64
X-Gm-Gg: ASbGncubp7x+O4vxiJsgV/xx5fQXN6e3ZKe8hid5CoEhQOzQ71crI4G+rYK+wGc4WGp
	uX+CDw3mwxP7dgO1+siGfnfiDEjL9qztOBrVEZxggZPFaLRf0VuDJPxtB5Yv9TJf2q7R040Yme0
	QM4oUCCcrWFBeRu1PWAQhcUj7xpUkvACKRiervERNRqkT6sXrOfQFhTNy+SzPJQW7pLUDKAC5KL
	s47oOYia2fGYHOnUi9IWCQSuW98WknUkFc/9y6kVw1lGMN7tkXqMLWYvCZO40N8OuNgcJd4zBiM
	91Lm+XixMWv2F8z7HfUhYVGLudSJx0Z7l7ZswxcYKAGcFc+5mYwI2t4eamxcYq7aiFqq9/NfumY
	F0g0QLbFMuI9dgA==
X-Google-Smtp-Source: AGHT+IE3LWuBObioSz5WRjpUQmOLiurHOMha6G61MD9ycBRKzq1jJmOJGa4KadiZiBM16zRrb9XsyQ==
X-Received: by 2002:a17:902:ccc3:b0:215:9bc2:42ec with SMTP id d9443c01a7336-22df5838ce0mr44920465ad.47.1746029479561;
        Wed, 30 Apr 2025 09:11:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbd230sm123543045ad.77.2025.04.30.09.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 09:11:18 -0700 (PDT)
Message-ID: <2ec928ad-cd84-4964-9f7b-c414033412cb@roeck-us.net>
Date: Wed, 30 Apr 2025 09:11:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <wagi@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de> <aBEW4W40ZelIXfs2@kbusch-mbp>
 <253e0551-d4d7-4ffe-8842-daecf1f6c753@roeck-us.net>
 <aBEdkUky_-bfgISv@kbusch-mbp>
 <8121b8d6-2b30-4086-b2fb-bce354f203dc@flourine.local>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <8121b8d6-2b30-4086-b2fb-bce354f203dc@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_091120_699453_78A0DE57 
X-CRM114-Status: GOOD (  24.64  )
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

On 4/29/25 23:43, Daniel Wagner wrote:
> On Tue, Apr 29, 2025 at 11:42:25AM -0700, Keith Busch wrote:
>> On Tue, Apr 29, 2025 at 11:23:25AM -0700, Guenter Roeck wrote:
>>> On 4/29/25 11:13, Keith Busch wrote:
>>>> On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>> index b502ac07483b..d3c4eacf607f 100644
>>>>>> --- a/drivers/nvme/host/core.c
>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>> @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
>>>>>>                    msleep(100);
>>>>>>            }
>>>>>>
>>>>>> -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>>>> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
>>>>>> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>>>>                    return;
>>>>>>
>>>>>>            nvme_unquiesce_io_queues(ctrl);
>>>>>
>>>>> I would rather have a separate state for firmware activation.
>>>>> (Ab-)using the 'RESETTING' state here has direct implications
>>>>> with the error handler, as for the error handler 'RESETTING'
>>>>> means that the error handler has been scheduled.
>>>>> Which is not true for firmware activation.
>>>>
>>>> But the point of having firmware activation set the state to RESETTING
>>>> was to fence off error handling from trying to schedule a real reset.
>>>> The fw activation work schedules its own recovery if it times out, but
>>>> we don't want any other recovery action or user requested resets to
>>>> proceed while an activation is still pending.
>>>
>>> Not only that; there are various checks against NVME_CTRL_RESETTING
>>> sprinkled through the code. What is the impact of introducing a new state
>>> without handling all those checks ?
>>
>> Good point, bad things will happen if these checks are not updated to
>> know about the new state. For example, nvme-pci will attempt aborting IO
>> or disabling the controller on a timeout instead of restarting the timer
>> as desired.
>>
>> Can we just revert the commit that prevented the RESETTING -> LIVE
>> transtion for now?
> 
> Unfortunately, it will break the FC error handling again(*). The
> simplest fix is right above, add the transition from RESETTING to
> CONNECTING and then to LIVE, IMO.
> 
> (*) ee59e3820ca9 ("nvme-fc: do not ignore connectivity loss during connecting")
>      f13409bb3f91 ("nvme-fc: rely on state transitions to handle connectivity loss")

I don't know if having nvme-fc _depend_ on state transition restrictions is good
or bad, and I don't know anything about the NVME state machine.

However, given that there _is_ a real regression in the code right now, I agree
that the solution (or call it workaround) suggested by Daniel (or something
similar) should be the way to go, and it would be easy to backport. After all,
firmware update is now broken in all stable release branches, and that is not
a good situation to be in.

Introducing a new state for firmware updates should be done carefully and not be
part of a regression fix which needs to be backported to all stable release
branches.

Thanks,
Guenter


