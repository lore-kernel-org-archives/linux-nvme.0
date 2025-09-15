Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EA7CAC598
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3UAx19vK1YiNrAi97n0gU/rRiRg+M8i65mS2Lnx+jM=; b=ImR3zPcr2y9G6Ilfs4HMqVIH+q
	49bodAaXdwH4oi0ZlGQDLi6P0knGeVDZ6pdTbtyfwTlTh+i5ZV+36g2Wn4bzjFg2cr8tof10lsnis
	BTYE2MmargP/IcElsSDYSLUJU4u5P1xwb3w7ILaSalCCSO8UWJqVa2xvgDnE0haFVj2u27izRn0nz
	N2snt9X2ZLkDhRLNCD0i5iCStIFtmN7fyAWWqe3cSMxyWcazVdN5Zn+bQm+kIsE8dUhD4vkokIE9E
	2CefjO1BUjRVLWu5WOH+Hj7lYvc/WoCh9Wg2e4BQV0z1FvMpGFfiP5N8/iDz+bj7B/1Qtm6x38wUh
	mLmrdyMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyYNp-00000008QcS-1CKe;
	Tue, 16 Sep 2025 16:18:21 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy6n4-00000003mlp-0vOt
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 10:50:35 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-71d603cebd9so32308917b3.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Sep 2025 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757933430; x=1758538230; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a3UAx19vK1YiNrAi97n0gU/rRiRg+M8i65mS2Lnx+jM=;
        b=EXJsrpwRNoleKwCApuecfk590yx99Rskyht9SM1wdGhi1NYS5JAopUQztkS46AXgNz
         ieonu5dvjjgb0TWXIOZQWH388Xfq8wV7Wh/JXnOQiWa71CnfT1+1de2IeOZsFDhCHA+K
         rgdcffvd1QsSapOeJ8TMHtX1FHpsprP3CDacZpsTk7tMvhFP/H4XMwu8EY70hyciCO0q
         w9g0cF4xo3NjOSEkVTNMl+Ov9V9Kmo8nZ3ernlLT0GAwDKicfkgPgC0i4Nc2OXnBuei2
         /TGXjxHC+AI5CVVPFbUHQNlDuIRYS7BWjokXmsmZxUUpyWjb4tQ9KrYwrSIsTg4fuFcv
         xG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933430; x=1758538230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3UAx19vK1YiNrAi97n0gU/rRiRg+M8i65mS2Lnx+jM=;
        b=YLo3UOul4pHi6fzOHtb+V3otvw6AuIkDWWnmyQbQTxDBZXOXwUaYGy1st32n8pXsYu
         53afY5pJmJtr/D9G5hifuEtF0o13aevC2hmLs/RgrK/MBtHP20u4l6zG4dOIGJydXb3E
         5oPPoAY9gJadBWqqeuL8Af2Fs/bypaRWDPcQxmJNcQnE2W4eOq3L0dhbUAYmQ28A+lnW
         G6EgRyZs7kQsSANGi025YzEcYC04Zc4Xs1BCQWVe2v39yd5G5mtB+RKKu8tFfSDLDVQQ
         9gUeSdshZjboti2GO7ANwXXXRFschF/7EGbDEGIzUTmZK1QCGMH/YZzCnz/gUCzhO8vh
         MffA==
X-Forwarded-Encrypted: i=1; AJvYcCVCG4SPtxIwdPkPegSiDg1E1DI/VSkvFwFagSt430HiNvB/6gRP/87r3wULFq0W0dPBS7IkA7ILBLav@lists.infradead.org
X-Gm-Message-State: AOJu0Yw13tWAs+Yn6yXMoXHpybuHy5p1a8AlcwC4L+Lej8jmFgWsMu3X
	19UkB47Oygkh7ORUJexvPwjb3MA9fkrywvIQrPbmmCmr0HbpNxzpc7KV3HZuFDimH+Fjb6DQG+/
	TBz2pfZ3GtfIY97LNA9Wy9gNTjF/DZplJMm/UQeQ20A==
X-Gm-Gg: ASbGncvDvfLqHCuM8OmHcIsSbNqdUIKfreT6xRsEEUYwwOfdSdscvp51AsVyuBT162j
	TYSm2KmucggoSH1z7iDFZo1IrKR8LDTwfwjGT8KQkFZAyiH+qYP/hkJGVy9uB3a5puWEqSd6O8R
	3y0aGkBdawIHTRowcnRMCYjtZlPXgjEUQafTvWtjF9nZp+jpYJ5Dj+UIs/DlGARWVHnJj5TxsQ/
	6U4PpPRc2LzrqJDRwE=
X-Google-Smtp-Source: AGHT+IGDEYgOKM3gJ8Zzlityz/syLNE9FRvDAqAmupyu9aSeveyvR7FHQhtEilEP6qYlMPKL0ImuzwqqE0dGUhFDiNI=
X-Received: by 2002:a05:690c:3706:b0:722:7d35:e0c2 with SMTP id
 00721157ae682-730626d2dd2mr106799857b3.2.1757933429679; Mon, 15 Sep 2025
 03:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-3-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-3-507ba4c4b98e@jannau.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Sep 2025 12:49:53 +0200
X-Gm-Features: Ac12FXxZCAZGblY8VwFHa1GJ1rGV08p3Fv5KI-OAzvQkX2G4ZDMKiAukPP3wanY
Message-ID: <CAPDyKFr9dAvP7U3dZ_LFw8YxcvJ6n95OKKLYpntUarqdfUqjWQ@mail.gmail.com>
Subject: Re: [PATCH 03/37] pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
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
	Marc Zyngier <maz@kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_035034_280707_2A11292B 
X-CRM114-Status: GOOD (  21.38  )
X-Mailman-Approved-At: Tue, 16 Sep 2025 09:18:17 -0700
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

On Thu, 28 Aug 2025 at 16:01, Janne Grunau <j@jannau.net> wrote:
>
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pmgr-pwrstate" anymore [1]. Use
> "apple,t8103-pmgr-pwrstate" as base compatible as it is the SoC the
> driver and bindings were written for.
>
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/apple/pmgr-pwrstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/apple/pmgr-pwrstate.c b/drivers/pmdomain/apple/pmgr-pwrstate.c
> index 9467235110f4654e00ab96c25e160e125ef0f3e5..82c33cf727a825d2536644d2fe09c0282acd1ef8 100644
> --- a/drivers/pmdomain/apple/pmgr-pwrstate.c
> +++ b/drivers/pmdomain/apple/pmgr-pwrstate.c
> @@ -306,6 +306,7 @@ static int apple_pmgr_ps_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id apple_pmgr_ps_of_match[] = {
> +       { .compatible = "apple,t8103-pmgr-pwrstate" },
>         { .compatible = "apple,pmgr-pwrstate" },
>         {}
>  };
>
> --
> 2.51.0
>

