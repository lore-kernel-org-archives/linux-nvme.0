Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE816CA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=; b=amEjZbjC+8F2QSPUhdbN3lHngx
	pz5VCWKTUD30mQsXEhxiPzB6NjnEkbX6iYV0ngbvWNT4S2nQ4CwGPCZd2nSna+49eMJKowgdaN+Aj
	1zrlhYK6v9zbvpvYgm6IAQuAUjZes/29HbmQbuiKEzC2tO/PuTEt+VX0mphZ6NYITq1pBfVoCTGuI
	+y7ThqlposqI3s1t8zA6yvgBdmytyzf4NHj2saXiyP131/u/Rf8xYvcqdhpdB9RHFDo3++LAjs9mm
	GoivkRLjS2ftsVya7ouY+pcyjx+1+XFaYdKnL9qQzpwGXf2N8SZlALExMsIKcV4oFxZGQa5uetD6h
	tLQY2+YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo03t-00000007VJ6-1a7k;
	Mon, 18 Aug 2025 13:38:11 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvT3-00000006xo2-0sFG;
	Mon, 18 Aug 2025 08:43:50 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-244581cc971so46302675ad.2;
        Mon, 18 Aug 2025 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506628; x=1756111428; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=mVD2b3JwI0wXmKlhahDGo1M4T1VSNhXu1waYH1UtMQ9133q02NeXlyLDDfRqgdkkyr
         PwBpGnCqNCcMHnXfnLAqotvHacXgwxlzQd3A0biooON/6uFn5ImRUGk7UfIDpbLB+byF
         RywbS1at9MUB4Gk0N82Ky3smI0fyEahYqwjn7l96kY6robs3dojxZiM/f6oD2TQfpNpJ
         VK8SXvzt2oErQAI1xt5qEyOnfwU6UpFMfw9WkdZt0av47EH7DNBhTBcBwYFypBfyPvoO
         wGRNIsxbjqgLL+1ChF4N9G+RaEGvIuMYIbQGAogG3M13r2akKFOnZf0I/RsJCDIRYpWU
         PZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506628; x=1756111428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=P270aDbe3PpRdJXowi/gCaykESResG1TZxY+X1YRJZWi0DdsBsWOOR6hqze9foHTCO
         JtfDRh6xflMtqYNu1+Ln2V0IDAysm8l6o5ImOv5c3K4Kyp0/D8+CX27l6yAQ7fyJrHjY
         oc88cQmExRz6rWMyUCfuNHv8f6Qs9b6hORTcznWed+XknAVqlRztFm/FwdpUmSY/Ipy3
         eCS4UleOUOPyuv9d/uH5ROC1RDP/KA2lKwqle881VvWxFjQpIBB5TbEKfsKp7QEVyLvX
         yd0CYdn2mlat33fUARNGOS/ET231WV/GLmPFeGWIu0wCVcrxI5G/IS9kCinnr1Urx4bq
         41Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWbO3qB6ehv0s19ksk7y5uehpDbXzUxWXm01ugNqWGNuHEKDK35m+sAnfnYFnsn6HkC2AK1mvTtZI/VzcZMzOtT@lists.infradead.org, AJvYcCX2Bes18CKbBc7kiGRaZq8+yNfMdOiBXT/z98UYW0CRSSODeNutVJP42pVQCexGTcFG+OVTSxPmDM4spQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0/hMWPP6Ds/mAmcY8NiS7PwX0q0yknoHvkGBh/j8Qv1RdZA4u
	elhcIzA8d0bbdBAzKgowbAqWzBwfFHrP+b4G+v52yBTaqlzbZ0jCLYXMYwbDGQ==
X-Gm-Gg: ASbGnctnAyyeCNemCBcWcjT3yZHHSuD/k4njk7c+tFdCHZOUv2GTQJJfxcuO7jFtOOY
	eENgetevYJrn/B195amFN5LonCS8h6Mlk5JiFvOVApLY7WrhaZjKKc1SjTvsvNjDobCgL4ETuHp
	Zn5EfeLOvl4if1+F11DfJzAyNlupuxRyXwCKEa0jwqpIJUOjbJCiy9SIYbXpGID8iOF0qjEseFD
	L1KiX75xR4keWLqcLXFI6drcmIpOv1fKNIdvjmYVlhf7KfwfNa8nZXMCIwL2kGlQ0AqZILxZ/2K
	IQ14ynTYM5NuHkG7KOwUm3Obr3Kezz46KHK3Hgq7LFd2wN5uZrpqZCe5neSE9pc22FxbEnUIRjc
	9DdIWqgheO0qW/gTUo5dEhgG0HRds6L0xKl9J+ULEFzj52Vc=
X-Google-Smtp-Source: AGHT+IGE0067BnqCsNs4bYtEQYzzJ4UirziWwa4iYUzmO8cpWyztzcvYDjdk1rlUKAgEjbaBIMQQEA==
X-Received: by 2002:a17:903:1a2c:b0:240:50ef:2f00 with SMTP id d9443c01a7336-2446d8f407emr157641995ad.26.1755506628132;
        Mon, 18 Aug 2025 01:43:48 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:47 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:57 +0800
Subject: [PATCH v2 4/9] soc: apple: sart: Make allow flags SART version
 dependent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-4-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=SfdgOsOFi3dLK60ZgLb2wBFpqlY1bGwIVMJiWwSGmDY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouellqqMH4V1jKMBzMhHfZrJO3Ydy7TcAv3fU
 mzAcpZmYteJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JBSAEACShbYtnm9veqAOH7lI1/GZtCd7iTn7NwNjLKYJCZjq3yEnkhimjP4juRRTv5iz1xUuRmC
 MXxW7WqQxAx1f/aAGdD3IYPSjtyA54MWPXesBRUkI/enofpJH+TW6uhs9W7FFPmC4rYBsDEm4fF
 V/5EUWfSYN8FJ2mC2mq+J+de/x5f+liD62wXjiCapu0CggzjOohIJ0+jjL6WVX4yJDXpfwEDIH1
 vjqtG116IqW76NfkHFZFq5EyaiLSprlAmFsio0rjQ31LFlLKFOkbT65OX4XKPWJreTevTOt0NZ6
 FnJ1VhTJ8pkSvRwsTEUKU8J0E21dnSj6U+rLdVfzjduUnqrljcgC2zmWUDW49vutVfb+KhRtZra
 s22lDgrQBFBX7vAaDR18a31ttMjPllD3YcEqQuZXkXpjKn38TizxwyLyiOcsw0TFmqWtGaKm5A6
 OJtM2sNKMDuW+w0vEKi0zY9LoAV261VD7WqKk9fCYFvQ6cdswkLoNYd8heyFHoKhwkFbhvv4PHb
 vJElNLuTXfiHkBUlGqeyRZylNvMCJkzvTbaD635wXjf/raQOFAhyR+S+CYSErzGqyVeJKRGXPmD
 rp53KBdtTrqzbJphtsxkJe/Adrm/HWWGXzPQJJ7sBf1z5a5SQ+gKiPRKrcVKWp23oFKxTKFAEaa
 5p1slDUgrXdxSNw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_014349_253314_50505F5F 
X-CRM114-Status: GOOD (  13.79  )
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

Reviewed-by: Sven Peter <sven@kernel.org>
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


