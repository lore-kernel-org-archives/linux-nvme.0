Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74341CA0EFA
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLgKkUt/EORHceeO89abTN08otZovq/goeI6WeVPzj4=; b=XIhBUWS3XiatjbiCDDga7lzm5X
	WZkxyhKlE9vRBtG5LAvNurxb0FQT7ItzTm3nqSBxSb+qGbxE4i3Y/7B51OECHvIMjWZLi3YwlutWy
	gM2z5sxV5WKtp41WqVMdpyZgC6ByF2B4GmUqDmhEOguwpulZWlm+nOd+fGcSk65kI7hEn5aGg3mfb
	PXBRjIF7RGXhWf5YgQEBZNV9VpShmWbOiDZ1Q/iXwu/6I9aGEehFoFNLjabvaNIlOGKI5vfhArNIn
	PPCr/6k8TdpCYiv8vCM7VJPUuG7CRRNFUbrcyuY07QBXPtIglWpHvL9Tk1DlfhUIADhZx5f0JoV8o
	chEsdGRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqspX-0000000Bwzi-42Fm;
	Tue, 26 Aug 2025 12:31:15 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsV2-0000000Bu8j-35jg;
	Tue, 26 Aug 2025 12:10:05 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so4293899a91.2;
        Tue, 26 Aug 2025 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210204; x=1756815004; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLgKkUt/EORHceeO89abTN08otZovq/goeI6WeVPzj4=;
        b=GEhcVT63l03G44bVZZhX4+d5gmbUxQ908+EL+ehrWM1O3ZMXjdIvggWSe2yG/qWmPq
         M+PZ/67tB5tdNaddDpOtjZgYWYw+ZD1Rh3MQ/K6RQJSMBDyr8ONBch1D6pxYoYu9pV/Q
         8N1qBgHEbdmuA3FoUscKYdV/+aZ1NevR7ESCZxjQ34QAHoIAUiLJYs2xyPHCQK0Js446
         +FrIGblK3HA4UMO/2lx4pWJhv8vesvtnqZdudsg4IOt22b2Pp47j6T2piKHS5g3uNwTR
         XVewE/E/KJzd11vtE3at7SicXmAnmVcutIFkQTLNZURrnHM563rJlT0irTp3caJia6p2
         HLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210204; x=1756815004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLgKkUt/EORHceeO89abTN08otZovq/goeI6WeVPzj4=;
        b=OytWJDaP2q+ok6SBvIMv8fAUi4ybQ5EAttIrBJ/3euEADiZn0liqCYXG5ZTrWc/fxu
         DIGgwvv1HghCzO8jvXj0Y2tI6ThEADd02N0V90+8T6g3AjdjT6pTyvzQYChOXDMrgjsd
         50fse+hF/MMJWWCZJR4OlUE4x2NHjSCb92pS2xJgmZSq6gLhePqCEIqcYEXjX8i2dtAk
         rl6ZIfVT3LUQ9uWJrQMgv5V9UpWuBMgClf5j5gk3pW3Xr7157hJdZXOmbKB5+m8iI9Ih
         awcX2kkrDvZ46lF1E9JxTWboDQJ7yEPmKkvLBGauYahxx0USaHf3erGzZIZEpr4q0MQR
         /buA==
X-Forwarded-Encrypted: i=1; AJvYcCWnPb+JLWYxntVXBjc5tFFNnzbVqg9oNX0hl1iSFDcv5QX5WDU4X9osknSkiuHq/hj+xdbaSBZ23Rd4ww==@lists.infradead.org, AJvYcCXvtVlLsaVZOiHT8bavCyNtLJSvKpuTT77WBzkKdETxdoc+mUQACcWiuNhbeFg66gP0Kr3fL9D+8+4Zlowj1uyY@lists.infradead.org
X-Gm-Message-State: AOJu0YwgB4mVeTrtnlxPCNH5F0sCYQzFR6OhKnrUNffkXkIIXBeb1kSo
	l0N7RoNJzojJp4rZq31TUxTltRt1nYka1+IRPJ4Y+40+eA+3vpTMIyIKcjBnwvIt
X-Gm-Gg: ASbGncu/XHksSS3sbVpIXS275HsffYGZom7e8zRGwxUrPQ9L0M5usmdEZyHpxB1g1KQ
	YzuYTPGhyslX+0OgRg/y7DXUt/cMpd5Bsuqm9r6dzNRYIvIVv9NJoZSYsgBl4fKyHYOtB6YRQWd
	4QLk4s++cnBPZmQ4TkNBjrIQPOmTjFlA4VN0NPLGgBo/4ZPpuEsrskd/IfprDaO8L1UDAJZIm/P
	Aj4iLZqaSbBdgH1ICa7Mvd7xOnb8MBc/x0sq0Sc19w9FOAvk8ysR/UU48kka2AumwwaMvPxxWmZ
	EVd1X1fSex2zIGRh27a9/pr51mFxYY5TJnuGsECZu2BT1z93msBpb8WgrImG5kqzeD1V5qvcmtj
	6NqbgTYt3MoSOZz/n/haUKY3w5/w=
X-Google-Smtp-Source: AGHT+IGWgie8ZS02lLq0YJgxOyT9OhF17cJYHT5FMDsYYjsiJPCGQK8BxGNo1tID5Q6Dk0AkG/0Bgw==
X-Received: by 2002:a17:90b:514f:b0:324:e6ea:f959 with SMTP id 98e67ed59e1d1-32515ed12b6mr20451822a91.14.1756210203424;
        Tue, 26 Aug 2025 05:10:03 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327565d3924sm619966a91.13.2025.08.26.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:10:03 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 26 Aug 2025 20:09:15 +0800
Subject: [PATCH v5 4/4] arm64: dts: apple: t8015: Add NVMe nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-t8015-nvme-v5-4-caee6ab00144@gmail.com>
References: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
In-Reply-To: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoraQDdi3xvWrgtoq+xYU0KaEpYAJiSJed9pe6Y
 /L5WzRkEjeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaK2kAwAKCRABygi3psUI
 JB1eD/9FRaF5x0qOcvMaYKSiP6C7NrIQ2IRtHgqkthJk9bKAJo/6jVT9USMx+2fBKj3XVOlHGd4
 B7k3kwLSivIH7/Jxmhmu8nBktrbBnan5KWHiM24HnMrNompcQOIVKpCrJFlCWdma8sysAdG1w/P
 wCI4oZr+FlHtyx4aIF2e/mqOUe2xB5YuKlcAkZJ3s6x7NdzlY7vPTFatiPFGQxnWt5D2oFgextM
 cpPFRw80SmudDzweipUKE3+XyWBq6x9Q5VHE8xz8B1vbvDYh7rdFy6zrW+Tk2Wq2UdnsC+G+B6N
 lAEUDJscdVObCSnCinkxUnqYBb7322jSRX7ew/QrgJRrZkMMgoPeiXqvyVaYRJvVgvJO8avtqKR
 8z9KTqP805PtPTpUXsKmjUOQ+xv1bX5dKlhm9+COAwZQNU2D/5JdPqaf71T722PZNsqD5rsIvW6
 Jj7h2LBjsMq21c4EnpSN4Si+iXHUYKo4pkrS+WzIlE1KH7oeQymatyKCowleF4N2IaD/JoJ3B6u
 tTFEdXikWWk9WGngv5wQTUgYKVPuGE5YoGLRW5ZMzsjpWxwbRMgIn/gbrmzt/i8FtQQf57t7RLy
 PZuGQjW2ja7ri7RIjWULGqlcUBwH0Re7h5kta5xXw7DlnwsF1tLY3DQIx3shq7tmy23tw5oPOZr
 uKVWm1K9alCgZKA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_051004_774241_1D62006D 
X-CRM114-Status: GOOD (  10.95  )
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


