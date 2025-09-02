Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5C8CA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 12:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EF1op+eddct4pM3ZB2o0aAETXERusr9OmQud0x6jKd8=; b=So1wv+waYeASHBuzh5zYw8XAfu
	kLyDUA/nci3VDYyhDvb4JIOOBOieiet8P0qWqrCNyKU2lVMlq9s+qLSizqJhnaQhQsOU29L07Y0Ux
	/eEcB6QT+kxlKB/EC0AQ7HS5yWQJlxhuHk7ujn9HaLqNDieNKbWoI/DimOOa4TMIMt8qT0/fUibP7
	7rv2e7qkNCdbmcg4DuQifLS9Xj0PSHueR8mgXRYajG6FVU/VJnFOg49lGEf4wUFgrCsI+B+QBZ5Cp
	aFQjP3qRwtf1jgzR//Dj4R7ujRsaO5EfPjRmR/kjKoHYkHgaTNTdUuuQ/OSGCzQD2CZTOXJJpKbko
	EbF8UZEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQ6Y-0000000HDqv-2s41;
	Tue, 02 Sep 2025 12:27:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utLvT-0000000FscQ-2lxP;
	Tue, 02 Sep 2025 07:59:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A549E60202;
	Tue,  2 Sep 2025 07:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B101FC4CEF5;
	Tue,  2 Sep 2025 07:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756799974;
	bh=EF1op+eddct4pM3ZB2o0aAETXERusr9OmQud0x6jKd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJG3GOiE51Copquw/et4yKR2MBNqyeTR1IAPc0P1wxza24c8Bq4Zc/8Q7eKkeJOJ8
	 pYWFTt1JmIPWALpvCaXjNsP99j/f0dLV/DYLcnsQ3vBiopJOhJLZBr6W/QP40TczLY
	 s4mj9mZjOSnLBdFU1bnx5nhOyDJcF93bwPlgmYGWl3pCuhraZsFOltCb77vP8GOf5t
	 12ryEquytxYXA5Le3xuYe8epm+vJQDqaCgoRv6HGXdjCf7BWZqERl7WQ97+WKzu8y8
	 +FrcNp9sY8CK3kbN/yxn0KKBCpQodqKbLOJCPqhdlq76MB+N2NhN1BGCu2b3GIzIWi
	 ewGqlCi6YaApQ==
Date: Tue, 2 Sep 2025 09:59:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Michael Turquette <mturquette@baylibre.com>, Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/37] dt-bindings: arm: apple: Add t6020x compatibles
Message-ID: <20250902-optimal-copperhead-of-chemistry-ebd7fa@kuoka>
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
 <20250828-dt-apple-t6020-v1-1-507ba4c4b98e@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828-dt-apple-t6020-v1-1-507ba4c4b98e@jannau.net>
X-Mailman-Approved-At: Tue, 02 Sep 2025 05:11:04 -0700
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

On Thu, Aug 28, 2025 at 04:01:20PM +0200, Janne Grunau wrote:
> This adds the following apple,t6020/t6021/t6022 platforms:

"Add..."


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


