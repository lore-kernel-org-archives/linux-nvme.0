Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FB3CA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pl9J6W5DaXIcLTJ+Hd7FgTU/vqlZzgtxEGj2IHvCy60=; b=gWsx21saP0uOnBHkxThJuFt4pL
	zlffgmrB2yoUzPdcwLQlKlsPXZ/yl/gBgbnN3wqTAVV+RRsAAUgVrm2QiushY/Ff/nUl/0vyMYx1Z
	2u/HYe6RlssynyYU7pIp4gMf/pfQQrMj1OPM1jaxvm2BHUJOt4ghlIwSklEcPg+mf2J9ocOaPdNN9
	cKqqKDg+83tnNKd35bHk4Q4PgTWFKsRxNWOaIvxdIY+5pYU4BWwt/r0dtXCaXfmT5eD/UNfg+/5+u
	f54HLOZs9cEeYMPg7t2uSD/dGmK9LYsA6ybmz4s6Vxa/ZQvY8UUpipTdszkSyCh3bDbpsFgSkeQaB
	0AoiQB0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqyE-00000004OtO-0y5b;
	Fri, 29 Aug 2025 04:44:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ureNl-000000024mg-2cnx;
	Thu, 28 Aug 2025 15:17:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C7B8E60097;
	Thu, 28 Aug 2025 15:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD76C4CEEB;
	Thu, 28 Aug 2025 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394264;
	bh=pl9J6W5DaXIcLTJ+Hd7FgTU/vqlZzgtxEGj2IHvCy60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBgrNgBiOhBzd5HsVskTJc9G3cRohp73lHuBxblI75LHeCDVqJEDbOHfhz5J60g7+
	 DIgGqxyMB+m+Ify/PmU9vQfif00b03uy3bsGf8ULk04+m2QUpIMpPhVdOhNZhoeTPN
	 EGZfh5mkK0Czo5wgj/Typ9uiRv4fbcvpAUXrR1oQMaGvZR8K4ga6lBTOKNSf8iR/XP
	 gcuYiLywFKm2UgwOoCwoi0KQQOVqJOjLpTcVz0MQ+7Z4tfmpA455C0DtMBJDgNzD6M
	 joz8cUlz6dlS6ucNe3bgSqKYyjnV/94PBmvHxR0id8v3uymxFlV5iCWbFbOtAR7InE
	 X1bo9Qb4wsusg==
Date: Thu, 28 Aug 2025 17:17:41 +0200
From: Mark Brown <broonie@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 32/37] spi: dt-bindings: apple,spi: Add t6020-spi
 compatible
Message-ID: <aLBzFV9Ds0mJR2TC@finisterre.sirena.org.uk>
Mail-Followup-To: Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250828-dt-apple-t6020-v1-0-bb8e1b87edef@jannau.net>
 <20250828-dt-apple-t6020-v1-32-bb8e1b87edef@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CqzvD1rwobR/zXK7"
Content-Disposition: inline
In-Reply-To: <20250828-dt-apple-t6020-v1-32-bb8e1b87edef@jannau.net>
X-Cookie: Filmed before a live audience.
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


--CqzvD1rwobR/zXK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2025 at 04:52:10PM +0200, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,spi" anymore [1]. Use
> "apple,t8103-spi" as base compatible as it is the SoC the driver and
> bindings were written for.

Acked-by: Mark Brown <broonie@kernel.org>

--CqzvD1rwobR/zXK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiwcxQACgkQJNaLcl1U
h9BaQwf+LnTL2OowIaHOhs66jWbHKJZQEjyzdFSZktuUJ4atgjHDhZWDsXdlSts4
F714cHQrZAD4DCr0ecKbfvcIBZb43XrDTUtjQdWHqXumJ4zB5ooB88m1+GnN4CWk
XaY51uk99TO9UCQZ5BZh+zOnWp73gxTvkYuqtZSulJuOsrHexK2JO+ITx3P43ETI
9/7oDeHP3/cUDLNatC9ItvrPkXwLLgsKKbAXh6Fd/vxkfxUcWAGzulPvNT3/iOaW
CkLGpU9NdSKBHNOP+Z4pSbsbpS53wxRY9KGEJ5DZJk14ZQkfYEDqia7oj1BJI7eH
NNo7aVRXF3kjchkEOQ3upq6b/Dreew==
=lpAk
-----END PGP SIGNATURE-----

--CqzvD1rwobR/zXK7--

