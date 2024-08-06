Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75498C52D70
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=; b=w8I72QMR/cHYZ1aONeBQreTCWM
	88TMj/n3gOaPCu5sPyxleLvJVy9B/kTebAJKl/lHpLw9TUML9gibeOLB14GpDyT0FAke3/bmhwzqd
	fDCTLSKFUaMS5id2PSCHH4WJpnysDaYkMLrINOlffnPgi83jVA0dnaiHukxR2tvIE3LOfGVKomJdR
	EN/+DmeVqPCTcVlQTAfgy6NI98uOCoqZpWNlkRyLh7jBlyKNvWU/lApWg26QC0WSovNOTJt2BNg1j
	mG3W2xvKVunHHibbXiTYA+BMmcV8BYA5OF07s2JKALxSX5CqR+wLmBjxRd2G6ajjIIG1ci9Wofy7V
	gAtmJsYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJZJ-00000001Xsz-0Cgm;
	Tue, 06 Aug 2024 12:45:37 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZO-00000001NB2-151z;
	Tue, 06 Aug 2024 11:41:56 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2f149845fbaso6046081fa.3;
        Tue, 06 Aug 2024 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944496; x=1723549296; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=;
        b=OPIQVOzJ9UONSa+/XS5n8+vTVYgqIkr24xXgrZ6aVhu3PjeP0xWikzY+Ym87kt+KEq
         y4G0es/dVIrwX07OmPVoK+dtnvgzhF4I4Z47WLVCyAbepz2zq2brafKiPhV1CLhMiawI
         +xF5xCNMBH3Usm/49CgVnCtnlEgIc0Zn9TKb+d+uxqKhuzNkmVzOSOYVS9J9ZiQS8k3c
         D0H4QejQ6Lrkzy7UAA5YFl/A++8/qoBWXxI/PYwGn2spjuRZ+dmBR+IQFGLrKKoi+7kT
         faNsH/poozO0jfjK/Y7Akp9x0ZlBLy05JSSzzwDpY/Vb15t2JR2CJXr19jnPRuJaYyQY
         DOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944496; x=1723549296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=;
        b=dnPnf1qq8d2jjFx1E5YQ+3G3FI+Z9+Ij0R3CUlQAQ9lCAvSPizGLJJRmKUeM05ng68
         O3TH5IlG0MMtD363UvQ/t0hz0N7BJpr4lovORe1dgl20N0XDYhwmh6DuD5cPrYV+An3i
         i5akqMUEZ/y5x2J6nfAcMCSETxy/rAnPR4+sU9kAj0NQJvqojgNkLUXLZh55xlp+fL/u
         6Pu0KdVHRW8AWvAen9DchubHYJsZp30gNMoZZ4zNw9MWE8D00hfwTlxrFcCtfv35UDUt
         xWQoWHSr6HukKK9Y30CxPiGpm2BvxOeANziJigpmqDoJWwcfOfaotFMF0gbPNLHZCf+K
         E7xA==
X-Forwarded-Encrypted: i=1; AJvYcCV4yB59DGynJnz1c6g/ebO3XwjXbo4nj4OInDOl0+0yv8pAmZhv0wtTE+dx74szg+0WWDOR5C7lVdwOqtxckCuK98sN8MNfiT7t3S3Zm4sTTZoPzMa6p9DYHkUCUIQCPAdrfK5XzKWLW/9PA+nu
X-Gm-Message-State: AOJu0YzeUaeOivbqWJT3Gc0xNaVJdYPKfjM91Fg6lwZvcOCGstlZZozm
	lu11gRatJVZpn0FtijpvOmGy6Bii35TUGgh38npFOAtJj1hiiQN+
X-Google-Smtp-Source: AGHT+IGEw7FbfFGV4bGUwud7W+/31hW0KginGDZdKiOUFG09QuHWu6Nsg6YcjdixER72oYD5wUIGqQ==
X-Received: by 2002:a2e:999a:0:b0:2ef:2f19:a8b3 with SMTP id 38308e7fff4ca-2f15ab049f2mr102072831fa.41.1722944495774;
        Tue, 06 Aug 2024 04:41:35 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:35 -0700 (PDT)
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
Subject: [PATCH v3 5/6] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Tue,  6 Aug 2024 13:41:15 +0200
Message-ID: <20240806114118.17198-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806114118.17198-1-ansuelsmth@gmail.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_044138_395429_C79219E0 
X-CRM114-Status: GOOD (  18.50  )
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
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 2 files changed, 81 insertions(+)
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
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..ec254e03adf0 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -14,6 +14,7 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
 oneOf:
+  - $ref: airoha,fixed-partitions.yaml
   - $ref: arm,arm-firmware-suite.yaml
   - $ref: brcm,bcm4908-partitions.yaml
   - $ref: brcm,bcm947xx-cfe-partitions.yaml
-- 
2.45.2


