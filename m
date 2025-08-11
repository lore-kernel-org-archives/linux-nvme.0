Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DD6C87FD2
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Z8PyP5sKcVvm50Lc4ho4ozdCtTBci5j1M5U5sqHCfE=; b=ZA6bXWsyvj+sFodmvtxxEqCBDL
	j1Rnkde6jJGn4dQn3QYOtbHmaN8C4NNu7XqTxT04Iy8plZ8Jg6EhjcCmzH8XIfYgQ4EqKPL8ILlGE
	gGNu7rOYuKuEznt8S5YcfoNvWRmL0xZa2N/EO8efRe2GL8IhrkiikTQQPurDIm3aGzsYYsLyzLMys
	x/aEV2PM1uWC6YPaN6Oaa1Sol9C14mD4U3MDMMmFklY6VoFQwYJ7JyX3CrVqFglxmw3/SiXmg1shX
	bBHAt1EVsJLyRlScvHpSRQFPcp6IRiHk1vmcvJHxxRNZ1B2fIlE/neHKhd5+bmav++CsulPeD8igf
	+NyGDX0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTAP-00000007wsB-0ait;
	Mon, 11 Aug 2025 14:06:25 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSwB-00000007t02-2wXq;
	Mon, 11 Aug 2025 13:51:44 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-76b77a97a04so3874818b3a.1;
        Mon, 11 Aug 2025 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920303; x=1755525103; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z8PyP5sKcVvm50Lc4ho4ozdCtTBci5j1M5U5sqHCfE=;
        b=Cw080aT0QjVagmJetbNxuHZWHChQ9KEKOn6vt/ydnvzxM0HsVOuhkKIesPUEd6+odT
         J1YHex3IuZ5RIeMo/JUkIH0yhai79Av4hXg1VGwmlibMIgr43VDSXGpSDVudrX6Q9DDU
         D7g+NsNQUbVcJvaxLTGaVY3/czaAidOeeoKTeU9yVNr3MlYzWwsuzbq78tUS1N1mQw6N
         kcLwjNJBCsKdbCMFuiNTHar3diUsjplUsOSUodYIBhl/WnjXT2jjDs82c3lQZeLzg+ul
         r4zTx2adYRFioCcewtyFXeyb27w/YL0WIqJa2ZDIlsdg6jXbL96ys55dLcOQXu9ZSu+0
         7U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920303; x=1755525103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z8PyP5sKcVvm50Lc4ho4ozdCtTBci5j1M5U5sqHCfE=;
        b=ojOUj/R96pa27O1QM1pVZ/u1bdzuIwENXkxjEXDybGAkcEAOnqEOckAvqWM9SYr/Fe
         +fodu0d2rGpTDBxfwBLi5evKWhlG7Exuo7X4gGX9o3RbmV1aWm5FvJ/AYDRROCFbRXuz
         dMJCyjw5pWvZmfe2528PF96Oj/aFlWfPwRYQd90E/tjJRo58Hqr3iu9UaOXio7J//vKm
         56CZr46qEaahYmTD0RfzkIJJxLZdA21Oh9oxgftpvoSXO2cIw2I8SSYJEsEiA7PEr04Q
         5TpxxqhwlcaaaW8XgwNlPciOn/voBHaXdqJV4VshJYePvhXTFUmIpC9AwaCu7+khcWhR
         M4dg==
X-Forwarded-Encrypted: i=1; AJvYcCUv/dlLb1WMXAntCqtONBDc0HDqEYj7V2pQ+hICyai273pIVRpDAA8j7jtI7g2KC20NKG6IDm/743KepJOT8hFA@lists.infradead.org, AJvYcCWNr3Vqeh8ih3kPa0Zr4Bu/c+fCTGnf9k/xuKJU2fkHen2DbZwP8xf0lVRGs7hlueeolluHjY5b/P89NA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2Hwjw6QuWvwuuOZ7cepWiQa+zOl1/nXNsns/uQPXpU8qNIdbn
	/Y7ek5JZZNoALT8Oew2I00cp5iSYIzGvr7yB9HQP5iyVA3RMBoZLHcQn
X-Gm-Gg: ASbGncv+pOkxL/5CA0e52PgfSbfsWPWQPr/uHKpUUKXQdtSlGguwYTU0APVc/CHL4kC
	uRv2YOH0GqpOI79EBgseh7o5zl+a1THsNiw3zoj8a9quFigsXgpbwrMF+6vCcBU1UTQnWReFjIc
	fDhTakDwAqLreL1dfqxD56fIxBjWRz0uRD7lFBoMLgbFINKYvuVk1QQ2FFqzrIN0NQI1lsTBseI
	LvO6dDz1f2AwHazVGar9/dlEGikh4xmG4Z7dwo67YtkZvyEFPGi7HV4sm70cpi3qCPifu/m0Nvd
	ji7JDHo1Fv6SaM9XMDAs0RWrC0VGUz4TGsLhnqz6H7T66aTD0iQQuiYqb9rcHMGLWuamrI6IMQl
	i3TjpPyBexqs30+AcIH+EM9Zca1neQqwqQ+R7dZbdW2YlejA=
X-Google-Smtp-Source: AGHT+IHrA+7zJge9i962S6orPzAQDEhO1XUkEFQ5EVyEYNFg3sFEV8xqGFfQsZM23vmED8/k7VCvpw==
X-Received: by 2002:a05:6a20:3c8f:b0:240:195a:8324 with SMTP id adf61e73a8af0-24055015142mr19729554637.2.1754920302821;
        Mon, 11 Aug 2025 06:51:42 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:42 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:56 +0800
Subject: [PATCH 4/9] soc: apple: sart: Make allow flags SART version
 dependent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-4-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=qu53Npl9p1UJIa6YTj/hRvC8zr9mwt5eIRHVXIxtFxQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVQh6mVaSEh/31vtj9Sp/TjrE7dHgIyGxnSV
 ZSHXuJG3rSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UAAKCRABygi3psUI
 JMdNEACdXz4QPo+kOUFthywvLIAGegRvepLxUfokbyfdsVmpojMj5j9zId3XrjZaa8HjvdpGKmE
 rZZGAFvoGvQfoE/WIO2Hn1MS26yqKsXPYsIxtkaQnAuObrk2MhZPxHCcka4i1aokE8sC9lAKL+/
 WwNhnJr/hD5WTXNy6wC+RBRn4tXEdiOI7/Ix6tts1yudkv7AhcmLE4u6G5QuDs+8t8FHIA9Y+wo
 AEmSOYgHvNYgA2jvkRzinP0p6ogaX10fBWbfMlN34q/OHGUN6MLsHWhrq/KnOlYnfdPuvWYCXnF
 j5b6JVgeZB8TJH7fol5y549AWuyPtfVkyrsCoPfRWd2kssvzwjmcYX+eTlpLhK9REMjWTTc0/SD
 jWQpFkqaYYAUrqGl8WozokSUmyXcVwyzC60zqOpAqPAbFuz3xb6fPkFatm7RB5/9KRQwnNmqQX2
 EU1RBIF/CxOMBhYAgMaL0GeQT+4xMMc8twKbo8+XNJwuZeY9E0cJfTLhEfJkUzfIpv6rb/iR7gN
 0zE3w+661aGxZ+mpWdJYw6kKLSJNdhAzEjrB+8vIGNF7GaAFIIHPBJa1MuafMfvTzAYRVZmJ3UK
 KzuQzPYuHQhNcKrimU/dsRcNl8OQyzso+9rPKwiTQaKpTuieMMwgj2cTa0fCYOA4Jd95hwZU1lJ
 OvHb0vAmQYyExsQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065143_749128_5C0C4254 
X-CRM114-Status: GOOD (  13.64  )
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

SART versions that uses different allow flags will be added.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/sart.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index afa11173689979f100a63221af03214f4a928a7c..318f6e518a54f6edb8b97e320519df8f77c7f143 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -25,9 +25,6 @@
 
 #define APPLE_SART_MAX_ENTRIES 16
 
-/* This is probably a bitfield but the exact meaning of each bit is unknown. */
-#define APPLE_SART_FLAGS_ALLOW 0xff
-
 /* SARTv2 registers */
 #define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
 #define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
@@ -38,6 +35,8 @@
 #define APPLE_SART2_PADDR(idx)	(0x40 + 4 * (idx))
 #define APPLE_SART2_PADDR_SHIFT 12
 
+#define APPLE_SART2_FLAGS_ALLOW 0xff
+
 /* SARTv3 registers */
 #define APPLE_SART3_CONFIG(idx) (0x00 + 4 * (idx))
 
@@ -48,11 +47,15 @@
 #define APPLE_SART3_SIZE_SHIFT 12
 #define APPLE_SART3_SIZE_MAX   GENMASK(29, 0)
 
+#define APPLE_SART3_FLAGS_ALLOW 0xff
+
 struct apple_sart_ops {
 	void (*get_entry)(struct apple_sart *sart, int index, u8 *flags,
 			  phys_addr_t *paddr, size_t *size);
 	void (*set_entry)(struct apple_sart *sart, int index, u8 flags,
 			  phys_addr_t paddr_shifted, size_t size_shifted);
+	/* This is probably a bitfield but the exact meaning of each bit is unknown. */
+	unsigned int flags_allow;
 	unsigned int size_shift;
 	unsigned int paddr_shift;
 	size_t size_max;
@@ -95,6 +98,7 @@ static void sart2_set_entry(struct apple_sart *sart, int index, u8 flags,
 static struct apple_sart_ops sart_ops_v2 = {
 	.get_entry = sart2_get_entry,
 	.set_entry = sart2_set_entry,
+	.flags_allow = APPLE_SART2_FLAGS_ALLOW,
 	.size_shift = APPLE_SART2_CONFIG_SIZE_SHIFT,
 	.paddr_shift = APPLE_SART2_PADDR_SHIFT,
 	.size_max = APPLE_SART2_CONFIG_SIZE_MAX,
@@ -122,6 +126,7 @@ static void sart3_set_entry(struct apple_sart *sart, int index, u8 flags,
 static struct apple_sart_ops sart_ops_v3 = {
 	.get_entry = sart3_get_entry,
 	.set_entry = sart3_set_entry,
+	.flags_allow = APPLE_SART3_FLAGS_ALLOW,
 	.size_shift = APPLE_SART3_SIZE_SHIFT,
 	.paddr_shift = APPLE_SART3_PADDR_SHIFT,
 	.size_max = APPLE_SART3_SIZE_MAX,
@@ -233,7 +238,7 @@ int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
 		if (test_and_set_bit(i, &sart->used_entries))
 			continue;
 
-		ret = sart_set_entry(sart, i, APPLE_SART_FLAGS_ALLOW, paddr,
+		ret = sart_set_entry(sart, i, sart->ops->flags_allow, paddr,
 				     size);
 		if (ret) {
 			dev_dbg(sart->dev,

-- 
2.50.1


