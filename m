Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6D6CA0FF6
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XPKN2AhbPWJ6u+69uufLpsAZ4EFrmOAjn6EhxFa0aJI=; b=H2YQVoWhOsPKpLpWj4WOWkddvd
	nUJG/Bu0ovwBxmL/dNNLcyS5eJCXAaeE4Azai67V2nbjJQsAFNWJcgzCJH8T75k0JQ8Jc86njLEPo
	T31TdV8zeHs897uvf74n02ExBUvQV546tDqFVEyD+26Q6RRU+OH4jl2bpgRi+HMyaygVGw0BDlvIV
	2Rvo8xp23HjVyHALZVXkmgd78npWJ+XU81itaJXDUvEgFXJ4ZzMCoLMRVxKl1mt0EcAIg2EmoK1S1
	N0d2OpPtqDVRpAt366n3hAOzH86B03GQkWOwXaaxmHrxkLKhrTG0di13++ol50y6jnHLWwBtqt5R9
	d/dZ/1hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwl-00000004Ml4-2aHH;
	Fri, 29 Aug 2025 04:42:43 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdD9-00000001pt7-1p3N;
	Thu, 28 Aug 2025 14:02:44 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id CEBA81380DDE;
	Thu, 28 Aug 2025 10:02:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 28 Aug 2025 10:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389762;
	 x=1756396962; bh=XPKN2AhbPWJ6u+69uufLpsAZ4EFrmOAjn6EhxFa0aJI=; b=
	szKX1qxxYi8rnbaH5n2OqBStxIoLar8z1f7A2ojF7e4GSVIE01NUoqJroFofA1jp
	N+RiJvqpP7klvW9mYrsEgebwuiAEYCDVNs3vdRMeezvk++bI9BqBXkerNjpzAtv0
	H0l6K6Abk9xNdmc5mQUdxka0HGu5JynHb9qGT3Yao6sCU4orbvttav4/swjFwkiH
	vh54XFFHcInTm+glSAauR1Rd5DY8qBDqitajdLKXuVXYX4qDxZSPfTrI9xUFTCPk
	gbY34EInr8x99Q2pr1zcMd4xfV2XwDIjmPakAz4PU/jh/dlpx2lZSfWwW7+mjdge
	aIpeXs4uqZaxkI/LZsHr8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389762; x=
	1756396962; bh=XPKN2AhbPWJ6u+69uufLpsAZ4EFrmOAjn6EhxFa0aJI=; b=M
	rwCmOM2gTwSNNBNI5Pb672d6W90ThQJkFvhpx0zrhG5cGkZKDc+Qb6RL6d6+3X6j
	xX2rugjuOeO2dYoa21MLy2tG33KbhDFJ7ZJ0fDmMAGhMJFh76OO+w6xQ+q+yizbV
	19JPFPI4CWPjuRiamJWdaNgNgqKjXAtdCfnsB2KArvR0wQyMMAjvcD56Mpvo3wQG
	8RVT86jcSvtMq0rduGRsM7IbClra8LMeGKxw024AnbD81Q+QrDZIyhHBF4LK9p7P
	s0ajVgIldhujizQzWFTku7uJolB3unEFLF2jtBwpJ9yNEsFXeD6x+moDBEQG3ohV
	qSBZisSVqJpVQhxeXXAyg==
X-ME-Sender: <xms:gmGwaFW-wxhCwng1lvmyk6A3pT6dhAngYIN3gHZAQ5r9UxjgaGBmDQ>
    <xme:gmGwaNBL2MePem_vz2Wu8tZWyq2aB51lAId-KIqrceHlp8maUIlymkJDveshuw6kX
    rz1-Kq7Wfs06L1VwYE>
X-ME-Received: <xmr:gmGwaKUzvACPnJNAI2AROeqB6V6mm7k0qiRlu8zaGPeX2JFrJs3R5ScwDvBtTasfJBUNnj0OCH56-Uo56eF78bS0xp3_DndpOGxINQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
    ekkefgjeettdduueejgeeuteduffefteejudegieevuedvieffteeljeelgfeknecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohep
    ieegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhs
    ohhluhhtihhonhhsrdhnvghtpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipd
    hrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    gvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprh
    gtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gmGwaDS2l4XcFY1k0orbxbbCaQEgI5jC8ZXEzkpR3LAwtNjSDjqALw>
    <xmx:gmGwaO2-lT6N6b6MNN4YSnW-g4Q3fLNCWg3yZX3pHl1mZydyZEYMBA>
    <xmx:gmGwaH5UAxy_2E2e1LkFPjD91FHSDYbx_NglYIB6V1xgrVNEkA23EA>
    <xmx:gmGwaLKg58g75BSDa74ZQThl3oCWZ4ZwYqeHCRmUAK_aN35iI9OAvQ>
    <xmx:gmGwaFBmEocC3BkeVZmKmv8FFpxSeUFxbcKTYxUGH40BFbdbgkrs9m0S>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:41 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:41 +0200
Subject: [PATCH 22/37] dt-bindings: spmi: apple,spmi: Add t6020-spmi
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-22-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=XExasvnZCa3lFPti+xqXVJeWRFBKJYtzynW+b1NYbpM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNiVbRU1nb5Cz1zU4JJ33yD9c3fdd3Ksl+dfgXGdVvr
 r/+1nZ1lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmIh2JMN/36tHKnPTGGR43/9b
 F3L/vcPv4lJZgaplG2ey2yz6s79OjeGv8Of5kjLvLFsXnCpP155zu7t/VUVaiEhAgpzszOcf/C7
 xAgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070243_614543_AEDA6851 
X-CRM114-Status: GOOD (  14.69  )
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
lists with the generic compatible "apple,spmi" anymore [1]. Use
"apple,t8103-spmi" as base compatible as it is the SoC the driver and
bindings were written for.

The SPMI controller on Apple M2 Pro/Max/Ultra is compatible to
"apple,t8103-spmi" so add its per-SoC compatible with the former as
fallback used by the existing driver.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
index 16bd7eb2b7af2c0b176f0e5b1970f4670af691da..dbf09ad0ecdecab82074344aa6a840a820bc448a 100644
--- a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
@@ -16,12 +16,17 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-spmi
-          - apple,t6000-spmi
-          - apple,t8112-spmi
-      - const: apple,spmi
+    oneOf:
+      - items:
+          - const: apple,t6020-spmi
+          - const: apple,t8103-spmi
+      - items:
+          - enum:
+              # Do not add additional SoC to this list.
+              - apple,t8103-spmi
+              - apple,t6000-spmi
+              - apple,t8112-spmi
+          - const: apple,spmi
 
   reg:
     maxItems: 1

-- 
2.51.0


