Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFB2CA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=; b=Pbi+EI9LiHodcljapYKoyX7XFJ
	L97IQ0eGXS/wrZ8R9ELKjKMlSbOkRxoPfC8Lds0uG4NOIswsNIJSRjSWWjdhb5thYBjG5wvGw/mPo
	MdMFZ9CXaO7u9IgsLGbRIjBqreqwVU16zQEtXc8+Q17tD/FgiNdGpWCGMG0zsu/zK160e1KdQeHrQ
	h/8ePo0CZU/TQ85GdgxKfhtfWRrIcIMwxxOL2DGKcUr9PMupKdssJD/j8drV4o4PyEvAcahFdLZjx
	5JbmqPEQ6GTYZu8J2WQ33pap+Y1iEQi3jYNv5x7NL2cIaPJU/pnqpLv7DpLKxd1sscvVaED8R4YaL
	4CyzAXUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDvd-00000000no2-2NvW;
	Thu, 21 Aug 2025 22:38:41 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7fa-0000000HTzl-0GXT;
	Thu, 21 Aug 2025 15:57:43 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1453372b3a.2;
        Thu, 21 Aug 2025 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791861; x=1756396661; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=W0eQgXOQtorW3Ja+ZZWnnAsWGALWxHFmQgmN7Bj03IDTeBv9zA3gBp1UVxLUuKI3v/
         K9xaQsFYs02Tym4lBSYyzdDZrzg95SUu0VvAxF05Cq6T+ShWiQskeRe1rQHDO4crhWkV
         XDyFoiuYGAy6YoVy+vE+wfCvmclq1c5I9SblchO6zdwa9QjsYeMAuyoX2fQmK1fpFeQ5
         3V4LMxtN+xDC/U4XXMKYLTdi9Pmj59J3DWEM3Fovl1+cW76jJz0XzftiJp1QqcVT933j
         Nm/EYhJCno+jo/0R5cEhaTz+qUBR/977BKQIywmo1vognM5EDVl7vQgvbQRoAocVPYJ7
         eIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791861; x=1756396661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=k/Po8/+oHTAK2n+8B0Gw51r2m0uCBoHzIxz1ubrNsJjspLv0095TgJZkBfOBEbX4GU
         GC80S1c3bGb7p9SXSS2ahfk/o9DVgXAixpDlVulH/uZLPsvQtl018awYGHZC9BjOdnXk
         sG4tn620j1d0JPUUHOVEfBKs/Laa6YWwkRwQhFB6Bq1rrxkulv+P5NvY6kw68nGI+kvU
         JdRXSb61XF1MH1NjLkFsSHhtszguf6bn08d38VqL66gsy0iyZSJi0HOOe+o9beqd4CZg
         MhNH1nwb/7Y46Gm4XkpxOlWWM+NOwk3qnBoJNlHcm7H85QWOkWJ0ZxamQuEBILgAFrw8
         vPhw==
X-Forwarded-Encrypted: i=1; AJvYcCVM1NHLkOJmjfbui5B1j4owfxZNTK/zq5VBZUb4VIk36SZR7xRc8oX06gQ4Pl102pwvxALecXaVjZVapmx+/X6R@lists.infradead.org, AJvYcCWOelMmjqbO1e+xS3cui1KSs47JQL8fl6AtFh1FL0C+8tNDMvOGj9zVSNbjwTmEbR6vpsmH30Z/Rhdqxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzgBcf4P9V4M6ff1AF2FWRydkgs00pER56IsOJuXWHujdpmUOfe
	cjdHlj+TYlTrn09TmaYZz8jZLmHRNo39o1qrQH9bQuN3CK2jiBQ5y3ZH
X-Gm-Gg: ASbGncvmS8JUW2XEpho9MHIDTJ+FIQc0K6Se7UmkKaCv4TXpZBT0KMZ/9vrSuyv3thl
	6XS+DRbkHfhELcw/pRxqu1+6dlvpSveet7uy9kk+j/BEkNvY9cXoogyxBXiY/N5J1SOOxRsU+cO
	9PDPfrW0UuHzTQ9mliSJF2y5tZiCJl7CiNf7HtP/UcL4wkE82ASL2CzUbW/8j/20aQ4VwdJQDX9
	r7Rk2YAJ1lrpduNE26QTzBhaeaBDlFPCWNzjI0wcwIlK5gfhIaMMvwcFscF6qlqaPwVZn/Jw+pk
	Rytn8ocTaZQfzi/Xz0WXJD7j8DNCywfm7dKVIho6hZTM/2pE6cCVedeb85j4R5HmA/MH+rp+4Yg
	JIjFXsjy6YEwdHLPKJmkG4vDYPnyNsUkigawOg0nrbo1V8t0=
X-Google-Smtp-Source: AGHT+IFaU8yhtF4FFIW1hpaOV+kXnGjxNNTFWVUFtb6OBi3B+EkjNWrkNm8/OJ6NhTYEe/kYZZJ70w==
X-Received: by 2002:a05:6a20:1594:b0:23d:68da:e40 with SMTP id adf61e73a8af0-243307ca9f1mr4413857637.19.1755791861128;
        Thu, 21 Aug 2025 08:57:41 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:40 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:41 +0800
Subject: [PATCH v3 4/9] soc: apple: sart: Make allow flags SART version
 dependent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-4-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=SfdgOsOFi3dLK60ZgLb2wBFpqlY1bGwIVMJiWwSGmDY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HU7NMtHnDkY5eAbeUg897zyDtXJql3NIamI
 rTb/5lcQeqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JMYhD/49jIthH6VQtzMK6W2zDSG32o6Id0W/AMPYXsqaYqU5n8yIYzQxh+q4gahOIF/mXdloZTB
 93x5zyPVbtFwwBEkANe4rDpwYqUKuuVMYxpWMd0Oye0wcvjNNkPtVMIar/d5dXEki1gGBk1RnA0
 GuA/y2QzBC4jfmur40VswT4HmEvN5T7/HXdaE3zS/uxQPfhatEUWjC9Tq9/16CcVISf5TUWyWGj
 sWcLbdSRtRYpO5KSAbxkzSVsPBEVZv2i55IIpa4g2FWcHSTuKQt3jJr8/6FXlGuPsc2+rvswJEg
 TL2Zrs4nI9nqA+mHcYLzq8DqdnMU4AiMQdSEK9/6EwSgGm0nLPNUb8VW6JpOTQSsFSZTira5e9r
 mE503tlw9DVn9n5tteADeet1LcNtQI1GUuEQZHWI9hEgEAB0pw/4PNSVLz29tJmBZBljQwCC13D
 Pgb2Sob83ISI9pVshvulPR7iRRF93g4NLV8MWWLwXH1Vfy55vDszY6L6xoH2yIpUhgpYE5OqipC
 6o6lWV4MgMbdOR7ovpubJDs5BWviByBYSSazFjlIX80CKPeViTNDsM/mwEtGQXQZfbfpx9USdJt
 no3pwe4OfZiSOWPoG68N4c0PVc/LkhvUm0sy4KesT8v7HTk1ipCminef5J+BzFWxsX6JkNdZxJC
 9oEqRbSmCDAQ3aw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085742_108727_92CD8B4F 
X-CRM114-Status: GOOD (  14.07  )
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


