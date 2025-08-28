Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80DBCA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D+bpvOaQAXy7s2cVIMAXdoNDiAVCsEFrmVcS+pTDris=; b=GGeul8sCq1LaEWMtGz0rcZqr5c
	OBz2nliNmGmi26Bi8PwPN81GwT2xo37y1kclzFiTemXc8+SUvVMrrbRAuFhYM4zWCq4WR8KJ1YORj
	u6h6veGP3sKOy8xVlBaZQrCVRn3+hk/DmU82qm7VaZ1P5+87nbypHdNiN2aEfBrtvCBnB+rfUx2nX
	dOEG8DOYqDqeAPEj2YzRwlUYZkfbvedVAZ93EUd0Bk+QobKT0/TGrUJrwnVIbetGH1FkrGCAsXDXb
	j7ALRAdOltio3xnLZlvuveDRSUi4w82v1guqXAtxr8S+Is7P5/dsaKxm5fiQJTWBLT+/xrrFGEMBy
	Op/uPCbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urr23-00000004Rsn-0xuJ;
	Fri, 29 Aug 2025 04:48:11 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ureSJ-000000025gC-40jk;
	Thu, 28 Aug 2025 15:22:29 +0000
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afec5651966so190107266b.2;
        Thu, 28 Aug 2025 08:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756394546; x=1756999346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+bpvOaQAXy7s2cVIMAXdoNDiAVCsEFrmVcS+pTDris=;
        b=vJqYwlalfTnfVGpphury3TA7HlttAXkOW08RkIMmUe/muTDKHwuC5OiWMS8V6E6lWN
         1mrXtDLVSa1zabWEsoJzA2HNyurp0V1tMK3z2nvC2/yaWcRup6ZVoXvLL14Pa/tOTfwz
         Rq07zSZ3mDXME5CLxJ31sLGlH7OishldAmYi0cQz21qzM2O2KCcDO8fDHjrIUkpDEW8i
         TLYdVSY5t4g87TDjK1HhzPFkkweVc2HdguRmZjaA8Vx10oVmNS9Sfzh1kTDsUziA3eGQ
         VnVmZhUGwMbUs9eATJwkw/r82G/t0aD6XOaj8O3u6BjHqHlPnWrfVG+mrRIxwXj8u5mv
         +Lzw==
X-Forwarded-Encrypted: i=1; AJvYcCU2zEP+3B1sPkJQoqKsCMtoRRNMXkM+3pk1Uu4q/jeH8BBPzd2NyEiUs23Fi0f7E53oBQrm+qXrBe9Gdg==@lists.infradead.org, AJvYcCXHPdHDKV3N4G/53jmXH29DM/q0yx5HbNGbeDsQ1AsJ75Wpan5tO32bUSQ+DXdnZ8JV/VlQoeTjb5tbcfDOFc0g@lists.infradead.org
X-Gm-Message-State: AOJu0YygGHHxrrrM+YbFEKg4t02im/JBbvDaaJbOnPsQ5IHGQX03/iBK
	MsTomcVG0YPqphEFR8NwsGOK+7xMNLFZJt596FvmoKssAGlAeUFRP25wNKIEbALc0jU=
X-Gm-Gg: ASbGnctWjKX7tqv7VGg1y27HDE7pQLmsBme3rxF6Hhgn8HN5Rl+lrcJQbg/uJWt55uY
	YLu5INCRezSAsJSjHInTUfNHMJ+reu6W5m6Oqo9v9bDgTOwfwWigl1NETYXUiXWqVgaHY6bAxMt
	OzeWqyeFv7hWXmM4Ka03dXFflemzA3XOz8Jaaam75se8zLklgoKp9vojAM1ikHKf6tfTJfbFPnp
	dlfP4FJVAA7q9Mu5Flddbc+0wjgZdtw/rp+rjeTShTOQOEKzfNAclaHDuK3UKEzW3gcOLosBbMO
	CAs943RGAiDdbOqEAyTv5j3JXpiyD03l7nuzO6bhPDTdlIWXS72nAJJuKVRqTbflNv+pg71GxnV
	w2I0FLX55D1KVQsjVNVQtX/WzrYHauuyhf3kxtfa4m9A8uuD5cZJqgAPBkDUjlhKbyCTiuWoXuG
	7z7zS3JfmU
X-Google-Smtp-Source: AGHT+IH8G70tXPvDSWuckuJG7BsqoBHl+dv+Gd9ca8x5Vm+bqDITr+H4joAspGFyZByUDwI0xRvkmg==
X-Received: by 2002:a17:907:7f26:b0:afe:ea46:e808 with SMTP id a640c23a62f3a-afeea4747aemr202817066b.47.1756394545826;
        Thu, 28 Aug 2025 08:22:25 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cdfdbdfb5sm1359132a12.26.2025.08.28.08.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 08:22:25 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afec5651966so190103466b.2;
        Thu, 28 Aug 2025 08:22:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKQA/Oqa2fJqlIvL8vYSt+65j42tD7YCD7a1NLNUjcoaMnBy18iyCLoxtBGrOoqd4OOKUL4cAl2Eh4eO/whsA2@lists.infradead.org, AJvYcCXeoPtRVLdnF0z6uakdCsCJN+hMXdMWPIuxv4InwTJSTzpS07cC0S+MAnsNlDWd8JPDGWbghVgiQxDp/A==@lists.infradead.org
X-Received: by 2002:a17:907:7242:b0:afe:9f26:5819 with SMTP id
 a640c23a62f3a-afe9f265912mr972062166b.28.1756394208258; Thu, 28 Aug 2025
 08:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 28 Aug 2025 11:16:11 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_FrHRE+X9s6od4O8r6VkkKfnie-NytMjxv3We6ee5Ghg@mail.gmail.com>
X-Gm-Features: Ac12FXwTZkDFtMlRGwhEx_nT-vIpwFaGSzleOTcRqJhHRnUCSpwpt1CTW2uLk5I
Message-ID: <CAEg-Je_FrHRE+X9s6od4O8r6VkkKfnie-NytMjxv3We6ee5Ghg@mail.gmail.com>
Subject: Re: [PATCH 00/37] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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
X-CRM114-CacheID: sfid-20250828_082227_989557_2FF60BE6 
X-CRM114-Status: GOOD (  36.28  )
X-Mailman-Approved-At: Thu, 28 Aug 2025 21:48:10 -0700
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

On Thu, Aug 28, 2025 at 10:01=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> This series adds device trees for Apple's M2 Pro, Max and Ultra based
> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
> follow design of the t600x family so copy the structure of SoC *.dtsi
> files.
>
> t6020 is a cut-down version of t6021, so the former just includes the
> latter and disables the missing bits.
>
> t6022 is two connected t6021 dies. The implementation seems to use
> t6021 and disables blocks based on whether it is useful to carry
> multiple instances. The disabled blocks are mostly on the second die.
> MMIO addresses on the second die have a constant offset. The interrupt
> controller is multi-die aware. This setup can be represented in the
> device tree with two top level "soc" nodes. The MMIO offset is applied
> via "ranges" and devices are included with preprocessor macros to make
> the node labels unique and to specify the die number for the interrupt
> definition.
>
> The devices itself are very similar to their M1 Pro, M1 Max and M1 Ultra
> counterparts. The existing device templates are SoC agnostic so the new
> devices can reuse them and include their t602{0,1,2}.dtsi file. The
> minor differences in pinctrl and gpio numbers can be easily adjusted.
>
> With the t602x SoC family Apple introduced two new devices:
>
> The M2 Pro Mac mini is similar to the larger M1 and M2 Max Mac Studio. Th=
e
> missing SDHCI card reader and two front USB3.1 type-c ports and their
> internal USB hub can be easily deleted.
>
> The M2 Ultra Mac Pro (tower and rack-mount cases) differs from all other
> devices but may share some bits with the M2 Ultra Mac Studio. The PCIe
> implementation on the M2 Ultra in the Mac Pro differs slightly. Apple
> calls the PCIe controller "apcie-ge" in their device tree. The
> implementation seems to be mostly compatible with the base t6020 PCIe
> controller. The main difference is that there is only a single port with
> with 8 or 16 PCIe Gen4 lanes. These ports connect to a Microchip
> Switchtec PCIe switch with 100 lanes to which all internal PCIe devices
> and PCIe slots connect too.
>
> This series does not include PCIe support for the Mac Pro for two
> reasons:
> - the linux switchtec driver fails to probe and the downstream PCIe
>   connections come up as PCIe Gen1
> - some of the internal devices require PERST# and power control to come
>   up. Since the device are connected via the PCIe switch the PCIe
>   controller can not do this. The PCI slot pwrctrl can be utilized for
>   power control but misses integration with PERST# as proposed in [1].
>
> This series depends on "[PATCH v2 0/5] Apple device tree sync from
> downstream kernel" [2] due to the reuse of the t600x device templates
> (patch dependencies and DT compilation) and 4 page table level support
> in apple-dart and io-pgtable-dart [3] since the dart instances report
> 42-bit IAS (IOMMU device attach fails without the series).
>
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatibles anymore [1]. Instead either the first
> compatible SoC or t8103 is used as fallback compatible supported by the
> drivers. t8103 is used as default since most drivers and bindings were
> initially written for M1 based devices.
>
> The series adds those fallback compatibles to drivers where necessary,
> annotates the SoC lists for generic compatibles as "do not extend" and
> adds t6020 per-SoC compatibles.
>
> [1]: https://lore.kernel.org/linux-pci/20250819-pci-pwrctrl-perst-v1-0-4b=
74978d2007@oss.qualcomm.com/
> [2]: https://lore.kernel.org/asahi/20250823-apple-dt-sync-6-17-v2-0-6dc0d=
aeb4786@jannau.net/
> [3]: https://lore.kernel.org/asahi/20250821-apple-dart-4levels-v2-0-e39af=
79daa37@jannau.net/
> [4]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Hector Martin (3):
>       arm64: dts: apple: Add initial t6020/t6021/t6022 DTs
>       arm64: dts: apple: Add J414 and J416 Macbook Pro device trees
>       arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra, 2023) device tree
>
> Janne Grunau (34):
>       dt-bindings: arm: apple: Add t6020x compatibles
>       dt-bindings: arm: apple: apple,pmgr: Add t6020-pmgr compatible
>       pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"
>       dt-bindings: power: apple,pmgr-pwrstate: Add t6020 compatible
>       dt-bindings: cpufreq: apple,cluster-cpufreq: Add t6020 compatible
>       dt-bindings: interrupt-controller: apple,aic2: Add apple,t6020-aic =
compatible
>       dt-bindings: iommu: dart: Add apple,t6020-dart compatible
>       pinctrl: apple: Add "apple,t8103-pinctrl" as compatible
>       dt-bindings: pinctrl: apple,pinctrl: Add apple,t6020-pinctrl compat=
ible
>       dt-bindings: i2c: apple,i2c: Add apple,t6020-i2c compatible
>       dt-bindings: mailbox: apple,mailbox: Add t6020 compatible
>       dt-bindings: gpu: apple,agx: Add agx-{g14s,g14c,g14d} compatibles
>       dt-bindings: iommu: apple,sart: Add apple,t6020-sart compatible
>       nvme-apple: Add "apple,t8103-nvme-ans2" as compatible
>       dt-bindings: nvme: apple: Add apple,t6020-nvme-ans2 compatible
>       dt-bindings: net: bcm4377-bluetooth: Add BCM4388 compatible
>       dt-bindings: net: bcm4329-fmac: Add BCM4388 PCI compatible
>       mfd: macsmc: Add "apple,t8103-smc" compatible
>       dt-bindings: mfd: apple,smc: Add t6020-smc compatible
>       dt-bindings: pwm: apple,s5l-fpwm: Add t6020-fpwm compatible
>       spmi: apple: Add "apple,t8103-spmi" compatible
>       dt-bindings: spmi: apple,spmi: Add t6020-spmi compatible
>       watchdog: apple: Add "apple,t8103-wdt" compatible
>       dt-bindings: watchdog: apple,wdt: Add t6020-wdt compatible
>       clk: clk-apple-nco: Add "apple,t8103-nco" compatible
>       dt-bindings: clock: apple,nco: Add t6020-nco compatible
>       dmaengine: apple-admac: Add "apple,t8103-admac" compatible
>       dt-bindings: dma: apple,admac: Add t6020-admac compatible
>       ASoC: apple: mca: Add "apple,t8103-mca" compatible
>       ASoC: dt-bindings: apple,mca: Add t6020-mca compatible
>       spi: apple: Add "apple,t8103-spi" compatible
>       spi: dt-bindings: apple,spi: Add t6020-spi compatible
>       arm64: dts: apple: Add ethernet0 alias for J375 template
>       arm64: dts: apple: Add J474s, J475c and J475d device trees
>
>  Documentation/devicetree/bindings/arm/apple.yaml   |   39 +-
>  .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |   33 +-
>  .../devicetree/bindings/clock/apple,nco.yaml       |   17 +-
>  .../bindings/cpufreq/apple,cluster-cpufreq.yaml    |    3 +
>  .../devicetree/bindings/dma/apple,admac.yaml       |   17 +-
>  .../devicetree/bindings/gpu/apple,agx.yaml         |    6 +
>  .../devicetree/bindings/i2c/apple,i2c.yaml         |   27 +-
>  .../bindings/interrupt-controller/apple,aic2.yaml  |    1 +
>  .../devicetree/bindings/iommu/apple,dart.yaml      |   14 +-
>  .../devicetree/bindings/iommu/apple,sart.yaml      |    4 +-
>  .../devicetree/bindings/mailbox/apple,mailbox.yaml |    1 +
>  .../devicetree/bindings/mfd/apple,smc.yaml         |   17 +-
>  .../net/bluetooth/brcm,bcm4377-bluetooth.yaml      |    1 +
>  .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    1 +
>  .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |   29 +-
>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |   27 +-
>  .../bindings/power/apple,pmgr-pwrstate.yaml        |   27 +-
>  .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    3 +-
>  .../devicetree/bindings/sound/apple,mca.yaml       |   17 +-
>  .../devicetree/bindings/spi/apple,spi.yaml         |   16 +-
>  .../devicetree/bindings/spmi/apple,spmi.yaml       |   17 +-
>  .../devicetree/bindings/watchdog/apple,wdt.yaml    |   27 +-
>  arch/arm64/boot/dts/apple/Makefile                 |    8 +
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi          |    1 +
>  arch/arm64/boot/dts/apple/t6020-j414s.dts          |   26 +
>  arch/arm64/boot/dts/apple/t6020-j416s.dts          |   26 +
>  arch/arm64/boot/dts/apple/t6020-j474s.dts          |   47 +
>  arch/arm64/boot/dts/apple/t6020.dtsi               |   22 +
>  arch/arm64/boot/dts/apple/t6021-j414c.dts          |   26 +
>  arch/arm64/boot/dts/apple/t6021-j416c.dts          |   26 +
>  arch/arm64/boot/dts/apple/t6021-j475c.dts          |   37 +
>  arch/arm64/boot/dts/apple/t6021.dtsi               |   69 +
>  arch/arm64/boot/dts/apple/t6022-j180d.dts          |  121 ++
>  arch/arm64/boot/dts/apple/t6022-j475d.dts          |   42 +
>  arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi         |   38 +
>  arch/arm64/boot/dts/apple/t6022.dtsi               |  347 +++
>  arch/arm64/boot/dts/apple/t602x-common.dtsi        |  465 ++++
>  arch/arm64/boot/dts/apple/t602x-die0.dtsi          |  577 +++++
>  arch/arm64/boot/dts/apple/t602x-dieX.dtsi          |  129 ++
>  arch/arm64/boot/dts/apple/t602x-gpio-pins.dtsi     |   81 +
>  arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi     |   45 +
>  arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi     |   38 +
>  arch/arm64/boot/dts/apple/t602x-nvme.dtsi          |   42 +
>  arch/arm64/boot/dts/apple/t602x-pmgr.dtsi          | 2268 ++++++++++++++=
++++++
>  drivers/clk/clk-apple-nco.c                        |    1 +
>  drivers/dma/apple-admac.c                          |    1 +
>  drivers/mfd/macsmc.c                               |    1 +
>  drivers/nvme/host/apple.c                          |    1 +
>  drivers/pinctrl/pinctrl-apple-gpio.c               |    1 +
>  drivers/pmdomain/apple/pmgr-pwrstate.c             |    1 +
>  drivers/spi/spi-apple.c                            |    1 +
>  drivers/spmi/spmi-apple-controller.c               |    1 +
>  drivers/watchdog/apple_wdt.c                       |    1 +
>  sound/soc/apple/mca.c                              |    1 +
>  54 files changed, 4722 insertions(+), 113 deletions(-)
> ---
> base-commit: 50ee15a27ec4cc41e99ee5e9011de7875569cd52
> change-id: 20250811-dt-apple-t6020-1359ce9bf2e7
> prerequisite-change-id: 20250813-apple-dt-sync-6-17-d1fc1c89f7ca:v2
> prerequisite-patch-id: 1405c7c78139704a4cbeb1adc67786b2c7971a3f
> prerequisite-patch-id: 65865050e9e7427bac04f47d0b7927aacaac19bd
> prerequisite-patch-id: 9240e5f435fb3406e77b4e4e9b02eb3d52e660e6
> prerequisite-patch-id: c16715c9a9fcb396b7e4365fd767b05604b8de81
> prerequisite-patch-id: a675ad20c2b427a021dafb5d6c8716497741604c
>

This is quite a series, but pretty straightforward.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

