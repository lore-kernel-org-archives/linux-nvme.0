Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB745CA0EEB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bx8sUIY9aOtvP6bPSKF1xVFQVSXOtKKcBX0gwDpJVCg=; b=0DwkRyJI2G/7EZ
	J4JD5n54oetxyumAgLBGnB9m7qDQ6lLu7fT+7QZ/SZEr3QyGfIhc2jxXhLysB1souWHA0cZpngxbI
	pGBjHy2gdAqhd8BImhZoVtJzYOYFn5RZA/i5MZLUa3zTrRQ83kPzxB+YXcMOh0/wWZllI4dOEzNyg
	bytQO+sPLhOgxNtzzOY+ecBgGh6986XPGai/VmAffrrb9ZTsLKIZzkFdPy4uV08eiA9VKhriWMy8H
	G8/VUK2j8PQrNEA61C8Od3GCXgmMuofu0p5JDs2iX+MsS37Odf5dzKvPgHbMs3WRepTYlxhXPUx+p
	zdR2DC96aBy0GL6kNPpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo03e-00000007Umz-1wwm;
	Mon, 18 Aug 2025 13:37:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvSl-00000006xj4-1cTl;
	Mon, 18 Aug 2025 08:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bx8sUIY9aOtvP6bPSKF1xVFQVSXOtKKcBX0gwDpJVCg=; b=Me3zZ2WR3lzLkZqxM+VDrjEYw7
	hLnZoH0x8/XE50WAD75t3WEIvHwpqW+f+qp6TdM37ztL8/cEGGDqUafNfBUGYdK6uhB3lqzX8CjNe
	G3cCpOpPXF6PkNGA66cDB0cMFRLOQ/mqZQgFpw+yG1zCfNnp5/74yr5144tu7fB1k9SWw7ftM6UD3
	Z6Yjrz4EGBSi8x4ZWAR1V9ARvRzxU+gBrdw5MlJsEiGqQLZEojKRws7NRbgHan6GEn2W5JJzC02/C
	A7dgj1oNfuAE/7Ssmen+yIY6m4zU7fNVIs410zjNJeW2oWWXgr3rCT1a2PDLbNrfjf/z5cfnJil01
	UqUifIKw==;
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvSg-0000000HKh2-3zVz;
	Mon, 18 Aug 2025 08:43:30 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b47174beccfso3314235a12.2;
        Mon, 18 Aug 2025 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506604; x=1756111404; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bx8sUIY9aOtvP6bPSKF1xVFQVSXOtKKcBX0gwDpJVCg=;
        b=YHgUJ7nFazXFFzGJp4wjopshoBxT1RrSw023UXaEFiz9ed9t3wvbCL8mHVYDUPdX1B
         LanKL+q963DhYT2f4hrsNB/TbP/hyzK3JoubdtjxuVjwJRBDGqphhO0ZKdmN9eHDbkxP
         kQQsNHa9eBVTnKhOEOBGBv5sA50+0Oo80jKl3LZXHi+zhu1NH0EMzKew17/plUj5iKrI
         4aBoMvikn5VW5s/x9/IXPGx9khDCcWL9KBS8yR8x5SJbGP1Tzem4rb/cioDffw6cbs/1
         LNjOoUlOnMSOgUUQlRc8zbhJG3W4Yo3cyeitaanzHHdHzi96SmGQr+YKFVyAQ7k6xACG
         HGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506604; x=1756111404;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bx8sUIY9aOtvP6bPSKF1xVFQVSXOtKKcBX0gwDpJVCg=;
        b=Vov5/2Rd3XbAPJxMyaJen/xaa1NfP2adscdnJl88kfGa+eHsbiI5J2Mjl1msJrsDbl
         KiPecJlzsMsV3yeF8wstpa8+I/5qcZLA9WT+lWZLVAS2bDDS8YiT0NejHD7aRnbsI56h
         Ysda5P4ho65ccUbBeEL/JjBm0dUOtt2Xb9KhG00DvwiJBy8qVskLXcALPicZI4imQJMF
         rRPLcftx8m7YdU++7mHsqJ4jwlZHmzzWE2RzoEtNBa0o1TU73zhNgGbvHKwzKOSSuc9a
         xkIga69vfFAwIjVlzXrc38EgXnHxooV6x66CZI8/QM2ubx/qqLvySRP7HomWD7Wqqvd0
         fm9g==
X-Forwarded-Encrypted: i=1; AJvYcCWywo4aWovgnUGnmJKcvBcW74niu7kwpYH3Ri/OGpxtJBvmQfOjoyuEvpQMWbmeOsnG3tXCOy12qqcsnA==@lists.infradead.org, AJvYcCX7rLLiMHq9hFWSPpsFhtjmw38TxiRtnjos+xU9N9V2zUf7/71dwV02nuFEAYoZVAk+KeoyU+kmdZTRbA0z7LLl@lists.infradead.org
X-Gm-Message-State: AOJu0YxodftRPS98g70LVoy+qojd7js/oCmQWCkItOAHPQVURjUDWMxS
	cXSEiAISftyC8RQoXSAxc/MA2T9Xq8BWi6fs8RQcAdq+jsZ8BI3m/0Osgj540A==
X-Gm-Gg: ASbGncvvPdVo10KnEFvsZfWDZ4jzxklzhOCKEcZY7G64Mysd4Vjl//yz/hLoQo5V+TS
	5E+kVkIiL+MqAEYGmz7aLkMnsiIui89fxOUaTU4yIP9jHgAt2O2Nle+YXvuiR1wlmUU/Rb7fOJ2
	y0asmX8jacFweJsNAsEnvuPdxLnY1Apf/Z6cfFji58P88P+ElqzIZKD/Ho93PaHWcmsiqR/R7ad
	uptyjNjrudBWEP8rABWz+aeoGktZSWuk/8sSKgnZYsn/ncE4ntg+xf+gW5SniouzhHApyTrd7Em
	zsl/bYVHtBMSJZ4bKGk+AT7kDDdqWiWodXHWBHLn86GtqO3+XxYEOG5Jq9AxdGTS7sw+bzfa5gG
	ZJEFwDnztIFSkVUfKVLG3FoVtteGehQKfxRkw0+XXkmOVWm8=
X-Google-Smtp-Source: AGHT+IGr+QvXGo3/T80TEtk8GucqtvAHkHyeZ3j5ycRlwOeaTV8Fhjp6M6C6LOuR/Yh1gB0/IdKRSg==
X-Received: by 2002:a17:903:4b4c:b0:242:a0b0:3c30 with SMTP id d9443c01a7336-2446d8edf38mr141753015ad.43.1755506604217;
        Mon, 18 Aug 2025 01:43:24 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:23 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/9] Add support ANS2 NVMe on Apple A11
Date: Mon, 18 Aug 2025 16:42:53 +0800
Message-Id: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3nomgC/03MQQrCMBCF4auUWRuZxIZGV72HdBGSaTtgWklKU
 ErubiwuXP4P3rdDosiU4NbsEClz4nWpoU4NuNkuEwn2tUGh0mjQiM2g1GLJgUR3se3ovFXae6i
 HZ6SRXwd2H2rPnLY1vg87y+/6Y6T8Z7IUKGi8OoVIXWu7fgqWH2e3BhhKKR/numlkpAAAAA==
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=h//OnE8xjMrdJsTFOXyv+oxSEG4dfiZyYKDlv6KTGHQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouegHci7I26tBuTw2954p8e1MuDA7bm7+1HK1
 MMona/pAhWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnoAAKCRABygi3psUI
 JAnAD/4sXJEJsWnJXyEtUrZyoCoNIoaFwJzZuTYIWftzOPbeFpexvXqlVwu+Ysc2UNrQQr05hco
 kF3AFRksFtzPz0VxvuisoNbhvv24NdsTvsxs/z2T0ofzyJ0UQ1BQL54uiwLYgiqMSgqRqCu7SNY
 isS+k8QYYwt7W1idiosA7W9Sp/i2WEyNu6tSAXwIJF+eykXAeSVFeZyIf3Rw3FDwFXyRsn+rGWM
 ABGTsSP2o1/HPNr3FobP3WuJ4qZAP+9n8PsOi2YcvFsF0wuwcFiZ4xs8aIswtAWMNKWXq9tDv4X
 DzqFDNu2iUpjlAeB+LfCBGn9fdO4F5dp0UZqXyg7tV47ryOVdfxTHslC/02UAmFBrszw2hqM4RJ
 SSFTzvF1q0qb3hnPr8PVG8IPYj5LyPa9+gzsGuPnGYRhFUeqhF4KQwyyOaB2rlHgKO+qgRgVkWR
 ChSqP7W8hyV5dm4fOwGFwSlO3gyp5lOFnKszOPsmwekqQyfg9/+27TIF1oMnbsDYbK5XG+hukG9
 11Dn1/TwCIjN/yPyOMYt9/1nwMo5TF/wu17jwMSkXo3jSCUAPYodPLwsq+Jiv3hlIS2ukSQLV4j
 RUfcSqUk1TqNXjgtLcf9VJhX492IkA4ALFmSVle3syy9efPFNB71Hz5cT6nR1/bea95NZmn+wiE
 v3Ei+Fu+gPBvyEw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_094327_262471_4D0D59AF 
X-CRM114-Status: GOOD (  15.39  )
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

Apple A11 SoC comes with an NVMe controller that is similar to the
NVMe controller in M1, but less customized. Notably, it does not
have NVMMU or Linear SQ.

The controller is wired to an older variant of the SART address filter,
and uses an older variant of ASC mailbox, so add support for them too.

This variant of mailbox is also present on Apple T2 SoC.

This series has everything required to support NVMe on Apple A11 SoC.
However, due to RTKit protocol version support limitation, it will
only work when booted with at least iOS 14 iBoot.

Tested on A11 as well as M1 Pro (to make sure nothing broke).

Patch 1-2 adds support for the older mailbox
Patch 3-5 adds support for the older SART
Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC
Patch 8-9 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Remove bogus command_id decrement followed by increment in apple_nvme_handle_cqe()
- Split apple_nvme_submit_cmd() into two functions for t8015 and t8103 since these
  two code paths were not sharing much code.
- Link to v1: https://lore.kernel.org/r/20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com

---
Nick Chan (9):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |   1 +
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |   7 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 ++++
 drivers/nvme/host/apple.c                          | 198 +++++++++++++++------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 ++++++-
 8 files changed, 267 insertions(+), 68 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


