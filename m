Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78D4C8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VCgz87AQbD+NIqYtaGv4MfNGpvxEv3mxEjPpigap2YI=; b=tP4qMoJFASH5Ad8nLY9xGpAVNx
	TjilDknQIk5eiVKxLhceME6Txd5yx/DVxVE2j7XPfLMawttSzj85FOg6DTs9pthJZNZfiAVhDBD90
	KxSs4JZOI+Dj04xlsX2udoQQd1PFryDJc5IdBYFho+QZYzqANVKpAR2ddH039l1hz/8zM/zOKKjAI
	hvsZuL+29vmkpqeH7/u5TQsLx2E2AGqhg7eS+MLXqn9ySGCVMOPOFkBVK18M8e5vob9+FO+PfEwTq
	5k8B427PQjlq6tRau2wHZeSDgq9fgOdEy+KpjC/0DYCKsosyt1XCQ+KdwQO3VwPZsWm1MzNk3JO4g
	yGPBrbDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urs3o-00000004Y12-0FUH;
	Fri, 29 Aug 2025 05:54:04 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urfEC-00000002DLF-2yVw;
	Thu, 28 Aug 2025 16:11:57 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-24646202152so14062195ad.0;
        Thu, 28 Aug 2025 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756397516; x=1757002316; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCgz87AQbD+NIqYtaGv4MfNGpvxEv3mxEjPpigap2YI=;
        b=J0ihv/FFZ/xmKrxFYJUghnn7G+xQ8uiDvGIj/NwgMTVPI4/OVbIio98TATYCsCb9id
         mOYj7gbh9NrTZnXUcNt48CnNzK+uEtzopI2JaCvusJSJCY1D/zWHNo+cAZaERPlTEX70
         SnZkqjxbbnXIvVrnOL1Xz/L60vD8Nrmyg+yzbSNzWFxaAWm0tcTYfKdaTGPYgKMHaYYl
         19zvy1iQh9FITw6LC9U6QWZ/8IOq94l3xLmZsdOIh86yGINGEzH49zqorGo0qGRH24ik
         5z0YrGgMcRmNrMca7ebrns2roh68+MRJec1ObGZ24ci/JI28kab27uU4pyMOTDUluvhQ
         pOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397516; x=1757002316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCgz87AQbD+NIqYtaGv4MfNGpvxEv3mxEjPpigap2YI=;
        b=bEzM0M60rbsNGhoBr2Hzu8K+WAAkRtKXFWINomSUn5j7c0A/mPvkHzfc3E13wxLWfX
         jsVMFN5xhlp3S2AEPA96wbUOV34/WwVRxhISvot0X5z6hH8mQkiA3Pu8L7ZoAcyKDml/
         6UO9U1NgTskRmSKpzf8mfZmuMwkaS736iJk+g2FTG9Pqhcl42EUbHAeB9D4P1F/mRePw
         ywRQ+WVzCWWF+6nCpjKkMVr6Kb/TpNUReYk2DYveUqB4GkgzYlSVt/LYqDJArShRxvxr
         9bZMe8WOq3Baw7uGtrL4+/7xCLsQrdSzCbswMY+yLOrOCLDIU5nEVoCw/rG8q7r9LLIi
         y3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFvBtsAKQ61YbqKJL8HFB1oO5DLgNlIfSoa/I+8Z5fGRd35poQvZ7XQHgZac47j6/fgc6FU7VUXg7ZymY8fgyO@lists.infradead.org, AJvYcCWFysC87oPip1S6DHPvpiBUZ8iKCgJ8mxgh2X/flZqnt506t2VlRdxcimo5BXHRQNjZQec4QEoFZg485A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+mDfM+WCquAo04GIt+bAKSowX8oWcaaaF0IvXFWS4aKgyLArX
	EOIQ/epkxGo2gQENYivSdCy/JTAQpj6udjbu0RKcYAFg8gm1Bw0zULXP
X-Gm-Gg: ASbGncvXncw7Jj+1eeRkE63yRlN0tVANxyVCVp036vhE8Itd2zWuytDx0OGSzsDf5qN
	xNovgXNg5rc0MxiLN+kkMhaest7W7vUs/0i7LpRStCNamWypT2BKB8ZWImfFG6ovpCfj1QzD3Mh
	B7R5TORAYjwoujXYs3zYFdCy3FaTZVZQOXQw1Lpy0q/kUWC92hGGPC81aydd6OVkFDWS74LajQq
	wxR3E2igcq0IbQzgqjl17JIbomkfeF25mGiWj+HqKmIAOWIlEV/YmsZB4nFb863jf0Yn8e3yZ3h
	smfC4jjrxjlA/wX34G3vecAohm7Vk7mZS8ZhGbkltRj/kUghXKpVuXz1MKvY2FWhHxsoR96tVFy
	99YXNPgJOXwkEI7kSPk0vjddHUBl8yW0pSw71sWb2EKpLYcvAYOJPgZPARTA+jxJH
X-Google-Smtp-Source: AGHT+IEelSOuEo8Npbahj3GwLi0XEymTTpHMsSHpMsvQzhvD7rxDhVw5w3VB77ZuaLmwNpmmTqLyYw==
X-Received: by 2002:a17:903:19ec:b0:248:9e56:e806 with SMTP id d9443c01a7336-2489e56ea30mr87843455ad.12.1756397515676;
        Thu, 28 Aug 2025 09:11:55 -0700 (PDT)
Received: from [192.168.1.111] ([59.188.211.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248a63b5916sm45971445ad.52.2025.08.28.09.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 09:11:55 -0700 (PDT)
Message-ID: <932e0085-c901-40f8-b0d5-67f8f0b934e6@gmail.com>
Date: Fri, 29 Aug 2025 00:11:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
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
 Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_091156_749506_601297B0 
X-CRM114-Status: GOOD (  13.52  )
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


Janne Grunau 於 2025/8/28 晚上10:01 寫道:
> This series adds device trees for Apple's M2 Pro, Max and Ultra based
> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
> follow design of the t600x family so copy the structure of SoC *.dtsi
> files.
[...]
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatibles anymore [1]. Instead either the first
> compatible SoC or t8103 is used as fallback compatible supported by the
> drivers. t8103 is used as default since most drivers and bindings were
> initially written for M1 based devices.
>
> The series adds those fallback compatibles to drivers where necessary,
> annotates the SoC lists for generic compatibles as "do not extend" and
> adds t6020 per-SoC compatibles.

The series is inconsistent about the use of generic fallback compatibles.

"apple,aic2", "apple,s5l-fpwm", "apple,asc-mailbox-v4" is still used.


[...]

Best regards,
Nick Chan

