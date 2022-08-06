Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F2C19F2D
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Aug 2022 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W6YVXdOJyNzhjVV/R81dl8NKiSjcLc3yzGQII4mktQY=; b=fWm07PNjrEXiMSpCe5nq0wFF61
	2BQYpccycvZsFYK25weyBAZ4EN02IPK35/RlcXT/nJDhCUTpzDo/FEGKejZ+ey2EWCTTfPruEeL6r
	mlf7HSsTgr06oteC2//fiI8UvYl75zddbnu66a+OtYPhltZ3Otyd/JBTHQKlGmLYSLfN3e20lTyXI
	OYhw6m+xmVFRV/KOeiKWRI1uZ4mpH+UYhqgjBZNYT3q5b5jqBWqsFvVOYcl0xpRn344G24YgLcIXP
	f9jtPdVXivpHOBxWJDqmuKD/4Zvy9My3w7mU3VYrup4BdJuQ8vmyoe8FARMaHCHpisH4ASc6jvX84
	98+gaCoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKISH-00A7KQ-Tz; Sat, 06 Aug 2022 11:58:57 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKISF-00A7I4-5s
	for linux-nvme@lists.infradead.org; Sat, 06 Aug 2022 11:58:56 +0000
Received: by mail-pl1-x62a.google.com with SMTP id iw1so4740314plb.6
        for <linux-nvme@lists.infradead.org>; Sat, 06 Aug 2022 04:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=W6YVXdOJyNzhjVV/R81dl8NKiSjcLc3yzGQII4mktQY=;
        b=IZsPWEUKUc4BhILCAKFCNpkVj/ZfnWXuHI/mQQwiytzd4OS6NaiO3OE9pY0nvZ35cs
         WOzGXk9oDtpY1RPgazYzzLgCzNyyxlQ+SnK5khPY5Q5tdYCQcBKG+pucl1LgSVcEn5iN
         7V8tcL2Vma0PHWwlzqD7/23Ncowf5PrY9g9v4i93vgnU35dx8A2MS3WU+tP+FeVub0iI
         CQg3WAYFpXKiGV5eEzwHZrd6KloOzW6MN5XjYttMs3FxE+F8zP+HJoh3S9/fIWO2jNKL
         l+Cjxl+WP8toqIXzif6CH2F37kwbmwI3npRS65LManbbVBbYMno92T+V8SZm5AMQbtHs
         QN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=W6YVXdOJyNzhjVV/R81dl8NKiSjcLc3yzGQII4mktQY=;
        b=1LcMg0m3p+Q5VFHeUcTxeQw4mIoGFTHHQaoLsK1uufJbxxernaIZEKNYDyZqBYTVwq
         kE8m9+V929VSkGsMrMRJdufWK9JoiIfFzBAsGwtdHOaejvzIv+VUzmSiDwZeaqL8FFXX
         fbYd1wZuLN+P+q7z0EFBPyhOrPP8AExQBX6oar73hy8zSbyVBgYrIBKvFUjDFoba9ejx
         s1EA6DaGI6kvUumGioaR+i9Qi6WWEWqvmSHuXLCpb5PLlTjUQSfk+pqHYoIf9VTVgyFx
         JgZHZL64TGAgQBIaoTh9w5e2uZvAmJjkpWmm+QgHbpoJaatVlBifw1D9FTn8O/kkPhS7
         av+Q==
X-Gm-Message-State: ACgBeo2GWLVuwaErlJ6Mn58A4GMureGQjgjZ5F8uKOYsmH8Ade0lUSPQ
	iGMFqBw45llDTjKYs+UVW6A=
X-Google-Smtp-Source: AA6agR45FeIVBJ1NbRMwECJlVlbKw/vgIEHaTJx7Yj18ae9woUI6Dw/k/EWVRBKPACne+OmBoj4buQ==
X-Received: by 2002:a17:90b:358:b0:1f5:5c55:752e with SMTP id fh24-20020a17090b035800b001f55c55752emr12292394pjb.151.1659787133063;
        Sat, 06 Aug 2022 04:58:53 -0700 (PDT)
Received: from [192.168.122.100] (M106072039032.v4.enabler.ne.jp. [106.72.39.32])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f70d00b0016f0c2ea158sm4796519plo.157.2022.08.06.04.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 04:58:52 -0700 (PDT)
Message-ID: <ae3a4377-440b-af9d-8033-cbfe2d76d135@gmail.com>
Date: Sat, 6 Aug 2022 20:58:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] nvme: hwmon: Add support for throttling temperature
 feature
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org
References: <20220806054606.7280-1-ikegami.t@gmail.com>
 <20220806083113.GA3986075@roeck-us.net>
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <20220806083113.GA3986075@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220806_045855_242908_1755D82C 
X-CRM114-Status: GOOD (  15.92  )
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

Note: Sorry let me resend the mail below as text format since it was not 
delivered to the mailing lists as contained HTML subpart.

Hi,

Thanks for your comments.

On 2022/08/06 17:31, Guenter Roeck wrote:
> On Sat, Aug 06, 2022 at 02:46:06PM +0900, Tokunori Ikegami wrote:
>> NVMe drives support host controlled thermal management feature as optional.
>> The thermal management temperature are different from the temperature threshold.
>> So add functionality to set the throttling temperature values.
>>
>> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>

I think actually the suggested attributes are not met with the 
throttling temperatures as below.

   temp[1-*]_emergency: Temperature emergency max value, for chips 
supporting more than two upper temperature limits.
   temp[1-*]_lcrit: Temperature critical min value, typically lower than 
corresponding temp_min values.

   Thermal Management Temperature 1 (TMT1): This field specifies the 
temperature, in Kelvins, when the controller begins to transition to 
lower power active power states or performs vendor specific thermal 
management actions while minimizing the impact on performance (e.g., 
light throttling) in order to attempt to reduce the Composite Temperature.
   Thermal Management Temperature 2 (TMT2): This field specifies the 
temperature, in Kelvins, when the controller begins to transition to 
lower power active power states or perform vendor specific thermal 
management actions regardless of the impact on performance (e.g., heavy 
throttling) in order to attempt to reduce the Composite Temperature.

> NACK. There are several existing limit attributes which can be used
> for this purpose. I would suggest to use EMERGENCY and LCRIT attributes.
>
> Furthermore, one can not just extend the hwmon ABI without discussion,
> much less as part of a patch introducing its use. Any attribute introduced
> into the ABI must benefit more than one device, and a matching
> implementation in the sensors command and the lm-sensors library is
> expected.

Sorry I am not sure about the hwmon ABI situation but if possible could 
you please consider or discuss to extend the attributes from this patch 
review since the suggested attributes seem difficult to use instead? (Is 
it difficult?)
By the way I have already created the lm-sensors pull request below.
   <https://github.com/lm-sensors/lm-sensors/pull/406>

Regards,
Ikegami

>
> Guenter

