Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F25DC531DA
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wODkYjjXLHu7LoIUK6vdyDoix1Qpc0/A1JJtwyuj/Us=; b=kF8ceWLcafGYifw9GB6tdY2vqX
	/ezFpzgL7+UpI03jhxST30AekqZD2FlLbVvWDlrKXkH9aTWmj/5oGh32AHkJaY0mlKpoeClK/wz9M
	uBu0L1e0pfEN04cLuUwPy8TpWEdFxQG3qZxc6NGShrMlBCmOpMoY1AsNBZaTXdoM6kfe91o3atrIg
	DS/l7vlIxmZsEPWuvaLIYAaQxYTecju13RDCn5n59UDgrkMxc6L3tQavK/b+qJ+PCth6Rpl3uEWA9
	owsKRtDKCUIptlzrbuAoZ37ZZpZ9p7S9e8q+8SxMOOUQiSYt28JRGcfF1trAxYLqEXVYpis95HBU1
	WjdOasEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYd2-0000000Ci2h-31jN;
	Fri, 09 Aug 2024 23:02:36 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYcu-0000000Chzz-16D4;
	Fri, 09 Aug 2024 23:02:33 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so14780485e9.1;
        Fri, 09 Aug 2024 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244546; x=1723849346; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wODkYjjXLHu7LoIUK6vdyDoix1Qpc0/A1JJtwyuj/Us=;
        b=YZyutxEOyz6U3XIPemVSsXCVTE0Ves6XvHfSkfnhhHSRpul8+ukmexj2UHJ4RqP0/f
         G0pbXgUfgQcU2wSbDfAjdUnXVybMOmBEk2TOXztKy43Yl1HN8V4jkMp2APSL9tViRkUs
         N+J/ztffb+RL79A3CvQPx1mIhY7DQog2NmUOUCeLrfCOQXU7rk4nGjneIXn0jVuAQGaU
         oKvZoEIViay5fC/RxhrC5X7VTPugoqg8jTVRC8GYJ3PDkyyJkkXc1AOgIy/pxqU9uzN8
         DKx4INKVJax1xfiO/KC8Nw9xFbdRnVJEOqVMp8VHGC/SJO0dn216bMndWv+8M4Rz00wa
         M3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244546; x=1723849346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wODkYjjXLHu7LoIUK6vdyDoix1Qpc0/A1JJtwyuj/Us=;
        b=Ajhal92HmpW0mJ59cHWC2X2/33rUb4auZTAKlA27xx2DYhZHeh41jAHM0VTcvmc6bQ
         MP5+F4NxsZJT9cCeNACwEzKF2z1eSYhaquxml6XwI9S4BKoIfV068HwWWUa3KJ/CwFrt
         Ztp1ZtZ/7xlHA/AJ71/hr5IpHP0vznRg7JMNcsNJ3R9mLLm3ZI4sX2vK+2WLN0IKuW6c
         a141GAF2lXR6gtl+e+swWU3lLLwcraEKq3tjffnJQscNFVUBMVZArTa/oJIPz7juGKDP
         czUrvCNLWmp8ZAXQEudK60jRsI94aIFqQHy7+Uz9Q4LK/EWbp/5NUzu0wtP98MsIgCnA
         55XA==
X-Forwarded-Encrypted: i=1; AJvYcCUoZzAJIOHnJ00Wv6uQwvYBkj6ChyVdWjndZwTOlzGCRHFlueL0htscSNv8vhFaxcpOaKBBZsHTK4ugDUtXZItHQtCpIsFQa2HmRH1TIRsJA9xJeQ5LC3hx4ALwfPz6GafWN7FQBgWVCnus/be5
X-Gm-Message-State: AOJu0YyM0dTzCDGSyPMX6mBM4PocBk//pCoQW+G4j2ejyoIMhwSG11fn
	6MwOijsaMycutGXxl1rWEctXF8okStBvM3RMW3kr+djpuyXK3+sG
X-Google-Smtp-Source: AGHT+IGgtArHY1Ccvu81bZyYnJJ7slG0Epa/7R5YAnQKAsSgIp4DXcbt2NtFFMJrnz0a9ioEQ+VSXg==
X-Received: by 2002:a05:600c:1c92:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-429c847ffb9mr1527355e9.15.1723244545925;
        Fri, 09 Aug 2024 16:02:25 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:25 -0700 (PDT)
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
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
Date: Fri,  9 Aug 2024 19:20:58 +0200
Message-ID: <20240809172106.25892-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_160228_324654_9BD29C84 
X-CRM114-Status: GOOD (  21.23  )
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

Changes v4:
- Add additional patch for ofpart kmod with of_update_property
  not exported
Changes v3:
- Fix compilation error for missing slab.h header
- Add compatible to partitions.yaml
Changes v2:
- Fix typo in DT patch
- Fix compilation error for non-OF platform
- Fix compilation error due to recent changes in block2mtd module

Christian Marangi (7):
  dt-bindings: nvme: Document nvme-card compatible
  nvme: assign of_node to nvme device
  dt-bindings: mmc: add property for partitions node in mmc-card node
  block2mtd: attach device OF node to MTD device
  of: also export of_update_property
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
 drivers/of/base.c                             |  1 +
 12 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2


