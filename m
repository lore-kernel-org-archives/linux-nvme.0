Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D854CA0FE1
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 23:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=; b=VqL0nQkCpjgRzPSR6YmmWZLW5j
	sFvBK/sfVrSXkLRT93QBNbl6OJ86kudZ3VLhGoL0wFqr3vjSGnvezoIuphqgziFanEL3HUrNSE4H9
	IZKd55mX2yunS+32orlaqxyB7Lbqw8T5ewlNaS35ymI1q6quRdLQeVJvakcFzdDSr0x6TrPwin4z3
	O+cmIL3QpAsUMrBAf9XbnVvCC/Mc9qkkWI8F6qOt6fcHQnLBcyj+05W80kN0ng4jkyyjjhBL9Ootz
	LX6fdXY1sNjzhCiJVTRuaDNp4jbW00sFBZK1IyfMcJzoB1xMUemuk3dX4BcaGsNXU5Nx8HqA9Ybf5
	vAt0w4tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upF1l-00000000xkG-1knm;
	Thu, 21 Aug 2025 23:49:05 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7fy-0000000HU5z-1cfG;
	Thu, 21 Aug 2025 15:58:07 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1453861b3a.2;
        Thu, 21 Aug 2025 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791886; x=1756396686; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=JP8GQ/n3mmwvhJvoIGm5MF+iQj3em1eugn/BdnHxuexBQe85FfLcSH3LUejijhFpYG
         jArNSE4tXCwoK5cp2lZXoH0D5edm6spbyR1AScTLtLY5Cw9fQDF39H8FDSPGZ/MP99X9
         BdS8bZoNZJYK5Pqsu+ybAd7t5Hw+rmf32sfKO++vdpgdWeB+2pUIm44bLz6X6KK1cDxp
         diiQ8vKpYy3LmsHG1mRSBQSxmThNCSvN1aiont1hOwvA1WgNlxp/nxX/IkJz8YTQ4tgk
         uo3ZYwZG6nac7gkoHueTVOwOJSsqmRCTcxll2qxy+w8LHaGoEdXhMBAScDhoC5uaUVNW
         Yhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791886; x=1756396686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=Rt/otprRcomEKpeID4/WfezGcN3trCpfmgfroCDZreyk+e2sCFqa/iIwYs6LeU0MRR
         +Gljyuik+haO6EzK/Vg5x6Zi3VC9i+TtNSPxJNr6kUHar4L5yltoFXyWNvMbVxs3GuRI
         ERNmMwJqyvvvcSkC3tV1oCCmNyQUghKV3kZWtGZtMsVhcSRyf6F/Qpd6WM0V0bNuAnqM
         2G8rUhDYrZpQoHy9YDurmMQsX5KoiWLBXxPJoUCRBUyCyyaFYpD5cC+ZYH9FxIClZmOb
         22qHdxvqgFHXDd3gC6mdan0AHEobSnGt7FwBnElJjfnRQRdBL9Q0wSlgU8+BPdMUaktK
         rBQw==
X-Forwarded-Encrypted: i=1; AJvYcCVdnGyThGhahV/Skj1WsObYJrVQSYlho49Rr9TiFTKsZbpAxKCEcrdaAcMuoO/IZRTlffSX8weUxSgqjouTWnQl@lists.infradead.org, AJvYcCVx8QexHe2GbKmXdvU5VBlsfPg9i5+ZncAnxNDYFvobPxAX4rTJ0TvPzX7hh8AkiClztiZiEVEn5wEIxQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQuAXQMJKPGXQsODt32eoNJhQWok5U2U0uPRdVEY1reaG4ubxS
	imiLS8YZbYbaOEyu+NdVL8AiAxutiC8jTteIWGQ4tJ50hHkGkDCEaLS0
X-Gm-Gg: ASbGncuHL82z+eBmVLCAEjrLqah2J3hS+y0HmrR67G6d2uzGwRzrBqSu8OnweCEX4sF
	TfjYMUr/rNdYstSA1Cgd2FOTv7E55w5lxKEgdjO3W35fNtiTlMtZCIErL7GcaVdv10JfEZwPIuE
	496hShZUa/57cu19ZVXs2tujijZUm20B1cTeO4Lv0m++jd6R3uHTy50iVO90B16dKjjQVz0+ckD
	V3/VWsNhqhF1zJPdm/cZn1rCfzbfJ218o6RHdZmouY+lcNdhMyo8njjVhyRzALpT22R1Vuhvs3S
	PCPTVgLJGYaoNbYXv//iAFo9rY8tGTGK9X2UGWrBlvfj6eSK8E72easJ3HzQfCg8c2cotgVAYMy
	pGw7oXe1XQoCGXy599ivGKALyz5tvBJ77xeKart405UuRba0=
X-Google-Smtp-Source: AGHT+IEANrnSY6fFShGILep2ycHZBMPux8sJi2tr6F2Rs1Ziij66iom0whiB3Kjde3in4VCY4nqZlw==
X-Received: by 2002:a05:6a21:328b:b0:240:75c:6f40 with SMTP id adf61e73a8af0-243307c954amr4973125637.14.1755791885735;
        Thu, 21 Aug 2025 08:58:05 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:58:04 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:45 +0800
Subject: [PATCH v3 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-8-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVmCaSw/+oi3sVEhtvuJHWUTvf8G4prmp//
 YiXmbkm2zaJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JNK2D/4mz5vu/Rrjfd46ezfd+12en5Stf1fevsnGAnRYJmwNP8Zj6ewOMDKb4Hckbr65gbaranD
 OJvCXduPVY9ZRPucRECvzMASR04HDR4v2cIHjb5up1ho8zS+wLOfRxOYNEaZO5ktb1B9ArBaiGA
 wfgnzBeZdkzBMSo7YkVwl+NzOOxNSQTLT4uHdvz49KXPWLrFN32P72V3ljyxXnQNlCAtmCNn8uD
 xx3eH94bhUFbM3S5opENJyqagxAa1FBemcAN+hRu/dRqQfgK1swLrWe0Oy3OO1HmGpmEKbvXm8I
 MYzrAbr6V0FqLUJvbPh/Xck2EdsfumT+0+PG/p50KfM7pLvKQDRqKMMxAqlXlliR3U/XkzcZPg1
 FsgQKhYDvympCQs1t1eycSHUAZu04LFNHFPuIA3IX4HTBdfV5ch2xLMsm9jXK0LWYej7A3V9V1S
 JWMx/i1eZWu2XGGRM3XkORCctP4PXtasy5MJqaQ4r7oKj+1kemOwGWZJnmY5bHeYyCYE8amrOlk
 hIoe0sRkETeS2C/+MJq2ODhDJHwcj5XuEAz71QwW7r7pbQ6jXoJP85oZscInTKf7cpAzzS+Xcnt
 iwSaZm1PFWWRGr66hmj0ufw4LKq3Mjrh9lPlH8mQOwFjp1T73EEdYaSnw/W2H4MiB7PibcEv6Vm
 k5r4QFW71ZZa3fA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085806_427224_B3B09A90 
X-CRM114-Status: GOOD (  10.63  )
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
2.50.1


