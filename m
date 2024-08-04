Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F944C3DA64
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EoiP+tcKUyZMgtTqxHp6GAW77if+rMXqLxj1wKgai0w=; b=1eipb22FUXMWGys0+Dh4qtPGPo
	vnZ3itoxmHqh7GfV8gQQpBVnng9STPIXRrCISxzcZ9UdP7gat9cgp8NsmaAH+1MxtVoQUaMiqtgty
	DJ+onqdbmEVcESw3PCpsrysaJsSnoLPDkwIHdH1iTe2OoSTNvTodUWtVPxSCF7IeGCtBAW7M3TUQ5
	ihXhaHEXl6YqXLcuv/BRIIw/s3kL+NEjZlKPxe+ZmTSIbgyZeIMwKicOo8huDcCjnNS9B7U+HKhHm
	JZ104yfX7a2cqA+09xBFLle4CzDtXYuH2eZoWZMhJhhkKvVSErPirIbPcE1UJ04rl0Nz7DY757vrT
	S3ha0QRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHV-0000000DguY-2BWB;
	Sun, 04 Aug 2024 17:44:33 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHS-0000000DgtU-1Exf;
	Sun, 04 Aug 2024 17:44:31 +0000
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so112651791fa.3;
        Sun, 04 Aug 2024 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793468; x=1723398268; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoiP+tcKUyZMgtTqxHp6GAW77if+rMXqLxj1wKgai0w=;
        b=QBVmGxVwI/An2uCywljj46LMCxcZYWnCbHJo4NLCAcbRnt8ygUltfVbPWdYR9+KzJf
         OEWarGFj+uh9Vzlyq6FiywuinNDLb9Ky6W/Px/4nSG99RuVHYEtSGCfi4DDQSJ50YA7X
         x3EOpjsHPRxHarHmj+DfjfGjcbNXngbYuAcBTMUHuosBatisX+ZpSsHKcuiMP44D4FJ7
         KbKC/nUqiM0yX7L44sW/T6P3NbCyleCv6Iqukj1liTwei+h89W02NPjbxwd7VAjMBdB3
         whizoDbPLC5Lwv6IieoFXADX7y6vb9LcLOD7WiWIQRZFM9zHoLkvherMNEeFgLa1Ewb9
         v97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793468; x=1723398268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoiP+tcKUyZMgtTqxHp6GAW77if+rMXqLxj1wKgai0w=;
        b=kEsxZDkoh0bj5/d58FUnvGg8HB3SUOqXklsFl0wZnUsVkRC+zmjQYv3GjcDZT8Eqjw
         xUmNisHrElwiLL65FMWWjQbW1exk4f8KtC9DsOntuALorfjinFNZzxkoVrdHG8iG333U
         VscO/wjqo2bmBXQGZ4kV56XYU5Aq7jiALlLGoLA6vy75TbDeie3HNVmVhUcDZSdv0T4b
         tqE1veQ0sqf3wBn/wbbq36q5ub9myUl31RAcCY/l4JtBUXsvjdHr2k/YC9tZCHMMvU7N
         pGwJ9rmbjky86CxCbKFbDMZfrGIAR5XoFR+rIfGa1VN1x87y0c6gbi9g+tssD089qkUa
         9Ccg==
X-Forwarded-Encrypted: i=1; AJvYcCXmG+vsxQqrTYOgGtaOf4HqsvXpCGmIxkpevOx0mY59P/z2rEzyoVzultNaMUyTng3NQe5HInXbdgmbufWxpoiVjPCHtI4QSDz4i4Vjb/gPSx1bOgVq98ozgwmp6q2JvaI8gAdftjKgEVKGYEyf
X-Gm-Message-State: AOJu0YxzRZCyzsJZ8yMzzbvUmcPWHkrJoVN+XY/2+t8DBH5y0IAyFMS2
	8bUix1sNB9v6v7dkG09x84tVcG6vUSalb8WfM2NFS9lkZZ+IwLEk
X-Google-Smtp-Source: AGHT+IErwMK3q/CPUbM0UcDWLOMSWoax6ZCTojye0vK4OjNmfjDst57FStXCrUKjx2otYofggK9xrw==
X-Received: by 2002:a2e:9e96:0:b0:2ef:2f37:345b with SMTP id 38308e7fff4ca-2f15ab0bff6mr59848521fa.30.1722793467836;
        Sun, 04 Aug 2024 10:44:27 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:27 -0700 (PDT)
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
Subject: [PATCH v2 0/6] mtd: improve block2mtd + airoha parser
Date: Sun,  4 Aug 2024 19:44:04 +0200
Message-ID: <20240804174414.18171-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_104430_360262_490902BA 
X-CRM114-Status: GOOD (  20.60  )
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
 .../devicetree/bindings/nvme/nvme-card.yaml   | 78 ++++++++++++++++++
 drivers/mtd/devices/block2mtd.c               | 12 +++
 drivers/mtd/parsers/Kconfig                   | 10 +++
 drivers/mtd/parsers/Makefile                  |  1 +
 drivers/mtd/parsers/ofpart_airoha.c           | 56 +++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h           | 18 +++++
 drivers/mtd/parsers/ofpart_core.c             |  6 ++
 drivers/nvme/host/core.c                      |  4 +
 10 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2


