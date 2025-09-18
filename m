Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C996CA1013
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Sep 2025 20:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NLOxTW+Xc0coRVFs5I2fBZDyyqmYkD/nVal27gtyfHY=; b=vIMV1tFT+BAZp9kPISYAAWXWgL
	Wi6UQHk5FpDjGOxVqrRJ8iLpv/EDzjUwRrp7vcGNBlkTvzxw1ObRtDlx+pi4iwuAGw0Slv3t+Z/J4
	zGorFRij63r2y//pJKDssFlJqRg9PEH/xHoYj3Ru7XQoSV+P/O7Fgk0EpIxWKjKXAXqCi9VhYaunS
	1n8xNeXLgIU2qAODx1ulf2pddr0R17uGiu5IZ+qSVxZDZc5vE9b/lYi4BZvqTseIAykejUYkJ2lVv
	eASICJSu50HrvqyNl1HrlcGtEsNC/s7IYNfmJamfhBsAIuO+SJDFKnOSY34RVyIPplHl0l8In6J+O
	BPfKegrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzLW6-000000018bA-3Rkg;
	Thu, 18 Sep 2025 20:46:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzKNX-00000000zsB-39mf;
	Thu, 18 Sep 2025 19:33:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 53149601D5;
	Thu, 18 Sep 2025 19:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6849EC4CEE7;
	Thu, 18 Sep 2025 19:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223993;
	bh=SiTsMJ0sXAvpCnRX8FDPv8MfV2YWSlcEA47DenlZULY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlGWVZsw4RvC4JibN0EA6ibUfzsD04RlN5WeB4D1zYQJ9gFHptEmnMVPmNBfSr3bB
	 HH0XQZaLMzje1GGD7MwYt/JCmyf05k0dQ6elVo0kMqFC6RFQERQ2PASS0IlJFTGjkC
	 TM63BT3RirjMC9mwtoe83aVhq5IgPpoiCWPo3XrZAvth7Ae6b/S0KHw5UclcLM357T
	 vBP+w/K7TuYScKef3bSEN7M147yQI0P5i48fs3CaLS+hEszfe9jT4ZharfxIxLD6Rf
	 OBJrM7gKQOK0jhPAl/N8uNKTH4OqrvrxhtqD04A7yLGkDGjRLWIlXn6DNb0lwSs5lw
	 A4+l3vl0alafw==
From: Sven Peter <sven@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	van Spriel <arend@broadcom.com>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Turquette <mturquette@baylibre.com>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Vinod Koul <vkoul@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-clk@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: (subset) [PATCH 00/37] arm64: Add initial device trees for Apple M2 Pro/Max/Ultra devices
Date: Thu, 18 Sep 2025 21:32:52 +0200
Message-Id: <175822390213.30186.12188566922096991002.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Sep 2025 13:46:09 -0700
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

On Thu, 28 Aug 2025 16:01:19 +0200, Janne Grunau wrote:
> This series adds device trees for Apple's M2 Pro, Max and Ultra based
> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
> follow design of the t600x family so copy the structure of SoC *.dtsi
> files.
> 
> t6020 is a cut-down version of t6021, so the former just includes the
> latter and disables the missing bits.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/drivers-6.18), thanks!

[03/37] pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"
        https://github.com/AsahiLinux/linux/commit/442816f97a4f

Best regards,
-- 
Sven Peter <sven@kernel.org>


