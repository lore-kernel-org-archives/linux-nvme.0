Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0843C3DA7F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uWf5gTHI+JT/SQK1TNIP2OxNSLbRQh1nvSdD+ourA08=; b=qNzop2FVjOIgGLKWhJOsaeZTr3
	G61EtzKP8gJGjSDPGcnZivL6B03M5jGVr6GqbfJRcCxh287cxr6B4US8ivJjsRWsUUkXbxAqitK2q
	D6uZ3kHbRtl21QJrQpFQwwrOfOJiOlUhqe/ON9RYi/P9cJj5dmlkbN8UiC9vje79POO1LHqxAxEKd
	ikoxsbzu26CBJIefUhFAX9JVsxaPuWoE/zYwIzejBnP9qnJcNors91e0QLh39beKdJDymeZBqi4la
	n4pltsL3OTAs6TciafEOTrwVYu0AWoiAGoCHAK8JhS8f9ZOaQWpsNa5fFO6xqHPEgkc302HQKGQyn
	6hmgNYbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZcc-0000000DAXV-2DlH;
	Sun, 04 Aug 2024 11:41:58 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZcX-0000000DAWQ-2vcf;
	Sun, 04 Aug 2024 11:41:55 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so121133401fa.3;
        Sun, 04 Aug 2024 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771711; x=1723376511; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWf5gTHI+JT/SQK1TNIP2OxNSLbRQh1nvSdD+ourA08=;
        b=KW7kEoF0kXxn8FPZA0oPRs0zNI3MsZ6F08fefkUTvQMnx3q/1UyEEbsawrp1ox3s0Z
         IlDlzu/aSCLhdWodC8iADnlAyqG8ozgm7MopEJvJWPJGChLbvdStHDM+fj7WH0xHTMEo
         yvcx1Z9mL7LM/8u5dpnWrbwt8EM4LcbYWdBzilGoHu1O7i9MaeMy/yN9OnmxuG7VmOz/
         6SkoUPK2znQSeYwPVKESNhgeKX//uruYftJ4BBaKYfBzCAb0pro0nkjQum5ZlG/XzLSm
         bbfEWAoR7U9WG9zFXh72uTT2bh8bbKUIxFIbFnF1ovqEyLGOsE13M9xMor7CWXQYabDn
         NGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771711; x=1723376511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWf5gTHI+JT/SQK1TNIP2OxNSLbRQh1nvSdD+ourA08=;
        b=aR1cQs4xswDwHh6FYXtHm8EQGygqwuf10rFyBiv9TXKvgF8pLLfo2KxuSJ4mfzT11o
         bpjIsUhvHzp4W5EkyA7q3ARzD7ZyKk86tBZWoBqTS0ar5HZpbKl57xB0WDM4MIeeTkcH
         idQoEHA2yps5H3C+WMVcgec874Z4BnPCdsoc6bCGNbdXHpesjMFaewPk4mM2b3XP5u2A
         3Dtl7GnPcbWlSBtn6xF1YJpr71EH9Cq38LrydUwOCEyNlABP0OFxmu8PXR6NI12eP3RH
         Lhq7qO0fcHlz7YIzKEm5eGnnPdu+ysgLilPnJgd+0wb+kXifMpuOddv5Xgc473p/9pzn
         DKvw==
X-Forwarded-Encrypted: i=1; AJvYcCWtpCWkMOVLrxC3LK0XDX3aQoI+KRiWU4MjY3QO50vBgJe9vHH4Q7mNnii5s7T91QEA5mZr4Br2N1uKs1tgrNClWfGOOxW7MX6gIFzWYShYLMES0PdQRPOUQenJdZjM+6FBTUiuGrhHrmh9rnqF
X-Gm-Message-State: AOJu0YxNmZv4botN46IN2gg73oB7vPirMXBbCGNae0nhSgzqD6uGfUxZ
	Gwb+QWOYoxa5bakLZxKB11xE2125jHoZv4uf5+8WnY1Fz9qEICV1
X-Google-Smtp-Source: AGHT+IFQ4ywEK+Nr05gDozWWIKvELkaPNu9X1hjfL7jSZE7JaOVmh+yHXQJ/j3NTm9CnUOJtPHdoxg==
X-Received: by 2002:a2e:a409:0:b0:2ef:296d:1dd5 with SMTP id 38308e7fff4ca-2f15a9fd29cmr61440031fa.0.1722771710561;
        Sun, 04 Aug 2024 04:41:50 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:41:50 -0700 (PDT)
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
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/6] mtd: improve block2mtd + airoha parser
Date: Sun,  4 Aug 2024 13:41:00 +0200
Message-ID: <20240804114108.1893-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_044153_783559_C96B226F 
X-CRM114-Status: GOOD (  19.31  )
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

Christian Marangi (6):
  dt-bindings: nvme: Document nvme-card compatible
  nvme: assign of_node to nvme device
  dt-bindings: mmc: add property for partitions node in mmc-card node
  block2mtd: attach device OF node to MTD device
  dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
  mtd: parser: add support for Airoha parser

 .../devicetree/bindings/mmc/mmc-card.yaml     | 40 ++++++++++
 .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
 .../devicetree/bindings/nvme/nvme-card.yaml   | 78 ++++++++++++++++++
 drivers/mtd/devices/block2mtd.c               | 11 +++
 drivers/mtd/parsers/Kconfig                   | 10 +++
 drivers/mtd/parsers/Makefile                  |  1 +
 drivers/mtd/parsers/ofpart_airoha.c           | 56 +++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h           | 18 +++++
 drivers/mtd/parsers/ofpart_core.c             |  6 ++
 drivers/nvme/host/core.c                      |  3 +
 10 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2


