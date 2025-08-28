Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A06CA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SS4pv8uyaXLZEUMjbC2GJgsLUt5PP91S4SC3iNr8JIE=; b=A8uL9WgpeYmoXgAzNGr5V4QWbw
	3F5lJcONMk+UR6Hn37iSI8pGuZS/hsd2G/3gvRot585mqYnlrVc8Z2sKROsmbbl/JdiXF3ffSn0c/
	ec1RZg4f3VFcX3EvspDa6QVPMc2G2Q2XoIMfYwklT9nP6Vb4LWyj8nsW2j57TWJ4KAGMHLGtalrQE
	h6AmQ8dnI8IKiuSPQgRSPwVamqoKAqgx0VYA2ztvkTXocYuLjrAohmYuOX0AC2RTRf1GhToopRLEk
	MQ2ukRIRkY8AMLxvin/zhtvT3EVmCsYNrzACCB7v/N5Gi84miNrF3Pk6tgK345CwbqWFnebIu3o5L
	bHGPhcow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqyc-00000004PRL-1ZzS;
	Fri, 29 Aug 2025 04:44:38 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urgHA-00000002Oep-3L5o;
	Thu, 28 Aug 2025 17:19:05 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2445805aa2eso12945745ad.1;
        Thu, 28 Aug 2025 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756401544; x=1757006344; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SS4pv8uyaXLZEUMjbC2GJgsLUt5PP91S4SC3iNr8JIE=;
        b=YwVJe1iSUZct66B0tM+6Xef4LyREZO2ak846ufIQNrxdxgeHn/eVfjDEDy8UDOAKxD
         dGc63Gi5HhUZGwcxDGzsAbwcE53beM943eA2KmcIsfid5qiLwMb5fuVRGMBdyXWxU/1Y
         nsm75smBehJwHKRRw+C9S/hOSWSJzRsv3nJh4ijGwti440iRM9vdFXAwh96A+9icSlF2
         kdx7/RAOa18iilj67dMKbytf5OFLyiRo7p6nQiY+j7fV5lI7Z+91tB42KWyZGw0cgOww
         h56FnUFX5xSPVI4Cr1GdVlF1Ey44/Ew5XLxvwvWU0Tgoa417NlxnrcVPj/q8TWc3sMNe
         66WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756401544; x=1757006344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SS4pv8uyaXLZEUMjbC2GJgsLUt5PP91S4SC3iNr8JIE=;
        b=GMINmgwEYa2w1OZduRb/HmGHmIXIaG4q8R77k/4m0bIwAEyG+NYsaYAlpBYLo8E/mX
         Rh40iwxu7vJzrdeYyDWpNu2bgwCeyEpbEgP6bwEo1Fdb62rdzyMKurKhR/9w6UZkVpc5
         F5ZszDyGNpE5X8seaNInokvZtNxxMlFTMjkiY4x5TcRLXerA3o4Ev/kXc2HREjbfy0dG
         aniixwlSlS6ADQDaICngOrtI9oGJ22bjtnIOpf+Q79oYaVk0gFH14lh3JjS4WlSka8Mf
         M6ymANOG3GyBZp041pZxevxIoiKd+i3ep5vbYr8VyR/uAHrb8NjJVfJOFbndUOJCjd5Z
         J9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUFRUmrsCWPT+eKwfVwNj+qgsqVSnoET28AOSmzY/4Slf6qeCCPsZsybTsRCgX1Ql6gUauxi46+arn8DA==@lists.infradead.org, AJvYcCWRhFJqaFaso8OmhWlljoBNgZKriUfjCgyPMWgq7qkvrE0QQE9irn8P5TUa+Ug4qmlEEo7/otbfYJdO5qWZQzBs@lists.infradead.org
X-Gm-Message-State: AOJu0YxBgSbdDtSQr7NZJakhw/rfnlOujAu6zqe/xRtcIa6HImYGGThy
	ljdzwqKwJsr+c+w7bZJv39UBMgS0RNLiAU2DDmTE5vWfjXl5EZF+udPH
X-Gm-Gg: ASbGncug7VkKPKFIta1K5fA4ps1jUQcG0q1SzYUYYiK5588X8hc357va4MuH30MxNCR
	lKmYPaBxNncCDl6xSTe/QD6zWrC+QqlEOCFJNsKumM5dAEc4jgvSBEWM0tpxn7DUCAZickqeEHT
	Pt+nOkIGK96bbS6r8cX2PbrShyryaJKGiKz/9iMPPew3gaeLFnSCIlZN56ATSPpcftsTbXMcXr4
	3tMzGJszQdvcw+PbTwjh4or7676S8Srd6j9/x65ou9HVF8X6MeqLlRJqvpJzuFV1CEefFHDXKxp
	8eRJSMYifF+0Ltv5CSGo2GoIxkgR0Tebazgp+cX8HaV0THPX1CDIupSxpLfxrbbDN2MaSK4pJFj
	UfsGo5z1H4B9JxuO9Oui10Ay4f+n+vw6kg/UnBUJOpRy6iK/4laQg7A==
X-Google-Smtp-Source: AGHT+IFPj3GBG1tXe0w52JDhOrrrStWKIT6zs8hpAEsM8UEVZqo8QCtKE2lg8olsPKFlf0oBzRgObQ==
X-Received: by 2002:a17:903:2391:b0:249:308:353 with SMTP id d9443c01a7336-2490308048fmr5489935ad.41.1756401543466;
        Thu, 28 Aug 2025 10:19:03 -0700 (PDT)
Received: from [192.168.1.111] ([59.188.211.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da2f20sm739185ad.82.2025.08.28.10.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 10:19:02 -0700 (PDT)
Message-ID: <86ab9bd4-9a4f-4ae9-930f-5fb9ef69c963@gmail.com>
Date: Fri, 29 Aug 2025 01:18:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>,
 Lee Jones <lee@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Michael Turquette <mturquette@baylibre.com>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
 <932e0085-c901-40f8-b0d5-67f8f0b934e6@gmail.com>
 <20250828165012.GC204299@robin.jannau.net>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250828165012.GC204299@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_101904_836774_572764E7 
X-CRM114-Status: GOOD (  18.71  )
X-Mailman-Approved-At: Thu, 28 Aug 2025 21:42:14 -0700
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


Janne Grunau 於 2025/8/29 凌晨12:50 寫道:
> On Fri, Aug 29, 2025 at 12:11:40AM +0800, Nick Chan wrote:
>> Janne Grunau 於 2025/8/28 晚上10:01 寫道:
>>> This series adds device trees for Apple's M2 Pro, Max and Ultra based
>>> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
>>> follow design of the t600x family so copy the structure of SoC *.dtsi
>>> files.
>> [...]
>>> After discussion with the devicetree maintainers we agreed to not extend
>>> lists with the generic compatibles anymore [1]. Instead either the first
>>> compatible SoC or t8103 is used as fallback compatible supported by the
>>> drivers. t8103 is used as default since most drivers and bindings were
>>> initially written for M1 based devices.
>>>
>>> The series adds those fallback compatibles to drivers where necessary,
>>> annotates the SoC lists for generic compatibles as "do not extend" and
>>> adds t6020 per-SoC compatibles.
>> The series is inconsistent about the use of generic fallback compatibles.
>>
>> "apple,aic2", "apple,s5l-fpwm", "apple,asc-mailbox-v4" is still used.
> Those are less generic than say "apple,spi". For "apple,aic2" especially
> it's clear which SoCs use it and the set is closed (ignoring iphone SoCs
> which very likely will never run linux). For the interrupt controller
> the fallout of not using the "apple,aic2" is larger since even m1n1
> expect that. irq driver is special in so far as it requires more than
> adding a compatible.
> I think "apple,s5l-fpwm" and "apple,asc-mailbox-v4" are specific enough
> and describe simple hardware so the will not cause issues unlike the
> complex firmware based "apple,nvme-ans2".

All of these compatibles has around the same specificity as "apple,nvme-ans2" which is
a mistake of using A11's version (ans2) to describe the M1 nvme (ans3). Though I do agree
"apple,asc-mailbox-v4", "apple,s5l-fpwm" and "apple,aic2" should be fine compatibility-wise.

Although AIC2 compatible should be fine that may not hold for later versions since Linux's
AIC driver is actually AIC + core complex FIQ stuff, so when you do add newer AICs it is
probably better to use SoC-specific compatible there.

>
> Janne
>
Best regards,
Nick Chan

