Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A5FC8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3ktk2THESvwNeNJQTcn33e/HVAx4kl1gVVXAaiiS2w=; b=El9YIihIKdRZ+5UK3vhwOh+tI0
	bAcb6s/jlp/oHMmi185O+aNZG0HrNzxoCMs4GskPK36c6XrLje6AaTc8OtlwkKHScz+p4279J1wkX
	u7TpufbY3yp/nvPjKoLaRaEyi5EP1wSApfAZISVNzw9JUV0ptmtgNQTJTsC9fQIlIbLZCMV8sASHm
	44qzdL+BjNmxAdU8BekcTiqGR5EF83IYFDop8Ib8Um5MbkjUlFLij64Xu0Keg1yRkGYrrRP3F/gS8
	sprmsSbCgQGTzrYz7HjsHEpGlP1JICP+eAKguW9S/PUmhVW5pE2rcKwSF4aD8DFiWLpu6Pt4SM6Jh
	eqHVLdGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqx6-00000004NIO-3pJH;
	Fri, 29 Aug 2025 04:43:04 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdDQ-00000001pzZ-0nWk;
	Thu, 28 Aug 2025 14:03:01 +0000
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 8CBED1380DFC;
	Thu, 28 Aug 2025 10:02:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 28 Aug 2025 10:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389779;
	 x=1756396979; bh=t3ktk2THESvwNeNJQTcn33e/HVAx4kl1gVVXAaiiS2w=; b=
	PZJmTOGCOxbKePOEiZ7XZ3dtRLse3QWmNHEAO5TAK1a4a7mWRrCCK2c8piEXtRii
	3WG3yCx15su9rM0ZtgfP9thazOY6Wb362v0OQPJFmiJsyL7CJyvS7kHUPfLEwVko
	BLb/77obZATzkfJSMq1OgC6jmQ8cJF6+s/X3Cvorx5BbTTbFjZMrvt7qohmOxb0o
	RsFI2gyJznUPVZg/ytOyQ5LJqpAB22y2OtEgeOU8MAGq9aLojw7Qb/thD6L7hoaJ
	QuxxCKZDdRees6QQ6iOm7M4q/eIqR8L4TM7eM1t2L95CDklNdfOVEGMn3dlWb6hz
	0Yyx3Jwzkp/bq2rDwAzf8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389779; x=
	1756396979; bh=t3ktk2THESvwNeNJQTcn33e/HVAx4kl1gVVXAaiiS2w=; b=e
	Dfd7EaBfwTq0qkXFtS5BbmzOPrjo9hheGwc+gEoDc/y2Z+zydl3nodqxkViEVJr7
	f6Adn6ArYFibmimjy80fdyP3l2YN711T4epcAKD8u+B8w3d5ppevY8X0aZGKk1m9
	LHQwm8aQt+j1Vwl2qBaUo4SB58SadIZ9Pu2is/1F7gTbzkcQ7LDE5oGzhJOvdeHY
	pgdLNTbCLPStYeV+grCAdt9857nsSolsj659tr0NDUzu2p5SjQf3z+NKnhF3ASQs
	zYRr16xbrHU1zAWR/EWkzyZLo+H+j8zmT++w+UG5XCFQsiVjNegbnHvBIDIUksyq
	w48d4+GsnIiUDdxSkCCEg==
X-ME-Sender: <xms:k2GwaGS7tE2vSU4BOovVDmcKHsR_ld3PNKydGkdK0jaMd5ejuWcypQ>
    <xme:k2GwaKmtRkD-VxWqaN6hWDg-omMeej0NtA_L8A4qA3FcXlnZHZ2kRHWWzO8980xkN
    VwTBc7BRxfbT3ac064>
X-ME-Received: <xmr:k2GwaOhB3fCc1Jd5Nlxax3XYPErpCe2XA5l0xAUO0gqaNbwrh8xa4se0Jnrhj08Z1R0BKkUd2z4Z1f7L49UrAVN617niihKfmWTrDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:k2GwaJHypUhj28VzeRkN03GYKAlIf4LWwpGSqewxkJRKL09kvqpCkQ>
    <xmx:k2GwaFKpfsbT-rmw8F6GCNtl1zUcmMt5B-JP7Juvx41-_9ilbqQdPw>
    <xmx:k2GwaPY2ETkh1lGGI2n2rxyztrYl-doGHBQ05J2DsAM05J4L0HEGhg>
    <xmx:k2GwaH3uacnCzrpkUgHfio35FdsfODNLLyuZFE7Q61qE1wiHFReT6g>
    <xmx:k2GwaE7BNv2fE33ODtG9NLMIGOSmn5FAhvm-nQ6RkbffW-zynw7jLf5v>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:58 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:47 +0200
Subject: [PATCH 28/37] dt-bindings: dma: apple,admac: Add t6020-admac
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-28-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=SdDlDC642Zv8/SmSHx/Sw16xYTRDrTJq+L/ihSrwHeI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNidZ1HHufpuc2aB649sSyLStr1aX8PYer/9/KVHV79
 dbOwOJvRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgInIyzH8sw/33L1/zXZL5pX7
 /32/4iXakXalaFc5s/St3MfdidlzFzMy7HryPqSV4dUO1bzlkyP/Bb7Jd3yz+m/ovzvu10yj52n
 t4wAA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070300_371698_1020128F 
X-CRM114-Status: GOOD (  14.08  )
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
lists with the generic compatible "apple,admac" anymore [1]. Use
"apple,t8103-admac" as base compatible as it is the SoC the driver and
bindings were written for.

admac on Apple's M2 Pro/Max/Ultra SoCs is compatible with
"apple,t8103-admac" so add its per-SoC compatible with the former as
fallback used by the existing driver.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/dma/apple,admac.yaml | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
index ab193bc8bdbb3ed933bdf52adb0698225616df06..6a200cbd7d0280ae32a8a251eca805822756f25f 100644
--- a/Documentation/devicetree/bindings/dma/apple,admac.yaml
+++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
@@ -22,12 +22,17 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t6000-admac
-          - apple,t8103-admac
-          - apple,t8112-admac
-      - const: apple,admac
+    oneOf:
+      - items:
+          - const: apple,t6020-admac
+          - const: apple,t8103-admac
+      - items:
+          - enum:
+              # Do not add additional SoC to this list.
+              - apple,t6000-admac
+              - apple,t8103-admac
+              - apple,t8112-admac
+          - const: apple,admac
 
   reg:
     maxItems: 1

-- 
2.51.0


