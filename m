Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEC4CA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 23:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=; b=FTfRXhCrDobtuZ5Y+RzN4wO4nZ
	3MIu3ZOuaQUFSuQuCYA6VEccHyRH7W7Uja4YgV2Qd68G8hVGI219JRRDyLamZe920dWXysXOL4s7f
	lyMPInzkz7V2Gxf6eqKQ9NBCes5F5//s6Noyb3dOfhBIb9a6kKf7cQox58X3n4KaPg00vEYodrWPF
	u2GBkks4SpKqPjkBgGBIFzKqXLBNVK7AToFMqxUEffb9R9dfWrwzBxnMLYar+pvOzGqUz0ky8JWRL
	ez45ZHm8o6pjJwMtZ5LwEka3wBWAKIguEDIpZP+HjgS3HW5q5bBC5vjwu7cUG6fMhjGmBFTLha+Oz
	PoZavBzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upF1m-00000000xl8-2c5U;
	Thu, 21 Aug 2025 23:49:06 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7g5-0000000HU6s-27Za;
	Thu, 21 Aug 2025 15:58:15 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1147707b3a.1;
        Thu, 21 Aug 2025 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791893; x=1756396693; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=ldYIhezIPMBQ7sitPmWZzGsz5GoBxdkXBWB3lEOHbgH6wKMt1YaT3tH2lNipt/XFFA
         lM5v6iTtwUIsV5Ee5CYeGCcY9/Mgi+OaW1clTN3SMvvoKmOsXUJrKVSEaf7yHupDc52P
         yNTKecfih3mHmlI2VMHIySfnSzbe+Ul9slB42Ehg01OcXJx9+Y9tPa/Fx99A8f5RdYMs
         HG/9gKP0ONJwA3zE8mJ/2cNHHM4W4y8miPdXJVHy/7SrI26oHZ/QUdto6lRbWIDNL0TQ
         P5cbOMrZvQ0nujSUqTPxLVUKlcSXwJo/L1/XyL1ayZrY0CSLQHCO+nk8AeYBy7ME+7Lp
         UoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791893; x=1756396693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=WTARDyZyAHL7w3A90ZS6UzkRrKb+Y1ONLoJf2x3yhxgNzzkkCY8WdE50DTIBwWDegn
         0eeALf3SagZkdlEJotl4Z7VOralcXal06HUEqVsnnejgpYE+INLjPUg3vZoWZfnf1Fcs
         +rBFhesL4wF2vet+YBOrj5yMGfjJQfxxNhDrXv6wbg8JbW1zPkzKPuKR5fJ3ZsMhBobn
         WXhPl5uXWa8VSqG5iR1PHBK18o/HETkvx2PWCd7SPlPynMwGH7m2jCgxjS6nRsIHGtWM
         O7t/MmSs9ocWxB6NehepPrdDwm55v6BDUKU7AII/mEx/ASkzV1hwLls/RT4vFW0upLJO
         6tyA==
X-Forwarded-Encrypted: i=1; AJvYcCUU6WrSdDO0DlH+/d+WEs/oXz+3F2C/lBtHA56Qksn3NgzgkPWWsZS5sDSR0Hlsa64722Zw75RRtsU2krv5XzJ9@lists.infradead.org, AJvYcCXqox06hyqY3QyQY6lhie9T1e03JAjbukpJTl9QseFIDxEQMOTbiRY6tL8lFch/84LUr1Gm4RHHulaMuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyVVM9pqWXWvM5X8YCwHK2IuPMJ+ZjkvslBMxJNz0/ZbDmmCwaV
	wJ0bcW5yL8ypN1/Q7n9w5/1q8IRMynL+FYYwiZIXUEj1QX8XIFQTNgJM
X-Gm-Gg: ASbGncsxLdbZ1pnjFsTapBhKOpuma9faCivag2FwwI7gGB63CTk/AOeaFKkaKh06qQF
	a0ciuirNkJr93KOK2UnlwEAuONoFLH/sxRNC+IMIoJLq82xHBs6nDepLa0KAS6TBXD6qhYzbNSu
	dJIDih6Os1Kpw2hYNm2IxMehAdgyieYd3AjQmfWth4e6SJucxmN+I5EnTVe/e51UXpHVxvat4Ek
	BycWohQ/N/88/xzjvV1waGvW/j4yFq5nu6I6ltvWKQFQ6+ypePMeIEGidSoDoxlTZ12085Z6/up
	uMaMy5mYzjLufxOTDeOpRxeNKzgntFhBJtDur60PIIALoyD5NjWzEq/di3bmbM2BNhUFy7u4v+L
	JXy/uN+C3EVbbKK5Rhe7qa+FWU1t5LNzazAby8RQFROnWXnU=
X-Google-Smtp-Source: AGHT+IE1q9OtVvcB7jD7CQCK6LT73Fkhhe6O1oTYoqIaF9COWn7bTSzZtptOlx0VklEzRU+W2Yg10g==
X-Received: by 2002:a05:6a20:7d8b:b0:240:387:cee with SMTP id adf61e73a8af0-243304a2ddfmr4276481637.0.1755791892695;
        Thu, 21 Aug 2025 08:58:12 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:58:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:46 +0800
Subject: [PATCH v3 9/9] arm64: dts: apple: t8015: Add NVMe nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-9-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVNEQSbAL3+tZjzyN2WWJPuPis7prsUJE4e
 r+/j8uvOM2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JHtuEACKC0KzhrgUSgUD0OWXRKnND+KJS6S49TEY4jfE8wS0+7bDXXPBH2LHqwFwyEyUHh/y45R
 QBMjGqJsVuFtjLjuAqJea9McDOJOf4anhYQck9UPhKFl5+COnr9pw9/Hw9HrvMN+hjML603tkJW
 MW3sW4RscbE5AOdDH1+W3o7Ib11FaiVAnEbu+XX0IsRfOgEVCg4QdPWM/UCcaBk3FZGMS3abXGn
 r6lqK/zwO72cRcZg27mdKqnitSyjbmqBF8ojB9aGNnET/9OeyaH3tn7JSIASY1wlarATt+z3GyB
 zkuVbwthmU8wJHm3xeq2bzEdpAdRxY4qn/OY08yzrXaJKnJi+Ex0yiqW5eHXXyxWQylH62oUP//
 3YBFV4eFtDyGy7ApLSESHfrQ5ch3m/1J21oOOR5+LB2yzcOUajZkbCK1AzgzPHb7cz6cZI8LQeJ
 5QKjLbi7r2JRXTjlszmvxMpi/0Eq3ap3uCeV+rs3FQn/N0N4Bau3X+joy+3xKmTHGCR3GEhqGgx
 8rRN5rSrgf/UTKqsiUq0C4XPwE5nCOvg6WczE8UW5ORdm7z3B3ls0HvvzZRJsnDL2mhYYlRQJ7z
 l+TYMXGGRm7oI5MJfKau2yTunT+RcXdSK6+6kA2NjHOcNyRxOs5UeT9TLiXcEDyZYFFJQ8fPDDG
 iFMSRxoy6aoLIKw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085813_547353_687B556B 
X-CRM114-Status: GOOD (  11.51  )
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
2.50.1


