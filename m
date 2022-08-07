Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C28C19F2A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Aug 2022 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLrT+SYuYyrSNZJ4rIuWgT9eGjJ0lroXecUAQVDE4NU=; b=Jr6hv0Uq1+NP2C9m5qfGSWEP30
	fYeYXIeqeQwKngrLO90PWG6GoVfK/VMK5C4kAIzI0ftBBwDCCQM3k0Fgumg0tKi6PEa//U+wb3HUL
	Rb/RFHnlI/hkezOnttP6Tf/ug+/5MBnBkkIkxsyD9+E2TmrZj3gVl6csnSWHnTDp87CQNr3YQWkQ7
	ZlBIUZnS26OqhdCCNPsWusgbrwz9gYni1FoNb33zfIpVlecLWMs/ycm2b+sdZlfRw4m5H/G8PENSN
	g2RjowR7soSVyIzR3xWwzWCcv3H18jqU/vdgRz6N+m0edpokMjiqwJGHBdjjArI2xPNH+uXWNQX+/
	qf4Pzimg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKhna-00E8zQ-FE; Sun, 07 Aug 2022 15:02:38 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKhnV-00E8qm-2L
	for linux-nvme@lists.infradead.org; Sun, 07 Aug 2022 15:02:36 +0000
Received: by mail-pf1-x42d.google.com with SMTP id f30so5760639pfq.4
        for <linux-nvme@lists.infradead.org>; Sun, 07 Aug 2022 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZLrT+SYuYyrSNZJ4rIuWgT9eGjJ0lroXecUAQVDE4NU=;
        b=YK6IhcjnGvxOgufslTR1eSsFMT3ZlK5xrm+GKO/rZd/2PctU4DreZv4pTq7yrb3+y4
         W2lILp0VYB+3E8r0j0n//BEXDvg1sRUII0DgmMN6hVj+1jBI+APlpTLRfuTrx+XMSUWo
         cKI9JORiCQMCkAiUhMN4dJG+v2Wopko0xvsdfq5056/vmrs5K8XNOttkI96322mhdSJK
         And/LZx/1h5Ubj01NFDDPDaEzucnjwK4uxaHtl1mB7kba927eqi6jZ3fZVuuob19tEz2
         WHq9eUhsu/H3wWkMnBOlTLWjb/6Bt0k4RtInGwWBG1nnoOaEILhHJu22dltONBI0AXC4
         EgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZLrT+SYuYyrSNZJ4rIuWgT9eGjJ0lroXecUAQVDE4NU=;
        b=UP8qxrV5mKYWeRn0z6BP8a3QmjYv4t8i+NPQNL9ODeQtaT52Jpt8VZAXPQCqRVTF9v
         FYuMkZF5mcyqkCnHVuU3F1Od5YTjHVaM8M7nS+r6ac7HQh+qOkq6GfHBiYQ+AhG16Cxy
         t9BjAbd0GJY7u53rEPSN2qJW6o3HakPIN+T5Di8C7FUbAoxcDUWGpRZ08OtKLlKWbr7J
         n+x//5Dhy50qz9m8jTlx6p2TsD+lXOtxCa2Hnb9P2liLSJKf89w8NP1/0y30uRbJn7EK
         8uwrKA447J0nf9DWk/mL6He/zNth/AszNonfPoEkkiHZwmxdE/R7VDgsJtPKjnw+vjIr
         lYmg==
X-Gm-Message-State: ACgBeo0BjhV9CJ+4/6UIGTTfwmDZie3y2Lkx8koDAZIROq4UkjLdxX6H
	SUuRoNkn1p/aAJ618X3tkGmgZNrFKvw=
X-Google-Smtp-Source: AA6agR48NUvw1x5BxFuh8rYRZe6hnS+0hd6TykhYwtdwdW9tPMlmZYttuFC7lq7YLAD79xVvAgpnBA==
X-Received: by 2002:a62:6497:0:b0:52e:e0cd:1963 with SMTP id y145-20020a626497000000b0052ee0cd1963mr8159557pfb.58.1659884550448;
        Sun, 07 Aug 2022 08:02:30 -0700 (PDT)
Received: from [192.168.122.100] (M106072039032.v4.enabler.ne.jp. [106.72.39.32])
        by smtp.gmail.com with ESMTPSA id x194-20020a6286cb000000b0052abfc4b4a4sm6994313pfd.12.2022.08.07.08.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 08:02:29 -0700 (PDT)
Message-ID: <eb1722e2-8ce6-c30e-8728-8ab5e616413d@gmail.com>
Date: Mon, 8 Aug 2022 00:02:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] nvme: hwmon: Add support for throttling temperature
 feature
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org
References: <20220806054606.7280-1-ikegami.t@gmail.com>
 <20220806083113.GA3986075@roeck-us.net>
 <ae3a4377-440b-af9d-8033-cbfe2d76d135@gmail.com>
 <354484dd-bf1f-8339-c68a-f950fb72d3f7@gmx.de>
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <354484dd-bf1f-8339-c68a-f950fb72d3f7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_080233_197186_F5C7E08F 
X-CRM114-Status: GOOD (  22.26  )
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


On 2022/08/07 5:19, Armin Wolf wrote:
> Am 06.08.22 um 13:58 schrieb Tokunori Ikegami:
>
>> Note: Sorry let me resend the mail below as text format since it was
>> not delivered to the mailing lists as contained HTML subpart.
>>
>> Hi,
>>
>> Thanks for your comments.
>>
>> On 2022/08/06 17:31, Guenter Roeck wrote:
>>> On Sat, Aug 06, 2022 at 02:46:06PM +0900, Tokunori Ikegami wrote:
>>>> NVMe drives support host controlled thermal management feature as
>>>> optional.
>>>> The thermal management temperature are different from the
>>>> temperature threshold.
>>>> So add functionality to set the throttling temperature values.
>>>>
>>>> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
>>
>> I think actually the suggested attributes are not met with the
>> throttling temperatures as below.
>>
>>   temp[1-*]_emergency: Temperature emergency max value, for chips
>> supporting more than two upper temperature limits.
>>   temp[1-*]_lcrit: Temperature critical min value, typically lower
>> than corresponding temp_min values.
>>
>>   Thermal Management Temperature 1 (TMT1): This field specifies the
>> temperature, in Kelvins, when the controller begins to transition to
>> lower power active power states or performs vendor specific thermal
>> management actions while minimizing the impact on performance (e.g.,
>> light throttling) in order to attempt to reduce the Composite
>> Temperature.
>>   Thermal Management Temperature 2 (TMT2): This field specifies the
>> temperature, in Kelvins, when the controller begins to transition to
>> lower power active power states or perform vendor specific thermal
>> management actions regardless of the impact on performance (e.g.,
>> heavy throttling) in order to attempt to reduce the Composite
>> Temperature.
>>
> Maybe those two throttle thresholds could be represented by tempX_crit 
> and tempX_emergency,
> the special throttle effect could be documented in the drivers 
> documentation.
>
> Since tempX_crit is already used to report CCTEMP, maybe this value 
> could be reported with tempX_rated_max instead?
> As far as i know, CCTEMP is the maximum composite temperature rating 
> of the NVME device, so reporting is as tempX_rated_max would make sense.

Thanks for your advice. But actually the throttle thresholds is lower 
than both the current tempX_max and tempX_crit by default so it seems 
that it is difficult to use the current tempX values for the throttle 
thresholds.

Regards,
Ikegami

>
> Armin Wolf
>
>>> NACK. There are several existing limit attributes which can be used
>>> for this purpose. I would suggest to use EMERGENCY and LCRIT 
>>> attributes.
>>>
>>> Furthermore, one can not just extend the hwmon ABI without discussion,
>>> much less as part of a patch introducing its use. Any attribute
>>> introduced
>>> into the ABI must benefit more than one device, and a matching
>>> implementation in the sensors command and the lm-sensors library is
>>> expected.
>>
>> Sorry I am not sure about the hwmon ABI situation but if possible
>> could you please consider or discuss to extend the attributes from
>> this patch review since the suggested attributes seem difficult to use
>> instead? (Is it difficult?)
>> By the way I have already created the lm-sensors pull request below.
>>   <https://github.com/lm-sensors/lm-sensors/pull/406>
>>
>> Regards,
>> Ikegami
>>
>>>
>>> Guenter

