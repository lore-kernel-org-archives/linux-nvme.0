Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B47DC8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nb4trnMSm8TGPxR4zQ7deJPXuZqG4DeNFaJrpNc7mFs=; b=taMVndckJtjHpiIwMuI3qAFwr+
	65Ie6jatgtkZEbDH4anxo0+xABAW9rmbH88MND5y72fkZsZEZ9LqdmQWE7gkYPEx7RrADl+loA0S2
	YoWAxXzcdBuoIpAL198szxecps+gyNCpD/Tu5E8B6EiJAUe/VAyt97SKxSGdNJpDES4MgbIIcwWHR
	wGSGkMrdKQrxjrbEqnOOclPcpSwv4PKOBaEN98Pq4uyLM+b52j7JCW6CPci7aFpFArS0xFJBoYKxs
	mSH8y2WWOY32eCWolHbhjfpwfrNMVqZyuOFWAgnPHHJiTsNMpYmAqgDV3AHAmaUcAT0lBbrZrS8vO
	eOkM2Ukw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwV-00000004MII-1ZzH;
	Fri, 29 Aug 2025 04:42:27 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdCZ-00000001pfm-28V3;
	Thu, 28 Aug 2025 14:02:08 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id DFB7E1380D69;
	Thu, 28 Aug 2025 10:02:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 28 Aug 2025 10:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389726;
	 x=1756396926; bh=Nb4trnMSm8TGPxR4zQ7deJPXuZqG4DeNFaJrpNc7mFs=; b=
	T8P6eJEdDCFE5f/HQgMOVD3ump5mRpzbiBFcrO2cuJdxhyNZmUHUoSOIL5gAreMK
	63Yq3Xuaj27foBbkhL3Fh73riBIy+TsxVjIORpfFUiyNtYo7g5GoIEGNxM5V7iff
	IUufu897sPC1gwBDUHNH+bpB0lKVyNng/z6GhvQlR0ISxaAy84h/YSAp3hkNNUWo
	1j6+IQcSejmbYevyrVfiiNcwx6R98iJ0kkDl/kk0R0bb2cHz3lqdzT6Wmtmh9GlZ
	iH52z+kHaTxWpybNbZoNUgus/QP/WaNe+pWHOYXrKF+vjhg0CZbUTyMs64D4O+9X
	Sj49x1wzAAfR/NO+rl6+9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389726; x=
	1756396926; bh=Nb4trnMSm8TGPxR4zQ7deJPXuZqG4DeNFaJrpNc7mFs=; b=k
	tpHhLioDV0I27AE028XcZnz8CFX8yktVwM+Y2bewLUwMVrxqU/T/epESj18Z/3yV
	OhDJZXm4MorjKZmODmxC9NENYoLYxfrqJKeQUWTwEn6Js1bBu8ihgZFZSOZrKwwF
	XI5ZwQUzkl3DZK1+/kQsCDNhT+XAO5r/nx4Br5i9sglc0qLCZdPSiCZ0p3/LjBjY
	jHLFpsRnmSOPbMelSo92wcbSuAJ4eHksXNKosd30eJSc4sw7UqfCFArdpeOSQl07
	0nnny/ladcmJBI5dOpUxbW7zAFD5ktmAnWburQMwm8yTSX5PZzYYodFFgQbQO9hn
	27l5mvOFQ6KDvlrx/Angw==
X-ME-Sender: <xms:XmGwaGbAsYWKJkAfLmPJcw_20aDgJIz92HtRZnx15HmoIzJdkTLkkw>
    <xme:XmGwaA1ztqRCxpTeS4PsX4vSKEgLvaVeC8oair7kAhY-InS88z1NmEqISUO4_hOfn
    6PXAQa5i_-9yNKGbSU>
X-ME-Received: <xmr:XmGwaJ62z7TpUolCOKucfwOCRENOgEbN3cOjCccjhboo9lztp_PUxkCqEkrzVhaCOCWlAQpvp7GaNsjnuJfi6J_es0XSf_ONn8R3bA>
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
X-ME-Proxy: <xmx:XmGwaDkwHmUo6tJbpzq_1liTzJSCyCsEnItYCICV_4JKbANy2iM1YA>
    <xmx:XmGwaA4xFA9qjXv_yvlnTbeI12ZDnTzMPQPDo7h8Aewp201Bbb8nDQ>
    <xmx:XmGwaIuSz1CFrNYqS0gvYEv-Zg4XeL7F2Vb5_CGZlV9uaH6Yn_z8hQ>
    <xmx:XmGwaDu6mT21re_h7Uf_FepJ0rzrmdCPlumcKYTaP2XqjZr6zlsdkg>
    <xmx:XmGwaP02_rRG9F44QhKv5H__M_a8_YcohStN_TD5pDwIepkB9ccvLvOC>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:05 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:28 +0200
Subject: [PATCH 09/37] dt-bindings: pinctrl: apple,pinctrl: Add
 apple,t6020-pinctrl compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=XWF5pr8WY9xbf4tj8dh/0ec6hk5fhKera/8T4j7mtt0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNiRYv4j4sCFN6P12T055tdcsJ+xnRR803zl6wOpfj2
 B975zixjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABNRUmJkmOy6nyN24d5dtff5
 ut5ov5jtbnf464feJjbHdMeovK7PnxkZtm+5NqVo27beRMfUCa6+7xdZ54ZE8G7p37A+zD5nr6A
 mKwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070207_630608_6807A3BB 
X-CRM114-Status: GOOD (  13.20  )
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
lists with the generic compatible "apple,pinctrl" anymore [1]. Use
"apple,t8103-pinctrl" as fallback compatible as it is the SoC the driver
and bindings were written for.

The M2 Pro/Max/Ultra SoCs use the same pinctrl hardware, so just add its
per-SoC compatible using the new base as fallback.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml | 27 +++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 63737d8589442953a77e3bbab08f8b59990fb33c..665ec79a69f1db1020668c68ecbb7e215cb7cb28 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -16,17 +16,22 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,s5l8960x-pinctrl
-          - apple,t7000-pinctrl
-          - apple,s8000-pinctrl
-          - apple,t8010-pinctrl
-          - apple,t8015-pinctrl
-          - apple,t8103-pinctrl
-          - apple,t8112-pinctrl
-          - apple,t6000-pinctrl
-      - const: apple,pinctrl
+    oneOf:
+      - items:
+          - const: apple,t6020-pinctrl
+          - const: apple,t8103-pinctrl
+      - items:
+          # Do not add additional SoC to this list.
+          - enum:
+              - apple,s5l8960x-pinctrl
+              - apple,t7000-pinctrl
+              - apple,s8000-pinctrl
+              - apple,t8010-pinctrl
+              - apple,t8015-pinctrl
+              - apple,t8103-pinctrl
+              - apple,t8112-pinctrl
+              - apple,t6000-pinctrl
+          - const: apple,pinctrl
 
   reg:
     maxItems: 1

-- 
2.51.0


