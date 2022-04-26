Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB71C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yWHfMKCiwjJXCsrJiGT6/bVZgwgoJFHFS34FWlqT3gU=; b=hv+SwGMAPKabMUF5LVydJh4GIW
	AI7+VqP9T+rPK1J3SYT287PAcZ1fIGPNpmCTZTVokPx+2ctzu5ioRecMAIlk380VD/mQRBnpSEF0Q
	RAO0mhqGIID/pmSESvbk3XLxsWOH6fweCqx/2u2LwiyjNH0BSNSEHf44tb8ccHjWS2rAkj3RBnHXk
	G4NdEfcipJ977Osdoxrs134wUcWdNo0UnNmwD3XcyUZxtG6m9Q1UetuCi/7eSMIw6Oa2s86em9V+k
	ALTAjreFyJjVBYcShJfySUP78zCU5d1vv7eJDwFVXYDbY5TlVocq0+5BFbujEtq6Nqk9ZgArjsCTr
	kaYTFz0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njRdC-00G6CU-He; Tue, 26 Apr 2022 20:17:54 +0000
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njRbK-00G5Gu-Eg; Tue, 26 Apr 2022 20:16:00 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id D7D8D5C0109;
 Tue, 26 Apr 2022 16:15:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Tue, 26 Apr 2022 16:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1651004155; x=
 1651090555; bh=yWHfMKCiwjJXCsrJiGT6/bVZgwgoJFHFS34FWlqT3gU=; b=x
 +wa7QY1FsThQXRwNJe3fJTGyMnw1lOwtuHoJiN86GciUU8fOVl/NGadS2DNhY7s/
 7owlbPMqaNfOQ6voJ3CaENSN5mrwqqPDOXr0F8K9E5n83N52xxS5HNBVuqSXgJin
 Lro6PwTtr7sxFNh18gqhgsiUZ7zUh7sMZNg2pICrSiQeNpiPEzThIOsFWk4WFeJD
 Cd2AU3y0//Hudf0X8ivZSbLC0fuOIyucdaa4QImLl/2rgCM9yfEhWGivwcXi5Us7
 nphjNh7dhEn9+1l2QppIK1MaygdJg/LOULjWV3yqLm9KC2oz2tZ/tt7CO50fPYMV
 sSP8tdIUNNBL+MSzSaBcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1651004155; x=1651090555; bh=yWHfMKCiwjJXCsrJiGT6/bVZgwgoJFHFS34
 FWlqT3gU=; b=lwxLGW/IoP1uie4057T+28UFltsWSpXMzzLt7c+OD3RZjUc6BAc
 V/pBCadmLC2xCJlsAvYPmdSyvi+UpSZZTu+3KDCMdbGN0anfMjuRFT2WpOa7fYt/
 Mb1S1P96t3x28chqQ1x6k6bgT+kqAQmVJ3FrPCCnNPu5+OGAVr9dbg0AaWXgjTro
 z8aSAMJza8zzXxhedImmMFjFs6YXmfe9pCWfSvBJ/dMeYe0v95a38tzrRNuxSALB
 nu1Zw/3wQHRBUx7z2LbLILi1Z70E9zPATmgY7f0KFg4tFQz8adV6EUrww+99m2xa
 buxLe/RZVJrkbxLSjTkkJkdVkQp4h1Wgn5g==
X-ME-Sender: <xms:-1JoYnBKoje4xDkxq2ds6l2oMCpwdOM7JUw7DiRw29nVTlqlphxv6A>
 <xme:-1JoYthtMIatVAkgpw6wsrPMc1GS1tbvs6KzmXOahfPUjZthmUrQbUvKkNHlTmZe9
 Ph74h388YBL3R-WdbM>
X-ME-Received: <xmr:-1JoYiktzy_EMbbi5td2ObOX42-VV8G5A1aJoiGAa52YNK6LtoWRF9PHWUXGV2t0gGrdysNA32xYMYNqgfn5dSdy5yrwafFxKKPFXVuZMVxL3L4i6WWOXWzV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
 ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
 gvrhhnpefhueffgfffgedtfefhfeeujeefgffhleekteduvdffieegffeuvdejgeduleei
 leenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghr
 rdguvghv
X-ME-Proxy: <xmx:-1JoYpx8ePJPB4R36qS9d-_ECaVkzfyNBxwkMo1XGkAt7xPhvtFpaw>
 <xmx:-1JoYsT6VOF7t-kMa7uU9sZ4J_qnqIWGvsyG3qZQqpRHiedsmYftLQ>
 <xmx:-1JoYsZ5EfBoOt3500bq1nMmvA8WVsMhyM2sc17w6rpoprC050t9mg>
 <xmx:-1JoYphYBagC4jrcfE9c48e5Jsrp9emtMoI440gbPaK6l8hPvXFIMQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 16:15:53 -0400 (EDT)
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
Subject: [PATCH v3 2/6] dt-bindings: nvme: Add Apple ANS NVMe
Date: Tue, 26 Apr 2022 22:15:35 +0200
Message-Id: <20220426201539.12829-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220426201539.12829-1-sven@svenpeter.dev>
References: <20220426201539.12829-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_131558_605344_69C68CCB 
X-CRM114-Status: GOOD (  15.06  )
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

Apple SoCs such as the M1 come with an embedded NVMe coprocessor called
ANS2.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v2 -> v3:
  - Added Rob's r-b tag
v1 -> v2:
  - Moved to bindings/nvme (Krzysztof Kozlowski)
  - Added power-domains and power-domain-names min/maxItems
    (Krzysztof Kozlowski)

 .../bindings/nvme/apple,nvme-ans.yaml         | 111 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
new file mode 100644
index 000000000000..ddff9233b159
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvme/apple,nvme-ans.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple ANS NVM Express host controller
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-nvme-ans2
+          - apple,t6000-nvme-ans2
+      - const: apple,nvme-ans2
+
+  reg:
+    items:
+      - description: NVMe and NVMMU registers
+      - description: ANS2 co-processor control registers
+
+  reg-names:
+    items:
+      - const: nvme
+      - const: ans
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    # two domains for t8103, three for t6000
+    minItems: 2
+    items:
+      - description: power domain for the NVMe controller.
+      - description: power domain for the first PCIe bus connecting the NVMe
+          controller to the storage modules.
+      - description: optional power domain for the second PCIe bus
+          connecting the NVMe controller to the storage modules.
+
+  power-domain-names:
+    minItems: 2
+    items:
+      - const: ans
+      - const: apcie0
+      - const: apcie1
+
+  mboxes:
+    maxItems: 1
+    description: Mailbox of the ANS2 co-processor
+
+  interrupts:
+    maxItems: 1
+
+  apple,sart:
+    maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Reference to the SART address filter.
+
+      The SART address filter is documented in iommu/apple,sart.yaml.
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: apple,t8103-nvme-ans2
+then:
+  properties:
+    power-domains:
+      maxItems: 2
+    power-domain-names:
+      maxItems: 2
+else:
+  properties:
+    power-domains:
+      minItems: 3
+    power-domain-names:
+      minItems: 3
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - power-domains
+  - power-domain-names
+  - mboxes
+  - interrupts
+  - apple,sart
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    nvme@7bcc0000 {
+      compatible = "apple,t8103-nvme-ans2", "apple,nvme-ans2";
+      reg = <0x7bcc0000 0x40000>, <0x77400000 0x4000>;
+      reg-names = "nvme", "ans";
+      interrupts = <AIC_IRQ 590 IRQ_TYPE_LEVEL_HIGH>;
+      mboxes = <&ans>;
+      apple,sart = <&sart>;
+      power-domains = <&ps_ans2>, <&ps_apcie_st>;
+      power-domain-names = "ans", "apcie0";
+      resets = <&ps_ans2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4961da640e82..1bc8b732f129 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1838,6 +1838,7 @@ F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
-- 
2.25.1


