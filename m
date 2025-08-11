Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C29C87FDB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G+4DQ9gFfqWg9bYh04jDrMGb2bGde9Og3BcDQZ7GXzI=; b=dWXXXvxQ0zxtRzAqA4VIv6QrPn
	qWt8L0giadG7f6VjZHrp7oyRlAa0m/f1H/9J0OaX6zpP3ssAhFagFSW6+QsFlN/1u2wDn3U5f65yS
	H+IkIcMGLoDGP0ay0nniVCAKDPi5YlYYiFAdX4YbuTBs2+pzugjXlaaFzfYynWzCmDil9LBhGtuFq
	vzQkt01mbG9hufly8Q89uSLQkEjhjj2A8RcjyVfM7FSGdOn/CNeCjis1dWOfkd5a2vmrie12/jeNW
	Vcjnv3YiFbcNfDRBCS1oYDwITGRyhRzhIMm2e0QTvs5o68kcd9L8YYNAy0u58Zlwso6WezZpli+va
	cUOtRQQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulT57-00000007vTh-3jrI;
	Mon, 11 Aug 2025 14:00:57 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSw0-00000007sx9-0K1x;
	Mon, 11 Aug 2025 13:51:33 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso3747983b3a.1;
        Mon, 11 Aug 2025 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920291; x=1755525091; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+4DQ9gFfqWg9bYh04jDrMGb2bGde9Og3BcDQZ7GXzI=;
        b=l0eiHfKu1hx+mcJMpEtNcJrdR6dijEgsW4Y+MAIIgcy55cjZhJUw0lPTwM1povqzRv
         R1Uo3/dwwJt1PDzua4xpD7h2JIkkk16sMQu1zJh44CE9nfgvh/Epwfqa9wAe9/dVkmYO
         VEMuZqRUK0zR/eatyzywfyRajLFEBryiBK+xmIUzZ3F8HQjPe0RbUeRIxjfUFUTe15Ez
         56Uhv6/W0Q4yAv3Oe0YgYLtCTfUy5U8VQfcHyHtb1OfkFOHy810lLfDv11S/QveuRaE/
         zFNCqPMm/V9LVRS/VFgrNsZ+XYZ9Bk4iH1iZepyHnhLRjoz+D7bN8KnySuRtw6OTnyll
         F8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920291; x=1755525091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+4DQ9gFfqWg9bYh04jDrMGb2bGde9Og3BcDQZ7GXzI=;
        b=k0cjAgRYVkpZclR2oK5x0DP6Omn5jqvRNnnv9K3iMBa8Ma7M3gw1Ckb4CDozZsRkyU
         egoutTI4ZngeEZpkMi1PaJ8DehmcS40S9IdOjzxUuZb5RhspFfau+6E9BTYrXly0lwkV
         iJ6PtFSnSzSZM7SDhMlctnFlmLma3df2V2UeaL5hhhXbcxjEUCaTR4zjGI46IwEsLmSv
         WW6h55O/3K+3z9vkbxN0EO/KKVw/W555FwZxVHoobNXjJEc43O3gsfAHG3Ve1tjAkTcA
         mJLCYAF0PtgZ9UwUoTRT94ihTwlbaIuiw83b7h4Kb54QERXFjfb8HkBZbjvg9+RLpmCZ
         QvKg==
X-Forwarded-Encrypted: i=1; AJvYcCUGIHNjkJQvL2AXtB8UgKXV3ranOWO3CGVRNSSH8iMtbWIZWdiLNJtrT0/1GOypYpGW/ziaaguwB8t/vw==@lists.infradead.org, AJvYcCUwabeZyQ4y/zkysvaTsjZ4t4muKiv47vL8vkGNnWjNpu2zRcqUZ23ZVQ1kD6iq1Exz9LaNwZPKmFmrxRkS11Kg@lists.infradead.org
X-Gm-Message-State: AOJu0Yyy+++Qxdf2zcsoEob0/Sgf18aWZE5H6nNffxgVVS2UOLADsZns
	c+pSeEt67Gya1LfLstTgbvul4pEMzat8DN/27LVshEgxChHZ8IO2JWAo
X-Gm-Gg: ASbGnctyuRgaa/GXN+YETDHOiUR29K+ixhE823qvgipN1YZRljIey5k4/El0v1mwUNS
	xvdrpo4dOTt2oLlPs4c1GWjwSIO1B/HwvKlpYOZ15aGSleGnJOCLhoyAxhwR++L/rc4ryhUJ9AD
	+E5KjlNxPGPaGnuw5O+x9EomJEyXRdX2wyuQPY2drmeyyI/lWhSbMJUm9cFBpGsljip4qymTtoH
	6zx2+HeLvd41CrOe+AZRzhuTAbUJ/7lgSFqOFSHuaJi5EN4zLDKCF5TQcKEmuLlWBR1W8SLpydl
	9w50I88lWkNvafXCOgHTzuROk+PzdOnxNRXBRcZVSkLqOGhPvg4oeZjCjqelaEC3Ht/BOpkMj3B
	EZLpTn2b3ei+lu5R9JRHDnR06t7U71ZOhhWZ9nfuYTESo2q/9i5GsmoEvzA==
X-Google-Smtp-Source: AGHT+IHza1fW4UR+ZAa981Mk//ah0psUmGmnKePPNhzQLBjiW4IikcyFLH89QSp4rbQ69Ase7x7TcA==
X-Received: by 2002:a05:6a20:7f8a:b0:240:43e9:6cb7 with SMTP id adf61e73a8af0-240551fb001mr18843076637.45.1754920291256;
        Mon, 11 Aug 2025 06:51:31 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:30 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:54 +0800
Subject: [PATCH 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-2-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=rwyfTWY33eH9/JkH2R41w9Wvs6PBkQcZY8fhDT+IUjE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVQudOR+VSigIgYYBjen/pSrND3fNHu5gx3t
 v0Alm1eGAyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UAAKCRABygi3psUI
 JKYXEACymLu/6TH8J0+/T0V91LKlcavy6HnXo0LFirBif/9o5t1dfJ5yjxGlBO6Z1Z/Vgcmckmy
 icO9lENZrFE3D78uNj+Qwk6QbNnKKWPg/dlUKoRj5bKFmJWvnvQ4aLkXVzArxKPqgmNasnh86XB
 9iP+k3huSCfnNor5IAFCeHwSbBnpH4V3pW8CEL7glJDGRJwyK1xOjJFk09RBev/ej/MWNRfQCbw
 oTGGGzhVBoZ36hfc/lTrx8lOytQC01PyEnmN82HS1ASgVCz42/VuTgjm+NNX/ghzm6PuPv6IA61
 spstvz84jxbigjK2czdXEIQdACdyIXk9g0BcRh7nEe1A1bQkRE1EJ0vH8ND9I40mf6qZjBMmebg
 NUMEZh+6qXpFejhVyGXAFbyH7CQQyje5S7qkKXBwu9Yl9YGRVQ3by1B66o5AQMoOGZ1c9cV6AD5
 z89XG5JXa7l/oO9te7Cs75Wlm2kC1qq1jT9lrWFh3XRcLFzsGJTl97nr6auM3KAoxmJ3zCCFMmm
 FHDWC8QUDeJxCAKsQedw13eiUcGkMaBhJHb5ByQe4HwF8ErM6kMjXDLMVRQ3YWYT0VBg0G9ZBpa
 bw4YB1AEURxDCOFjyUFoutlTMrBgTbXqE6njnA0T4JOW5AXp2QInJNBrUTC9uEn9ws9+bWi8aDe
 8FayRVsJAt+R/Zg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065132_125070_97AB897A 
X-CRM114-Status: GOOD (  13.86  )
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

Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
coprocessors in the system.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/mailbox.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 49a0955e82d6cf5eef83e5f63ba8d31194c65324..8f29108dc69ac964236121d439e86c923a441265 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -47,6 +47,9 @@
 #define APPLE_ASC_MBOX_I2A_RECV0 0x830
 #define APPLE_ASC_MBOX_I2A_RECV1 0x838
 
+#define APPLE_T8015_MBOX_A2I_CONTROL	0x108
+#define APPLE_T8015_MBOX_I2A_CONTROL	0x10c
+
 #define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
 #define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
 
@@ -382,6 +385,21 @@ static int apple_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct apple_mbox_hw apple_mbox_t8015_hw = {
+	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
+	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
+
+	.a2i_control = APPLE_T8015_MBOX_A2I_CONTROL,
+	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
+	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
+
+	.i2a_control = APPLE_T8015_MBOX_I2A_CONTROL,
+	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
+	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
+
+	.has_irq_controls = false,
+};
+
 static const struct apple_mbox_hw apple_mbox_asc_hw = {
 	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
 	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
@@ -418,6 +436,7 @@ static const struct apple_mbox_hw apple_mbox_m3_hw = {
 
 static const struct of_device_id apple_mbox_of_match[] = {
 	{ .compatible = "apple,asc-mailbox-v4", .data = &apple_mbox_asc_hw },
+	{ .compatible = "apple,t8015-asc-mailbox", .data = &apple_mbox_t8015_hw },
 	{ .compatible = "apple,m3-mailbox-v2", .data = &apple_mbox_m3_hw },
 	{}
 };

-- 
2.50.1


