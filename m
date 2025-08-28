Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15574CA0FF6
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cRzTYLdDQJlN+AsnUFYs6ysk9Esr0uJgukajjV8XmNE=; b=pD1TfJglS4tB58oHDN8kw1wHd8
	3oxsrtGwG7ZlW3QNRqPSF+2zczjVzQaHbuZHXt5bLTw6gQ2ckRG3YP4PnTRextfbsOrykACixcga6
	PNZEZv0MRRMoX4TyoG26wb4qtDYkoZwamcw/93V0cim39Zq9XgqcBAUj8t5/OKoUPJ3b7T3rA3t4o
	3WpdLVDxMsuR3zIilm0PyWCnHg2IEWFOmMWjX+R3ZQywbNU7nLcSiIAz8XN9h/8I0yWeBNCM7yZu6
	OnH1Gd2VU4vhK23Ag/7Xf0Q4zTdi3XcR3AjH9zEFefAakWXagX+QScYoUzxCUVWCev5/c+bM7ayBG
	mSv6pnTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqy7-00000004Okj-2c4K;
	Fri, 29 Aug 2025 04:44:07 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ure49-000000020Af-3XNX;
	Thu, 28 Aug 2025 14:57:31 +0000
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 3A1E81380B50;
	Thu, 28 Aug 2025 10:57:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 28 Aug 2025 10:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756393049;
	 x=1756400249; bh=cRzTYLdDQJlN+AsnUFYs6ysk9Esr0uJgukajjV8XmNE=; b=
	dKZTWc9Nyr2MgfmVErExgv3GyPKI9rl6L6MT+3qGC595j0SGP1xRtnkeA0nST5jI
	YdvraRaYA34I/hqaZSk1OWfSr/5qcAtfxSTgOytRI/md0z6vmHTpE3W0bm87UE/6
	ZjHR7JEDrkvo1t6Ir7327gCpislIuqjq61kxA2Mk8OTSoyB7JmwIWUJ4/rzFPdJe
	6T0HmY2j+wZWuplx3EXHFKE7Zj9FnuXGGUb6FaCVuRpGyqkYiYWTAsZARSZp1ODs
	XzUgiXwGAmiDHYQrsXA2FSIua+La6zXzzZ/YuOo8v4UzXL5Wq7F+tvrlglJ41hHr
	nsoXNTSTExuKNYHDmBYKZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756393049; x=
	1756400249; bh=cRzTYLdDQJlN+AsnUFYs6ysk9Esr0uJgukajjV8XmNE=; b=B
	hy7dx9+1iqzda2R29l7vODcJAt+FCFjPGkbvFSRlACyUGnvjA+Mbwbaa4yaYa1DP
	8VCZ6/eMEC/uT5BjRaiYmodzkF1d/+MZ/bCY/fJUI5CvFwZJ/s5SuqeOCt7NF9AD
	ebMTHuyOvSZvKoVVrwYLXrW/vB8kQZ2G19xeZPlXtLPU8GNrnXBKV7r9wdPeKFC5
	VHvmKIqtK5ZMHhvmhg9tDIEk1j74oxGUM+BK3B1W+uXuRYhCexDUtuL34TcSnFCi
	iTkxNFkJrjAmvzKhWilPwFGNRdSVlJpYX+/FQ5cuJ6L2PpnqzHBsxBpjieqY+ecb
	nChc+Q3g6q3bFy+hEuorg==
X-ME-Sender: <xms:WG6waDW7h_eh1wkVrYohv96kl6_k-H0ULlWbufogOMvAvbhC548QOw>
    <xme:WG6waKZfnzMjWHwwieE4dT0nRDIsyUEAydmiPv85I-mIG0gocXUv56pxqiCDZD4gb
    E1dE7XTUkKIZpkOBbw>
X-ME-Received: <xmr:WG6waKFYxrh8xVhi8pnZ6WQ_TPlO-wI8jwW9B4NGyG5UdaTacQcZYWU00NCnGuo3Rq0-2sH0CQDKIyBFaeu8kgF3-WFEe-uVxA9gjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeeigedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhihshhsrgesrh
    hoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdp
    rhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkod
    gutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsthdprhgtphhtth
    hopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhk
    uhhmrghrsehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:WG6waFbV2jHRuOR8r63tauCSw0QCbqXP3AzIO7CR8Q7siXWRV3YufA>
    <xmx:WG6waDM1XHnLOcyiFVDhPt5W6WpqkDsbw-Ia0-HhmSWFm16ktlcwAw>
    <xmx:WG6waMPrfX4T-SCVUEc1EQTpAjeQQF2a9BsgrQ6jHxAbv3VW0zyjGQ>
    <xmx:WG6waMYXH3ao4yKFy-e17Wuko0HJ8qpxwe3CMHbfD5zTHxdveaKArg>
    <xmx:WW6waLug32LqoBDv-FN-IdS1ZOPUvUWAvvZdBuwz4Qy_Lx8Oj7Lojqyy>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:57:27 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:52:15 +0200
Subject: [PATCH 37/37] arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra,
 2023) device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-37-bb8e1b87edef@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4648; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=Qn4p2qGj7smY42jf3MkxeZAcVQODxziZd71/POYoV3o=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNuQxFxyc+1psQspX3iKvxnsYfuxw9TStSbM5p1Wzhu
 R2y7hNzRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgImsOcnIMPFn/z+t4/8jjTia
 5z2zUl3lMH8Wh/2rQv2sQk7TM13/LzP8z3+YrFL/yHDvqZmhIcmJ7v/SdoVwV7nP2jvrRYq1+vk
 N/AA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_075729_963726_01B66251 
X-CRM114-Status: GOOD (  18.82  )
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

From: Hector Martin <marcan@marcan.st>

The M2 Ultra in the Mac Pro differs from the M2 Ultra Mac Studio in its
PCIe setup. It uses all available 16 PCIe Gen4 on the first die and 8
PCIe Gen4 lanes on the second die to connect to ann 100 lane Microchip
Switchtec PCIe switch. All internal PCIe devices and the PCIe slots are
connected to the PCIe switch.
Each die has implements a PCIe controller with a single 16 or 8 lane
port. The PCIe controller is mostly compatible with existing
implementation in pcie-apple.c.
The resources for other 8 lanes on the second die are used to connect
the NVMe flash with the controller in the SoC.
This initial device tree does not include PCIe support.

Signed-off-by: Hector Martin <marcan@marcan.st>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile        |   1 +
 arch/arm64/boot/dts/apple/t6022-j180d.dts | 121 ++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 21c4e02a4429fa1db506dd85637a44000073590e..4eebcd85c90fcf0f358b0b32debf2475f6dbbf2c 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6022-j180d.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6020-j414s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6021-j414c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6020-j416s.dtb
diff --git a/arch/arm64/boot/dts/apple/t6022-j180d.dts b/arch/arm64/boot/dts/apple/t6022-j180d.dts
new file mode 100644
index 0000000000000000000000000000000000000000..dca6bd167c225aa23e78e1c644bf6c97f42d46b5
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6022-j180d.dts
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac Pro (M2 Ultra, 2023)
+ *
+ * target-type: J180d
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6022.dtsi"
+#include "t6022-jxxxd.dtsi"
+
+/ {
+	compatible = "apple,j180d", "apple,t6022", "apple,arm-platform";
+	model = "Apple Mac Pro (M2 Ultra, 2023)";
+	aliases {
+		nvram = &nvram;
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+			power-domains = <&ps_dispext0_cpu0_die1>, <&ps_dptx_phy_ps_die1>;
+		};
+	};
+
+	memory@10000000000 {
+		device_type = "memory";
+		reg = <0x100 0 0x2 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+/* USB Type C Rear */
+&i2c0 {
+	hpm2: usb-pd@3b {
+		compatible = "apple,cd321x";
+		reg = <0x3b>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm3: usb-pd@3c {
+		compatible = "apple,cd321x";
+		reg = <0x3c>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	/* hpm4 and hpm5 included from t6022-jxxxd.dtsi */
+
+	hpm6: usb-pd@3d {
+		compatible = "apple,cd321x";
+		reg = <0x3d>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm7: usb-pd@3e {
+		compatible = "apple,cd321x";
+		reg = <0x3e>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+/* USB Type C Front */
+&i2c3 {
+	status = "okay";
+
+	hpm0: usb-pd@38 {
+		compatible = "apple,cd321x";
+		reg = <0x38>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <60 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm1: usb-pd@3f {
+		compatible = "apple,cd321x";
+		reg = <0x3f>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <60 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+/*
+ * Delete unused PCIe nodes, the Mac Pro uses slightly different PCIe
+ * controllers with a single port connected to a PM40100 PCIe switch
+ */
+/delete-node/ &pcie0;
+/delete-node/ &pcie0_dart_0;
+/delete-node/ &pcie0_dart_1;
+/delete-node/ &pcie0_dart_2;
+/delete-node/ &pcie0_dart_3;
+
+&nco_clkref {
+	clock-frequency = <1068000000>;
+};
+
+#include "spi1-nvram.dtsi"

-- 
2.51.0


