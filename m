Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC55FC282CD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUm+IuBgB6APWPl7lSqAckaEAweKyxvMr5gEa9KGLtI=; b=UJaHAVw8Ia3FWgqTkVcY4v6SnZ
	ChnBGQhYouzSheuEQB1388/pis8QbHJ3Wp6CgVK12Dh9mxaB+QGi1Fnt8QerTc9K6P/+mmoIXDAkq
	EHu92wwcDIIG9QV4REL1EdoDHpq6s+iRl3T8VhDQe7UT/vsi0dQ0ByiPWymI7rrbJnHGfJxGlbslE
	UomSlT1qTlv/TtfkqOU2Qytz3lZoOlWUHBcqgkbO6wxpA7w88S02M0lNve9mMphJSPBB2inD6LsYM
	d20pauIQSZeboWrcss47FZa4of7x4btzF/XyPtahnsrCnmRFrD04GhOHUKFQr/oahfIvkzibRqyxz
	1Zg9XhJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6ie-000000015ra-382F;
	Mon, 03 Mar 2025 14:24:32 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6QX-000000011Sk-3jnA
	for linux-nvme@lists.infradead.org;
	Mon, 03 Mar 2025 14:05:55 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-43994ef3872so28927295e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Mar 2025 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741010748; x=1741615548; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUm+IuBgB6APWPl7lSqAckaEAweKyxvMr5gEa9KGLtI=;
        b=frk2FR85D+EzPoeLL8BvHGBgrnG8iXZstXyOzarakkYje8LaHU2GBJlSY6sBWYuFBm
         qM6uLX4qGkPmV3c8npzk43a3FXAeH5P3ooVM+Zt3GSmNezrUyscPf0hxeoJFoq3fsw9F
         kRSC0Nm+qEOlU763J5shMenee7UIF8VJj8bb1Ug9jrUZDjUvlptOtrGvTkEndjPgYg3D
         VeUtp/c+UFxV3BC/OIrMcKvnsD+512f9X+XtNcM2osZxTAFN1zPE6/7y6r5EzQrowFJb
         VXZ9DJFPTCixHfzlqCOup5KDbFqxLbnrKQEd7+3E5uc5nOde+WTKKi/uGSJrst2kLhLu
         oDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010748; x=1741615548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUm+IuBgB6APWPl7lSqAckaEAweKyxvMr5gEa9KGLtI=;
        b=DWBGj2dHOWHvJMlwqeLPRcTOlTjaaiHgUh1Y7AQtRM4U4H3cfUEkBsupjX16Qd1Cqc
         J83tVGBCcpSyHg7ItBoYbn6LUUMukcR5I6p/xt7nEiB/qZNWV8oKVNRo0WN09srp0I6y
         IY81AIr7xlpGjwaht5fkwPOAlFqexX4X5nxPMyXGfWxrcx/6iLQyDw3S76lLMrRV5SY3
         /AdfkFwTIeFQJ1iGrLgiy/Ry5DrwcwjtS+ZoBwlv9VqNqym8x1IBix29qQND63Oc8CPu
         oy55tsRQuFYXjx0aRPyw8O9b7ey9nbem+0OY+iUCdfu3KGCOitf4v1jKkJEwkhdouBZu
         6sJw==
X-Forwarded-Encrypted: i=1; AJvYcCUB9KiJnAtK5E86FpEzEckaKdAXTs+gQucImcycQNj3ya9ywAyBTYWFbFeqX5WwE4lZIW7eYNbkwvvn@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9BIXA8vfv+Oor6APYhSaygOVOVPJV5jdMzGhKonMp7ZR0DOuj
	V9lisaTt1fWB3ywkeWbyf6GMYLPLGgr+mM5PvHeEA4H0UNenatUQyUSN0keYdgLV/ZhJSAsITjf
	I
X-Gm-Gg: ASbGncssAy5IOdPkhkkEfUT46dT7B5xXxqqsU2y2v++aoC31gIOiiQz9KwfLQLER5Ph
	AGfjDdcNgZImbfGBubEoJ//e20KXpWn2zgaej4WQQ2qgb+n5W8D1EtOUu3wjXehJLdls9XAB9Sr
	sNKl2grwT4/M5P3guCChFxlfxdZunjQ4N4hUk1uH/1vNX5OxRH3cPA0sU31Wg6v5/SFCJ8UBakx
	dDBieN6c/jfmsVCSt/AjXYT5Sz1mPL0Rqr25hvqnNcU8hSKphC/RxZ4w5NuYn2iiyOmSvee9UcO
	D1YxpzgAR5GQXfJmaKpJbOZYXfuY3jAhZhs2QpOZHUvqL6iFAaAq7zD0gCIB+SIYB6Ty2Q==
X-Google-Smtp-Source: AGHT+IENZYGAKhGGuX+reg/HEx/v9egLPYmiHrtkAc8bPgbK1X7fR/YecuxaGJgrJpEyFaOmZI5/VA==
X-Received: by 2002:a05:600c:5014:b0:439:9a40:aa09 with SMTP id 5b1f17b1804b1-43ba730d731mr93722455e9.25.1741010748204;
        Mon, 03 Mar 2025 06:05:48 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba539450sm189870885e9.21.2025.03.03.06.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:05:47 -0800 (PST)
Message-ID: <edb23775-1688-4804-86c0-eb5615871b0f@suse.com>
Date: Mon, 3 Mar 2025 15:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Matthew Wilcox <willy@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
 <Z8W1Z7m_fWse8KWz@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <Z8W1Z7m_fWse8KWz@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_060549_942799_A5770418 
X-CRM114-Status: GOOD (  13.44  )
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

On 3/3/25 14:57, Matthew Wilcox wrote:
> On Mon, Mar 03, 2025 at 12:06:18PM +0100, Hannes Reinecke wrote:
>> On 3/3/25 08:48, Hannes Reinecke wrote:
>>> On 2/28/25 11:47, Hannes Reinecke wrote:
>>>> Hi Sagi,
>>>>
>>>> enabling TLS on latest linus tree reliably crashes my system:
>>>>
>>>> [  487.018058] ------------[ cut here ]------------
>>>> [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719
>>>> free_large_kmalloc+0x15/0xa0
>> [ .. ]
>>>>
>>>> Haven't found a culprit for that one for now, started bisecting.
>>>> Just wanted to report that as a heads-up, maybe you have some idea.
>>>>
>>>
>>> bisect is pointing to
>>> 9aec2fb0fd5e ("slab: allocate frozen pages")
>>> and, indeed, reverting this patch on top of linus current resolves
>>> the issue.
>>>
>>> Sorry Matthew.
>>>
>> It's getting even worse; after reverting above patch I'm getting a crash
>> here:
> 
> If you revert that, you also need to revert 8c6e2d122b71.
> 
> But let me dig into the original problem.  The fact that it's
> kmalloc_large might be a clue.

Let me know if you need more details.

Incidentally, there's a blktest unit for TLS now:

https://github.com/osandov/blktests/pull/158

which should allow you to recreate the issue locally.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

