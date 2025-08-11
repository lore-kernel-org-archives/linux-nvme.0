Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39473C87FDB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lEfy1d6REVklGGsJ2sHwNoDWcI0j2BApVTLhGkHwAVE=; b=Cchz7LDLTrdlFmOvoT4DPn8VvU
	p+6QnXsT2UluGfsk901wYtee9aNFDTUnUvf0ILED8sheJfwO2uGNqHs/agJUdX6WMhVuK2n/SWFwe
	ua3Og0OrF8z/fEMbprlfkZ+VwO415W1tljsoiYBzJAIR8azrlgvuuRcCauxp5v87ewiJxJStaCbIz
	SEamw1sRMgdJgJ/z2CB0O/4X9f2CSc4Sp9TXVS0KjYwjPY4zo4BAHUyjWmPZMq1EW+n85Q6sZeo+o
	BkVyonFawYnkdYlJB6dQ+x27uvMJhWkEeOIwbt77mrKy2uc/8nmobTqYR4tL4bJPSEZgV4tu+YD4k
	uXyoGa6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTCx-00000007xVX-2khb;
	Mon, 11 Aug 2025 14:09:03 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSwH-00000007t22-20a8;
	Mon, 11 Aug 2025 13:51:50 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so5123280a91.3;
        Mon, 11 Aug 2025 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920309; x=1755525109; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEfy1d6REVklGGsJ2sHwNoDWcI0j2BApVTLhGkHwAVE=;
        b=eCxvOEcBqHGQ3C/gO8eHvOmih40OcOARMV1rt8Ii7zFnvcVJcSRQYy823bbwBolfAj
         m/du+CO3iksfVPkbOc1WFGTRMKeQ9W4xT/o3czcJC0pLBLA1TKMdpTcU6L59xJ255hb7
         qDd6hxFZho9yOKqoDfn875WR16V6MXWzyfYxyx04zrMiVAGWs03ZERfauZEYdDZqS7/0
         MhO5P73uI6OiljUU7amlSV20nqYyw0ae+TsWlKLCWXPBmgTP1pNLLgRUjTKTgHz4BDny
         EhlRjysfzVmTZ+ewBvFT+AauM8b0Knx7BwlCZwyxrYx42+uTV0otOxMPvRZTpuloSUdh
         cppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920309; x=1755525109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEfy1d6REVklGGsJ2sHwNoDWcI0j2BApVTLhGkHwAVE=;
        b=PrZK+lbrbNPmXPC/pGng6YlR1M5n3F2f1TXWIx1AiF6BlVWhda77d279PL7jH2CAB0
         3dxPFo0NwT6fG+V2bzx5O0qnDv836G5w6Qyzq6PfwfccQYy6Y3wA+E26IC066BtTBdJm
         epp+8qKsZRPyuETjLVr+sStiaCrP78wvToJrYa9LtbOfFUH8PStCSs0SbdATQcB5JcYJ
         /kf1nr2rCh6drX/CIJ3R8jNKlUxcGAZlEGNSW+2OzqeNjefh6RauabD6ikctZR7R5+wf
         k07syiSwOpgxWjqJa0Hs9ozMZVfgfPyjCvATNhMzRg4zaFP89jLHsQpY3n5SHYDTD0V9
         RJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKLLl4WDXaq4oQg20c1pv/REYpnhihMKQAX6fo8q0Vxo2FeVUkDs6Rz0JpYw3oYheUsUWjWZKGwJ8Qq3ACWzpq@lists.infradead.org, AJvYcCWbsomjCsOf8ngDdWCTaENNNoGJoV5QwLAnUfz5JN2sKLvXsKnALAm0mXM+GKKHqDsMq42npIHVJktW4w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxuknHys1RiJBQODd/tTgKc9z4oTiF2Jgf1RjlZiQUGuSadsyAQ
	7EyUTbxn/gQ53jsqTrsaKJ4rVuFj83ti2zrD5LQ8+Ug0eyhrSvdr9FNk
X-Gm-Gg: ASbGncs1OO6edLnApWZG4x5Xkz1afzde3ITLzWJiEyzpXyMg9FM9JYg2Qq23skA4nYe
	+hZ81OpeQISNvAWW3ANVKbcWspCvfYgTbHQAvXLA7iEKu0UVhScOR4d50n0fsC06gVrcwm9o6WF
	iHKUqNJyMXFaWv7APpWxW5DzARNnqf1d91pFT1YOyZI32sJY8VmU6o1JO2DBkJYFycdD4FNrp29
	JqchCQBFVcGuFTM6BRxrk9QcO65lthy3TbEwVv1g0OdWpkLQAwmDRnJZpAHiS3+JOg6PudWCPZr
	4q2/51IHxj+vwtwaO3CK5JeerBVTiEruOxSsslKD2AAUj5KA8m88g9+vrvNBdUBSIVXGeJjaBjZ
	i7l+2Dp8Qk4Yn3kSTo0LAfN9x/Cs0PE6aDkBouU+DvBZd+FKjw2SKql7dCw==
X-Google-Smtp-Source: AGHT+IH1udNShnfKQ/kNxUt52VN2M3uRw5amTvYb5XrrZ+KNWAr5SidXvoeniU5jkLgzVeqPaTf4kQ==
X-Received: by 2002:a17:90b:4ac1:b0:31e:b77c:1f09 with SMTP id 98e67ed59e1d1-32183b3f438mr18169391a91.19.1754920308652;
        Mon, 11 Aug 2025 06:51:48 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:48 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:57 +0800
Subject: [PATCH 5/9] soc: apple: sart: Add SARTv0 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-5-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2748; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=HASc/UE1e+zwLEpdDftsFG871JkJOER0qIdXrNOZ2Wc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVR3nGx5ONiMyduDBTlKlsmAlWnDpuM62Yq3
 1N3xXx229qJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JFIYEACa2AXuWbCL6bohXb58bhGalXB85bannxcDnOvFbk/9hPyEAcJYLE3oWmi6q8/BnaarPzy
 vtJo5ryAavk/GuSa2O39JQf4IOiemJXMGfUmZed9Jik0ezLUStqfF8pRmqBa26SG9Lo5m9blora
 r39zadSvSE10FzjxQPvib1FzmseVjU1LaPLlMuiPjSWyNwOJJoqJGw6m/rNgK/DPBXOFSDktWLN
 CEztWyoefNWA48CV0Chcl78Gdmc9oeGOW4MPfG0od56w1IBkCctlMG7EqvHwncVwBWaDxjI/Nw8
 hB6LEODLbV0xm4E3giTEFuPIDMIH9pLLyawH9Bw0CE8BUCdTIh4lg12cTgad4eDPlJC/OxdZYf5
 heIITrHpz896bc1SLDk8xBH6bZYruB/QDZ0cIsmV970NLUJM1HoslVdaxtm9WhpQ3/myGaymd5V
 d4KDoBiYzGj7r6bGsfFRlU+dZ8kxa2n4L7TBHldf0R1Z2e0qTA09rejZaXjg0NUxceqm5kkueT+
 rrJBk64uLytlRjdkZo8iRV/Ghkkx/rz6wxE2Qr2ovmE3LeUgVs6A+kLcYe0hpc2onC5/UXELzJk
 s7JrSKhzY/icHhpfMwf9x/Mv7wuNL9wNlFayZULYU5GXzbI8RYn3L2ZLAQt1RntQbskORxNxjP9
 XIrzGyz4qHp3GHg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065149_524217_6C8DADB2 
X-CRM114-Status: GOOD (  14.19  )
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

Add support for SARTv0 as found on Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/sart.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index 318f6e518a54f6edb8b97e320519df8f77c7f143..4ff1942b82a74cabeda99540ba63c6e92386986d 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -25,6 +25,18 @@
 
 #define APPLE_SART_MAX_ENTRIES 16
 
+/* SARTv0 registers */
+#define APPLE_SART0_CONFIG(idx)       (0x00 + 4 * (idx))
+#define APPLE_SART0_CONFIG_FLAGS      GENMASK(28, 24)
+#define APPLE_SART0_CONFIG_SIZE       GENMASK(18, 0)
+#define APPLE_SART0_CONFIG_SIZE_SHIFT 12
+#define APPLE_SART0_CONFIG_SIZE_MAX   GENMASK(18, 0)
+
+#define APPLE_SART0_PADDR(idx)  (0x40 + 4 * (idx))
+#define APPLE_SART0_PADDR_SHIFT 12
+
+#define APPLE_SART0_FLAGS_ALLOW 0xf
+
 /* SARTv2 registers */
 #define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
 #define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
@@ -71,6 +83,39 @@ struct apple_sart {
 	unsigned long used_entries;
 };
 
+static void sart0_get_entry(struct apple_sart *sart, int index, u8 *flags,
+	phys_addr_t *paddr, size_t *size)
+{
+	u32 cfg = readl(sart->regs + APPLE_SART0_CONFIG(index));
+	phys_addr_t paddr_ = readl(sart->regs + APPLE_SART0_PADDR(index));
+	size_t size_ = FIELD_GET(APPLE_SART0_CONFIG_SIZE, cfg);
+
+	*flags = FIELD_GET(APPLE_SART0_CONFIG_FLAGS, cfg);
+	*size = size_ << APPLE_SART0_CONFIG_SIZE_SHIFT;
+	*paddr = paddr_ << APPLE_SART0_PADDR_SHIFT;
+}
+
+static void sart0_set_entry(struct apple_sart *sart, int index, u8 flags,
+	phys_addr_t paddr_shifted, size_t size_shifted)
+{
+	u32 cfg;
+
+	cfg = FIELD_PREP(APPLE_SART0_CONFIG_FLAGS, flags);
+	cfg |= FIELD_PREP(APPLE_SART0_CONFIG_SIZE, size_shifted);
+
+	writel(paddr_shifted, sart->regs + APPLE_SART0_PADDR(index));
+	writel(cfg, sart->regs + APPLE_SART0_CONFIG(index));
+}
+
+static struct apple_sart_ops sart_ops_v0 = {
+	.get_entry = sart0_get_entry,
+	.set_entry = sart0_set_entry,
+	.flags_allow = APPLE_SART0_FLAGS_ALLOW,
+	.size_shift = APPLE_SART0_CONFIG_SIZE_SHIFT,
+	.paddr_shift = APPLE_SART0_PADDR_SHIFT,
+	.size_max = APPLE_SART0_CONFIG_SIZE_MAX,
+};
+
 static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
 			    phys_addr_t *paddr, size_t *size)
 {
@@ -319,6 +364,10 @@ static const struct of_device_id apple_sart_of_match[] = {
 		.compatible = "apple,t8103-sart",
 		.data = &sart_ops_v2,
 	},
+	{
+		.compatible = "apple,t8015-sart",
+		.data = &sart_ops_v0,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, apple_sart_of_match);

-- 
2.50.1


