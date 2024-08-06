Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6E0C3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YpfYwGb98vUIAZ4eOkYm143SZkEFj932lYgjUfhnx5I=; b=GwpavlmlOrwykbjk8Z61XC8zqz
	JgcmgiF0Zzrf/c8RCZ/IYX8pz1Jbqnnqxpr2mvcyRhHEfAxDPAmaHMWv9UfZLBrTq+8oJEZTUR0lE
	M6I8tJ2AyM4zM4BpdLlidycjV/WxpRgOaPXg1TGyy61xX6fv5mz5CnZOgsc9GZlm2E7sfqf936ojq
	gY75v+7t2QyyUlCLfFB61IxNaYOtyRy5wtATXQbygf8AklHYfyIReclIBAM7jDPfOSR+NzfzX/65x
	jDuS+71Z1Ks4LZf/YHxpUOju7If//9SaXkOkGqU62N7eboNIzzsUU2SO/wmz1igTMx9l5tmY59xnH
	5uk0TctQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZI-00000001N7P-39hn;
	Tue, 06 Aug 2024 11:41:32 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZE-00000001N4x-2rSR;
	Tue, 06 Aug 2024 11:41:30 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-428101fa30aso3152205e9.3;
        Tue, 06 Aug 2024 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944487; x=1723549287; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpfYwGb98vUIAZ4eOkYm143SZkEFj932lYgjUfhnx5I=;
        b=aMpcF6zcjSpcIdhup00J6GgswvuVlGy6yd0JLCM/2PCMruvw0usVEOE977Rrl1Qxa9
         FPvSoWlGzlesrSglrOpPPFoPSCzfPil0mvyJDEZUOEyThOk15QxxnDtGbLdsAB7BgHc/
         pP2+8hk6SmQwTBzq1NQFY6SIWCo8MXyhLlXBuFaZameR0G7xYJbtGEPVp9WMQJtYSFZd
         IuRSTnDi6ELcHuuTUUQ3E2Xep0Jpq3/Jbf4lEyzLq9HVslWYTRzSWkbioEzWMm8q2kaV
         UhGejisM8wTcjrtjClLzl8wPtWM7Fl0GkCNLBXp/rcYTIroX6To0RO4Eu4HRLExzI4Fl
         gflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944487; x=1723549287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpfYwGb98vUIAZ4eOkYm143SZkEFj932lYgjUfhnx5I=;
        b=Z5mCgzeWvq3/SdgfyIgU9p8KRY4+Xo5hHPRI/IbizW2BKRa+9OBDOu8Aws1ffsVnBE
         eG5NRUdSt5w9GuWnbBn64WqZh7mlop8opilhxJ3qG1pQUVvQwOdTxwH+uF71NXNxpIbd
         Yn3p++ljINq2WoTW8E1eCEjdU2XhLs1BoRTTqIoCOp8h7pHLpc7geSmTawYzAHgooZku
         /cRv5N3Aj/85hRZXMrMROHZOQMonP05Yu+6j2l0F7jaRwY/ZyIbcj9HpHCm/WDHZZer7
         SPqD5fH9y3PtpxagzAnmPkB6OcDAtwpkT4UKWcOM5tgH7sIQ8stjXzjVpMMDmFh1s3TK
         cKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsgavXEyHTqmBSj8QrJDiPsN9dRWRTM847lmswt2nhvB9UpupTg6gWJTOX726LO9nsgyMFHrzVWr0GmP8a7cAk94MPKs9mFFhnFddzB95r6betDiZKmA3wtTvpZd8xam1Z199jhHUcOvjDTrEz
X-Gm-Message-State: AOJu0YxY3vNzO6MPeJderxpKYR2spMv8GJRT6gWd4uWn8MNz0734V50Q
	sZKMaMnnicqQdTivwPE8GKttf8dU3BIls0HjA5XYhFuxSn2ua8gp
X-Google-Smtp-Source: AGHT+IH3bACCHKh1gLb1eYfDR32vW4Ay/HBQR1YwSGOa4TNKvGPiVuBbrwRDssiyzifL5Rm50ofl/w==
X-Received: by 2002:a05:600c:4f4b:b0:426:614b:1a72 with SMTP id 5b1f17b1804b1-428e6b07ea1mr107971085e9.17.1722944486415;
        Tue, 06 Aug 2024 04:41:26 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/6] mtd: improve block2mtd + airoha parser
Date: Tue,  6 Aug 2024 13:41:10 +0200
Message-ID: <20240806114118.17198-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_044128_746854_D195BC9B 
X-CRM114-Status: GOOD (  20.90  )
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

This small series handle 2 problems.

It does try to ""standardize"" the usage of block2mtd module with
MTD OF nodes.

It is very easy to add support for MTD parser by just adding an
OF node to the mtd created for block2mtd.

This apply only if the root block is used for block2mtd to allow
scenario where the full eMMC or an NVME is used for MTD and it doesn't
have any partition table.

To also support NVME, similar to how it's done with eMMC, we introduce
a subnode to the NVME controller that needs to have the "nvme-card"
compatible where a dev can define fixed-paritions for MTD parser usage.

This series also add support for the Airoha partition table where
the last partition is always ART and is placed at the end of the flash.

This require dynamic calculation of the offset as some dedicated
driver for bad block management might be used that reserve some space
at the end of the flash for block accounting.

New aarch64 Airoha SoC make use of this partition table and use block2mtd
for eMMC to treat them as MTD with custom bad block management and block
tracking.

Changes v3:
- Fix compilation error for missing slab.h header
- Add compatible to partitions.yaml
Changes v2:
- Fix typo in DT patch
- Fix compilation error for non-OF platform
- Fix compilation error due to recent changes in block2mtd module

Christian Marangi (6):
  dt-bindings: nvme: Document nvme-card compatible
  nvme: assign of_node to nvme device
  dt-bindings: mmc: add property for partitions node in mmc-card node
  block2mtd: attach device OF node to MTD device
  dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
  mtd: parser: add support for Airoha parser

 .../devicetree/bindings/mmc/mmc-card.yaml     | 40 ++++++++++
 .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 .../devicetree/bindings/nvme/nvme-card.yaml   | 78 ++++++++++++++++++
 drivers/mtd/devices/block2mtd.c               | 12 +++
 drivers/mtd/parsers/Kconfig                   | 10 +++
 drivers/mtd/parsers/Makefile                  |  1 +
 drivers/mtd/parsers/ofpart_airoha.c           | 57 +++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h           | 18 +++++
 drivers/mtd/parsers/ofpart_core.c             |  6 ++
 drivers/nvme/host/core.c                      |  4 +
 11 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2


