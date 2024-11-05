Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DF1D2C114
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rfrLMxirFgFt6MFKpElacXEDJS2/vWmJcnE1Xe0YULQ=; b=cy9kN1/m0ttW+Yp5WAz1zquiAt
	2PZV/GG8kiItX7kyzYTnUnF0xbXRJD31kzRalNl45EQSF2h07BS3qH+TUdXjCQrpxhqPP8rb4p/0y
	5d1RI4+wAp5o6gnkfqF8sRXCUqQGOpRxDsQKdnLhAbuScN2TI1U3rkZ0AS/AEQDI8pBDO+JwH7Ufl
	ivGvmsbbgmfJ8lsGasmZoSncQJvIGHi7M5ppQNuVnvku3cLrJ2wnkaWWqKt2vcapQcXD5hNc3JcBU
	u3SqIhLZHJH4VMdiRcXWT1pXUockc7AVSY9dZ3vjSXsX4DHUzPbJgnk9g/MdDkHPc6LggAr+Y9Jd+
	k1GCr6nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Kz1-0000000HLX6-0v6t;
	Tue, 05 Nov 2024 14:56:39 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Kyy-0000000HLWT-2JPC
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 14:56:38 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-20e6981ca77so58059605ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 06:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730818594; x=1731423394; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfrLMxirFgFt6MFKpElacXEDJS2/vWmJcnE1Xe0YULQ=;
        b=dbE+PD29fwzQiDFK5ZIKFPYqDPOgEvQIDqajnKmK3kZvj1ynmXSyBRMJ6msnYbwySr
         j1GZOdJJKLnvvO+IqjJmHSVllOpO057BX9aVLqeBE3ww8zhUPKjL0s3XQ9oQxXb9Zezb
         XVHJwqo9Lf3TyFgcoIrPdp3dy1us640qgPDGnGd93T/AEds0Ry+BRjazz0YZgslTpHTh
         6VInpV67qNQs34CMJAqntafOgoEsvvNxp9dFPxoVihClKBO7tqXllFWu2i2/LfqF3yYQ
         8mpI/05+dfuDFgtfCLKCktn2jaOshh23QbnHp5YPR10gqD0y9EBM/Tv5Zzxb70AG1uqv
         yJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818594; x=1731423394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfrLMxirFgFt6MFKpElacXEDJS2/vWmJcnE1Xe0YULQ=;
        b=RlBcTAHTl44YR27g1NhrCG64aDGsvxTBqb1UDn24XX3WrxVIyxWT6RHRkwtCwFVnhw
         JUDuQ0sMvc+jwekeZhMZ/UVr4RIqPqfD/yifR0cm0W6tsH4BgCBxQTJX0ssHVP4PfguL
         USEzVU6Q9K19zDGyFjriyyh0ly0cTfWAyXahkTuLdkRIpsTHoBiPjpR9jQ4rYhr93xRh
         7ftyw6tTqBPvjc8Hj9wI7oBWgb5OtNXRU6ZPjnfoC3sLyZCoejA8XDZ/NRmtYDHNJMSb
         6TJNvSBm5hHehC1HYIBSnDmXqxu/M2hpAbNhwG+qv1c0L3hqQtdS7MjQLjQvtyjgwTOU
         A6ew==
X-Gm-Message-State: AOJu0Yw8GY7ZmXmsb0QsaRtXQ9xGfUZfBK8dkBZ8YJvx0kY7clujWPZO
	1ledw1Cx+34QEWQEHt2plS7zLaLQ6V8Q+G4cdDl0OV8heRLDRXR4VhPDLw==
X-Google-Smtp-Source: AGHT+IFTk8MqKV7PDrucXNvhxqOTD3aO8OrRcKAa9TgdCby2Y8/tOaDPbWx3JccaEyVJ8Sx7HK6t5g==
X-Received: by 2002:a17:902:d2c1:b0:20b:b5d5:8072 with SMTP id d9443c01a7336-21103aaa7e4mr288209025ad.2.1730818594381;
        Tue, 05 Nov 2024 06:56:34 -0800 (PST)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:dd6a:a7c9:e9e1:5e8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d52fasm80028215ad.247.2024.11.05.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:56:33 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: add temperature threshold hysteresis feature field definition
Date: Tue,  5 Nov 2024 23:55:36 +0900
Message-ID: <20241105145628.11833-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_065636_609894_1B3AAA92 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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

The definition TMPTHH field supported by NVMe 2.1.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 include/linux/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..68c60b0b177f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1121,6 +1121,8 @@ enum {
 	NVME_TEMP_THRESH_MASK		= 0xffff,
 	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
 	NVME_TEMP_THRESH_TYPE_UNDER	= 0x100000,
+	NVME_TEMP_THRESH_HYST_SHIFT	= 22,
+	NVME_TEMP_THRESH_HYST_MASK	= 0x7,
 };
 
 struct nvme_feat_auto_pst {
-- 
2.45.2


