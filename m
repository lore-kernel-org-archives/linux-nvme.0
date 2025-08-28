Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4D8C8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nhUyagpznBFRZ9pdGyujL8snMtRV7AxzIDv/2iWCkkM=; b=J2bcC1Q1ifwypnsByBQcmuxjs5
	5eHSORlj2+J3hlnvpMoenOem8wPXnJgstAlc7wJh7+PCY9Y9+8IQMF2dVzmJKo1KYq7m3wViLOEnN
	Ekcc3tjzxyyDMnVmTHf/P75qnykVo7Rjv1yosUmcjuWiNpnpBXACdF47ZASc9pTAe53AgajBXyW/i
	DY3Orrobnrk7grEk4KHijszIpmWZb3wlPFb0dM1l1dXaEabCYu1Fvtj9DWr2TjOFR6CP/10ATWB6l
	xMNZdS1Ap9UKUWjeJi0Q++9Rod6w1zgB9DlOHzvOrpibUkEWiTNLnjIIUz6pi6jrIeorOxykJZfT7
	PZatWfDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqyv-00000004Psd-0h0X;
	Fri, 29 Aug 2025 04:44:57 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urjiZ-00000003Gkn-0QkP
	for linux-nvme@lists.infradead.org;
	Thu, 28 Aug 2025 20:59:37 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-55f6507bd53so846034e87.3
        for <linux-nvme@lists.infradead.org>; Thu, 28 Aug 2025 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414773; x=1757019573; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhUyagpznBFRZ9pdGyujL8snMtRV7AxzIDv/2iWCkkM=;
        b=U+STyFWdDuvkV+UOB68EZYOkqoR/c6hO9h6z25eZYvUQnNxvwe1VEMEvZCLLDxBDyV
         a8/8SDYKcyXASsKn2sB9f498MIIIEqkRqKGqqzx7QZb2ideI4RjDhzSU/M2vvw9ZYFAt
         WrDrw61DGIYs86a6cO3+wQiH2nIkJCphFqzxpSFUNl0z+MtLc/47cLzBv2+it/b5GH8a
         MxYXasDviZPaY1Pl5OiOA+nA6c/j81ObUBuaPdmXeiQi80uEQsOr6uVrlm0JDDmzpqEz
         THr82iFlTvRdqYPgjdsWvQPZ3QUoggBvOVt2c0sBGcjPHdSI2DNd3FD+wbgh5TbTPlCS
         C/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414773; x=1757019573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhUyagpznBFRZ9pdGyujL8snMtRV7AxzIDv/2iWCkkM=;
        b=itGfP/gVCRpDp2BZJ0qu0CrCarxHX+JeV4iF9exws9X3SIgw2nialmt3otPJYyT+1C
         Bb8aYDs563xZJyg9Se+6vB+lg85Ke+5rda1CqzrheR1r5tbHEjS7lHEuUCDeY6gVKnhw
         oqIcmzmW9N9smaZUwDq5VnA9IDpNWDab5lfzm+pIK7G7tIlpbo7PAO5EvTiq2Q+/zu2S
         I9lU5mXrr7V4mll8u+orDghwx30pY3oJ3RtMpfE+C8YG3pPj0s036uu/GZ8XNxUtly2O
         E1eIEKUDGhVl8Ie4vy5a9Vi7jXRYCkYK8W6XcQ3O3fPcvYKcWpUYCPFKuIV7KGD/k4Gs
         IigQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdUWj/f8reU0jdHzalKrWz4k5vnIRka/lgYeWw8VvCkbYcdvNgp/SEmYAa6wwCY8l9k/VRrTn0PIcf@lists.infradead.org
X-Gm-Message-State: AOJu0YxQtUXst3BFaCqqPWnT48Ai55opRJOi9nGlqgeOdF+B8w1gHrDI
	xvXYicVxmQJAoEcnzhVLEiojKJfM4fMsWj00xDCjE6IGy4dws8BtqJcj8klwlT8LJ6qrXfR6olW
	LgCpPz4dxgzLxkeOZRlztsJu+/r5xBqI3lRYnL+xZ/g==
X-Gm-Gg: ASbGnctI+MfUBtyODtg7AZuOAwaUgjDCkD1pw/GIDiAZ6MzIljls1EGcVRa32oWttPG
	gVj96FCjxlo3GCqNeAS7GASGQeYJfTERn2W8i/G2Q6dc346FyJMzVRazqEfTzw2Una/N0bndPeB
	GEka2EVMtax6FxBmV138UkBlFjIXlP87XFayaY48EI9JN8fhjV3kiBc1QvrhJwHVdnl+NLNmbwJ
	eLn3i4=
X-Google-Smtp-Source: AGHT+IGkAeRfSepttrAWspST3WxeFhzvmsQkOJn8zGWgyydoFU7mfe7dFpmDKHnPoU/jmN1MyfkA6699WvyfKPSV4Ms=
X-Received: by 2002:a05:6512:6301:b0:55f:503c:d322 with SMTP id
 2adb3069b0e04-55f503cd585mr2344975e87.40.1756414773211; Thu, 28 Aug 2025
 13:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-8-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-8-507ba4c4b98e@jannau.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:59:22 +0200
X-Gm-Features: Ac12FXwdi56r5WxKQlnuWh0e5CWqxbReZCdYkWbkMywpfjpFF5zgYMlMEAzYzgg
Message-ID: <CACRpkdbvLhTQ8EujGg9QMbuGVRDnH9ApVxVt1NdmSmPw77QXdA@mail.gmail.com>
Subject: Re: [PATCH 08/37] pinctrl: apple: Add "apple,t8103-pinctrl" as compatible
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Turquette <mturquette@baylibre.com>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_135935_152068_57D349C3 
X-CRM114-Status: GOOD (  13.58  )
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

On Thu, Aug 28, 2025 at 4:02=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pinctrl" anymore [1]. Use
> "apple,t8103-pinctrl" as fallback compatible as it is the SoC the driver
> and bindings were written for.
>
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

