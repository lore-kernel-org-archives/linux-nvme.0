Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD621CA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=; b=xFbSKFNeNRtYtXEWLsW3ErYTO9
	ZvM1OOjC88YHLV1BK+6JH9uBKHQE6UBJdA6cMe/1v0yY6uC5i1nnBKyhrWJmfw/rZ+CQZjGMrKh7Q
	2KtxcwPOEraqj81kAbUSUQIeGeZChYrPSkt+E/L7f/tYDwiKwF9fkNs5psz5Za4Kh2CJRIOCSXlhr
	DdElOQppLhphxKspN22FWSvqJ3nqlp4qau6jcYpsgRUfZf0+Osu9ucoCpiyu516w0z9G7jUQLJZbf
	+Vc4T29/rIxIofJ/lJ5eCykl+ClU6KdOAa1yPm6nGDqWZFHaDBTGwksFc5jcgpFL55wZ7303A5Ygj
	VnT5RXTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo044-00000007VZ3-35jE;
	Mon, 18 Aug 2025 13:38:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvTD-00000006xqM-1rkA;
	Mon, 18 Aug 2025 08:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=; b=Rddtds3tQ2lg/mT7ATMsQd8NXs
	QG0tMTJzx7YwDQ98WdB0aJXZPgka6GTmkLh30Ebp7BPXo0H6riMb2SbU925HrntVzhabPaRruCIYe
	TDBVeSAQKS3blz0aa7D6rOWmLLvwHyQ6uR/zF0sdnU/W/OzpPLGhQB/UlP9z96j9+METH3BCOnAEK
	iYVA8IStFg/l+i9OSzM9J5PtuW3Ofiycr9OBIJxUTaCuB8F+lDBvGKBb7QqCRj1Un3fickcfLiA87
	qJvD+l3WAkFRe9jI/sD/tlcx3vFdhmBbM6uSBZqtROFlM3iDhv9viklMpehIqIiutEVbHNqkEWBcz
	M/KcslGg==;
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvTA-0000000HKkT-1xaN;
	Mon, 18 Aug 2025 08:43:58 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2445818eb6eso28803815ad.2;
        Mon, 18 Aug 2025 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506634; x=1756111434; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=atfYa85PnpBjx7j3OKEgDFwOJVoDGpix/WcWkXpkT83kZHasPLoA6gDwn24t5fHAcX
         GaLo9AWmOhE9xO70ebXZr5FUuUpSA/9WVnftCmXa0DC6mtU4kwtbbnZdToVkb/ZoJ0ob
         Zw165+ocvO/fEb1py0tOq+Wcuoy/USG+bmQlO6zz8FMfKiAff0IVNrWP4Ssv4AA6Wp6f
         msNLNQCFPF0BUj5gyjRLQTupYa7XvBhxOPPpqDHy87rF/nDqn7hs0M9ECCiimJNf6yg9
         +DbBIi2ld3VoneBrH77oFLAOBDQX3nKc4b9ranKLRDIoW41hLn69mgxwffRUvBs1CAci
         qShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506634; x=1756111434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=ul+Wmta4tQ5vKdan7sF5fxnoPTtzPGmdm7YVkWdYHlbJ3Tt5hkDLXJ1Zpum91zMGfH
         mQ1QgOj88Qy6L8K2Oc5/K9gtoVO1L3JpEdnibgJCQZiumeQsGXfJzgZvK2+fEBPF35we
         BPJCEQQtwAdLjC7v1mCo2yuzEJa56Tjn/V7HEHTCgaoPGe79P11ruDTp400RidGyNdUn
         SDUlRvUwDIxIYOEiKgUQ47ljsU5tQZbJu25EDuB14rxJLD7EHHiaMmjHXwKRJqVNItTP
         jLOq7jd5B82QrM6qe3QWsJhBLOgc20SEQN18gdB3Siy96Q6MDv17FtENfTr8sZcLkxDb
         WZDw==
X-Forwarded-Encrypted: i=1; AJvYcCVVgZiFZE62WY+HuTxGf1jTz6QripIluGzemdzVL/cqFWmwtFYuYhQQxzmyKiXgJcHHpETS6NfVifydyQ==@lists.infradead.org, AJvYcCVxS1wOcKiD4ZtAUDg/ipg68tOXT+MBWv/+byGZKBPNuB/pbl2MgLyrlJzrjNOzahCHJS02eQevDUEEc5luXVcY@lists.infradead.org
X-Gm-Message-State: AOJu0YzXEvvPo/ogQGbfC7FQHhtjTOlHm3lJ4E05zIRG51N2D8Vq+sjW
	RLrAZCVWg/amaRqQf9uYwpXPIusJgWA0cy1shvtGfyNJC47MKPJzB8VVvVhd0w==
X-Gm-Gg: ASbGnct8l5C8lu0h6qkzwNRs7LdO46uVPa4lUOz8aaqmBv/Ro+CKLeZqsgd2CC1+ejy
	GQLF9uem9zesd6FkujXiWGPp1/xxDfbSynCTWC+rfGSryptpfd8WN1y7/i3FHwRnsbf73Y/pePb
	SW1sJIDupXb5eYOI+QwJLtTyEz3wbbxoR5iqW1xqx/tqz+gXu0Bvd5Xs0ofgF9mx3S4TW6M9BhS
	0jE+ug3ZLO4mdN7/7OGuuKupMNnfzRLGQ5TRiZgj6jvuGt1VoOtGCu1Pyttw/9vtQX+xdry8BVS
	aGKdsf22AkVoB1H5UG1wQucM2dKyGxElpRZkL/KnBdXVTqU7wJSWD6DwKZf2JgG2sjcJWDMo0Tg
	nkgp+9QqqDOZRh1Dh7H5BfSC7M9r+KozCzsgncyVQ+lFX8u4=
X-Google-Smtp-Source: AGHT+IHZT2isaZc8TNK+Ul72AEXTJHFHaWWnaLR1o3EAxYeINyGXfuxT+CWND5sj2IAPUNrSMUB1ww==
X-Received: by 2002:a17:903:1ae6:b0:240:25f3:211b with SMTP id d9443c01a7336-2446d980b96mr146776455ad.51.1755506634073;
        Mon, 18 Aug 2025 01:43:54 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:53 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:58 +0800
Subject: [PATCH v2 5/9] soc: apple: sart: Add SARTv0 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-5-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouel7tB5pMk9ZRPwFi3VYfo+wHw0Ob6V61kt0
 cM9qXkKNL2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JAzLEAC3GE6E0JJaoSCxIkhKLQwRO5CQqJZORLUx2kZckZ15RN2ygxITFBkfPiprq86LvbbkbkE
 I0p7uritaNmuEOWjwLU0GLKgNMgDrdHOVr46dPQmjLA+eYyZdLDBWVcgPh19bhvkI3vNYiiiLNY
 T1aA0yScyUMImiJYFXJ7JetUa+L33QKyMVYEo3ahLtQgDpgM+N5xBWz5Qb7xczGySFHR3oymxd7
 CE++jb6XpkCJ65D3KUIx5UihSCcya0EdlU0a/wJJhXgBe3Z44PUuhxHibvVQNBk2BWZ0dCJG8Sk
 Lc6fUQA+mg8RiZlTyPaW0lfhWkkQm7gU4nIjhC+b8r1ZQ8/82kIxy5Q+zxw453asfjDntuEdml0
 Rx0YGtaqd6XTWiDi5jiZAEi6uJba+cmA39hS7G8LhGiTpsvI3ajeqaRAIaLXZXnJipyEIz1Bg67
 LhzLbIaK2SbgcfrU+I4LrZULDInsrjjSC0PLZ/sQ9ipvWIXLCzotPFR5IuzUaesLEueit8tmRjf
 SJhZOLzPmKai2LhRugKpEpD2OVRhzYZtHmFiZWoVmpIf/kLbXyT7sFaVgVfdMmkyOzbVgCs3gb3
 KuymzpXLz20+s/gEvuuKa9OXRnMfKHrDhUVNtdeZ93M/BJOGQ9QacRoQp0kNnlrtVcnLeIffl+E
 gNvlqFtZeOmGY8A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_094356_682053_381F327B 
X-CRM114-Status: GOOD (  14.12  )
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

Reviewed-by: Sven Peter <sven@kernel.org>
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


