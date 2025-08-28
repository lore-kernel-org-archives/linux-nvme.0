Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADCBC8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/1HCzcPWpXBSpnbj/QDJHLEH1PFOq/NBWIwZsLaGAto=; b=0GA4btO04HQqpBnXaDYD8SOafE
	TaEVsID/rNb0TFCGvlc4BrUBlJlxXz8elJGvnKlc816UWd4Tm6vIOkvDMI9HgjSc/GCZuj9J5aqrj
	/L4w7Xbh8e7Cro7xVJtIgi8qNxTBIep2XD9+pVQejmK/RJevqhMhDoHEBdnv/gdcpOlDvzD3SIjBX
	xfqmoyRHbIeLkQuXxNcrdPCzYYzjTzIXb9RuoBG294lpV6Wc6nBqCdtUbCpaUsWeCg3Y8+GTwDcEt
	UgJZZoETDXMSqBA6vMN2SgJPb4ZzHDhaOiMCwvErDI4shFyperVXrKp7fdqaXCPxbyUJ9jxMtWr38
	ws6H/txg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqxd-00000004O4y-2c3b;
	Fri, 29 Aug 2025 04:43:37 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ure2T-00000001zn5-06Es;
	Thu, 28 Aug 2025 14:55:47 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id C850F1380DA7;
	Thu, 28 Aug 2025 10:55:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 28 Aug 2025 10:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756392943;
	 x=1756400143; bh=/1HCzcPWpXBSpnbj/QDJHLEH1PFOq/NBWIwZsLaGAto=; b=
	JUEfVJdalsBHmFDtqcsVx63oqloV+T/tGhzAHQ9+arprL8JADMc7WoNs1e+ZskUj
	R1I2KynVO6viufJVuXlxKT51gDnsPcdN189//WH2yRcV17Y9SlxN1gLi5iHtPQc6
	DnaZLmf52glHkJLXP/tXdiOrssVH2/CJGnvInPpgMMCb8eINbdgq48pSTDeQfMoG
	ECOWvSP4JL9GuPdHAGec2hvGh6khLyEO3GQrVxehD6mtd8sM2GTI0O44257zN58r
	tc82iudF0Zo7psuGnKjgGt0yNAbW5/tSbTBgAnugSSsVNS5R0EVkGZaLx9Of9g0O
	I30CK9UYemEGyYg+rjHVwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756392943; x=
	1756400143; bh=/1HCzcPWpXBSpnbj/QDJHLEH1PFOq/NBWIwZsLaGAto=; b=M
	Hq8u2V9IHvxSi75Fig+W0qozO2giF0xpwf/O6/1IkzYHIwk27xMhVdYlhPBITzQK
	hVR3LzelnwiLj4wVJzmzeFbMJiokIDCx5LbE0FbDlgGQerIE6t0jCzvHun5Gevwk
	cJfpVudxIN2j5LfQgdRymyptz99NL/1ip2+fR9IsF7sSt9+iX74DP1P/xEzAaMS+
	62fxg52akPDOB1RvZqEC3rhFl7N4JqVQI7KUdQmYhjCqyszAlRLAVpj3jWxLPtGo
	szf5hNci1sd/vG2O0cazUWkLU2cwi+sDhjaXXN2PPl3TMu65mS7Rcw1RvYFKD0dV
	sPbYOjWHepqphQvxwywQg==
X-ME-Sender: <xms:6m2waKmnYa2FdIrcu_L9tOlt2ZKYPU4Stfq7t586JpTMj6oCyN007g>
    <xme:6m2waApFyf5oQwidF9teShyXB6yxYFWxH_7LduDR5VKe5luRS1XQ3SVaeN9X2jKag
    x_FllNwzSVyZ-8SRHE>
X-ME-Received: <xmr:6m2waDXc5A2re2szZKOEi55YYyhfvavQkp6KsBeqck8m-tjpMzpgVobxkPjSpZyuG8-iKSF2710WJHlnGDT-uFp9_j1ibJ8QZYnNgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
    ekkefgjeettdduueejgeeuteduffefteejudegieevuedvieffteeljeelgfeknecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohep
    ieegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghp
    thhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoheprhhosghhsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrh
    gtrghnsehmrghrtggrnhdrshhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:6m2waFrTf35PgHb3njAcVHWQ8QR-g62UyrQIC7kEhKNAfyH6xKmzPw>
    <xmx:6m2waOf0g_tg3qwoV2wdDKszkMeMad52NNgvQmWw_qV8WkZnJZWLiA>
    <xmx:6m2waGdDlnENjZ5HBWAX4TL5jGe73veREkVa-VN4ZKQN_bQvqm_1cg>
    <xmx:6m2waJrAadnALiEkOA8lV99QmcXasWWJYDt8jKHkhCvvE3cefceqJA>
    <xmx:722waN9gGr8x5mX7n7t8O042S8vd3V7CC9cIJvsU2hM85ZmHrS3ks-GE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:55:38 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:52:09 +0200
Subject: [PATCH 31/37] spi: apple: Add "apple,t8103-spi" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-31-bb8e1b87edef@jannau.net>
References: <20250828-dt-apple-t6020-v1-0-bb8e1b87edef@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-0-bb8e1b87edef@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
  Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
  "Rafael J. Wysocki" <rafael@kernel.org>,
  Viresh Kumar <viresh.kumar@linaro.org>,
  Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
  Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
 van Spriel <arend@broadcom.com>,  Lee Jones <lee@kernel.org>,
  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
  Stephen Boyd <sboyd@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
  Guenter Roeck <linux@roeck-us.net>,
  Michael Turquette <mturquette@baylibre.com>,
  =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
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
 linux-nvme@lists.infradead.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=j@jannau.net; s=yk2024;
 h=from:subject:message-id; bh=WlBb0jJmn04MaLIfHfPKXwa9UjgUaNfYxdtYiQpQBvo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNOf/3qCr8iqy77cgo19jWq9MS+0DgcOvBOtM/UvNU9
 /w3mVfbUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJMExgZHu1SPHxm+vMZ/F9+
 GuluLnjnd2zKHgWlAp1dM6Le5H7a28zw341DLSzd0Oy3MWdyxIp1fKdXmaTNuefffE5CYcb3qnt
 e/AA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_075545_289544_4E95A4EA 
X-CRM114-Status: GOOD (  13.83  )
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

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,spi" anymore [1]. Use
"apple,t8103-spi" as base compatible as it is the SoC the driver and
bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/spi/spi-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-apple.c b/drivers/spi/spi-apple.c
index 6273352a2b2861c9da0976a46ec2adbc4c71d3d2..2fee7057ecc99063521bd0a9da3ba573b84776f9 100644
--- a/drivers/spi/spi-apple.c
+++ b/drivers/spi/spi-apple.c
@@ -511,6 +511,7 @@ static int apple_spi_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id apple_spi_of_match[] = {
+	{ .compatible = "apple,t8103-spi", },
 	{ .compatible = "apple,spi", },
 	{}
 };

-- 
2.51.0


