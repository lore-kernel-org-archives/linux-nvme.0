Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4133C3DA64
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGKaaQieag+Q14DTix3aGJa4i3xg34VJO5/0gIeYwCA=; b=TqkSWyKqaJmYFCBTGxPQV896iK
	JwQ6GxekwBJyMEtfKm3onopt8ueabhr4VzkwY8s+j01J6McoigKovdJX1rRtwfQEuqLxFFWFaBNkn
	0RgJA+coz5nDqEfc5G/9pWj+21JKjdIuin9Emvni1Kw70S4oecQko+wzjrKE0/tA5HmkYB3iE6tp/
	7aDsFztPu5j1OuDwB+Mor77rWLdshlhprRzgpsMZdFF4a7I4Pnip7ZdzjsU/a/8IbTcJX1tStcbR0
	vN8HEFp2/3p5c+tjynHuMpNOD657EhD0se1AFAsRMw38bS7/z7x8HaUeBnt5MFyhDkfBpPfXWJ3C4
	eyN9p6xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZd2-0000000DAsz-3zqI;
	Sun, 04 Aug 2024 11:42:25 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZcq-0000000DAg9-2aVT;
	Sun, 04 Aug 2024 11:42:15 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3684e8220f9so2569122f8f.1;
        Sun, 04 Aug 2024 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771731; x=1723376531; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGKaaQieag+Q14DTix3aGJa4i3xg34VJO5/0gIeYwCA=;
        b=VyplsHhZV6iqYuC2ysGYrVEbnQFzv03KADhgO3q4N/xFR8LWUeRWd4QKSktqMPWdh8
         p5ILXZoNIDDFGRYgAvXgvpqZUVD/VMLa8cd/jhYANm3UsPrixCoVpupYSEp44/KIwXUI
         57+TWYheRbNsXQKkOYxqeO2UhtW2luXsqSJ+rUxjwDPm4CAaA2MpUOiQnnTZ3/9guca3
         8vQq+iC3jpiJZXeGI81RyWkkfQmhcsB+dxzEMKPWC8ALPMZoUjd8E6A0l75yQI0gAfnB
         aFZ9eWMsPALqhUDrNc653OZx1jh6iE3UL4TZiciqJGRASAUL2WyB5/IPCyZjw1LgGgyn
         ZKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771731; x=1723376531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGKaaQieag+Q14DTix3aGJa4i3xg34VJO5/0gIeYwCA=;
        b=uH2jYxbTx1A1hRjRiq/m9H5Dl/mKQtyndgaYo7aPj3ntPYr/vz/xrQwITldHlCNo8D
         PwSDOG71XumhF8zRBuEvFzkXQIr7Tv42vvPZjaYUrkUnsUzPwvq8kD0/7grhZEuYrueC
         nFO7b+pcwrSIWKyZSVwL8iny8lUd+K6Ki4yksP1W5vJYf/8OJfogixeBBRWl47l0rr3Q
         bVMpBPCer04ox8AjRqDS5apjVNQa8yw3bfa+ZSwvyrQ9adnSdsihfgzw1gjakrG02ZmX
         Fgd10WzRw/90mBJXGCFOBevo9uzBhId5lRiAhrBMYCLtBAZQP90Au0Px2zQg0T83FIMm
         UBDw==
X-Forwarded-Encrypted: i=1; AJvYcCWLqevbms5X420cEPrPAR5E/8etgP6qVcFnaK/YJP/xkesed8Af4evrm/60EIGyBPZASGUm7CUEIxOHmISewHzPjw0IiQihnbHh8db64hIhVmLRpORZBFRkwZgP2RLCzDMH+JfYCu5+q+rfhF/A
X-Gm-Message-State: AOJu0Yy9ogUjuvbe5kT5KX71oP1oUF0R+PfPeegVXZOCVIZBnKRi/rzf
	MJczJlMle825yw5cKLIBvE9AjlsdPQ/07tonVropJI1wGD+Rkt1z
X-Google-Smtp-Source: AGHT+IFLHuekhjS3wn/gQuthegTYTE1hpUglR72MMyu4qD76bmaYcfmhvlzvI4IbB+867YnyApqvfQ==
X-Received: by 2002:a5d:59a2:0:b0:366:ee84:6a77 with SMTP id ffacd0b85a97d-36bb358463cmr8743186f8f.3.1722771730142;
        Sun, 04 Aug 2024 04:42:10 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:42:09 -0700 (PDT)
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
Subject: [PATCH 5/6] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Sun,  4 Aug 2024 13:41:05 +0200
Message-ID: <20240804114108.1893-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804114108.1893-1-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_044213_171877_5E417588 
X-CRM114-Status: GOOD (  17.09  )
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
index 000000000000..da7879c98317
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
+    const: airoha,fixed-partition
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


