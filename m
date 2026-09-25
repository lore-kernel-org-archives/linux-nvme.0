Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6480C9830E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FKrsPM1b2jKe3kZvS/DYTtfcN8visrVVzc3p9LNJVVg=; b=YPd5aAxKbKM4w6p/9f6vErkkOB
	H1mC8sI0E1ZO7kBrHKYNQNsPFMv+bC9kXFnxv77kZfi8xzk4zARlw1Xy45P0K9YW4xURpIO5XduYV
	mE5O8C0JMFVPAHIp39QCNubbFtC4BjDEQRt8Go/Lb/mVIco2SmPkOM7m8f2tFSdsT2iqkdUpXo83Y
	OlQpFWwpH5CplTbg0ZRQeGkZ6oCa0OqEPd8/dhpj+reN15oyw01FyseiKvfPXnWTDgtxwT/nZSr2u
	ACu8y/5+w/3s2H37u8VVa0O8+OjxjRzztUetGWWHKb17ltDzApLcNWJD9/9QJ2RNSIQqjiXfHIcVJ
	XyavdyEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2XE-0000000D1qe-3wop;
	Fri, 25 Sep 2026 09:48:04 +0000
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2X6-0000000D1eS-0jaQ;
	Fri, 25 Sep 2026 09:47:57 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 56DE0EC01A7;
	Fri, 25 Sep 2026 05:47:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 25 Sep 2026 05:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790329675;
	 x=1790416075; bh=FKrsPM1b2jKe3kZvS/DYTtfcN8visrVVzc3p9LNJVVg=; b=
	RR6lrjD0+xjZKyP8BpgxpLM3qfVxKob83DDQzZS2NqWW9DE2U1D4vTddAszuVqQA
	RTB3apLGkzlUfj+EfXWJsWVMX39sx9Fr6sg2MP9d4vaN/BIMNjlWSaFntNkZ6sHf
	niYdJ2JU44NB/fe5MrWXOFdWbRqI3vMie9F+0yt3lfOnHQqoArsTKWUrKLp9UxL6
	CjaDULPowIyEVhLyGU2NhCbJSDv3jhW+AbePjPLsLMUyNFtSB5Uzym7C0n/FddyU
	wS9jdes0RjNlHjaArFuidmJ7AYcSwMtOPJmfjTWrbih8ikVImyE3LnGyONjMkTWF
	dcpVlCXXGGd8rMDaG7W1fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790329675; x=
	1790416075; bh=FKrsPM1b2jKe3kZvS/DYTtfcN8visrVVzc3p9LNJVVg=; b=p
	848kTUYf3OebsyBDwiks8mXpXyZSwggJUFkUahqKUvaauaGOwCkjyQEzlAclvZPT
	Ao3OkmPVcPt64M8SUxm+vlqN6WToTPQjK0fCD70xn47sK3D4X1Tkmlw/Um/WShrl
	oTkLNyEYOprUIoTZYVOk27XPR5oGF9g3tg9JoLmddSuwHrDh7Ohdrxvlnj4S+ow/
	E6Ok4OlGSycO9XqKYZi9Pe35X0JnNWIBBz0ZslOR86F9XXy4IXpCyBFA48hVkQDB
	vHTLHevpllSLDYCTnsf8PievWuoSzy0TaFWtQineFChbUtDj/+3uXpm8Nps83w2C
	KYV4QbeBi63WM/xQQhtgg==
X-ME-Sender: <xms:SkO2arQ1FmfITNakwmBA9jTDtU7_flYhV3YNf2h44jidR3sMQiW66Q>
    <xme:SkO2atNcEY52XO2yaxPog2fO_hnu3hWV0dRL4YsJFPZku9WDkfwggJ0_7sOQtvkot
    pcHh-HilsmCokDdzNwgFoPGCTQOMjEmT6jlZRr56F3m0cAOz96Y0ZI_>
X-ME-Received: <xmr:SkO2amRbDHgysunKxK7edd37caWTiG8uI1y2vegaPSU12Wt7EsT3n036g3wT1tEpoPk9wwA>
X-ME-Proxy-Cause: dmFkZTEwps/QxAWSkagPSHBbcYwuI37XW4DvirwdiYOGwq9AEZKxmSwYz63+coJ7wZHluP
    jgjVctfghm5b5XWz2n07A9q1QaNev+5azhP7D1mIEnWcc7GyMeAKCOuAf09Zm6QFlhMejE
    gEXz+W+bKMz+kccVLYaqKBvNoAlmwe4qHn6j33++Tfk8NkCZ/4YxJmJFnYYt6bNYB5JyX7
    wU1UqpqLmMC5vJwj6KME23vX03QIuAPw+2Jxt7R/8XYigoV9KzDK+UG3MNfCxO5B75MboJ
    lkHYESZxGP1e30qhetVcIgSKr1zAlGTH0xqrbEx7tCd6z8+Rraubfup+2SsfcRLuC6VyDj
    vah13dLsEtIh2kbwx38xLkiiz77plwhH8qDYtUShkJw0slpRyOxJZBpaxrgH8I4aeiEJnU
    SGvJkV4mEIGTId9wutnvsH5srs9LG1RLEOQnkBxunfGnBgX8kwqYfl668bbItCE6VrIZEj
    hqK19htMTraOfEljILtswA2Ix9Ln+XlSWJN0kgQtLMocFLGv3itHoft+z1ByP8QIGM1RXA
    1KhvX0aOQg1G1vxqN2NXoId/GcxUTDBM53sdQTTrt3MXnOxNpxGv3HXRS6+51hzyosIUn8
    CuB2kYos3kacOjB6zpyGV4or9C1aZmVJhxGcoeczY5f4H8ntOoOoRehgwCnQ
X-ME-Proxy: <xmx:SkO2ao8Yx0UqWR76YWTlAG56S721sZD0hx49iOMK6ac4-xCvDEFdLQ>
    <xmx:S0O2aoVnYTNYWKGAyxDEQhXMnhHzrExWZaQBO5IxFBjRZYaUMTTFBw>
    <xmx:S0O2auOY3z1l43c9cZm7zPGbl5WrkH009GP2XxBpM51b4utqqgddMw>
    <xmx:S0O2agfwlW2sJJa5jpIgnbMG-BlDKq9jcBsOURBwjZAmf_jV_YC4Vg>
    <xmx:S0O2aqMNQtx_YHc1j1RCxRmM4lZAcmE4YEyoHjERFcT3_d5IXL94hfZx>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:54 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 25 Sep 2026 10:22:54 +0200
Subject: [PATCH 7/7] arm64: dts: apple: t8122: Add NVMe device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-m3-nvme-v1-7-5e832e2f4aa9@jannau.net>
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
 Janne Grunau <j@jannau.net>, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=j@jannau.net;
 h=from:subject:message-id; bh=19Hv0hKKWlJhIfvihHJebyj8UmWVLiDDYFirA9GLXFI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtzjqW7xsXa0VMlPM6UiDvHpzcXhOg9v5XuLKOpVHly
 gThPLWOiSwMYlwMlmKKLEnaLzsYVtcoxtQ+CIOZw8oEMkRapIEBCFgY+HIT80qNdIz0TLUN9QyN
 dIx1jBi4OAVgqlNkGP6HTU/elDZH//rL9eGJm2evt39hfYvt0D6x2yENz27LSs1QZmRYq+90bIX
 F6d6CWZECe1yDY+R6w4V2/X3/rUbMU3pa2SEOAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_024756_294462_60C2CDC7 
X-CRM114-Status: UNSURE (   9.48  )
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

From: Michael Reeves <michael.reeves077@gmail.com>

On Apple Silicon, NVMe communication is mediated by a
coprocessor known as the ANS, and protected by its own
IOMMU known as the SART.

Add the following nodes to the M3 (t8122) device tree:
- Mailbox for the ANS coprocessor
- SART (IOMMU for the ANS coprocessor)
- The NVMe / ANS coprocessor itself

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t8122.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8122.dtsi b/arch/arm64/boot/dts/apple/t8122.dtsi
index 52257fa22631..959ddf36efa1 100644
--- a/arch/arm64/boot/dts/apple/t8122.dtsi
+++ b/arch/arm64/boot/dts/apple/t8122.dtsi
@@ -454,6 +454,46 @@ pinctrl_aop: pinctrl@2f4824000 {
 
 			apple,npins = <54>;
 		};
+
+		ans_mbox: mbox@309408000 {
+			compatible = "apple,t8122-asc-mailbox",
+				     "apple,asc-mailbox-v4";
+			reg = <0x3 0x09408000 0x0 0x4000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 730 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 731 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 732 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 733 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+					  "recv-empty", "recv-not-empty";
+
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans>;
+		};
+
+		sart: sart@30dc50000 {
+			compatible = "apple,t8122-sart", "apple,t6000-sart";
+			reg = <0x3 0x0dc50000 0x0 0x10000>;
+			power-domains = <&ps_ans>;
+		};
+
+		nvme: nvme@30dcc0000 {
+			compatible = "apple,t8122-nvme-ans2",
+				     "apple,t8103-nvme-ans2";
+			reg = <0x3 0x0dcc0000 0x0 0x60000>,
+			      <0x3 0x09400000 0x0 0x4000>;
+			reg-names = "nvme", "ans";
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 742 IRQ_TYPE_LEVEL_HIGH>;
+			mboxes = <&ans_mbox>;
+			power-domains = <&ps_ans>, <&ps_apcie_st>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans>;
+
+			apple,sart = <&sart>;
+		};
 	};
 
 	timer {

-- 
2.55.0


