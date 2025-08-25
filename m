Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A401BCA0EFA
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=; b=16PfCivDslt5+tCxg/XpOkJRkv
	aT+K4+bt0arXa54cX+sLRAa5mec4i3RnJ2SRHquDf5spSDryXoysppWFsMqB52PWlBY7qhhqUxK2n
	w3FrWNSE8bO7gyU3IcWclL7IiVMC1U/2vBnOek2fJvwrd0/IO2Phln/zbyeNR82/qFWWQt5+bY0SU
	8fIsnoJ2jc5+qXHhA4alcxnbF/pcdzz/vPZxn7E9Wo3xdgwnjoLcE9f6qzaDOwqa4lNUgI5tQaozw
	WdYlmwMkrlm0EaYttD5yk0khb9sAxsyVphdgWK0Xib6tG6bpAa8CVfg9Di3vHWcfVO26Kz5Wxixqo
	CGAKpA5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqVNQ-00000007kKX-1Tsh;
	Mon, 25 Aug 2025 11:28:40 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTJN-00000007SrJ-421o;
	Mon, 25 Aug 2025 09:16:23 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-246181827e9so31399475ad.3;
        Mon, 25 Aug 2025 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113381; x=1756718181; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=;
        b=O7t+HuBcGmInn/VWmhFoS4BQaTA88nkOHCk7QjEqsciZzEdmvEL6aQVDdYcB4CwKlz
         DBqq7MGWXwYA7xohvWx8dvvJYgJ/Ys6A79RAQSMn4JiwLI0GmPBBk2pmvdRbW89P/pH1
         dizumF0QilJH5LbFEuOrwNnKCr2nFqP5xlVF6w/nDkuqwzW3MIRfWuf1coPxzqHkq8H8
         b3mNdseLFCW3RdOXs/zfTaPFBNF5uWfNTzhm40S0JKnd3QO2wAc39Nf1CNUPfOBovzXy
         e0BdwVFc/goeTNx53fHC96vdngv1bMpk183Q0GWpPO9bUWvtVzCYqacp2l57ix4T6Zta
         HzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113381; x=1756718181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=;
        b=k0oXl41zVdToWc674TEY9f7dZr8t/RnD7w0x4pkmJwAa7nJwvm2qJV/QUP8PB1QlQi
         z8hbq6r0rOq4lXZPDoHAmmlusmERGb1hNXD/rgI4fk8BXLkkgxcVXqaQ+rUck1PMd9B3
         6reW7unBdxk7xbHQ5sVYqDV6v7Bn19EdxQziOS2v9d9HK+TX3kOQ0YOCfUiURJjG0/t2
         TJJ/Pf7U5lwzJ8iV2UvL9gOr1QFqg2nAlcj+QUG6crxGfgUEDJ5cFKRy7Qo+5lbPf0Gk
         BcmLm263d98VPIEzWqygKD3Gawm6H3Svw0dzq9GcYgy95vvIQrWQR+GG3SQBiK7xVFHT
         Yanw==
X-Forwarded-Encrypted: i=1; AJvYcCVY7IIKQNis0CHp8bTPWLyf4zbmiyRV6jQM7Pb9bQJ5WsDojGfnJ581mubr4GoL4SegzslhEEhykaeYkpPKGqH1@lists.infradead.org, AJvYcCWxr1MU/xBOf/p/AM8BbkyMYMpc62P36HBxOOAdvafsY0rp8MIDYtZWNLa1RjlOuTaduoQocYFU/CAuow==@lists.infradead.org
X-Gm-Message-State: AOJu0YyyjbNnfim5H5sCLP7vT1YMXrvE2Y7vCVOV4lajd9m790ev5a+R
	KhjyVCIRuwtafutGzYp+9FGgewmEaBGHTkRqRpnGu2K5ZAT/gKGHw6n4
X-Gm-Gg: ASbGncuw0S0kMPgMQWr2GM6wDu7/Jv9KPJ7BVvCW+dwDX9m47JndlgGaxVipx4u+WI7
	KDjnuzrYTYTnAI1O/pYUq2eznuAxxy3c80E2wbdVVsDVjk51V9lg2fythJ0RF8Rf1uftlxnu8Oi
	CCuAsmJ/k+/lS5G+sddsFVrsUutXOu96fATB4XVUBij2gHpo/SlWztQXNRf9LSx2aSJf4RgBn1y
	i2DHpt91fPPVdVoh4miVO+36zdD/OltKMJCuLTASWGauHY0yjPh5kby72hzaoqNq9FKaoTb8Ft9
	7OZm5RC0hgTRj9TV2gYjkDaH4dHesfZRYJnV6tMxAJw6X7oAoXlKILxMwIZsSmAAY2zZafaPtat
	v5sg/9x4xX/UP7HqSVLd2abb6/eAILPdEJFfMWA==
X-Google-Smtp-Source: AGHT+IHA47RwYrhQlSdnPL+YYSXKWvogaXdS7+aDOLyvLluP5swy5MJMTU+F1aS+P0WHsZaiEZ4Ang==
X-Received: by 2002:a17:903:2f44:b0:242:fba2:b8e4 with SMTP id d9443c01a7336-2462efaf1demr168678245ad.56.1756113380983;
        Mon, 25 Aug 2025 02:16:20 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm62873875ad.122.2025.08.25.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:20 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 25 Aug 2025 17:15:06 +0800
Subject: [PATCH v4 3/4] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-t8015-nvme-v4-3-6ffc8f891b6e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=CYNjF9OQgn4g6Ftiuun6/MohBcP92VmI1C5IHAHtgWs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBorCnSe7tdWkaBU97yy4wbnzIj/pY02k9llba3c
 I7lzujWLziJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKwp0gAKCRABygi3psUI
 JE7dEACzNVpLM+4i8uqFOcvOfkjW3xgay/vR53ye42qMYaEkvaP37KrBfyROeY1ZGEj31z6QKUv
 D4DPls/oRz0S0RP4ck/YVCFrpfljG3aW9Wq1f9DshvLquSf3e9ruU0QCi70tjs+dt538UoGJ0yh
 l7bl7MRAkV7DM23zcqubRmTY5F1z+yiLjdyaa37estt3dSJlcP/RhBg/K7YPpfH6vtq3ywLImyb
 K4/GkOhv+8aK+wjafHlMLooSlIix6W9m5iEGlO0z6KZT7n7A5LSYoVoX1182hCQMpY+6MV8wfXn
 ZDGRpO+Zqsx85UJjZS/bfCSzRpmAToQ01y0bD0WnPy1YjpChz4G1rPaCePat+OTgGDnmHmOIp+I
 gDyU59GEHTc4RUAQsBKxVE8swI7ILEB5DhxKSCuOORCf6DlQB4hDjxcduOA2W6QayDpDAmk6ZIn
 /bhAKiN7+cGq5Do5Ec74edy+NysyAtcY2eC9xIC4w589hMTbovRXpWOIaDB/F/MXdwsVgyojWnD
 a1dZjlZ5RMCgzDrAgnv227Iji6yzH5C5WQSU4qViyAcRO8z3CCKcZtICfRk/h1PvqniHJUUSVo7
 UOD+So9LIrnSMgsY/wfLY/Yh7fM4rFMlJliKNeIEygoIlMpmPrr/ja5jYXIsCvO6Q6UFS6tMy/V
 xEsbtftF5ap2cOg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_021622_005705_DBED5219 
X-CRM114-Status: GOOD (  10.05  )
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

Fix the dependency topology of PCIE power domain nodes, as required by ANS2
NVME controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
index e238c2d2732f7944dc1f984a4eb647ba212b9ea5..1d8da9c7863e5b7a732888342de9d481f309edd8 100644
--- a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -658,6 +658,7 @@ ps_pcie: power-controller@80318 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "pcie";
+		power-domains = <&ps_pcie_aux>, <&ps_pcie_direct>, <&ps_pcie_ref>;
 	};
 
 	ps_pcie_aux: power-controller@80320 {

-- 
2.51.0


