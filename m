Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D59C369D1
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yBFB54Gn3nNDRE8EXoYgsgvdZtnUB689hFaMicMZtaA=; b=rdqstjpfg8gdVXTOzQW4ONnoYf
	eRK1g4JYlINjJzUx6kCbE+N/nO0cgQOySdYVhzqjSQc+MNmBjq9R1HcSX/QMVX0MkVPpwYDKm/ubH
	D2Fk04acvxzn1AuI4a0SPLofgoxCW+QW7c5C37MfybLyzTQwWSclBamB98zLUVWE1lH/FIqveye36
	SyZM/7ePbkgyzQOrqisF/3pNUGOzHasK9XZZmDCJ6fqXR/LMYQgN/RTFkrvILtHsjQxZc7YNvG04K
	7RtIabRK4siR0+2Dsy3LU81KCWMd4m8XX9dtDHwLnW0oDzUZGt5L64WBkGJy8x44nHcAgW6L34ur8
	s8nhKbZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uWU-0000000DofN-2bQI;
	Thu, 24 Apr 2025 11:13:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7taW-0000000DdHt-3tyf
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 10:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=yBFB54Gn3nNDRE8EXoYgsgvdZtnUB689hFaMicMZtaA=; b=TCe0sjbbtVHeyyZpqEyr0hOvzV
	w7tCXqBn+fCRV6RFLLLOAScb9NFR1G2t+QsRApDpelyj7lDNXT7O18ktIPlrjv4HqtvuxD+SXjV1S
	7dB8kYWImMGtESMSX1rWmvyHp8oIqcc3zuBoQ9gDr3EIPsbYAFtNY72xqi9ieexFo4dOX+vs7DiSn
	0yl58hble75WMsee2WG1fjoatSUFxnUB0GsPWWXLQZntkKOfDXxgcbizRndsMSxx9rEHW31xyEDr7
	ZLARAZZSSaO/2GJXPNi1//qJfCO733zUuRVAiGvvEYdXltY0Rlt4UF/oskRl8IMmL54fRuiauS6u/
	MrVVXUAg==;
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7taU-0000000Bj0g-0SQV
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 10:13:47 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2279915e06eso8155455ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745489622; x=1746094422; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBFB54Gn3nNDRE8EXoYgsgvdZtnUB689hFaMicMZtaA=;
        b=TcpgityXKnuMiqYv15bpHGpS/sC5Yn7V1MvnyIeCytbSD3sCbtYxdcsc/zCcwtTg8K
         UW2k0ijWHidiW8omEOPihsGWMs7DiGZ8xWTGQbIfTgPK1LuQGWW0SVanu8jSAeCnJI2x
         GEgQEYGHzBobPM+whn38rAKhuNFtYbqPYuesPhWapyaBqeyIPE+pmRgHT0MiGyq8znUj
         nFIkRekDTXG1DmW74x4X02S+8tSEfEP647jcTHWQlBjK6SKgblWkidAglz9BtK1N69hX
         n9BVGAz4M2yYUU2+aOVH9QFqhzomV1aKV94O0rsrZ7kaoKV06LdJ2dJb3O/HXR/Tz+5y
         b0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745489622; x=1746094422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBFB54Gn3nNDRE8EXoYgsgvdZtnUB689hFaMicMZtaA=;
        b=Oh8VEc1vVqvUM+pO25S69+OZ11aeHNXYM1gePBrXGVjpiCjtSUxiYE/nDcCsGMcbe0
         N+qYuSpORTJPkqMJNhoX487BgkSJkNnb2ABOrY5j82/viJHPEc3ptKAC/PLCF8OrQWcQ
         /Yba+O+Urfsuj7HQjSQx0xKUavHAu93n51fuctPpNHl3wdX+BG4gwEXUCJu5jPZs7Ofp
         MtJlZ0P8B7U8SQy9eeXxZo4N0eCSMfrpb/IM77oiNJEqszJ+vf4iIUSBBmrUB15Sf7xq
         UQA3rYK2dXnwOaSTGcqEBuQXiO9LnUkMJHs3Ikp3ZFtyUMjLe5SF1rvavW8N07Aw6mSv
         TcHA==
X-Forwarded-Encrypted: i=1; AJvYcCVTBoLjTpr3QKhL2Bwkp3vRLYlfxEMMuWWNkqwdsb689jarprFBoTGo8UqtuT4u6fFbQjOaRWnrRQpS@lists.infradead.org
X-Gm-Message-State: AOJu0YxDBU0sq+DGhHYldNsteXOeeiqMOQjn9Ib0KTLuVlT6NSRGfZin
	3wv20qorF+hgWdyTbAI1ElQGMH6UjLclDniar64no74FtvCdAcDyTKKDkg==
X-Gm-Gg: ASbGncs9DF+ZantFgir2+GfDvZMo6nzLii0lFuA4gxr7uOCdzAIyc7dJrXwMobDs4Yr
	O5FZyLgi+LeXmpJ7tEkh+es5x1OqsCcl2ilH6GeLs0KkzDZ9IEb28hdbvCDHbT+GiRgT7NCSJEt
	OA2tWarZMuqu0hCWuwypbJYZWA+PqKN/duLCW0bgE7/fyluCf0VQLoVri0J8AeghAZ211S1GO2M
	7YGvZpg+TVB2fTR1qV7ztU9WrMbCmSloLeUVcI887iZrKaIJtfA/EUvrExRjhkDrYD67pTBYblx
	l+r9uHRy9Dv/JTfJwwgnwGQSe4eh+yjHwGosTmRMDYU4WaiJzF1WU08718sqQAL8VTisDvgw4iq
	zwOKC+X9U7Htw5JY5liTAXZvAFB5G7M9R7AmI+LBgQlPIvQ==
X-Google-Smtp-Source: AGHT+IFATTwWVJ/AfelUjlOp/xcFig/uKd002TvXRDkZi6STfYNX0b3cQIwXiO9DEaSO8LylPiJ1MQ==
X-Received: by 2002:a17:902:eccf:b0:223:4c09:20b8 with SMTP id d9443c01a7336-22db3d78552mr26499625ad.37.1745489622144;
        Thu, 24 Apr 2025 03:13:42 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc75besm9536275ad.61.2025.04.24.03.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:13:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
Date: Thu, 24 Apr 2025 20:13:33 +1000
Message-ID: <20250424101333.2908504-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_111346_267024_9339E5D5 
X-CRM114-Status: UNSURE (   9.86  )
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

Ensure that TLS support is enabled in the kernel when
NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
used out of the box.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index fb7446d6d682..4c253b433bf7 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -98,6 +98,7 @@ config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
 	select NET_HANDSHAKE
+	select TLS
 	help
 	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
 
-- 
2.49.0


