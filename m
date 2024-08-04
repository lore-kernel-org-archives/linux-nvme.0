Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E28DC3DA7F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fvAc4YhKm/u3S+4O+Aw+vXQgk5wKoMLQshnx93IPvPo=; b=z+G6+Be5mldZHWFeZVYuc8q2XA
	uIOjcOv/L0okjJ+ro49nJfc8HgehAkU+PCEpRNMui4L5tgO9lquwIFN+PBpZA1Wy22Wioq3vkD2J4
	TwVsYf+TKZkYp7hc1nOZDGzBR1+0HdxgH++yF19HKEvGFZhUd4FkcBe+9+rTo/yLh/hh55JITs9CV
	MX+v2TGtDLXXpyymWhTDpk0DPfR1kWyY7rhIsiwBiyNOVvYeUepmrH3uQ19BR8aB12Oe3jskwkKJm
	YLh5utingCg5PmAfXU5ldQLm7lDkZLx4ECT7RaMPYoRB2EUk2OfuPLJ5DHXeCfSuMGx3Kx4BHURds
	7zceCa5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHj-0000000Dh4s-20dh;
	Sun, 04 Aug 2024 17:44:47 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHe-0000000Dgz9-1AKJ;
	Sun, 04 Aug 2024 17:44:44 +0000
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so120107901fa.1;
        Sun, 04 Aug 2024 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793480; x=1723398280; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvAc4YhKm/u3S+4O+Aw+vXQgk5wKoMLQshnx93IPvPo=;
        b=jFXLepCnzM4leVp4kEZ5jyfrX4fc7UtwR1RkhPXOq7Oeeq4oEpqeCnnaRZhTESN5wW
         WqVnDcl8YolUIFM/gI8rBRk9pxo4gj1kuYoASw3cfvM2cRWIn8uK04GvBCZmONQQyQy+
         PyyhyNzm3DseBrdJ38zDDNLq7D4RkYzVRGgKPr5PMQVIxJd+LkBlDDTVi0KomZ9QDAUH
         7cUq35gjpY2XbhVoxldqHuNk86IpABl0sChzoHvb7BadVbiYI1nwETyxhFBi/thO6UVq
         xsz2CX/Xh5CYcpMjKznQvPLzZ48zA5MAh008Rd9phIfPDp4kqfKVNBIbaP77IO/be2H0
         PbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793480; x=1723398280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvAc4YhKm/u3S+4O+Aw+vXQgk5wKoMLQshnx93IPvPo=;
        b=ZEsIRxTCx/R5gb7omEL85JPqCCFddj/pKy1ja44WMldm1RW8ek/RI2V9fSS2kE2jGM
         m2vxV3eohf08fzUXc+Lpytpyau9SeqwQyg8eP5eQxPZ6iVhAHLe6R69mSGXu4XtXgoxD
         yDhrvTqiFzQMhILbQHq4t7wK00KxmPI9bTJD2xBsia/gy9WM8KhYAkkfRdS4MTQHgOPH
         WVwUuG6XFY6CSEl478vc6RFf+bCNHTYTmAsWYwm7RYwWqSZqPf1nc2ugacWrDHEDpU1r
         qSKvHkKy8oCvHcavy276X9833iQ2qJ3dUAq6qAbwOhJ7lrM4LIsfhDVTHcFP8OyX47MM
         V8xA==
X-Forwarded-Encrypted: i=1; AJvYcCXMTkuJ7IroiH+0gAAXaK9ch5tiuRsayd4/1j7LhSiuA1ZemzI+fg9QpVjOANBAkktRYg5iLL/5b+BKb0Zo8RlkTronP8a1c4pbaU6+wxvJQ9D1QNNdLKhdnIaE4U5Zpz+3YbHW4fer6bweKw0H
X-Gm-Message-State: AOJu0YysTckWT5yqsie03GZtYBtw2kajl026NzwxjBd3M/7dMFZ4/7D9
	DMOyEFMELqIMpJ1ta2nqf/QzzM3yAAB/gUd0aIiqJY/ZQcuW9w/n
X-Google-Smtp-Source: AGHT+IFU8AJjmTAyV92JRJYtOdqk61Rt6Gt62ZAN8oIR6M3nrfeJsTuXcuqLW4SL5nh2FbVIg6bieg==
X-Received: by 2002:a2e:9794:0:b0:2ef:284e:1d07 with SMTP id 38308e7fff4ca-2f15aa97d16mr69060581fa.13.1722793479648;
        Sun, 04 Aug 2024 10:44:39 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:39 -0700 (PDT)
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
Subject: [PATCH v2 5/6] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Sun,  4 Aug 2024 19:44:09 +0200
Message-ID: <20240804174414.18171-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804174414.18171-1-ansuelsmth@gmail.com>
References: <20240804174414.18171-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_104442_365932_31F1D2DE 
X-CRM114-Status: GOOD (  17.02  )
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

Add Documentation for Airoha fixed-partitions compatibles.

Airoha based SoC declare a dedicated partition at the end of the flash to
store calibration and device specific data, in addition to fixed
partitions.
The offset of this special partition is not well defined as it depends on
flash bad block management that might require reserving additional space
at the end of the flash.

This binding allows defining all fixed partitions and marking the last one
to detect the correct offset.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
new file mode 100644
index 000000000000..8d7221561f51
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha SoC partitioning
+
+description: |
+  Airoha based SoC declare a dedicated partition at the end of the flash to
+  store calibration and device specific data, in addition to fixed partitions.
+  The offset of this special partition is not well defined as it depends on
+  flash bad block management that might require reserving additional space at the
+  end of the flash.
+
+  This binding allows defining all fixed partitions and marking the last one to
+  detect the correct offset.
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+select: false
+
+properties:
+  compatible:
+    const: airoha,fixed-partitions
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+patternProperties:
+  "^partition@[0-9a-f]+$":
+    $ref: partition.yaml#
+    properties:
+      compatible:
+        const: airoha,dynamic-art
+    unevaluatedProperties: false
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "airoha,fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+          label = "bootloader";
+          reg = <0x00000000 0x00080000>;
+        };
+
+        partition@80000 {
+          label = "tclinux";
+          reg = <0x00080000 0x02800000>;
+        };
+
+        partition@2880000 {
+          label = "tclinux_slave";
+          reg = <0x02880000 0x02800000>;
+        };
+
+        partition@5080000 {
+          label = "rootfs_data";
+          reg = <0x5080000 0x00800000>;
+        };
+
+        partition@ffffffff {
+          compatible = "airoha,dynamic-art";
+          label = "art";
+          reg = <0xffffffff 0x00300000>;
+        };
+    };
-- 
2.45.2


