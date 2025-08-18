Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABDECA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=; b=RighvvMoMEQ+RrpXF4M2A5XazN
	WB6bN3gt51oSm5OJmRvxfeGTzd9Bw2yPd2TRJFFDiOYfdeUI0STJ2XJg/J+n664DXeZFNMOIZ17kv
	uFbpwvrrV3qC7eFGn+Zr/Vlc51g1tCTCi3E5zGi4jloKdUzfGB2TQzuFngx1MuqKlzMPGbVJ/apDY
	wIK3dtoEAV50o3FfT5A9SDGkd0ukmRsiV2qOaGEPOBGrazV99tcvPYA4cnW9dgn0S6+tBdwpP6dSp
	3qqO39X7YOvvbZhn7NpFdDQRiyMoCCd+PQrFrdYNZjnY4kDy/WPt93jKDN6gTvzP1hg5WMPz80Fcn
	EnM8adAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo03l-00000007V4l-3cAY;
	Mon, 18 Aug 2025 13:38:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvSv-00000006xlq-2WVK;
	Mon, 18 Aug 2025 08:43:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=; b=ZStcITTZH82rs/Uj+RBzft24J1
	DszCwY8r1m9GZ5qbUi/UnWWpWBpV7Oqg/r+XpUKXz8Hgn1r0y29X3nS6I0iEeouCxRFYCJ9UOpEOR
	H4BH7+jfeKWs//ij4JZt0XkQtAfDcLFu0mOHV7Kp3i0tI32eymAxkx9FW4CP1TIybpxr2HM3sf+Xr
	f5vy1SLnLMefFTZz3/oBmH0ZLPud0x1UFIW+7i64OFxGK5pGG+9P+iS5DW4jFcRQpw+3mceuiYjmo
	lvbIbFCg+sJrHpUKE7/MlPxRcUg4ZgBKcGSpkyk5kefva0dAVqiftejAvDvIEICsUzHEWKFDxbWpU
	BJkxATxg==;
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvSs-0000000HKk0-385A;
	Mon, 18 Aug 2025 08:43:40 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-24457f47492so24900725ad.0;
        Mon, 18 Aug 2025 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506616; x=1756111416; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=JStNCRHrWlJCXql76QdMZBMFtrywydrXDKXRRG5DHAT2GqRdrdUZzDle4wlidI1x6W
         OKuTr0EotW9kpubwaCngBzhgUQgFASp+1sv16yxMRnmYkI0DrWA64KLCl117lrJ0vc1L
         ZqFM6K7neSbQNc5x8fvoj9TanJCX+s6DGeQ3HZg7avF4ceLLjrpGGyHEaIXRItBCA5+D
         A/0kwt6GjJcNhWurIhQftMFyZsOFLH/8zbubn80TIPHyiOF/eIAHY1XA4u1vkav1v719
         T499Jyj4GATui012ddEnuxFFru1yVq62F2AFfiIO1k/Q3kCIN6rvnSttUn209xZgdFAC
         ob0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506616; x=1756111416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=UmoqsQqlBM59SDGd0Bfs+QvMSeFohXI6HBGzm4cWicRgrhzi8KrAQpIDDFsEF4Aqf/
         SdE79gJqs4dUmTXObO9uHxlQApJK3/NKNtzrpf79/1ViLN1x5tiT9n7X4NrjhfcE0PIf
         uPOo5ZEUE6bqDIgjWjv191o2zv8Z/Zgufad/d6ff6WZHalo4liT+lMfKLYqSbeaIhR5o
         tSeNPwvy2pNnQvgbles8ifO/QXtThCdqIoojM+vYxk7+FhKlW+OCfvAHBVr/WDk0nb7L
         oMC5ZWdoWrP4kaLnkDqrygwm3rZZC5Ecx8J/7/HpeDZjeAPG3FBSP860tCUKDdo7b39b
         NZPw==
X-Forwarded-Encrypted: i=1; AJvYcCVFsemstJmTC+Zxp3uBarJPtlTQHpdVuNYvTLseRnblYhKxAtOgrwi7VTjR3r43W0Rq5Uz5kTUDipSM+/sn1WLA@lists.infradead.org, AJvYcCVm0yXmxsSIXoMXASPbpwRFy/jwkQjGZ7XABak2Acijbxt9rKulNnXHmaefoYnTux5oZA8V07xQhU+oQg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwxbxCnXidV7x2RKrkx9HwgotLSWgWrQBGYoUkHDqKCowqLG0i1
	CayvcE6ht6q6wQXIryaN6z0SG5gr2qdxZeL7OkWrEiBAowNGHkpIB60En+awRA==
X-Gm-Gg: ASbGncuoYqKqWgXR+IvQNRiPDB79yFgpsu0GFmfvxhDisKVGTi8g1xypS9FxPIj+lVA
	A6x/RncsWlCgrbHR2X1uuFzfpfcaCKJ4MfAUcXiPeW1VwOIDbit9wO9BDasmflt02i/PC+W+XGY
	xugWjX94scyMBjoMoIUVrN69TV6A9rvPUh/QMlA/Z8BihSdT2NroREBGOUVlHOfaXv3eUWdaAC1
	79+StgXCQgk6mflHkIShL+BTNY2WfLMDCs2pdZbfunmgBpkyJPlbPV7gQ5sCc+53xgsqxpSe6u4
	nNgrvgYfcdxU7aALIcOUmlbGxVdQwgEbcv0ApW5Qv4zBYpHJDZCH6k6M8FE/+HlCFjApugpxtuq
	u6ZCp7LoL0M27fnN0G9Ojy5B4A5pZSCDLjqscAiULPORhY6w=
X-Google-Smtp-Source: AGHT+IHQuRcWK5Ty3gJ8EDDZyN29LLDBRSuplCA9CS1qObTIJotcC+MlRz8nfjoDQTZLml+SROaIIA==
X-Received: by 2002:a17:902:cccb:b0:243:80d:c513 with SMTP id d9443c01a7336-2446d6e444dmr157996225ad.4.1755506616342;
        Mon, 18 Aug 2025 01:43:36 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:35 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:55 +0800
Subject: [PATCH v2 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-2-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=svMsQbdVjQ089a4loHQsnYthHi7jkbh4sKxZEGMZ2G4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelfGGdkBgEHG0WSSN06ixVCaplhe9IXYpwA
 fSyXY6BH+iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JKi9EACPGx5B4ynlooZmqJSOUDRbTtw86AQjMxJMrqdy5M9a1dzv/ohFAvFKQVLkTWDQJGsNEMT
 4RtdLI4zz9tUFdf//1mm/KicenY/m7IcOgEDsHpD9fQ5qBphjPm5/VZtiUt5L9xi/3rOXqf6key
 BNsUCY1kM46g4TbPTKnh4ztQMVoyI3jjBY3QQXG04K4zZfK5sTpDx2uVkk8T/yYbu5ThaAvHh2O
 VXctp72NYqR4fR9ANuln87BRqce6uRTZnyq9xZl4HGext90aQtMG52Ng/T1voOek3oSCvJgxbXZ
 4r+UePjqz77cmbN1N4qdjPql4Y8qemXMpHkMtGoa7ugfi5VDEbFVbVE03PKr424RqZBtOEMpoT/
 uflfkwncEWHHXVaYhT2d56PDjPT2sgiTEZhL4xEq0dTpI3fmtY/jr44Tq9+05EtAHuKpjAgHUP2
 1y5VX02TT6/BzZU1adsjPlFMHiw2013wQXEa+AStCGIv/3i9YJ3/Jsi0xhMd0b8qEEslubbK9Xi
 7BfSuo9xGQBSzPVXcP1GBtogu/XCbTQn9M/NRLy9d5i5NTdXKNCLqfoHMIqMN/39zgy8WexrhVo
 i7/woatmmUWbQU53nzm7IpIWuuiqTIFh5KOfX9Cb6eoLi4heaPFsp9vAg9Z8LCPASVZttAkn1Hg
 eKljbtns6nT9W4A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_094338_962588_EAE98C05 
X-CRM114-Status: GOOD (  13.94  )
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

Reviewed-by: Sven Peter <sven@kernel.org>
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


