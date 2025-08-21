Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D95CA0EFF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=; b=ORBaF9V+11oY7xzbBRcBdnbDNC
	vBAberW10176AUF7vUYRLKpmHs6WGhjyctbgsdgoh0wmeQxXgA3Nj+LgvR1vVebcQqWhNteFFS24O
	Fq4V7viosh1rcUxGv9Jr7RgiCStJiT8DlZMhF76LKVY8RMwfbiRK9jAoFEjyhM2Z2bhxsuKLdPAGP
	3+L07dAd5zdjOgi3OuLWFd6j6fLkbMR95pa8iK197EtM89Gt3tW+Dk9Nqu6faBHmVxgfXNT9Mb5GH
	gyXfkXirjJhSNKHggDuC3fy3CE1ukjvWhxCXjg4JoO0ovn5hW/BxlkMSnGIIt+q4roa/bEFwcgQSX
	EDZdK17g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDvl-00000000nvw-3mVr;
	Thu, 21 Aug 2025 22:38:49 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7ff-0000000HU1J-44Eh;
	Thu, 21 Aug 2025 15:57:49 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-76e563b25c4so906680b3a.0;
        Thu, 21 Aug 2025 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791867; x=1756396667; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=fR8jzAH+PB0+x3xOVoYlRPfJnTfMQFx5aZlsW/hHKvd2h9Uys0LV/tUa6EtAo98Vkc
         pZpJXAYyUAswf+1mqk/Nczu5EDtbTRIQlzZOHkClFOUW9mogBd/IKVmIAbQIIpixO3kP
         c5rwB4I5iTCFKwoNFpKSdfpdZudC28LQO9jpRJs3gqDy8D7gJWhbjum9VlIHMB1ssjo9
         nc0W7loVCkC4Fk4e0ZiiMzVMDZdbfhGpAy7g1U5Coi849DSzV0avA4RmrRdwj63u1ZRJ
         KqtWZE473roj3OHEpexIJOUJi59tdGyesdKYa1kQIRYWOi7IizuZrVfHJhy4TsGhq/II
         I3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791867; x=1756396667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=KKHW53YXyiPR5lHvhBc2U+AjN/o32jN9Lmi5xqtkK0hMpIYLYOjA8ZEcPOPBbYhpAf
         LrmYHVnagHdWMr602T3Kav6JTLUMKFtP9/boWn6q+DhKIsO7cxpDZ5ypJpUN+EHGCdIg
         P25xaI8a11tKdyNBTbtI7fRyW5HoM3D1oslWS+FwHy+6sSVhFlr3gHxenUYWelWjb84+
         4AV4j0A+qruqo9XTBy16Q3/TQcwt3hswAYdkFrnvlMFalt8J7NgPMPGggG6Qm5DzbMGV
         9kqEjuiO1+pKACnZoH6gkV/uh6oGflRcN/vwhY47LtoJTZlUqJFkpcqEBVmoXQMZTb1E
         jcAA==
X-Forwarded-Encrypted: i=1; AJvYcCULtzPe6p6tJkcNfI/iuv9XbB8hgZHlSOChQ+f0X2m8evsF5gzunZiKCOT2S2dd+N9GqzcWyogD5NmJBw==@lists.infradead.org, AJvYcCWKwoVUQiUkHcpQfooZFbXzNlSJFDaSS/uKVYNRr5WFgqwrls+JNz74LtblkbFYwdr0oDp2VglZPiSlIyMChonj@lists.infradead.org
X-Gm-Message-State: AOJu0YyASp/TLSA12zBfNHoLzccgyQtE4MS3khBNwrIJJUIN/GqKZ2s4
	Rl3jm3qMmI6YD0Tbx37d3vP6afyvcd0bxAkPJ2Z0WDRfuwBkwc4kgLOr
X-Gm-Gg: ASbGncvUXLAnhxnCKMzmFVh4LBjAnTQj/3OiWoCARbRYxGv62MtpUif/uWAARyTb9Td
	VOvlAduuG9ZoGNm6LUI9PFD7eWiOwVVzUZSKnlr/eTvVObp72z1UBnKrV+3uUukNOItKCqHZiIX
	c5dcal0UP+F8GUR5Z/m3Dl+SYLSKHlMn3g3l73hyn9APud2UFqtwUdN4YojgSIVoiUAg1v6NUp9
	wmVf+uhwiG/ItBhocqCtsMDbCJQOdiA25oK6v/p+466S2Lk0kyn7DYZLmLnfe0TQBSZi5DJZkpC
	j/Clz7AhlefBCQmQf4WWZljEtNBOXjE4EGfzzBOdkFyrIoBQWPkKiSIe+jMGuTTnYSlGwNsSIoU
	NZkf1x0O50ZX3fQGzfDF4E+tZyEqOR61FmsEr4fwejAa1ydc=
X-Google-Smtp-Source: AGHT+IHE9fgaPPSfoST2vYimjcU0YIs92qxt+lOf7Yhtfyjt1G9Z059hmKnvX2aribVrwcXalhAGdA==
X-Received: by 2002:a05:6a20:2591:b0:243:78a:827b with SMTP id adf61e73a8af0-24330b47cd1mr3790459637.51.1755791867100;
        Thu, 21 Aug 2025 08:57:47 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:46 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:42 +0800
Subject: [PATCH v3 5/9] soc: apple: sart: Add SARTv0 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-5-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUSDKOE7o9/KxkLrLGisPDzdwRuzUZKZVkV
 7t/hhYav/uJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JEf3D/9MTNaRSanW5d+XC6IKcZa3GXuBd2THZSYlnSMl/pfWwiWIbQF5SB4vv859yM0RFDxVNMW
 enLM8hzLdaD5r2oRWcL96Nod5A4EqiuZvW7aGis8F/E+kjVUPsn0xQnS8lKuZNWMBVNoIzSrUor
 E36L2vEbycW204QtjTRjwf14pH7jPEkmqIOnT0yO7nvbEVTdydbNO3uUX5g5J0Yro1eWXpUAEs9
 m5W1CEKXBGH/T/KB0xVf09DSqJSBXaiEe+sd4ApT8v/HZsUSZ3+pazTwk3Yqk/OLoVS+NfVM6bb
 NNxHirWbh0or9sSKaZ8OPRYD6MiFPT3WdjW5c8ujlR0xZ6yJvP9gKV7ERuEGuNo3gw75yI4pihD
 zYHh/7Wz6gnBZR129m7mJYboTPn17sO777Khk9lxyD+0V9xzfoUnr2Xf4Jr9qObs7peOHkrsBPP
 Pzqfj6X2P92L9oQIEVLeNNHpX2YcMNtQ9V1g1T2De5yCIX2Z/eLYXFOef1MDbycGXWyE7XA0qaL
 ED2IcpHnSfBe1Cy7gsLVY2znvNhiELVxQ4bvEB8tKDNjhDpDtYla2IpttmBlFMuO5VGC75iyJ+e
 C3heKdxfJwbYnLLkrwskHcN2AWgVDklnhvps4Hzqm8M4NlL6XHB39DsxPtEVp6Fdiv7QrtH6EnO
 XKmwQT0EXEP0rjw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085748_025338_46A3E5D1 
X-CRM114-Status: GOOD (  14.32  )
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


