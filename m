Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFBFCAC5BE
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Sep 2025 06:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:To:Cc:From:
	Subject:References:In-Reply-To:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WAbk4PWWXEXWUyECLBWj+jZRHQjNujjT1F6/7IR7Wkc=; b=3DB92k0WMSEA7A6+jEu0QjCZut
	7Kg6E9WuPXzlPAEMb08w9wKsRmaLiAm98I8Xc69Sf5HF4IBejVD76/QBU0ZZZQUXg1hATUp1aBgrn
	csvUC0GGnx8hx7L78wo+8N6i1Eu9n1qx7wlGPAf9RYJb4kAUP3JMYGlJJp7S830dXsa/Zm+VPD3G7
	zSFNpFkoG7gziUVUGh96rU8flEY5zAPed3qjc2tGQGydJjfGkXkuZdL+UDmzOAe6G3OV0fFv+JVFG
	R6z9ipWn0VHZy5D7vxWW51e9NSYsYTNsn09HoGMXus0rh68l/DN3TJsS2GrmHCuVw07Ex7s3u66TD
	IT06YRKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2ORB-00000007f9W-1Y5L;
	Sat, 27 Sep 2025 06:29:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0McG-00000007j9E-0D4U;
	Sun, 21 Sep 2025 16:08:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 23261601D8;
	Sun, 21 Sep 2025 16:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8CDC4CEE7;
	Sun, 21 Sep 2025 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758470922;
	bh=WAbk4PWWXEXWUyECLBWj+jZRHQjNujjT1F6/7IR7Wkc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=k9VA4+OvtF9WMxvlQ8gfo6xoYVgPhME93HuDeyjVf3VJQKg5L51KazbJGvnQm02j3
	 GEWkqrPtWUqFxr15WM4BpVIZ9dGHMDnsux1aleg52r5KyYv+LHxTGl3b169Cwpso2A
	 yUbcEIYwho2ZjYgeMp0c05LtDAyQHhYgWuVOQykRCV8P/ZAO0A2xrsHUFcZ1ZYVztd
	 hVuGVTIdguTJgiGej5woK5cjYGCQTRMU+ddYcO0s3teIMgUWENJJnMWoMVmgI+Xo//
	 WXIz1Ll5H7P+4YaCUMRhwXoBllRaGg+2qQdNCRdAyyrY7rJGZ0a5/DxMDhjkybdc75
	 H1Hi9m6Bn3eAQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250828-dt-apple-t6020-v1-26-507ba4c4b98e@jannau.net>
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-26-507ba4c4b98e@jannau.net>
Subject: Re: [PATCH 26/37] dt-bindings: clock: apple,nco: Add t6020-nco compatible
From: Stephen Boyd <sboyd@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org, Janne Grunau <j@jannau.net>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Andi Shyti <andi.shyti@kernel.org>, Christoph Hellwig <hch@lst.de>, Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Jaroslav Kysela <perex@perex.cz>, Jassi Brar <jassisinghbrar@gmail.com>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, Johannes Berg <johannes@sipsolutions.net>, Keith Busch <kbusch@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Marc Zyngier <maz@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Mark Brown <broonie@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <
 mturquette@baylibre.com>, Neal Gompa <neal@gompa.dev>, Rafael J. Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Sasha Finkelstein <fnkl.kernel@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sven Peter <sven@kernel.org>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Thomas Zimmermann <tzimmermann@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Vinod Koul <vkoul@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, van Spriel <arend@broadcom.com>
Date: Sun, 21 Sep 2025 09:08:41 -0700
Message-ID: <175847092150.4354.4054733553683969208@lazor>
User-Agent: alot/0.11
X-Mailman-Approved-At: Fri, 26 Sep 2025 23:29:38 -0700
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

Quoting Janne Grunau (2025-08-28 07:01:45)
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,nco" anymore [1]. Use
> "apple,t8103-nco" as base compatible as it is the SoC the driver and
> bindings were written for.
>=20
> The block found on Apple's M2 Pro/Max/Ultra SoCs is compatible with
> "apple,t8103-nco" so add its per-SoC compatible with the former as
> fallback used by the existing driver.
>=20
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

