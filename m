Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28194C3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yyTeZsz6IZ53slc/uXF/wiJNoEHlyhXOmtXLOMGmbDM=; b=QQ/JH79+6X6Ia7EuWPoXziQBQg
	R9/MPoQ6+Rwjz2Vyvhz9zuhFK+BFOsXD731DBBYXFEEPxvwCMLspm0pRcX9emGPpIzAlLC7qBe/Fx
	kXSQdmLOFeVMzXmkwRjt2qApbMdwd7+CbUVG3ZiX1nc6aBzjwrA5oEQiYfL+qGT8Xz2kUNPI2+40+
	5RSZ0tv2koTxuBwAeCMWS0dAhj7f3d8FQeWiDpTwF5h5hagWPYnNR7ArZVIcnNg0fU9BC6U2ifRWx
	x7X+MQO7/zv8mHcQh94MDYs78A2uSfOHTcWDKgqD8c50HysZEd1IQog0ETSY/i7zuOBM+U0XjYR00
	PKDQ/QlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9tdK-0000000B072-0NOQ;
	Tue, 29 Apr 2025 22:40:58 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9tdH-0000000B05o-1uo0
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 22:40:56 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2255003f4c6so74005245ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745966455; x=1746571255; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyTeZsz6IZ53slc/uXF/wiJNoEHlyhXOmtXLOMGmbDM=;
        b=bRCPjN1OOzKz6s59CemTP4AwqoS2FnTVldokahuUpYOhNDKA5dNiniCoK0EDm7L+Sr
         Sxq00fbOg4CVAOBleFWpn7biAcBH9/zjDDWbr3isblYNUEMjz0ajyl0i/dk87iBmorpx
         1Cf9IjKktgdUzYz+XEphtTrRfc5hyqwWCZaidc+ww5J4VymDPRaIR2pucA4FtQEYU8OG
         /hPJL3afgjH02Qq2QZrtmx0Sd8srYQ7I8YVqF8ehD1wgIROfnHBZX+34z+PUrel6Xe2c
         wwv9Yr8/J15lR5RIjxAQ5IV0anzHzJ5km7uvCtLeGE6gfmTxndXrcV/AG+3twndAce+o
         X/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966455; x=1746571255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyTeZsz6IZ53slc/uXF/wiJNoEHlyhXOmtXLOMGmbDM=;
        b=Q+EbAtdR+EwntIo3uhLq2XSiazswtWEidEld7jfArnpBhTy8BG55RF+j9w/RCOA3tA
         hlmF2GPUTADQR4L0tVC1jzMQkbj/3mh0gijLI9RgICZDKINZ8acHqmXR7FXOpU6Z5yA+
         pkWbFxs81D9ZZniUJBn4bQ4tLU+/qx7YF785Og7e6CpP7zj8BLsVblecGNIqO9AOdYpZ
         AIyR55DG5eNuscWTRTXg7A6IVyc+8z2e1nMT+puEztyjb9QHf0ZH0N/ehzpyEJurvJGk
         New+ni4CzCkGcK+wBHf3AHANVychoK1V81UtUtey3WPZaHVxxmZg+0WUK60aH9C8hGc8
         b2PA==
X-Forwarded-Encrypted: i=1; AJvYcCUgyeILQ9MyPNa+F2LbwGhxmzAVtio9Fx9Dd44m3WPsqXitmd0ci5Apg8eCJ4Sy89PrTYjxwRO34E9y@lists.infradead.org
X-Gm-Message-State: AOJu0YzxwMaNx9oayEj9KyRDrcqoBpHEoTvAnem0IF5rAE3bJ+Rn5CUP
	O1lH5ib6MiJomMWHmg4vKbVSnmsef4fchpO+FVoNOpIVdgjh/iZ6
X-Gm-Gg: ASbGncv2hfEGmM5z3XltfqA5UKFcZ9fYrspuUK0ABSGECbqvxvsZ/ZQozT4ppcuu8fZ
	Jdrto79HAw5ga1w4HnXaaSkcfBwl1syZK2cMIjvYkniCKZBkMv2pScn8ibOer5fmQ/T8SybJjDB
	pUl8u/73E0nBNDuIJVzdUNit62GakoSEIE0Bzk1Zqbg3CwYdlx2t6DfCfUyCwQHaLV7NmUvJfEM
	ATIRLIaZJ+NDcrJnbhnDLZreXMDZWWy/6vv9IkmukQ2JVJvVXbqLuO0r4bUZTx1RldEkz21tDQB
	V0EU1vGnbaLmwxTMulyp5jzsUEOYi/3xiexSXmlqSi+lD8FvSZXQNYKlu0IDFxNrra9CMnR1ybv
	8siovvk3stnmIMKmt2lqMvtprkovUIaFu9A+P/Hk+VN5CvYlAvq5Pp05a
X-Google-Smtp-Source: AGHT+IG/LcYTawggDwNx+7aZsKXZ7xv08EL1BPd6O9A7QWNZPdPJKyekrLT/6B7mGyw5UqbPrBFvuQ==
X-Received: by 2002:a17:902:e741:b0:224:2201:84da with SMTP id d9443c01a7336-22df34b38bcmr12875565ad.6.1745966454671;
        Tue, 29 Apr 2025 15:40:54 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51025basm108642445ad.187.2025.04.29.15.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:40:54 -0700 (PDT)
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
Subject: [PATCH] nvme: select tls config when tcp tls is enabled
Date: Wed, 30 Apr 2025 08:40:25 +1000
Message-ID: <20250429224025.3077488-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_154055_492604_A215BEC9 
X-CRM114-Status: GOOD (  10.30  )
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
NVME_TCP_TLSS is enabled. This allows TLS secure channels to be
used out of the box.

Fixes: be8e82caa68 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index d47dfa80fb95..4d64b6935bb9 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -102,6 +102,7 @@ config NVME_TCP_TLS
 	depends on NVME_TCP
 	select NET_HANDSHAKE
 	select KEYS
+	select TLS
 	help
 	  Enables TLS encryption for NVMe TCP using the netlink handshake API.
 
-- 
2.49.0


