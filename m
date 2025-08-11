Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1614AC87FD2
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=; b=Bm6uvs00TET8rPHldvXe1Fm3ZR
	mvYWnqCZtAiFFVTVTE+yfkLoLOFekg5AT8tMdCJ1MS17cKVC/yziO+I7AH5090CrOE0TOr7ruvl7H
	8lugdvfEAGLK3C0oZBODiJFYkZ0k0+cn18xrmIgIiX4r+VWm2XhV/cZiz2pZHZWtDhVNjxg91YWda
	SoqRTmEBUzXuR6TTS/6JkHuZn4eCRuLbbkv8c1v2aiMD5udZNQB9jcE7au+aGEK3IGGyGkMidvubB
	Kvlxtdmc/4aXV3LemCL0a2iF0aeo28jiukTMktL6msQzdHRoMh2N6kRewRMBvHr21rI/cNKkQ5KDs
	Ow0EA1QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTKn-00000007za9-2PIB;
	Mon, 11 Aug 2025 14:17:09 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSwY-00000007t7k-3tBU;
	Mon, 11 Aug 2025 13:52:08 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-24063eac495so33040315ad.0;
        Mon, 11 Aug 2025 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920326; x=1755525126; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=nXHPxpwbU9ARtD1QZcQ0zmNVRXhwbiPyu8tC8O8UtrNsSCk6Cd2JnrTxhUxX+XJAUA
         Nt94zLRnnU/iWlvr86OoGEeKQdBA6zP12eb4jhuer4MZQcSbDNVIuHiuqzv+RNZ1Or9v
         OLhjpFV5pBUVSKuTHRF9r0JbWffOM7eQzdQBaNLdTYJbtGStL8qiBcpsjC35tAp3TWWl
         6l6HcpuvYnqImSi2t9iWYHl2T2wIpCHuLcj9wKqf7s+Wy4b4Bp/shvv0Z4r12tcDT7C1
         7tRY/UnidGFdtGjHoLif+EPIF7BCrtT5fqBKh/G2+lnoAvjNG4s9EWa5ebVzfXthWwYu
         RCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920326; x=1755525126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=osuAYJBJoynrMRKs6iD6cEgOyANRdIjkeQnY4WwI4qb/L1S1PEZByGgK9BeCsGYh8Q
         vZS00d8tna1lWaIbtL8CjXnfoIVH8jguLRZ8S8Qf+8XCoZYuxtRWRMOYecm979WdOzN0
         X79qXx6aApzrSHvhDA9hppg8ulklm8zNLRn5BeYu3GoVims9NhnG0TF/ryo28zMqbj4a
         D2CRSLOyvR88SVb96QYaB0rINLaWEXNDpFwbO8elvyaGX78z9raqf+u5wmCy96hYIgXG
         07G2Czp6IRKEsaggo2g/KNCzr/cN+n9JwLr/7L0MiAR2lY3PC0Rfd2A9uGQKhgs01T+w
         xlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU16VTM2NfSnf+P4GfKmVyuQWBBtc+jTKDL1nUyPkzVvvg6SWQ3LDPFQbIzhoWvbKME8XH3xu+1z3PHLIcHHied@lists.infradead.org, AJvYcCVFdmmuFNx1NHl191cGj3eJ/z50Izo3U3Fvjd96UypJCa7mmg+OKc0/5y4vjoQEsuwpyvkbYlpQjLn9Tg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzyEWaVbcpe5/uva4fihx7rlT6jCTU/73e2TgSDENYszaVV/SMr
	ebYsGfKTdvkeTyo26SzgPbroy28emiNtHt5+sZrnZdw/Nubb7+m6Lqu0
X-Gm-Gg: ASbGncuZ3U/9cPNSz0KR7FnVVqDxHqnOu1dkMSMZwKNmu0NHP+sY6kohz9WWLQtLR2D
	6tUL59zdIq08e9360WgQ824HthOsnQBpkyufiiNNTz9g9l0JywvOlSDKkocf+W9DYSSaFYTeFbv
	OQEU7aPiaDutpqFaSLPFfVdryPVDNY2TUhGBj2/Ou37w1cI6i8lY+7vkZCqJuGKwGahdR3gk6m7
	vy+qA+BxzR4g/pbH56nb+7b6Yd6m3dl5RcSyYOhNQ98VQ2qyILxxrxbW+OnncFCqK3anFCkmYc1
	27J1C72ZZIdWk0MIA4gfUoO6WaEjAaBbVHpy4SGBumetvT2DtJpUvmPxtJYt39+SBeYW6jqHBAW
	EKUjAm14PzCHuT5FIwFEbXcamWzxr6u+4HuFP90VxcOsrTW8=
X-Google-Smtp-Source: AGHT+IFgm4RzzzE6J5r3iBNe2NZOigsbOyh949b8qoEAVuFdNMyuLJZ2th5tpGzARJNLzEYMcYkYag==
X-Received: by 2002:a17:903:4407:b0:240:1f19:d35c with SMTP id d9443c01a7336-242c2209b65mr207786575ad.39.1754920326147;
        Mon, 11 Aug 2025 06:52:06 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:52:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:51:00 +0800
Subject: [PATCH 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-8-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVRpulWh4MRp5/M2zxFrKVaLRt4h6MaA0rMR
 +QTSNA7W/uJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JIJaD/4ole1VdYaF3B3syLR82Nf1oZ+zvyPX4nskCUA+dlYnOPXR/DgGgwNxxRkSfTJkWvTjxEf
 b/sUDSZQzdnbdO60VfzpXw4yaBcWWMvjnMcisU/kBxYW90no9davink9VsL/5jjY+X9DegWBdsx
 I3DTjjBi7hIUc90SZF/sd6SULA87lmyM0rrfNORPgcTKNBalPldknE+rIs0Iv5fBdNId9vdsmAX
 4UDOjEE/PMVO4cOYCth+kP1Iz0I50BftFGakkSEObwVzMkbXnt9NcaQYmnLmmqwhXtTHuJ7NY3n
 Fwlu9wDTRKWV8rsMB6gwlDC9ZnuMi0Ndlnc/1zHfkDi1YqAUa3vK3qZd8qsvPAHe+iUzjpq0gGD
 5jVIga74uOTkS2de52aBK1M8Cpn3Ln3xyWrRhyPEdtUzjx0DlmRnXcGjUt0V+ObyGINdSbs6BEc
 Ab6qBtZpNDDYaqUqxnC5V/o7qCHfK7RlXPVVw/NPISdXxDbkhvrOIqmXJW2FuN7mFgb0iRpPXuA
 6VMBCnxr5sWvKMPlEV8vyGAIZE7JuznOvv4DbzUwedcsKItgSQ5KT6mujiB8nloLKwI4hWJ8/f6
 0MTe4J1fFcTItTHtf341IPux0FyNTG62adT4oNHIWATLDI/I5In4VM9rm4UHUmADSeqjBqTeLrA
 yu74lDeSmi/0JkA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065206_975282_0ED1305A 
X-CRM114-Status: GOOD (  10.57  )
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


