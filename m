Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBF7CA0FE9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLgKkUt/EORHceeO89abTN08otZovq/goeI6WeVPzj4=; b=SOQNpOOjnfmmKt8gqieo1kJ2Ls
	KKm7IYaO3UKxDa6jtZNEo+PZaG7ZA1wRDr4qr13VVRTLH2A+6sbNij0+IhRT/UYSvRuTB2WSE0UCP
	85Afu7fNYYPKWnXgKv8WNZdDqra6Dy/ns3u5NvkFXd/+OeKPQ/kllHRu9f94d2VosMAT6/Q09Dh2U
	X131sN2mNPFfo65oYwbY4o73eJ3/+SHyKTeSkUYP66e8FhMEiKRgKkcqcyGIuTxN0G9Shx7yewyBM
	64mNcK6zquTMPCcyU7Kb4lBVh2+1dYAb1wWOfS1iEh3gNOche3eGAIrvHD1almsN0jmnDFNt1vAIW
	6hkHAHMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqVNS-00000007kOz-3mmI;
	Mon, 25 Aug 2025 11:28:42 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTJS-00000007Ssv-2VLh;
	Mon, 25 Aug 2025 09:16:27 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-24456ce0b96so40332285ad.0;
        Mon, 25 Aug 2025 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113386; x=1756718186; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLgKkUt/EORHceeO89abTN08otZovq/goeI6WeVPzj4=;
        b=Jjq9tWePFx03gbv5wm+zmVbsC3f05O6lGAXVIr6/s+4YpMEy8TZTYMLjtfosGAv6oy
         1xHLYFA4vQiqqJHOk18snkR3KOJms5gbb0PkLhra0s2QOb609vB84JKXo/DIvl2vETJD
         P0dW95N9G4kuAtD66y2mU7wUXnfJa9Y5uMorUvrK04fn/n6yYTiDfTozm/jiorpjuNS+
         0Y9I1q8UBEJr47VFdy3oLKQAS7KCvjrPgjxllhv//1ThLjOx0Pc+BoAbR5hYlyVt0NHf
         UjvoQs1VtnbVrMEzCcZkw1xjMK6S/7ITFlROyz8vS7rieU7U+OnDgvPgdh5HpvGbVMbs
         0VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113386; x=1756718186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLgKkUt/EORHceeO89abTN08otZovq/goeI6WeVPzj4=;
        b=ZDSQ5rmDu5Qr3PZEH8gsma+QnDXbIk3gqLBfqi12FDA3lChFemRdau9z6IMzH/qA/j
         qGDN/TFD63De95nlKQESKLYbbf+MA/EVTjZSvr9rZHgmLTyE27alJqhCuVbsS8dJO27i
         B1nuOva9Zq1lZB3oiH/I6Nbj9TRliKMPnt2IybmNuV85qxri2QZDdV+6DthiTtQ2aN/r
         0hXcpVpxi7xFwNgUA2u03Rg8vMsjG2azL8qXBdd1EGXeWaBftZ0mjxeD5HxTegMZ/vO9
         QqnX37XdjEE3YrYYdep+Gz6EvX2UPJIXeHVRd/H8T46N4Fq3RoKyTtElESgktmeLZaZW
         40Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU9PjNymaM7zrbLbdFMohwiDLGdcaPzJ0vdOJlDoXfzQmMRWj22wd1MwUXltRcQh//uMHxtI0jUFaJLWZoGQDFp@lists.infradead.org, AJvYcCVZtc0++DyhtGIQZ9f0thQ6PKqCO7tkswm2MFGRdxiG9oxl0t4vcN467t/RD68X0lHSDlGz1vAEDue2mA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmbosReXYcFlZPwhluhICdZB8pbwOyvBTnl+Qu+N3uhuCIdpBF
	cGUBKKlsZAGT9VlLLvEHwmH4NS1iVltQ6UhNXa9QLf6LutaYFIP3YFpr
X-Gm-Gg: ASbGnct1uumupVyoB7wZnl5+CSkMFlBuMGjaLA6Y5FOVSTrpfXnknm2reDs+mI53cAS
	JourzUZIugV1YEMF0sJVWWZNUXoyMwxLRK10G2T2su2TWbuNCx+D/XyR12dz5z2R+jTthAhoHCd
	RzEqseAk5pbL+XNZob2EwPiaPyCUWRdhBRF60mBxIW3Q9YaJxoIMTmH5bYollbl+HnCa0SzV6vc
	4dc0a7JtOTgJ2xCzgnOh41uxYwuQtw6rStKGPQH7PeTPxofRaxInaNcnPqHB4N5nzfgfUI+GVYQ
	zYYJDYldNfOEAmFMnJ6SkK3mwE3mw2TCPl6OoOLgZGEKbL4CfXv/h35/Ff/XvfX9ebTesoGKdpD
	AUjzPBQiFAePRH2HqL5+1bwYEgG4=
X-Google-Smtp-Source: AGHT+IHgizChUVDS7mx0qvkliQW47KxLTLpcVKppDYz0nFP6cUthwlUhWYvTA6G9L8vEDxCRdxjvFQ==
X-Received: by 2002:a17:902:e888:b0:240:4d19:8774 with SMTP id d9443c01a7336-24633d6a31amr135180055ad.24.1756113385707;
        Mon, 25 Aug 2025 02:16:25 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm62873875ad.122.2025.08.25.02.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:25 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 25 Aug 2025 17:15:07 +0800
Subject: [PATCH v4 4/4] arm64: dts: apple: t8015: Add NVMe nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-t8015-nvme-v4-4-6ffc8f891b6e@gmail.com>
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
In-Reply-To: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=n0GU3aHOIbzcpxdfkfvKoQ2JdbUFCoeF/xHA7QnVC2k=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBorCnSx5G1CCbpODc4cRGWNpyxqthUZtzEbbGT/
 r5lqX9uaO2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKwp0gAKCRABygi3psUI
 JD3zEAC08M/q+crYeSCt61tg18W8wh96uLThiPK1oIN8cT6sza82FbzzE5tZz/JAkuOxmeDT1Jr
 /TniRuMWHcR1ABZzQxNSzoTEO4kDKwoVl01F7A9eG3xSG1hMcoBpFOefCD5ZJwKsBJPSkJazMy3
 Uq0MfkxY4vsMHJVTCxXczUZySYl1MGa81GLOqKcR6LsfzsGWbolmfH4Bvlrv63vGBd6i2uKMNSy
 fdK46uREg0LZfa4l+E2LsjiNk1Lvk/Ovb1qje+vjYfqB16/DJDGiUk1IJC1q1J8iLBJouyfYiyI
 upg9pcjsYb3xsOMcPmXcyI7W33LjCjhHYkXcBBaugqQ+7HoAL0CjS4Cuw879KYuOvHDYAnOofXX
 zgHTKr4XwyWQVB2Hd/pHthOiIc0D7OkpdL3314KaflUBRiL4obg5fFz0/bSdKCIiaUM6pLMrvi6
 QI4FyM/whrJYY1u8pstsdOD4XjPronxD/nneGpr2t/2PPPe9M+Mysse3MPo8XTSvv2x+fujb0Pt
 XXqVoAUsgTBLN+3i8QipITSrYbBSLnf71cWLXHNaq7ybKg8dwvWq/861T9M74mlfROH3n1XyuuW
 0+ijxGn5++G6PNnwvO6tlJDjihhJtLhSTijTfaQiQ4gNYR6XRlruP1e+rSTQUO+CCN9dSvktcMM
 QAlh8/SxgKhfv6Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_021626_637276_8D86EF82 
X-CRM114-Status: GOOD (  10.93  )
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

Add nodes for NVMe and associated mailbox and sart for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..84acf2839fb6279dcc956e1f4cee1afa909d2f27 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -402,6 +402,40 @@ pinctrl_smc: pinctrl@236024000 {
 			 */
 			status = "disabled";
 		};
+
+		ans_mbox: mbox@257008000 {
+			compatible = "apple,t8015-asc-mailbox";
+			reg = <0x2 0x57008000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 265 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 266 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 267 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans2>;
+		};
+
+		sart: iommu@259c50000 {
+			compatible = "apple,t8015-sart";
+			reg = <0x2 0x59c50000 0x0 0x10000>;
+			power-domains = <&ps_ans2>;
+		};
+
+		nvme@259cc0000 {
+			compatible = "apple,t8015-nvme-ans2";
+			reg = <0x2 0x59cc0000 0x0 0x40000>,
+				<0x2 0x59d20000 0x0 0x2000>;
+			reg-names = "nvme", "ans";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 270 IRQ_TYPE_LEVEL_HIGH>;
+			mboxes = <&ans_mbox>;
+			apple,sart = <&sart>;
+			power-domains = <&ps_ans2>, <&ps_pcie>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans2>;
+		};
 	};
 
 	timer {

-- 
2.51.0


