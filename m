Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98B9C3DA7F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9UVSgx2w+2h8saQn7Nf58i+A85otGYnCOTiNQf2qOnE=; b=Jz9oRRP8A9yF7NpGzNwNtOOg5K
	2qBJJ2vKPv09j7QQetHC4l0zu3lolEIHZKcx/+X+db57FHnnIBefnwGuPyOGmUdNJE40Ry/aMRmEe
	sRgWOk69RkUJtGR+ttQv96w7UXw5TEtQ1tPR9J50lDjlI1YuY6axizpQ9xLO9m0gcd7Ed3q9KAqIl
	HjMxNgfQtC5EFmuIv6wdFBBTB3oIga3sO89Wz8T9kkwhNExQfFDO8wsqOqbF3uvpVa0cg2zFVaJkH
	sosqTADXl1+i34ABhMb3+35d0Aro2dFzZbuT5lXl7eYl5OxXkQ4LFsVvnNA42Y7WQXaKvHWugreJk
	BMkPlsBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZdH-0000000DB5v-1IL7;
	Sun, 04 Aug 2024 11:42:39 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZcu-0000000DAj9-17fl;
	Sun, 04 Aug 2024 11:42:25 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4281c164408so57908745e9.1;
        Sun, 04 Aug 2024 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771734; x=1723376534; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UVSgx2w+2h8saQn7Nf58i+A85otGYnCOTiNQf2qOnE=;
        b=dTXWNhFl91qUrW2IF+3u3son/yioCYQlcmA1LcMEa2aTQZ/3PsOzDffLymgWVNE4/s
         7MBa3QiWRlIrQkAYFC1NAYiOIfWi2mP2OxFW5ewW6FxEZV9kVltKxKLWfwtPf/c8FLKa
         M0IiP/gexb+F5UeGpQAQFCeLpADvJerSs8QzEG+aiL8RMuLiAj26CxtXbI69izzo1ncJ
         7V6omUTM8q9vlA53MvOll8CB34JYIDCMD/iBWOvMh3dfq/n0IqjLN1zEUg14qc865xew
         AgpV7bNBSxIOlESamQiV2R4bF5WcvfDbCrEZk7VIwKFUdud669ST385nDpEJyUP4gT1d
         KxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771734; x=1723376534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UVSgx2w+2h8saQn7Nf58i+A85otGYnCOTiNQf2qOnE=;
        b=eKWhPpQPxC3z6SjVgOWtEjyi8lRX30Iw6+Q9fpj5p+dfZWCGsNLT7WdnC2yvpFS6L6
         3MoL6Wp+Z/Rvu48yQ12oCe38yxU+Yw87J95m3+Dr6JtuMiyIV+b5u2ESTBiPkGvXbKrN
         J7O7IV1mD/AqUc+c+bWJVdA4cwQvRYaIVSd40XVNFeKESDET577NbG+OnINa0/WyFPZo
         njDJvCJIyWfPKlw5KdlVcczfX/ad28wd8nvO3ZuJMduSlreQS6kW8z7SxPx50ezFmPpS
         pavhBlIDNL9rEdi22WMGu+h1gLWyX9/zV8VJY/UkVMiEVMlQtMf5IyXC4rL3ClVndIqR
         J/yA==
X-Forwarded-Encrypted: i=1; AJvYcCUZLvAwpf6JxwE+KRchM3YRGBBFazzbHnx5X19sfcEttgnNmCHl1fJRs4+l6FVxnx7Q7yDBANaT/jiBqwiw8WMDxrvZq+cl7C+IIn5p4C86xjNAj9u/vlXEzq8ZMksxG7fhpjRHNha/e45WpyuW
X-Gm-Message-State: AOJu0Yyc/alXYFAQ5wqmZB9vYCcGIGFrDK1Kr7SlUHQZJjcC41PaIgpt
	yr912Dulo1uAsgAn7w7uZiRQ/ZVhAb+G+k39F3pC8GMjARpw88/A
X-Google-Smtp-Source: AGHT+IGKaCDEArKFCkMRQiZKdcUjJdCjj4WZCLTvBf7YPdaEPgvS4EnneXBtmeDcGQXSLmrXmUCU+A==
X-Received: by 2002:a05:6000:1faf:b0:368:d0d:a5d6 with SMTP id ffacd0b85a97d-36bbc1beb75mr5955443f8f.50.1722771733531;
        Sun, 04 Aug 2024 04:42:13 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:42:13 -0700 (PDT)
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
Subject: [PATCH 6/6] mtd: parser: add support for Airoha parser
Date: Sun,  4 Aug 2024 13:41:06 +0200
Message-ID: <20240804114108.1893-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804114108.1893-1-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_044216_657583_EE80168A 
X-CRM114-Status: GOOD (  30.50  )
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

Add support for Airoha parser based on a post parse ofpart function.

Airoha partition table follow normal fixed-partition implementation
with a special implementation for the ART partition. This is always the
last partition and is placed from the end of the flash - the partition
size.

To enable this special implementation for ART partition, the relevant
node require the "airoha,dynamic-art" compatible. With that declared,
offset value is ignored and real offset is updated with the calculated
value.

Due to usage of specific bad block management driver, the MTD size might
vary hence the ART partition offset needs to be dynamically parsed and
can't be declared statically.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/parsers/Kconfig         | 10 ++++++
 drivers/mtd/parsers/Makefile        |  1 +
 drivers/mtd/parsers/ofpart_airoha.c | 56 +++++++++++++++++++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h | 18 ++++++++++
 drivers/mtd/parsers/ofpart_core.c   |  6 ++++
 5 files changed, 91 insertions(+)
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index da03ab6efe04..d6c53aa16ea6 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -72,6 +72,16 @@ config MTD_OF_PARTS
 	  flash memory node, as described in
 	  Documentation/devicetree/bindings/mtd/mtd.yaml.
 
+config MTD_OF_PARTS_AIROHA
+	bool "Airoha EN7815 partitioning support"
+	depends on MTD_OF_PARTS && (ARCH_AIROHA || COMPILE_TEST)
+	default ARCH_AIROHA
+	help
+	  This provides partitions parser for Airoha EN7815 family devices
+	  that can have dynamic "ART" partition at the end of the flash.
+	  It takes care of finding the correct offset and update property
+	  with it.
+
 config MTD_OF_PARTS_BCM4908
 	bool "BCM4908 partitioning support"
 	depends on MTD_OF_PARTS && (ARCH_BCMBCA || COMPILE_TEST)
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 9b00c62b837a..d67f9b4d39ac 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_MTD_BRCM_U_BOOT)		+= brcm_u-boot.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS)		+= cmdlinepart.o
 obj-$(CONFIG_MTD_OF_PARTS)		+= ofpart.o
 ofpart-y				+= ofpart_core.o
+ofpart-$(CONFIG_MTD_OF_PARTS_AIROHA)	+= ofpart_airoha.o
 ofpart-$(CONFIG_MTD_OF_PARTS_BCM4908)	+= ofpart_bcm4908.o
 ofpart-$(CONFIG_MTD_OF_PARTS_LINKSYS_NS)+= ofpart_linksys_ns.o
 obj-$(CONFIG_MTD_PARSER_IMAGETAG)	+= parser_imagetag.o
diff --git a/drivers/mtd/parsers/ofpart_airoha.c b/drivers/mtd/parsers/ofpart_airoha.c
new file mode 100644
index 000000000000..905df53f7716
--- /dev/null
+++ b/drivers/mtd/parsers/ofpart_airoha.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#include "ofpart_airoha.h"
+
+int airoha_partitions_post_parse(struct mtd_info *mtd,
+				 struct mtd_partition *parts,
+				 int nr_parts)
+{
+	struct mtd_partition *part;
+	int len, a_cells, s_cells;
+	struct device_node *pp;
+	struct property *prop;
+	const __be32 *reg;
+	__be32 *new_reg;
+
+	part = &parts[nr_parts - 1];
+	pp = part->of_node;
+
+	/* Skip if ART partition have a valid offset instead of a dynamic one */
+	if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
+		return 0;
+
+	/* ART partition is set at the end of flash - size */
+	part->offset = mtd->size - part->size;
+
+	/* Update the offset with the new calculate value in DT */
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	/* Reg already validated by fixed-partition parser */
+	reg = of_get_property(pp, "reg", &len);
+
+	/* Fixed partition */
+	a_cells = of_n_addr_cells(pp);
+	s_cells = of_n_size_cells(pp);
+
+	prop->name = "reg";
+	prop->length = (a_cells + s_cells) * sizeof(__be32);
+	prop->value = kmemdup(reg, (a_cells + s_cells) * sizeof(__be32),
+			      GFP_KERNEL);
+	new_reg = prop->value;
+	memset(new_reg, 0, a_cells * sizeof(__be32));
+	new_reg[a_cells - 1] = cpu_to_be32(part->offset);
+	if (a_cells > 1)
+		new_reg[0] = cpu_to_be32(part->offset >> 32);
+	of_update_property(pp, prop);
+
+	return 0;
+}
diff --git a/drivers/mtd/parsers/ofpart_airoha.h b/drivers/mtd/parsers/ofpart_airoha.h
new file mode 100644
index 000000000000..3e8a8456c13a
--- /dev/null
+++ b/drivers/mtd/parsers/ofpart_airoha.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __OFPART_AIROHA_H
+#define __OFPART_AIROHA_H
+
+#ifdef CONFIG_MTD_OF_PARTS_AIROHA
+int airoha_partitions_post_parse(struct mtd_info *mtd,
+				 struct mtd_partition *parts,
+				 int nr_parts);
+#else
+static inline int airoha_partitions_post_parse(struct mtd_info *mtd,
+					       struct mtd_partition *parts,
+					       int nr_parts)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/drivers/mtd/parsers/ofpart_core.c b/drivers/mtd/parsers/ofpart_core.c
index e7b8e9d0a910..9e078636d158 100644
--- a/drivers/mtd/parsers/ofpart_core.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
+#include "ofpart_airoha.h"
 #include "ofpart_bcm4908.h"
 #include "ofpart_linksys_ns.h"
 
@@ -23,6 +24,10 @@ struct fixed_partitions_quirks {
 	int (*post_parse)(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts);
 };
 
+static struct fixed_partitions_quirks airoha_partitions_quirks = {
+	.post_parse = airoha_partitions_post_parse,
+};
+
 static struct fixed_partitions_quirks bcm4908_partitions_quirks = {
 	.post_parse = bcm4908_partitions_post_parse,
 };
@@ -192,6 +197,7 @@ static const struct of_device_id parse_ofpart_match_table[] = {
 	/* Generic */
 	{ .compatible = "fixed-partitions" },
 	/* Customized */
+	{ .compatible = "airoha,fixed-partitions", .data = &airoha_partitions_quirks, },
 	{ .compatible = "brcm,bcm4908-partitions", .data = &bcm4908_partitions_quirks, },
 	{ .compatible = "linksys,ns-partitions", .data = &linksys_ns_partitions_quirks, },
 	{},
-- 
2.45.2


