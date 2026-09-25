Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5E8C98328
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 09:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgLJT7gJp2Fy7W73lyx41lDe1zDG0NpaZeQuqYkYPM8=; b=q0NnXOSvy38v5T6DcVSZp5U6El
	GUvI+GiqJIKltBpTizlDJZ4Yfj/aWWuqvZOjHMQRZG6CsIoGixiEJl3uzxF1jv0krUZSVOcdL3QNa
	3ZNZ2B13Cm0myWtCk0k8hpWgoS25Nb32WQTQYMjF+g9DVGY/KWPtL0lXo71tcC0xCyS7xnco06G/t
	1YTxuBi7EdLcerB27Stgo+M2pDJG75rJxBkhiG3WHvfB/Lh5zfc6iP99cbOQ5JWos/sW0ZYbm4ISW
	LUcKNpqQw4FJfd3X2W8eupx20RJa2OBGJFgbNuC/mWGxfoWWPfPlsYAKEn94kU0GRq84C4gM6gJpX
	jf9PUv0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2XD-0000000D1mD-0IsC;
	Fri, 25 Sep 2026 09:48:03 +0000
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2Wx-0000000D1YA-1Uu9;
	Fri, 25 Sep 2026 09:47:48 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0887E140001D;
	Fri, 25 Sep 2026 05:47:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 25 Sep 2026 05:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790329666;
	 x=1790416066; bh=BgLJT7gJp2Fy7W73lyx41lDe1zDG0NpaZeQuqYkYPM8=; b=
	PdE0cQ5ANjCmFzPv5YnHrWuTKpnTw4yMur66qhigIrsN4g2lPWKEa2W7GDo0ASFg
	wBGXdoIR9BTMG9GX2sOBrO5jNsyaNPOtPp/3aYs/3bcpsGHEvrk4nznUWDM+bPsU
	1TyiSNSMgRdvUT9BQyBm/XI4+sGUK6VIgjDNAOU2EOY0Gd9PzpVtgc0YMvS4E5I7
	zb8oGCU2z2F46cX0+qjS44WRz6Lp3iwSZRVC3kFy/c16baZOPS2iKXRNzNNU0b1N
	LS+7K6YYa+0ZukyebVgxJ6qclVbVFyS8+hoVui3CsMv49CQJmObx1aqLG480zL2c
	0YTWAo9A+gGPNMOZRzpWgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790329666; x=
	1790416066; bh=BgLJT7gJp2Fy7W73lyx41lDe1zDG0NpaZeQuqYkYPM8=; b=c
	J00AtH5KGUv4OOiwiXOaD0ZiNYScLJkqxCazZh0t/WSZJVeVmsnjj703b9aKCncA
	r4pwkrnEPW9CrV3phw1L0xDojzh7bS8+b3RWz3iWUy4ijRhBW7PV+DYiE3kmICtG
	tWMybAglxw8GQbVRaYT5nGrjEYj8U6SMnZKIuYc1/hdDEZo0DKs5JDPgVqLI0HmT
	XYmtbMC3a+nmYelZwaR3Ux14trBtBbmrN3SgFRyrN2QzhD5b0g56y97mB7C18mBX
	NGJ8KBQo46uKNUltGGJSQ0lYk47P6e7WiG87l6h2lRqkzC+uJjr5eXGd9ui7+INv
	m7TEfbiJap+L/PPeRqLUA==
X-ME-Sender: <xms:QUO2alFIkNSEj6tSQBk3VMGCHr3QJHPN3b4FT7mWe8IW5NhaqaHkww>
    <xme:QUO2ahYnb8vFMItnfG-YFGO0DuYJ_pOAU8qXOw0tQrUcS1fMhQJWpe6yOxe0-Xnzc
    nrtgckRBb2By2Dn3ZUPXNBRUiFnaXZBfjuPio3DRU9EUhJliOCICf8Y>
X-ME-Received: <xmr:QUO2au2Jg6Ge6xmFQVKETyEn5AxEBjgZkfkrs38wWcPRilG4VlNoElRqJscRUDzeT0kvB7M>
X-ME-Proxy-Cause: dmFkZTEbJhpSeMD7LDnpXCsQixag+cvxD3bFoso28WtgwG8J22LA5vwA2EmaCBywrGkNVk
    fJMjIB1Awjw+5D30C7m+Dp9Vxht3KEjZe6Lqrn96FVDODdxJTXUrAFR/eapVtvwXhviQS/
    JjIqmjL9odLytU7DATY/m+docx/hb3FWUj64crzCk+tps7ekg8phg3zCMXxYaP0Ob+waHV
    cSSktW8VoIuVmdCIqemuf0fMDG7R4dEOgW1ZWVrHKk37AKRJ6VGIvRwRezkqZ1pcO4AQYm
    oPUZAjyu+mKYQUVO4Gg0cdt3FfSRHd0FcPgbe7x6n5fIfG3GTyJW626LUIjETbYg6L0HUd
    bb3MdsynMFBcAFgeN+WrxNC9Vd0Omtucz4J/kuv6j70NU7ILl2+HX8fPdpJH8I+uWCAUJY
    I+WuujpmNuBDT2YV43U+b0MLMl/lAGfQhQe+HhLw3k84JlWVs2t1LPAjLTHe00RtM9D2FM
    3HPP2oK9yTP5wNX/17Meoiqp8aYvkZ/gE8R/jlGrUkOpd8XQ5MsNTKLytEaANZulFLyqnu
    Z5SqLcuDoAAnnDWiZmHl/370jREpk2XN4HFQWqeHYLJ8Br82+1Wn0PeGEmMW7zi8xPc7zW
    umkeBmdgwKM7ApjBIeU8lZCNJt8g/DKaQLDyO0IHmv73jVRoCRoL6x0vQWWw
X-ME-Proxy: <xmx:QUO2ahdcd2ls74ds6zeE2E8BUGrsMHCUX4UX-EB7L-gP8wl7BfZXSA>
    <xmx:QUO2aoDtfHpGDAIjNBPYJHWzv2SWdKw0REZjQUafjP9xv3fZjPATYA>
    <xmx:QUO2ar3QY_Q4UBph6UIGGQ-d3SgRtxhsnGXJfSiOUD7oAF2ExAXlQw>
    <xmx:QUO2agOzdKs9cDzx8TpU7DKr-vKXEUcAlDDwGLOljfoklss3E4PG_g>
    <xmx:QkO2amdl8hVkf_Fvc3_3pETOZFzeZTify9YmRDcaBqGr1JLbg3-wdw3T>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:45 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 25 Sep 2026 10:22:52 +0200
Subject: [PATCH 5/7] arm64: dts: apple: t6030: Add NVMe device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-m3-nvme-v1-5-5e832e2f4aa9@jannau.net>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
In-Reply-To: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, iommu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=j@jannau.net;
 h=from:subject:message-id; bh=2FnZzOmwSzL1DhuUo82J2O5tzJ3UyA/MVzvPykkU6fM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtztrVXTf296z2y/W2z64+w5mz7OfUE867d7XtXCu50
 WZLhP/6joksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKoFqxn+h35+r9XK8fPD69rG7CcvciYpruVWmL+OWeLpu7UuhjvPVzD8r+Pfd4p
 3IoOPyau3rIlxzwOOvxSN9skrPVGqeLXi4fPZTAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_024747_472946_E585B564 
X-CRM114-Status: UNSURE (   8.72  )
X-CRM114-Notice: Please train this message.
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

Apple silicon SoCs have a built-in NVMe host controller. Using it
requires device nodes for its IOMMU (SART), its mailbox and the ANS
coprocessor implementing the NVMe host controller.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t6030.dtsi | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/apple/t6030.dtsi
index 524e532830e2..85a16d03e22f 100644
--- a/arch/arm64/boot/dts/apple/t6030.dtsi
+++ b/arch/arm64/boot/dts/apple/t6030.dtsi
@@ -537,6 +537,48 @@ pinctrl_aop: pinctrl@374824000 {
 
 			apple,npins = <54>;
 		};
+
+		ans_mbox: mbox@389408000 {
+			compatible = "apple,t6030-asc-mailbox",
+				     "apple,asc-mailbox-v4";
+			reg = <0x3 0x89408000 0x0 0x4000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 839 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 840 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 841 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 842 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+					  "recv-empty", "recv-not-empty";
+
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans>;
+		};
+
+		sart: sart@38dc50000 {
+			compatible = "apple,t6030-sart", "apple,t6000-sart";
+			reg = <0x3 0x8dc50000 0x0 0xc000>;
+			power-domains = <&ps_ans>;
+		};
+
+		nvme: nvme@38dcc0000 {
+			compatible = "apple,t6030-nvme-ans2",
+				     "apple,t8103-nvme-ans2";
+			reg = <0x3 0x8dcc0000 0x0 0x60000>,
+			      <0x3 0x89400000 0x0 0x4000>;
+			reg-names = "nvme", "ans";
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 851 IRQ_TYPE_LEVEL_HIGH>;
+
+			mboxes = <&ans_mbox>;
+
+			power-domains = <&ps_ans>, <&ps_apcie_sys_st>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans>;
+
+			apple,sart = <&sart>;
+		};
 	};
 
 	timer {

-- 
2.55.0


