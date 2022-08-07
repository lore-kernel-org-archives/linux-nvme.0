Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613C2C19F2A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Aug 2022 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccT/Lv9DDxEKJ5TBaKPOTUb8bX0L0Ec0MAdc0eVNtWM=; b=t2JF1B31aX5S9LF2TCfSwmZMsR
	jYlBJt8X+r5Q8txvQ1Ti38o5zThM8sd4phOXF3Ok9bQQ+mci+eqwKcQGr9pgQkUav+mmkgxo+Z5CY
	mkogfiraev7Mn/8hZot/BKqva22n/lDKzTYAQJxFhxd0824nGIDmpxtCalY/6GX9OJZODjBlBhgCH
	4TOOMiIWaqlkJ9ZUTCGHcOVSulosxawWqDFvGhVwGVGKlr1K4urBe6iz6XUF2q0bDwApUVAMTe07Y
	auFZXKKFt9kQET+DN9HGTKOXdX/EeIYig78+B0DEivnmEjnqocM7Amt3KvIBO0z9TDVLl//avZtOX
	jFEmUMZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKhrG-00EFdb-6K; Sun, 07 Aug 2022 15:06:26 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKhrD-00EFNK-7P
	for linux-nvme@lists.infradead.org; Sun, 07 Aug 2022 15:06:24 +0000
Received: by mail-pj1-x1029.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so7025904pjl.0
        for <linux-nvme@lists.infradead.org>; Sun, 07 Aug 2022 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ccT/Lv9DDxEKJ5TBaKPOTUb8bX0L0Ec0MAdc0eVNtWM=;
        b=RU6CWGR8+WxTCtSz4MSMHQFOk23DwBdcGyr2ky5jr/aeOXBGhhn7UsTtZ/nOmZziYt
         yYhvtQvs2Pg4FmuSOnR/fCKo1Y0uedsDMxrwjaWirA/X5rO6K008Hi/Dera26neKoKCO
         E6+wwVUmr3/hiAWGDGLeIpYoBoDBon81Eqn4Zc6LroQ7AcmXzygLXqUhD/odKg/UpVGH
         Xt/4dGmygO6cm34MCe5qc9ob63izaFteyc8UkRU5ybBQoTP6hzoZOr1ZfF6alHhiyP3g
         XDbXcyU8Iy/ZJqyKVTwHyKTth2RaScWoSwzWwVzbHskFKxsLih+3WWAOQZeouX+tIxoG
         5pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ccT/Lv9DDxEKJ5TBaKPOTUb8bX0L0Ec0MAdc0eVNtWM=;
        b=R77FMGjilvnl3gQi9KSZ17RKwzAQX2jkiBspArTeLoD3goXDLr0PnAMzps49IZmd2w
         ZY8FpBwGNz7sLdrhBhVwv2Sh4qSK/ys20JBjS4JLFZVXeom2eFHI8l9qhOIVA53+Vn4k
         C3Tw6cRobnK2QjNTChhmmKkZOyEc3dtARS/ETfmxWhMBrNo6BTKr8fZo6yPMmb6fnSz8
         tEDUD9EKd6CQXAPob+ULN15BNjo/5CZSA+8aXunRtUdMwj37h5/u2cAKwpZ27CqQyW8m
         VPNLJP8TQ6jRCqu8nRqsK+FOg6g6Cp0X/9hTvCKNSRb09HNtzKwB/NJTINkL3hoWZCGb
         4DVw==
X-Gm-Message-State: ACgBeo1GTEYQzy+LWTY+s7Iel6MVtZZ5iVWaltJiFYEwF6giWGGHVXxr
	oTtuj3Bw3lLPIiMuT/bTS+g=
X-Google-Smtp-Source: AA6agR6ztP279UyCIJS65i6/b8KHvFooEObQZ4CPQWj4j9z2S6lly3EHhB+oU/Q3Cdo5Cdv42DNiag==
X-Received: by 2002:a17:902:e552:b0:16d:d3c0:85fb with SMTP id n18-20020a170902e55200b0016dd3c085fbmr14610522plf.38.1659884780148;
        Sun, 07 Aug 2022 08:06:20 -0700 (PDT)
Received: from [192.168.122.100] (M106072039032.v4.enabler.ne.jp. [106.72.39.32])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b0016cbb46806asm6684386plc.278.2022.08.07.08.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 08:06:19 -0700 (PDT)
Message-ID: <a5b9f6a1-1884-0b38-adef-ed47abaf7091@gmail.com>
Date: Mon, 8 Aug 2022 00:06:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] nvme: hwmon: Add support for throttling temperature
 feature
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org
References: <20220806054606.7280-1-ikegami.t@gmail.com>
 <20220806083113.GA3986075@roeck-us.net>
 <ae3a4377-440b-af9d-8033-cbfe2d76d135@gmail.com>
 <20220807060530.GA4018377@roeck-us.net>
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <20220807060530.GA4018377@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_080623_282896_6DC0CF33 
X-CRM114-Status: GOOD (  14.92  )
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


On 2022/08/07 15:05, Guenter Roeck wrote:
> On Sat, Aug 06, 2022 at 08:58:49PM +0900, Tokunori Ikegami wrote:
>> Note: Sorry let me resend the mail below as text format since it was not
>> delivered to the mailing lists as contained HTML subpart.
>>
>> Hi,
>>
>> Thanks for your comments.
>>
>> On 2022/08/06 17:31, Guenter Roeck wrote:
>>> On Sat, Aug 06, 2022 at 02:46:06PM +0900, Tokunori Ikegami wrote:
>>>> NVMe drives support host controlled thermal management feature as optional.
>>>> The thermal management temperature are different from the temperature threshold.
>>>> So add functionality to set the throttling temperature values.
>>>>
>>>> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
>> I think actually the suggested attributes are not met with the throttling
>> temperatures as below.
>>
>>    temp[1-*]_emergency: Temperature emergency max value, for chips supporting
>> more than two upper temperature limits.
>>    temp[1-*]_lcrit: Temperature critical min value, typically lower than
>> corresponding temp_min values.
>>
>>    Thermal Management Temperature 1 (TMT1): This field specifies the
>> temperature, in Kelvins, when the controller begins to transition to lower
>> power active power states or performs vendor specific thermal management
>> actions while minimizing the impact on performance (e.g., light throttling)
>> in order to attempt to reduce the Composite Temperature.
>>    Thermal Management Temperature 2 (TMT2): This field specifies the
>> temperature, in Kelvins, when the controller begins to transition to lower
>> power active power states or perform vendor specific thermal management
>> actions regardless of the impact on performance (e.g., heavy throttling) in
>> order to attempt to reduce the Composite Temperature.
>>
> That happens a lot. That is neither a reason nor an argument to introducing
> new attributes to match chip descriptions. If we would do that, we would end
> up with lots and lots of different and unmanageable attributes.
>
> Please note that the functionality is associated with thermal management,
> so you might want to discuss your attributes with the thermal subsystem
> maintainers.

Okay I see and have understood as it is difficult to use hwmon 
attributes for the thermal management functionality.

Regards,
Ikegami

>
> Guenter

