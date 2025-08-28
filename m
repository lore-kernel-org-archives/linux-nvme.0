Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DBEC8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Du2NKwG5kjMYapHOMS4ErXJWLOLHI7y0mRPWnckCGRc=; b=2x+2Qbu/0cWseVQWs7DjQY02de
	R5FIymCm31qm21+fVM7iQ/1pq4pzzp4nxfYGIa1ogbdrZtGwMrlbLtPmvAx4lRoyPwPtaGjFjjPFH
	4XWiy3t8L6rifb7KHsjFym1o9OOVuvcbprYePovZtsERuafk4NijsY/mLWilmNFpvztmZWwUoDEJX
	RrgUgvlp1pRNpyxjY/pIWXAVNFUeD4pfM85CAgDswcb4DKkpIrAZAZDc33ZWcigflQpyYlVuTd95Z
	/PQyblXf1TCeXpyB8LOLRRxdyFr/sy9EMuMEP5a3kCwsUTggexNPLcZ1X1rNaPkbCwbewRt3NfM8Y
	n2q3viKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwo-00000004MrO-3IS0;
	Fri, 29 Aug 2025 04:42:46 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdDF-00000001pug-0T4C;
	Thu, 28 Aug 2025 14:02:50 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 7B5D61380DDF;
	Thu, 28 Aug 2025 10:02:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 28 Aug 2025 10:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389768;
	 x=1756396968; bh=Du2NKwG5kjMYapHOMS4ErXJWLOLHI7y0mRPWnckCGRc=; b=
	XVx2JXVslCNQrTUX6rMoc1H7c2pxiOBr/8LPm6wIqOKxdCv+QHmPBNgrMYh95Z5U
	K4cBQMGovl4oSnILs6zNdv5tK3jFUXDTRrIhe1g50zbzNxszK7wNkq5ob4HPAnY0
	b03g0A22gjONulPBYxXi806CEXZsIMiX8zs16Avq9/r2J1C+AwPNGDNVeemRDJv8
	2jssWp87a4zz506RU4OrbroPa/RDkd8KboIjDADAUmkZ72wVRfVvubQNwnWDUuzj
	Z/pirRclbwhBbqe34B3wuMiAWJIWSUvYGKxhAjupElveZ2tT1KkAwQldPzsGqXf5
	ZlySZzbaf0UzDQF2uHnWLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389768; x=
	1756396968; bh=Du2NKwG5kjMYapHOMS4ErXJWLOLHI7y0mRPWnckCGRc=; b=M
	9B1JpB0tfJ1T56e1NRwnWbkXUmlcBKGZH4+xdITs4w/cImWR8iyg1Xmg3j0zUZPB
	WtePFO9bBaV3rgBB1hGDt9vWt6pydPsdKDmDXmisO4Yor5Ag8CxaR2D+sJniNSkv
	zy5ukD/RxczA06gBH8B+9e4juyaAX/dwFF7hXwB9GFpXixdyrH5OXdM9RjhFQb3E
	UNJphIXK2geZIbuV0Hh8BtuMJRHW9l8m4rnhvOU9Ik7N0k0whKdr9ayV5nqtJvBA
	BfkTPjvnnySiRGEUpk6HKrVXukWHPsl2bXUg4rCovGCgiYq0jQ812KW6A4R89Ioa
	RnueoScCE5BsvW+88LKTw==
X-ME-Sender: <xms:h2GwaAQ4MbLkyoZi9f0lO1GdMb4vPLLSekvjTpZ_jMfO2C3JRdoKlw>
    <xme:h2GwaMl9v4ShPl11JvqRTZXyWLi-vxJOl8dSwRxIpKJoZNR4hRjMrFR2hwsOUoJCl
    sODnC-bFXg7nKKLTis>
X-ME-Received: <xmr:h2GwaIifykCToSnYn8qw43gKpf837ce99C2vu6T8dDmnGnJYDI57fN1D7X2kcNIpbqm9SB4V3UDbwW4OS1sBmqNFpqWGBtNeh8Lbjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
    ekkefgjeettdduueejgeeuteduffefteejudegieevuedvieffteeljeelgfeknecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedvnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohep
    ieegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhs
    ohhluhhtihhonhhsrdhnvghtpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipd
    hrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    gvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprh
    gtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:h2GwaLGPVKIKQkx1jsX_5SRtkyw-LqoFRPZ39xXJjyOfF4C0uZLVGA>
    <xmx:h2GwaPJPgnCkyL21NymVJSXi1zUPu5YO6XiN2reFMTUfH4B929XGZA>
    <xmx:h2GwaBbp0j-Jas6AvKviCk3p9Fp_oS9ioMRcivi0SphoQqvxs362cg>
    <xmx:h2GwaB2Ga6XeWUNvtrJOZKcxFnC9d_x1pKdMHpavHztJBv9iZtWjog>
    <xmx:iGGwaG5Xw12NZGk-ViJ0x2NWqhdr93bxXtmPBuMfv4b-L4KcIh0EKMi->
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:46 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:43 +0200
Subject: [PATCH 24/37] dt-bindings: watchdog: apple,wdt: Add t6020-wdt
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-24-507ba4c4b98e@jannau.net>
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1897; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=ykPAcrH7nH5stpCWnGizSLioWRUE/N+dbccnuhE6jU4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNiVa3tMJLl0+1OZ/j/LDzZME5F7n/Z841PWcWM3LT4
 n25aL5tRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIlM4GD4Z1Giqb1S+v2NDXJH
 yy8dMMtfFTrdOlH5nbfDbo4iyb6wRIb/Pt7bcg+f5JNyXn+xYMH10DC7+B9tZq83XNolrtTw1us
 6GwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070249_223564_4DFE398D 
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
lists with the generic compatible "apple,wdt" anymore [1]. Use
"apple,t8103-wdt" as base compatible as it is the SoC the driver and
bindings were written for.

The block on the Apple M2 Pro/Max/Ultra SoCs is compatible with the
existing driver so add its per-SoC compatible.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../devicetree/bindings/watchdog/apple,wdt.yaml    | 27 +++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index 310832fa8c2803d463148954ed30795b11d97cb2..05602678c070d764331795f6df91abbc55eb0f2a 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -14,17 +14,22 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,s5l8960x-wdt
-          - apple,t7000-wdt
-          - apple,s8000-wdt
-          - apple,t8010-wdt
-          - apple,t8015-wdt
-          - apple,t8103-wdt
-          - apple,t8112-wdt
-          - apple,t6000-wdt
-      - const: apple,wdt
+    oneOf:
+      - items:
+          - const: apple,t6020-wdt
+          - const: apple,t8103-wdt
+      - items:
+          - enum:
+              # Do not add additional SoC to this list.
+              - apple,s5l8960x-wdt
+              - apple,t7000-wdt
+              - apple,s8000-wdt
+              - apple,t8010-wdt
+              - apple,t8015-wdt
+              - apple,t8103-wdt
+              - apple,t8112-wdt
+              - apple,t6000-wdt
+          - const: apple,wdt
 
   reg:
     maxItems: 1

-- 
2.51.0


