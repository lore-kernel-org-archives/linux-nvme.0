Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8819DCA0FFE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=; b=n3f/dEtRvVHzRDpMFiAcwnVvxQ
	dPInovRGvJP+G0JKFKulH9BSK5AR6hQt13EWUduQ7Q+u6U/r0SvA3phBKhBnv313l5j7SFEPPp+to
	ENDBJf42hzr+3IDrza4hPBVy1fdIqI6HzC/f78bSUDF5rxNDMFaDeEwsV7f4C0OeezoUo5Ba8jntb
	l7xuBIR7YPx3lHu4uMjMbVVuoi4EZWTDKpBcCw5lkbtHHBAqHYOxLuTh1vTZxJ/O9cQgLcgrzY51Q
	yF6oZaWIHUb6s9cU6wzopzq06XiztpnTk7pO0dSE559Lsg4AO6YU8TkeUJCTc2ma7Od1KkejcVHts
	NZ/7Q0pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urs3o-00000004Y1l-40KV;
	Fri, 29 Aug 2025 05:54:04 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urjis-00000003GrC-05Uv
	for linux-nvme@lists.infradead.org;
	Thu, 28 Aug 2025 20:59:55 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-336ada26e92so7010151fa.3
        for <linux-nvme@lists.infradead.org>; Thu, 28 Aug 2025 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414792; x=1757019592; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
        b=bNbOoz7jd1zUHRiCRL2tBBEum/BYcdBfI8tcFvbJBKFcoRBMFS7TyOHZOLInTJE1Qo
         gGWbH50GrJUK62aA0FqcdN+CKeimq5EcOBBQYWkJiP9lqcyZL3ee/Eoj8NzY81u56c9h
         7WtsSaJXmJzgX8DhYYt57eMyL/Ap3gVvwTmdFjMmWlFYqbX9gvEt/NrDjJ76kfmExyHz
         nqQFWMMJZeMQ2RlpP2Zi9GKii6EcyS9bAkRDVkQ2hxG/f/iBpuI5kDRcRruVTOI7owqM
         SpxFgSB2gebBw/bPgQAYiz67qRTGydAJU26hjFjO0aIMGupTa9uvZVxUUuxdqo3cHXFB
         LsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414792; x=1757019592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
        b=MR/8VENgnrsyjdmIQl+LP3mm2wRlzYqBCxboqxpmEi9qCfznc/e0qqisFydFpa3uqT
         ybTDtMRbGGakTminvoyapHidkY4PQXg+j6m/UvMLDNHY28Fj7Gy2iBRntjEpxESyxIxm
         LniJEKFUNFMB0gtapLvY2bwFcIajWdVBz8lCVgp4sVpGzaNztypeb8yfAI+wlgR/Yzs1
         oitiBasoFsfECrLDFZPRrvAHJg794qAqxttzjkaDB6UU7Zww1aYXKdLhAIlBSp6cXuG3
         77GzfcljrGIpFxk+HFC454Wax0OSEGWWpUr78ALFWMjAplRzMCQ5DgC/aEfhmssbRWG7
         KySA==
X-Forwarded-Encrypted: i=1; AJvYcCUIqcIAuXQrA3Ty/4Sv3CPI70Vv3VmtaHCoFrpHtG1FY8OFBciRFroeZmMPuFBsIulqKwEmeofD9leb@lists.infradead.org
X-Gm-Message-State: AOJu0YyAVwkyC8g0VnvJqC24RfWvog9jLEaN5VKIwS7L8Ij6cfAGiDQt
	tyvEELU9ZmEuGS/ZMSgZnNzZI1hklmNDWhg4V3ALvXvZ7g42XB08Tg/JsJmIp7xiZyJ3ZUzmOGK
	yddArS4mnMl71VYxeke54ifyl9xAAzSjxTv2X9q3wyA==
X-Gm-Gg: ASbGncsHy2GvSHTlU7kTZ/TzQmpNYjiIgeUDlg6DG1B8yh0BP3DFOenB2XgMBBIDpWb
	9sHGzA9E0FoWlUpVej5LpcP1PhSXd884jsbbDzEBPbXjJEB7zKc6vzMs5LV5GPGlpTLPN2lgl+y
	GLdvG28itWaxVUHv/h72I+Xsj7qyHGqmsOapcN9AratnQ5EDUX9SA7fvbd8vqpF4UxkzESN6LdT
	ZA2pNI=
X-Google-Smtp-Source: AGHT+IEvCK27Dx3T+NwB4QTV9UIlsAab63smCZ6D7uUks2NtQZowbM82iFbh3N6kvr8t1WPK8CdOU0xtB51L+4ds/dQ=
X-Received: by 2002:a05:651c:3256:10b0:332:3fd0:15fb with SMTP id
 38308e7fff4ca-33650ba8612mr48592831fa.0.1756414792241; Thu, 28 Aug 2025
 13:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:59:41 +0200
X-Gm-Features: Ac12FXyoYnYKNXDomZzl4EdS0dXvIhCV2tkZJGb1B6Y1kaQgUA-l_NpqH411N_c
Message-ID: <CACRpkdbg8KYcDpqDKn9fqs+rL9hLK9mGCj0PTXPBGDW7A_AZbw@mail.gmail.com>
Subject: Re: [PATCH 09/37] dt-bindings: pinctrl: apple,pinctrl: Add
 apple,t6020-pinctrl compatible
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
X-CRM114-CacheID: sfid-20250828_135954_060018_6C84D6BC 
X-CRM114-Status: GOOD (  14.74  )
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
> The M2 Pro/Max/Ultra SoCs use the same pinctrl hardware, so just add its
> per-SoC compatible using the new base as fallback.
>
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

