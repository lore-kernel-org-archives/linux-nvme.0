Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C2EC8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rY5OuiFPogDDoozdKpa8gVMIeaQZZXiwgXN+xL/4MYQ=; b=AhO8SHHu4/zG4UwERRlYpwUvs6
	8/zV8icpyL1D074uX/LHWSJaOjyyaPdzQugV90vlmyAO9P+i2iv5cc/h0MXtClPeZY9+ZzvK4i+vp
	NNEKbCGIAkgqgoIIN8R8CksdTw6Ul7dm9TkqirI3l7S4QQ9cNnlLetM8uopPZs1feiHimz4s+ASxy
	8d2zidG0hs8MXuqxPH4Z2412acuooKSNodWq8QK7yl5OFJAtPhuo+xVotEQkUmzShVzqbpI+oDZFI
	WRHuVD/1gM7njoRcynQjx7phcWv+XP/kWT4axRCqZQuN7Qfd7J3SR+Wi3lD3NXJUVVfZXNEVsiVXp
	vwQXrMnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwP-00000004MAb-098F;
	Fri, 29 Aug 2025 04:42:21 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdCF-00000001pTP-071c;
	Thu, 28 Aug 2025 14:01:48 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 6B5261380D38;
	Thu, 28 Aug 2025 10:01:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 28 Aug 2025 10:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389706;
	 x=1756396906; bh=rY5OuiFPogDDoozdKpa8gVMIeaQZZXiwgXN+xL/4MYQ=; b=
	Pvb1NdTh9JS/8VQwnPk1cvYJfRAEyQHLMcC48TSPCofwXD7+AXg88wsBGWiFwshr
	ryR/M/+OTlorlrq+wUir6ffOBLELoCG2mNDL975FUdR7DNypjYw0BPCyNi9TvquQ
	T1vM0umC5pBF+5fEjeeBfmDS+1NVJ0BfKDhDagg+zjwgX5cH1HsXnKcEAmVmvrGJ
	pZj7JZ2ZEhOAE+rme57vBiftDWsbd8w8pIO+jc/o38dgXs6Bw7BqDogO4p7xZkKP
	qzPfwX28vVXR00qyxrCjf15d6TLAxHAQNlvqeIOEyeaY10CMxdrmYIANvDjrTPgb
	721O1DVtaWe/3LvPPeYFSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389706; x=
	1756396906; bh=rY5OuiFPogDDoozdKpa8gVMIeaQZZXiwgXN+xL/4MYQ=; b=I
	jAkDpLaNt4Bg+7436KCnDr0yXiZVIKObAxkEDZ//if+vtAtfyIYljYcaYtZYb8+N
	yk2hg78L07020O1I6oWU+5LaeawyFvy2spJN6mccikYYooxvifs1RVRxgzgtxRtR
	Sh8NosQgoUzoDm/juMs4YF1L3UxJJBNhvm6WRnnvevqIUk7IYbWLK+qi7K9Jctkn
	/pKkn+6JqntpgnRfX5JJHDCGFSeczPFBePEJJRUzIlR7xL00iBe6yhKZ1y3xaC/C
	A1s6uiYjFEHXK3okonoK6n8VhPs2qNYyEYHXzIVZedxk3ggodqKzes70zEvwNzj0
	M2RNfO+dkhW2EqPKIBZWg==
X-ME-Sender: <xms:SWGwaMR8oprE9jHtC6ywuOypoMEC-PDEsrUGrAGP-04_Meg9Z6fpjw>
    <xme:SWGwaBMbGwOZ-SHbVFjaAp8N1CiIDW1i4asrlAyl4RwgwjMskQBHzFf0mUBqNaiIQ
    mAYDoSsNN3JJy-ZaxU>
X-ME-Received: <xmr:SWGwaCylKG6izCvN3jPJkmQw7xiBhHeOvSPunex2esTmVmllIVhD5_5QJlGqO-YNG3ip53-_svPGlWa1FsCHWOJr2xVLv7gq_UXgyg>
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
X-ME-Proxy: <xmx:SWGwaK9WN0WBb4eN2bZqR8Up4ZBuUwmJmIKGvoLUvQFzSC88dtIeLg>
    <xmx:SWGwaEyVH9tODb2WxB4fC8XyXrkZ7TViKONXcxFB84325HEdjWHoMg>
    <xmx:SWGwaPH04JrimPv_suzzhFUzPGhsHUYU2EDIqV-ieUy3nLauHw67oA>
    <xmx:SWGwaKlDcI_52Q7FzeYUA1_WJFWKVMQqmv-6oTEJtkjvHvaLICFQiw>
    <xmx:SmGwaCPErNtarjRsKF7Ve4K0xag7wuLdLQH7XQGENvk7YuEX9Oi0rrW->
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:01:44 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:21 +0200
Subject: [PATCH 02/37] dt-bindings: arm: apple: apple,pmgr: Add t6020-pmgr
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-2-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=wu+uDbTMV6jmw/p4J49m1szF4BOIrqAdaGiSxEkIzqU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNieauj30Ywu5XzeIR5G6dJfR6eXPYVK5pFzb27z8Xt
 vLy9KQFHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTAG5yHMP/gny/rF8mz+oOzNA5
 6/nlq/GrvYc3NK8XOjNjxz72UIUIQ4bfrG0VexNWGtzJmq+wdqbrQ37TGrabha9NNH27Dls9fXC
 eFQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070147_145109_251263E1 
X-CRM114-Status: GOOD (  12.09  )
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
lists with the generic compatible "apple,pmgr" anymore [1]. Use
"apple,t8103-pmgr" as base compatible as it is the SoC the bindings were
written for.

The block on Apple M2 Pro/Max/Ultra SoCs is compatible with
"apple,t8103-pmgr" so use it as fallback compatible and add t6020 as
per-SoC compatible.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  | 33 +++++++++++++---------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index 5001f4d5a0dc1726ff520a6b57a8c4dc895e98d5..b88f41a225a385e68a71de93027b5b62c38d6b63 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -20,19 +20,26 @@ properties:
     pattern: "^power-management@[0-9a-f]+$"
 
   compatible:
-    items:
-      - enum:
-          - apple,s5l8960x-pmgr
-          - apple,t7000-pmgr
-          - apple,s8000-pmgr
-          - apple,t8010-pmgr
-          - apple,t8015-pmgr
-          - apple,t8103-pmgr
-          - apple,t8112-pmgr
-          - apple,t6000-pmgr
-      - const: apple,pmgr
-      - const: syscon
-      - const: simple-mfd
+    oneOf:
+      - items:
+          - enum:
+              # Do not add additional SoC to this list.
+              - apple,s5l8960x-pmgr
+              - apple,t7000-pmgr
+              - apple,s8000-pmgr
+              - apple,t8010-pmgr
+              - apple,t8015-pmgr
+              - apple,t8103-pmgr
+              - apple,t8112-pmgr
+              - apple,t6000-pmgr
+          - const: apple,pmgr
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - const: apple,t6020-pmgr
+          - const: apple,t8103-pmgr
+          - const: syscon
+          - const: simple-mfd
 
   reg:
     maxItems: 1

-- 
2.51.0


