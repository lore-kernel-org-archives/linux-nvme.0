Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3B6CA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0c1Yq4NBGY94JfOOYTzzvaGSbCj2I2fSGp+vlrbADJ8=; b=VfVD4kUQjJY+XWJMOIsm3LaY+s
	UncraoC9rrV4UO+5jedAQP8f3nxKH0TPYEZSfBYs2PKQXjSkDic1/xDYSQhfIT8tp9SvuHRYxYaeI
	5MoyDivph4IyypQ0M6tQ1Gxp32qCVkC5h7SmV/g3B+1TBU478YG5av3I9McoJ6Jk6ajVvXo2HNYfA
	QfnP7Q8UbxzebNldWpz3c+4JPAYfqLVQRESVMh2IRFmIAJokox5nayo7JGi/rKCqdvykzbognkNqg
	NVCA/DYaAIoylnUM1Yye1B3VxxMYgKW5CtIzzaqSI64k2LL0hXG6npZ9bDEd94+q8oJ1PuoBihTq7
	TUi8gidA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwi-00000004Mf9-0Mcm;
	Fri, 29 Aug 2025 04:42:40 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdD1-00000001ppp-2LIZ;
	Thu, 28 Aug 2025 14:02:36 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id F37991380DD1;
	Thu, 28 Aug 2025 10:02:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 28 Aug 2025 10:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389754;
	 x=1756396954; bh=0c1Yq4NBGY94JfOOYTzzvaGSbCj2I2fSGp+vlrbADJ8=; b=
	FbYBLVUW1+wdeWT+scP15DCsvQgxFv3tYARBw02gda323j84ZoZnBL75fyP/hud2
	1fy+3sSAczxZcgUJ/OySh3eB3ER3KDsHH6d7SxoRVkT4smrhihtNipceQ5DA8+pb
	FdGjajY6Efwe0Hg3i0d8PI1W27oE3gxcr4k2B0+4857fOdRn9Vd53+lerk1LUOBF
	61yFoWL7wVUz9mlkvjLJ0l0I0CDmPsdbg29ZH0WMqwv/FYvYNL9JzP3lSNMNerj9
	nonaRm//aGiusJJ7XY5jB8NVq7Bh7j+3GxW2vzKVQxMYmuG9YkxK4R0iWo7/LYyj
	PZAeh8QxcJaDwOTtFjB3EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389754; x=
	1756396954; bh=0c1Yq4NBGY94JfOOYTzzvaGSbCj2I2fSGp+vlrbADJ8=; b=Y
	OffeU27Q4ymbWQHMKXttmd6lcyp0eKGehrZn34cpTZrtA28hKALKL12E6aI0T3ne
	ROun1pQbBO4N0Ue6OxY3Iq0Tdu4bKvLEHEDsxkJnexNI8P8X0cKg0791AkoOTNFm
	VEkuBGofZyMxOJziueglPiwWn6CbNDS+1sb49OZajjkZEarF6HjW/QS5kYfVqRiD
	WbZPyQVVNBacqdIn9az/nKSrI3DTvIUZMj66sxU7iUQt3Sb8gPBgTNhCAMcJ6GOu
	wVS6OmZlfMuLxrO2nSCyvv+55y1/ILz6owaXkJZ7YPCs0zavcNPWUepG90zI2DBo
	aRYAt1Zg0wMD5MX+9qWsg==
X-ME-Sender: <xms:emGwaIxkUoNmsvxn1koHcctinTDyhV-PtFOnsfwsifMgWRHFS-3-DA>
    <xme:emGwaDt7njyTkNsAD2vFDlqRm69hUMSivRjM3sxD6HuxpTLRlAD3v_BkvuuYyjJou
    Mx8jb0xAiCxkpNvPx4>
X-ME-Received: <xmr:emGwaDSGXEhHGoJVUN3NG1UeAn2OOh-ifXvQfdM4KitswSH08zX3k9B_6Gjdm0UCbRhC_mimaNO4jmLYg9Lblz_sqtH4Rq5mc0sjhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
    ekkefgjeettdduueejgeeuteduffefteejudegieevuedvieffteeljeelgfeknecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohep
    ieegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhs
    ohhluhhtihhonhhsrdhnvghtpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipd
    hrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    gvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprh
    gtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:emGwaBdX2yz5tgE5PwgNTT0tJHt1DdqUAHN9NHEXM3QFnLuyj-YWhg>
    <xmx:emGwaJQxMWS3y4rBv2W_wCciSQ3DWzNgBFN-rx-Nq7ED7kCdGAnTOw>
    <xmx:emGwaJkvKUxEpmpcTjaXAcsGp7pwCDQzr4jSSeFneY5XbVbLvq-yKQ>
    <xmx:emGwaDEtxLJ2XkMUVcvqDz24kHncDaUPA4dM0axCpYdwspD4V5zBdg>
    <xmx:emGwaJTey83ugS_EdGRIb3F2JEynf3SL7bPwU6s2YEoR8JMFuRA0jYjJ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:33 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:38 +0200
Subject: [PATCH 19/37] dt-bindings: mfd: apple,smc: Add t6020-smc
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-19-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=LYUm5MKTe08602cGu8u8E3B9OdZDIm6atzI54Orhqx4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNiZavnLu/MAbvnXJzVTuvMCun4ZzcqSsjon9nmXuZT
 Cl7vSSvo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwESYOBj+cESXrHXxzqvcXTlv
 8fJzh18yr+xVlzt0teWx1pY8GROZEEaGrSJxorM+H+Ka0b1CfYq9QcBx9q3t7ZGxazxF7945nba
 CCwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070235_669862_D6BC4CFC 
X-CRM114-Status: GOOD (  14.56  )
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
lists with the generic compatible "apple,smc" anymore [1]. Use
"apple,t8103-smc" as base compatible as it is the SoC the driver and
bindings were written for.

SMC on Apple's M2 Pro/Max/Ultra SoCs is compatible with the existing
driver so add its per-SoC compatible with the new base compatible as
fallback used by the driver.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/mfd/apple,smc.yaml | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/apple,smc.yaml b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
index 8a10e270d421ecd703848f64af597de351fcfd74..5429538f7e2e914fa4babc273350a5bf194273b0 100644
--- a/Documentation/devicetree/bindings/mfd/apple,smc.yaml
+++ b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
@@ -15,12 +15,17 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t6000-smc
-          - apple,t8103-smc
-          - apple,t8112-smc
-      - const: apple,smc
+    oneOf:
+      - items:
+          - const: apple,t6020-smc
+          - const: apple,t8103-smc
+      - items:
+          - enum:
+              # Do not add additional SoC to this list.
+              - apple,t6000-smc
+              - apple,t8103-smc
+              - apple,t8112-smc
+          - const: apple,smc
 
   reg:
     items:

-- 
2.51.0


