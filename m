Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FB9CA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=; b=W5BoFWhG5tP83Tk/ve4s0Oz5Oc
	jQ3kSP0voiJ7YXBHfOmnnmHxKl/clNLlOmym30QY0MlnpitbByHD2YQGUOOsCgoYelZ5xqMt/sUFh
	r2Dq3KJuQumiBWC8JYD4dR7sv3MkzyvUuiwtBdbZV+4/n8n67i0Yx9CWN2RmEwZhuOwRtnTiXKjei
	zGf3SOfKrruVOoRwoT1yd+UzmSQH8xI5nOFjtTIfsoKC1Jg/RwjaulEs61zw9HkShY8XLEB4ftGDA
	uaGk9NYjHoiYaty6lXwKNyE6nOpYr4k0WxhbChJuIENb1zLRrgibjucyGL+oq6XaMOXqqIVwkjs57
	c/zrWHcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo04U-00000007WDV-1lLs;
	Mon, 18 Aug 2025 13:38:46 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvTX-00000006xuR-0O6Y;
	Mon, 18 Aug 2025 08:44:20 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b47475cf8eeso397681a12.3;
        Mon, 18 Aug 2025 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506658; x=1756111458; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=FMpGVlKKxMd2UZBCyKYVzcG8m361QEx2qgKRSFTB5PyX/5Xj8GoxGCGpsItXG+wsQm
         tGCvSIZ04nJZGMPv6NUaNvr88tQhvLlRYO53A2O4pm3/uVsCuWDJIcpkKTnfiddyo9Ct
         HgaGcIiJgIRwBAWz1Kzy17jaYWBW4l4hgXaLMhTSXv9F54XiPtN0H/w5ndudNGRPidGQ
         /PLZN3hNGudpJd0VZRtgaHi3+PMnv+Csy9HbzvVrUKmOKQaPvqCt3IgHtIZy0UlKWyTt
         fesWbalY+lobZUmWJrY7HJHhtCnWves7Zm0grqNqgXwFIbjlmHZ1fX742pRFYspv/soc
         Um/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506658; x=1756111458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=Vg/IaVpPji0OSLZRC2FlbHNqg5H1IdYV9mv7lwa67FqFyOhGu+/b9mJlLd26N8dpLt
         kMIIWa1JRQWQEdTWO/59yNif460PnXSdu+K7lkk/J6IgUpsbYMYklKNPtqJV5iEVZ3MJ
         LyO9BcbI6CYV1tGrIiMsu/frp7uQopv63tpqwWXU63QyEcI6faNJGuXMO6MkZ9PLeaCs
         zwqTdUFcVDNftAZFFizK9h/i9/wd1hNRoEA2lowali9ny4U/fscDzG1PmMqQ1l+JAidY
         8D1y6/abBoCDeiQj56sFq/MI36kD2n0j3F97awDLcgxsZCDNfAhdK9nkAPlMkvigbh8/
         262g==
X-Forwarded-Encrypted: i=1; AJvYcCUFimuOmX1v1K3V6GIXTwg9eNH50zb5++L+2acnXEeALwHbAsJs8n844wPformL+QBdJAbXbi6EweD+AA==@lists.infradead.org, AJvYcCUfK9yfhWwt00iPs5HjiYvHERqpF70ByQYseBh4oyJYxxzzLlDDm6+1fFnWbY7cYsf60Zu2zVH54DpkayyLFOSw@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2ccYHZ+HpJgJkNu+ZXUFYAEt/P+3nWwXbqBrQimTnSW7HGYos
	exlHvs26QPe8eiaU7nD67pNFUYeuNatsOl8kRfZUQSbFTz14BtNxCBskSzLFoQ==
X-Gm-Gg: ASbGncuYtpsgpmy9X+LNGzPNi2FiS4KuUWgyAS2Zn14QzzunfF8mjeE7AmwUF/eYAEd
	hRJY8GG9ALw6YoqmF3YS3d4xSn+TeIUDrV7OaSSASzxSF6lj8WZngUUKRiiP71CWvMR5DhmH08e
	997tP7MPefsy17ORCL0OU78IImfX3puHvkj98Nnf2iIHW09G/QEbaJhqMMoU+xSdTPC/UQOLACJ
	fSAoDvh8n7vWzRn1JwtZPR3TMiXjprqxkspnMr8OGtM51yPJ//0AyN9fLPtlJxMiP43aM9Rm662
	vXDua1GsBSnu7UjnV3cDKDL4/3mfWLUPntm7jQffGvepVsljXvJ00N5/XB66fD1lpVBKbe6ksTG
	aYwPmPy6UB40BZY4El/19S7iTJnYJnXD9sUWWq/oPsDqEZIc=
X-Google-Smtp-Source: AGHT+IEZ7SgzaIcViACMoklHwNzXuNrvR+dLxWbWKBIt+/2PHm1FePLfHPE2fOsDswTJBK1kq5uTyw==
X-Received: by 2002:a17:902:d2ce:b0:235:eb8d:7fff with SMTP id d9443c01a7336-2446d8b1f83mr145333235ad.28.1755506657783;
        Mon, 18 Aug 2025 01:44:17 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:44:17 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:43:02 +0800
Subject: [PATCH v2 9/9] arm64: dts: apple: t8015: Add NVMe nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-9-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouemdDCDE0LTPBZa3djToJLXtZ0KFQccDpzbs
 4vZ5ZKiW8qJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpgAKCRABygi3psUI
 JCcpD/9Le073yzzucsbRvbZQOWl8EyMIsowsDZurct6uSh3G+LuNqc6CeLAdNkl3NfDZNbBUP5l
 dYqY/G60ao58ZeHJqd5L2pzXiBiW3uIN8TXATozENYrsBjP4+JcMqiGIId5LbEgukc/IpIeYROm
 2D5Xz7ETB0KnIg42np4fpZpljQ/QZOST9qi/n5W32yCkGIwhRLVLBM5T9pI2NfF9nUHlUcW6Uo2
 61haY/NF6qVhXOWYkfZ8AD5I7RM8H6yub1MJIg8p4nfGw75KqhtLOem59PYVel9NhammZesVXKQ
 fdUvePBRwAymKhbqhwA2VCdEfDviP8X0ENV5Mw3SrUujPvKVEE/IYLT4lOUmshWOxJwcBeWU1UM
 6QyogMYmueE65OPCkaSgQxk/U23yje4L++Zi6Yg7HDL18bZKPAXtsK/K6WrHBdsgDjaS6U2rXOa
 K8tRg04xb6dImHo8juZWVa5NgdDYJqE8Nn/yp4kAdyTeY4BuHIIu870gQo/nahWQ55hoDgTrPAI
 0ov+tkD3RHIVZZocP1JfIUVVn3D9vP3vceW2FIVbPacvpMDfqsKq3muKQBWfv/giMMohAMDlAjv
 sQHf+xvgWftQp6HsVC9TK1Lm0SJkWogXCRVUO/QJc7X8mZ2hx8rl/8scVQITbZ/B7Frp40Vxu7d
 yIEr993vDlfzcPg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_014419_135625_947A7A81 
X-CRM114-Status: GOOD (  11.36  )
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


