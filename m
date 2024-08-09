Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32624C52D7D
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 23:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8UY9azmTjhPunDkBNM5W4aID9KMi7XRKzM/JmHz9bA=; b=IWqtI/IIF2NiGoKf7H9iNVu7Io
	OW2CcSwe9rlOwcjbkS9zcIFzrPhijpcrRS6ewKWs24t560yDqe4DiqoCpvBcpyvrGSCflCwhixcwW
	0/N4b2fUpm+eUAUJL03ANvkIHbjODpYqwSe0BBFhU2YtLOw2HfMgGtVLLKZodif/k7uDTFc1joHlD
	plbj6jXoQEDEXXuuwEofP982weWTHBo41/e1G59UWnXwzYApg4vXE7/WZ1p8L7f+AsAq2D/kzcEkg
	q7OOT6bU6v6gMU7au8PpNYh/hya2yqYJZ8xAw982RPX2hhfg99i+ieerCHHsLEx7Ha6lgr//djrak
	W6nR9LQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYdU-0000000CiS5-12h9;
	Fri, 09 Aug 2024 23:03:04 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYd8-0000000Ci5L-0BnU;
	Fri, 09 Aug 2024 23:02:46 +0000
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso27721221fa.2;
        Fri, 09 Aug 2024 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244559; x=1723849359; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8UY9azmTjhPunDkBNM5W4aID9KMi7XRKzM/JmHz9bA=;
        b=dRKCjkkULHGdm1xpd2HJufrPWnZs7OVgj6DlaMnx6RD/hCaUqdNp7Te/81pAWprfOo
         IWYe9rEq0MCs6jMoq1nCqoAJlAOpOOr2URtcKTn3iv0Xz4wy7AVg+02o9rvubOFodjWV
         WGFHlLnoYQALi4DUKHg08E0xasHkf6iTmwbtDEPYwwFDO4/cRkCctb5RSbV1mvM4Zn77
         DTkBLtIqKC/4DAFf1h0UIo6ssVRuPO8GjmnEcqeOo6ltURsKKFsujDGN5WB1Mv4UZ6kK
         99DxxW5Tq19++IY4BCQgbwoNX/k5ACFh4Rb+vFaiRwySDlAcsxxXuK3yqnubmI01X5ES
         PcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244559; x=1723849359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8UY9azmTjhPunDkBNM5W4aID9KMi7XRKzM/JmHz9bA=;
        b=Kg9WAWQt//qXWVfMS5KuzDejxFIoJPrrqL6xcX8G0LYQbTbsB0q0p0muWZsvWgrA+J
         NHWfw1HYUoJlJexlfr2T9p2m9Qc4Yb1q4t1TjqMtrow1Up3y6wfVgL+ZSOH8CZBmaX0x
         voEvxIfmpnb3+A7jthRZ1/eED/mdFv00WIfIM6pvl6YZDQTs76R95m5sYyeI9VOhOZ8r
         KmlAho32BDmgoJsJIbgGIImekcJ9P701kX7xdUCuEdhMRMveOTZ9C4RpM+hFFNhwXpkg
         qE1rP+TZ0V9V7SQFabXNnhF6YUnXjZ3SuE1Qw+WW3La98VG1gOJMT5tYL3HZypTQpYdz
         5Igg==
X-Forwarded-Encrypted: i=1; AJvYcCUOM4i8OAHcT6ogAwi7y4GKJNhHtR1k+Lev3cFW9vxHpxn4yJNLYxauWGmDU/Am1WgsnWQ+pEBEDxM64K95/iayTOHzslQUabjlR8wZPGcoURO7dPDqG4hjL+pV+LvBP0s9t9c70tOEU08o7EQQ
X-Gm-Message-State: AOJu0YyCSoDO3DK+DNwoI16fuoOwKTDV6EKNiSMkH+gjTrtnvIEQIHW8
	85/ENfxtWyqiuYy68SAY7DJYWKhv9pbOZpQKxvTycJK4yTY9uoZv
X-Google-Smtp-Source: AGHT+IEBf39cMvZ+atF9aIQP/rIJt8VoQT1fN0vWpYzEGZAa9wO0kPgv+u0z6JAoBudts8qWd6j9rA==
X-Received: by 2002:a2e:a411:0:b0:2ef:2e1c:79ae with SMTP id 38308e7fff4ca-2f1a6c5add1mr22344811fa.19.1723244558978;
        Fri, 09 Aug 2024 16:02:38 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:38 -0700 (PDT)
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
Subject: [PATCH v4 7/7] mtd: parser: add support for Airoha parser
Date: Fri,  9 Aug 2024 19:21:05 +0200
Message-ID: <20240809172106.25892-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_160242_132161_368DB624 
X-CRM114-Status: GOOD (  31.17  )
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
 drivers/mtd/parsers/Kconfig         | 10 +++++
 drivers/mtd/parsers/Makefile        |  1 +
 drivers/mtd/parsers/ofpart_airoha.c | 57 +++++++++++++++++++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h | 18 +++++++++
 drivers/mtd/parsers/ofpart_core.c   |  6 +++
 5 files changed, 92 insertions(+)
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
index 000000000000..5e2cc7b6376b
--- /dev/null
+++ b/drivers/mtd/parsers/ofpart_airoha.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/slab.h>
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


