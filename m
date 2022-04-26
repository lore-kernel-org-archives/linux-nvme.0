Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDC8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 20:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gu8wjFAZS//ewmI6BDwb6NDbCp4RXdlDD2CfzD/0XzY=; b=zQCQglIX/vGhwpQAAiKT40KUhk
	JdqhvZEIb8OvfsR1loXJQpKEC1vJAccEqt+fl/XDyfGbxU3bd3dvOXc1WnY9W2NF6M7HTKgJUpc/f
	BpwrVQZYzXoZ8a9HWWe393ATbnU77xWAu6/EUOfTGY2+IKa+weRmXB0/mqzLDNAeFYcHZJtDNUOt4
	Yb7VjN5/k6VSAroeWeHyjL9s5uDDgBi2tOiOaYBTVkLUJbP95LqKPx1U8OcDEAlIr+aFas41WFJY8
	xf5sgdcr2nnpPissRNqa+wXL5GTs3JdPbGco09St035kaqCaIs6bG7sQyNSip1ELpEVCxbBkHOttn
	BFCQUcjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njRbw-00G5V5-JY; Tue, 26 Apr 2022 20:16:36 +0000
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njRbJ-00G5GJ-4w; Tue, 26 Apr 2022 20:15:58 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 11B505C00FF;
 Tue, 26 Apr 2022 16:15:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 26 Apr 2022 16:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1651004153; x=
 1651090553; bh=gu8wjFAZS//ewmI6BDwb6NDbCp4RXdlDD2CfzD/0XzY=; b=S
 zwzOMT1tPSRi5s5VrAwaWpvIPdBYeWKZNlcTvYbWLGQCmT4vTOF1jpbunibHD1SK
 jgNVwIrF3JsC/rgyxzBGVyLs/ssqjzooNKW92nrGuo2V/CJYxdmTS7h/un6b1OMl
 l4wKRTYmCTbq8pNLK3dR5/ysRBH1hcn7/HoDeWFECxQKI/mR8Qsq6S6icc12kIPE
 qkNXAG5egl1ZYfWtLImhWTxe3NMteqd0PTqywWKBDI06IpW7FjPtonQqYG+NWn7+
 VXo9vk/vQjiYYWoRXtLiNCSodDvEpM4YQyYQZ69AkCBYFeHAPzD6ZSZ4m0dtuyLB
 R2epG2Wn9a9R6o5G9Pnlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1651004153; x=1651090553; bh=gu8wjFAZS//ewmI6BDwb6NDbCp4RXdlDD2C
 fzD/0XzY=; b=JeJ7VkHKXvxWiPhVb/mq4l1aiKyD91OBCx4FV7QSTbczY8ARInl
 hmdpSM7CC/pqunoIJaxOWRMl5V+EajyqFdpAQ6HtG6gpIfdu6WVIh9cqkuTq2Qi7
 w5Yb4niSTOH6PrHFV73Ega66iphw0z0D630ezA1dfcyFfqVkTf/0lP3almXktA6E
 7n4hs75Eaa3LeufdsgYSe4j0s1JOOI/HTP28Y96b91QueNSpJRkR8Nwfm16NXUyH
 IwY0kGPtoUKEL+NjRo2ipOE3ZLc3uor4HDT263Zfw7AjXAZ1m3YZD3PKLUIV439i
 KIL9arLxuhS0bZlv45k/EojrAiXP0GkfxIA==
X-ME-Sender: <xms:-FJoYv74w3jFjCzKCYqzdg778nCFpvhNP4IoUWOXVxwjuIXv2781Vg>
 <xme:-FJoYk5UQ5Oqk85xs32MYcexc6lTSuGQ03FHSI9HMdc61HpPhpJvu1nSTX16aeSFc
 wUMLVgqRFdsNizS_Cw>
X-ME-Received: <xmr:-FJoYmdRsYRvEwwYZEGLMee-jqz9Rgxnfc3rKzcKRQGlfd6KpBFIJ9qB1C1Orz_73u9XiMlBnH5EnbW7BkjSG8t3rJREyantK_UrK3azCEw4ERzMLPdhRhh1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
 ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
 gvrhhnpefhueffgfffgedtfefhfeeujeefgffhleekteduvdffieegffeuvdejgeduleei
 leenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghr
 rdguvghv
X-ME-Proxy: <xmx:-FJoYgKfeXBue2qa2QZS0VCdjTryr6AV9xmCDTBbnV6RJCmvTzSOTg>
 <xmx:-FJoYjJEwLbp-wlblpXNCrRSlgCVF-dsV5_vxs3CvAUMEnht2KoZiQ>
 <xmx:-FJoYpyRIEi_DH4eX_Pm7B29ZaTM5LnUBDwbwL40N8UrLWAenTcmQg>
 <xmx:-VJoYk6RXDx2OJ1n2K__Y6dASNSj6pH8Bjv_7kK8MLxdIG0OuYWRHQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 16:15:50 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: iommu: Add Apple SART DMA address filter
Date: Tue, 26 Apr 2022 22:15:34 +0200
Message-Id: <20220426201539.12829-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220426201539.12829-1-sven@svenpeter.dev>
References: <20220426201539.12829-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_131557_330420_10906622 
X-CRM114-Status: GOOD (  16.75  )
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

Apple SoCs such as the M1 come with a simple DMA address filter called
SART. Unlike a real IOMMU no pagetables can be configured but instead
DMA transactions can be allowed for up to 16 paddr regions. The consumer
also needs special support since not all DMA allocations have to be
added to this filter.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v2 -> v3:
  - Added Rob's r-b tag
v1 -> v2:
  - Moved to bindings/iommu since it is "Close enough to an IOMMU in
    terms of its purpose" (Rob Herring)

 .../devicetree/bindings/iommu/apple,sart.yaml | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,sart.yaml

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
new file mode 100644
index 000000000000..1524fa3094ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/apple,sart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SART DMA address filter
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description:
+  Apple SART is a simple address filter for DMA transactions. Regions of
+  physical memory must be added to the SART's allow list before any
+  DMA can target these. Unlike a proper IOMMU no remapping can be done and
+  special support in the consumer driver is required since not all DMA
+  transactions of a single device are subject to SART filtering.
+
+  SART1 has first been used since at least the A11 (iPhone 8 and iPhone X)
+  and allows 36 bit of physical address space and filter entries with sizes
+  up to 24 bit.
+
+  SART2, first seen in A14 and M1, allows 36 bit of physical address space
+  and filter entry size up to 36 bit.
+
+  SART3, first seen in M1 Pro/Max, extends both the address space and filter
+  entry size to 42 bit.
+
+properties:
+  compatible:
+    enum:
+      - apple,t6000-sart
+      - apple,t8103-sart
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu@7bc50000 {
+      compatible = "apple,t8103-sart";
+      reg = <0x7bc50000 0x4000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..4961da640e82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1836,6 +1836,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
+F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
-- 
2.25.1


