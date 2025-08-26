Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCC9CA0EFA
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=; b=HhLLCXPtXmn4iDwhStc2kLYA+H
	EbgiPglpwQwpa7hByrihOKp4fwZ2Ln+F1h+qF/tjGHgds9948qKtSkStvv6OkLeX3Q8F10a/Rqg4j
	C+dlc53EUf+RHkaKzjU1eUHjremNKP/JJi5a++5JTPx10bRBnW6TkmCpgFOcH6pW5oV4hJce9tZXh
	Z2g8EStz0wxmXqral76gSIybOm/C6IQtSZF/7lh5yMS0CwKRid72V039eoeEGhkBE39QXP2pyFdkX
	secjY6TNeFpJ44klcmsAhvL1p+rQHOc3Glst6lIodeZ7X6XGHqS3zlVE+SMcnWm6W85m4S0uyEOfb
	a2HEVSLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsmr-0000000BwX4-21Va;
	Tue, 26 Aug 2025 12:28:29 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsUx-0000000Bu6d-2kco;
	Tue, 26 Aug 2025 12:10:00 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b49cf21320aso3357751a12.1;
        Tue, 26 Aug 2025 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210199; x=1756814999; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=;
        b=jsnYGWjVfckHwr2Mo05Wt1cGdi+pCTR3SyjyR0PhEoKRdxNPZVzZmKCrbo0avvwFR+
         mJv//gIXBAt52/6QiwbXcSQP9oD3n2gEgZXwVHtEfzPhtmUWeYY350/BOIKaK2kJ0GQT
         JlnjdAVh2ii1+bC7MYWifHT/eQjvGEbzll5pTVidfVt5Nbpd4RLsjRvje9baUGGeWZgZ
         opOevP086loIx/13P3Y7laZ+dvXQIBeJ78LYf+C4RmapygHvGHTOVn+p1Pw/pLvxBE63
         YAauE8/VFBCF07tqy0UK4jk8/phMpo+sKZIAeMkVsLQo9OkhkPbsNBCvAs3hCf2zsQNq
         N/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210199; x=1756814999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=;
        b=jV40ck4FaPWDEXGHW73W4sGLt6HlHj6M4TDcGPrnNeNuyLliaKP7DnRTKUlqKHeR+r
         Taqg0umKd4i/KqYutTVp3MOSLSVFsLRsPWxHbZU66j+dMyWgs6FUTosHWWd71AjpZ/fr
         cbhWfunJ1FpfSHBv/iNnvejsT+jQboGEmXWo6G4Aih8607cZoK0+PzCgijIaECabYLlO
         ncfdmbDKYx5N23Ftp8G35J5z3ONhfBK9xO1QFOqFUoKhZoye/Xa80NfznsvQRIHdj5qC
         qnUZVEiFAMCoczlVe8PRb/DH8ptujdTHt8HppFYExlSrXNZgfB9WntvTLwkEQaWpxo2O
         ZpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSnMcl521RVtEhLUZy2LVwlVkvoVzqAYIavEr6nBeyfcGS3NwwULHcJYCj7oeq5zx8hJ+av0T0QB8BoA==@lists.infradead.org, AJvYcCXPcHFyThuUSuXlGEphw4jVBmYLN9NDwLlsB9XQALfhz+o7DGDj+Hevf5lQqtI38ixd+zBxnQoW1sDRf8O28HAD@lists.infradead.org
X-Gm-Message-State: AOJu0Yyp55C+gwkW0Dxvl82E8Nv7N1puKZdRfYO+hgJya42AVe1+hek1
	492JjEmN1jztDpuDvQyLd0JEHfCiqwb/H7Ac+K9tqc4K2lcmn/Mz6HJH3gfZk9zV
X-Gm-Gg: ASbGncvNJsvrCRtC4S5VftgBI4852pjzaISVJVgrfY6sLQ215EFTTtBGTU/WnTvRneQ
	j1+wjN87GCvctij3CQ3kk7OjSNF4NoY4AOFb44gy7SpZ0WQMc2V1IC6fadBzLqcd/MO70YLKWg8
	k3zF3ojFnCM89/dc1sQ1fXrJuj5TLv5byDcnuflz/F/ElFVRK/IiiRmDy783MU50rUwVMfRWCvY
	J8cuHbDkCmeiYTheDUJ5TZpPQAJ/CLPf5mjrpPnOkCnRsvHG/DYvSVKjOO8ggKy6jA5R8QgZRR5
	Iyvvp3uP1T8fE+49FLUwztouTGwIdZr1ifypX4njIeykNWNwKzQ0qjC0zaNAO0hiO8vv59uartO
	Y/GuL1n0CYRuyk0qQlooE8jdzvmPeQyzl19Jmbw==
X-Google-Smtp-Source: AGHT+IHtj4KgXbSqTdwrJl0C85JLO/ylMqNOyyNdi7uTUtfGcZME4gs+kyz2KM5t0aJF8T2+RPr03g==
X-Received: by 2002:a17:902:f543:b0:246:7a11:3775 with SMTP id d9443c01a7336-2467a113b1amr133955215ad.48.1756210198844;
        Tue, 26 Aug 2025 05:09:58 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327565d3924sm619966a91.13.2025.08.26.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:09:58 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 26 Aug 2025 20:09:14 +0800
Subject: [PATCH v5 3/4] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-t8015-nvme-v5-3-caee6ab00144@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=CYNjF9OQgn4g6Ftiuun6/MohBcP92VmI1C5IHAHtgWs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoraQDxO7Qv1fzxL96zHeJ8UWQtZ+jverp0LMZr
 KDDOuHgJf6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaK2kAwAKCRABygi3psUI
 JEkwD/0QJJHfCREZw30/LgHOOZhIwxNN9/ncVeXksoFKhfe1XdfT0CTUV/5MqsZPYXRLEi5D90X
 c4b5Tg14SjloONpUPd4fFzx2pi6atWQ2KVETMATFdRbeA9D3hdnkAk5wo7K1NP8cKUHkreo+aH6
 OH/UZFBjr8Fi4ZQ55UHa8Y8nX/PHoXPpZd/0+g98pkIVrMdzcWRYnci9x5aKBF4dfryLJLytW9Z
 pLn2C/VEsZJAxWe4QZZ4KTcGAZAsVkf4ytvpi5S8NG3PNT5GiTemz5rc0oPz/otK6DS2NY6s3C0
 G3rGendudRTzg0AJRAoJmPNXqt5cN6Kt/7S+lGpRJV3avH2gDq2UPyxkHwK1cnrliUmec4WxOyx
 stFLRy1di10g8esevDN97RpmiC3NNSn5yJ1Xc7wsBl73EafjB3fytXW2HgkcypoZ090NlcgNRY/
 8N5bZaPuoLkWJkkfiqViehHAI6Si6k3w21NldiUzoaqegH+3OJS/LlMMPAEd5OUQNxpc06nRGR9
 nvWM2W+V8zZjQ8lyDpsj7V+wU0snKxVysRfkmkEUfhLCP5yEl2NQVKu5OMj+5tsA/cenjWLGst+
 rF59G0fy6vX+I/1vNQDwenNZMiHDFp6vX/1q6G65UQxxovLzQ6zqFmlwSQbPsofCaShSfAZXOsN
 7HK+Nk3zVoCnoPQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_050959_687549_B45E4DA3 
X-CRM114-Status: GOOD (  10.07  )
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


