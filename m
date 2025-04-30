Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3374C3ABA9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJJqUV5zTq4SuKAwpTIhgwruln11bq0nuEzvblXoSi0=; b=WO8ev55PKVRnUp3bvOhfBy7WnS
	OyRIrSJxyC3dhhZw/sMHEZp8apA2FII614mVgkmnmgpCm1CCcO07TEK8+gHNt7NDrAuT6dJbp48y2
	i4y3+hrQm+j/Wg6tVOYyrqb2Nk5saFE6IHORR0ALQ/H4j/Hxf4tUdH/5TOFDTFtuVLnf9f7mOpHx+
	qm1jKIw7GtizcFkv18vapJ6HFf5PxcAQWuIl4NtygYygkzRlIqaKAOBY907yFx/BppPWxrQ3wZoAB
	ad0r+2rh1V9IRYFjC4qD0K2j/hT8bymuQWIYS+l7YFpNdlIjLgSxWcUQgWpwCDrhs3WiaZhRDUrvt
	hk6nbfUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAA32-0000000DOWp-0G9B;
	Wed, 30 Apr 2025 16:12:36 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAA2z-0000000DOVp-34uS
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 16:12:35 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-739525d4e12so98280b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 30 Apr 2025 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029553; x=1746634353; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iJJqUV5zTq4SuKAwpTIhgwruln11bq0nuEzvblXoSi0=;
        b=UIjLKW2euksfr6l+FzjYaBjbFei7p+ou5kdjy1yFueEg7D+dp/ofCfKlAObDrVpp0X
         GWpS3qlP34baR/tl578iOIldpCmCVMGR5dYfJJby/DctdZJl4hgCJCLWXptjE+LfAQD9
         1xGIKzz8PPras12QYnNmBkHWyMLfUSZ+QiGkTh23v6YvXra1WF0BmUPo7IhhD0QuAHp+
         T33DQlfVxyHTW94Gaw4EtwRwCdc+8zyInZ+XDNnATaHwxQJ+qk9/j0M5P5NM41wq53gY
         SFwJQlnleXhkyp/lQqAbpK3PKd3KPQid9UKT7mqw1CkHUuiAyKQu8RLELHF2TjCY7GyO
         cg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029553; x=1746634353;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJJqUV5zTq4SuKAwpTIhgwruln11bq0nuEzvblXoSi0=;
        b=SifRtA9HWQaIkzT/zm6iIdbMfVu/nr9Hto8aAtPO5BZIpqTFdQvrc27J4ZIoLJSxnu
         C+ZLO2spoDvNMrDb5qTOg/7muV3ANfkEw5j7oKp/3Yt9GZNHIci9jYIRpIA7uGn94Xm+
         tz7aQtcL2A1q+i/fKQw393tc6Ydhl9K95JiB+xACUOyEcUL8Qr0DfD3FruuJil+rCOWt
         jtCJGcXQ7byNHdHzIgFzcL178xKR8cWpRZJ5dLtnkaUhxFF/VU2+WjYN9XQo9/8KWHIt
         woRnfj0oAZCAqsfcIO0kt/h/XKJJsuvezWE/tiSiehRnbfun754qKXJveDdJqCt/BlhJ
         xiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaMFNGw8CZUm3laYfotbU/awQjD/TFnS9Q8sH2OUNnByNZEaeI3MNPgjJLFbdTfIO+OpY5uGeiwpOW@lists.infradead.org
X-Gm-Message-State: AOJu0YwyogZU0o7wOGbS9vJNy4ywGsWActRaS0DHHDs/OR3gCKIc6lLs
	Q4V2y0IIOo/xUCAPY3n2RbuPA2CD7Q0cRhyxSGoyRX8WWUVXPWFL
X-Gm-Gg: ASbGncsYxaMScpys068z79FwFHn/NFVDf8vYr/FTA/OQ0++8Z+A0dNbFxs9SY9OB33W
	GQ8+OXERn53+aQ29UncqNF9obGvTpILzQzLDlNjJc3c6Dhc77GmaFkdmk0+qQGi8MeDGSUyDmA0
	4Uxn/0dRAPI3xyEMYXBDkHBdLNda5jzehMhzaSwAEp1OI0RFcg3sQ4QX44l+3vDPrqBwLaNH1un
	x8q2CSzUso9oQ77tJ1AqNwZ2EUMLYduSncsR5vLaPcRUG9cArPeKcp+F7HuQo6rAotqCILcB8yS
	QbtcW7UYL4Tf+v55UPiGdBa9TnhnJOBX0D+Gyk+6qdKG1qolP8k6pU1h1iGLdnShKOxHUmZRXzN
	H8XEQqgQfe9i85Q==
X-Google-Smtp-Source: AGHT+IF1QxhqmtfoW+P880p2hcKc4dZLjzz4WUl32BwIYhDdro/3mUFzvKg09FJiMUNCnseO1GodKA==
X-Received: by 2002:a05:6a00:a22:b0:737:9b:582a with SMTP id d2e1a72fcca58-74038aac069mr6336536b3a.24.1746029552601;
        Wed, 30 Apr 2025 09:12:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a5c244sm1899143b3a.134.2025.04.30.09.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 09:12:31 -0700 (PDT)
Message-ID: <d8fa9332-9475-433e-a203-e376845dcc66@roeck-us.net>
Date: Wed, 30 Apr 2025 09:12:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
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
 <aBJJQoOBhaXj7P36@kbusch-mbp>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <aBJJQoOBhaXj7P36@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_091233_777424_58C40C81 
X-CRM114-Status: GOOD (  23.27  )
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

On 4/30/25 09:01, Keith Busch wrote:
> On Wed, Apr 30, 2025 at 08:43:04AM +0200, Daniel Wagner wrote:
>> On Tue, Apr 29, 2025 at 11:42:25AM -0700, Keith Busch wrote:
>>> On Tue, Apr 29, 2025 at 11:23:25AM -0700, Guenter Roeck wrote:
>>>> On 4/29/25 11:13, Keith Busch wrote:
>>>>> On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
>>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>>> index b502ac07483b..d3c4eacf607f 100644
>>>>>>> --- a/drivers/nvme/host/core.c
>>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>>> @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
>>>>>>>                    msleep(100);
>>>>>>>            }
>>>>>>>
>>>>>>> -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>>>>> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
>>>>>>> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>>>>>                    return;
>>>>>>>
>>>>>>>            nvme_unquiesce_io_queues(ctrl);
>>>>>>
>>>>>> I would rather have a separate state for firmware activation.
>>>>>> (Ab-)using the 'RESETTING' state here has direct implications
>>>>>> with the error handler, as for the error handler 'RESETTING'
>>>>>> means that the error handler has been scheduled.
>>>>>> Which is not true for firmware activation.
>>>>>
>>>>> But the point of having firmware activation set the state to RESETTING
>>>>> was to fence off error handling from trying to schedule a real reset.
>>>>> The fw activation work schedules its own recovery if it times out, but
>>>>> we don't want any other recovery action or user requested resets to
>>>>> proceed while an activation is still pending.
>>>>
>>>> Not only that; there are various checks against NVME_CTRL_RESETTING
>>>> sprinkled through the code. What is the impact of introducing a new state
>>>> without handling all those checks ?
>>>
>>> Good point, bad things will happen if these checks are not updated to
>>> know about the new state. For example, nvme-pci will attempt aborting IO
>>> or disabling the controller on a timeout instead of restarting the timer
>>> as desired.
>>>
>>> Can we just revert the commit that prevented the RESETTING -> LIVE
>>> transtion for now?
>>
>> Unfortunately, it will break the FC error handling again(*). The
>> simplest fix is right above, add the transition from RESETTING to
>> CONNECTING and then to LIVE, IMO.
> 
> Gotcha, yes, that looks like the simplest fix for the current release
> then. We need to be careful with adding new states, so we can revisit
> Hannes' suggestion for 6.16 if we really want to split this.
> 
> If you send the simple fix as a formal patch, please add my review and
> the "Fixes:" tag.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Please feel free to add mine as well:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


