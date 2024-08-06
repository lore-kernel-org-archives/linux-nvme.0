Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED714C52D7C
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=; b=OyPJc3z0qldRAyawUzZ519PolJ
	KIYQWCwUBC1aa6xXZWKKoIT9Uu//iTu/pccHKnh+zTSsEX9nyrcK0/kx+uTjB+61vzOQABWa0JKhC
	xwz5DcuPXSxTmwLk6fqmu+J5Z2hCCZUNJw6a8vtQfKqGXxj0S+yfTh8E1IHkcyCmhzTnluZDjcuwG
	luQjCNcUnrYhRHTt86YmS1DjBwzcqZUuh59QVkBoeklYyn7WOenXeJVloq2W8uvdOcV6Xi7cRArfq
	ZoCbmBE+lqzL3UPg46q2PSeM7v27fRcCqqTkj7klhA+6GpkuUAeyLrVEAC0BPUEAdRv7XsJptvFc7
	4q3JnEqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZM-00000001N9u-18Ge;
	Tue, 06 Aug 2024 11:41:36 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZG-00000001N5Z-0u4D;
	Tue, 06 Aug 2024 11:41:31 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-42809d6e719so4110815e9.3;
        Tue, 06 Aug 2024 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944488; x=1723549288; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=T9X9Hq9cYSUIQl96He+wls/WTMNw9OGH1tdQU8QfT5sn9bY8ODfQvCuP0fwusNqwSj
         ng37RWj6IIkaxUNWANmhPbN5XR8y9WxMCCBfGzc9kF5lbrugRmjusvF1q2waUGG03Zkm
         wkPal94Hj++/YE4IgnJPHeYudP2DFc5cl8nLJkGIf016xv8qvNkeVoe7W3HGiwwupcct
         2ZL7m9ziPIQvDgD4qAoLpK0nfuP+UJoG5932HlipWPB73Vxvfhs1nsNUDNaxJeMTfgJi
         AN99wWqGNEllDFjal4L/xEeHhGnzEbHVxLaPPkcqGxFRM97RQHnK/2wMNT4Mp6AIH7qE
         As9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944488; x=1723549288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=D0Pwcav0TX+YDeY1uEmbd5Jhu3UNXW44GyWIRVuWyA3NvkJDIm8YaqkNAWuQoA8Dxk
         92oeDkkqSOdlodRj2Uso0Cqcl55/wMiL5SuAh6KJVhT31kmJ+PRhGKw5E7cItBFtisi1
         NkeTIoNxKfFCZRNgF91KaG2Wo97xau2NcoX+jwDvHSs4YTKOPUXV/r5kwG5Q52aKfsmT
         L0m1G3FA074Lq13kOycJO8oELYpSQt55qmw1ATzqPclldd7aJrPZUFtkPcJYRc4eENXE
         u5u4p8DUozUK9KF07jaTVyU3zevBSq3K9D4sTr8XqLY5dfDlRYrWbRKVHt1yqAB72lih
         LCIg==
X-Forwarded-Encrypted: i=1; AJvYcCWeggxIgUc52Yr6jSNAtWByGb1slDpk1kTy9VSSvsWgGflr2FNxRwMdkWQUAW2ep0kyeFF6lsPj5EcLwVmU9QSkwAtAmvQTxezrsC/hfKrRffyfAQn6k4tS8Y3tyX7tqEDkx4maaSR2EsZ820nJ
X-Gm-Message-State: AOJu0YwNylpTW3HS8zpTCgBZ7UrRSn9HcTz2ih5VE5VfIwmsmHkLxlRV
	3+ERtuPM0GHNbeiKgKhvJrj+464k05LHBp25WoSsGdS2l1MitOp6
X-Google-Smtp-Source: AGHT+IG9k8L6rRkA1Va2sD8UO032mLhZSWZwsxwXlldLySXDGaw0sRlChwet0LU+bpg2jQOFstrw/Q==
X-Received: by 2002:a05:600c:4f0c:b0:426:6099:6eaa with SMTP id 5b1f17b1804b1-428e6b7c61emr101771725e9.26.1722944488151;
        Tue, 06 Aug 2024 04:41:28 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:27 -0700 (PDT)
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
Subject: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
Date: Tue,  6 Aug 2024 13:41:11 +0200
Message-ID: <20240806114118.17198-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806114118.17198-1-ansuelsmth@gmail.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_044130_270287_750642DC 
X-CRM114-Status: GOOD (  14.85  )
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

Document new nvme-card compatible to permit defining fixed-partition in
DT by the use of the block2mtd module to use block devices as MTD.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/nvme/nvme-card.yaml   | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvme/nvme-card.yaml

diff --git a/Documentation/devicetree/bindings/nvme/nvme-card.yaml b/Documentation/devicetree/bindings/nvme/nvme-card.yaml
new file mode 100644
index 000000000000..20e9a877fac4
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvme/nvme-card.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvme/nvme-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVME Card
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  This documents describes the devicetree bindings for a NVME controller
+  child node describing a nvme-card.
+
+properties:
+  compatible:
+    const: nvme-card
+
+  partitions:
+    $ref: /schemas/mtd/partitions/partitions.yaml
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        bridge@0,0 {
+            reg = <0x00000000 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            nvme@1,0 {
+                compatible = "pci144d,a809";
+
+                reg = <0x00010000 0 0 0 0>;
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                card {
+                    compatible = "nvme-card";
+
+                    partitions {
+                        compatible = "fixed-partitions";
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+
+                        bootloader@0 {
+                          label = "bootloader";
+                          reg = <0x00000000 0x00080000>;
+                        };
+
+                        tclinux@80000 {
+                          label = "tclinux";
+                          reg = <0x00080000 0x02800000>;
+                        };
+
+                        tclinux_slave@2880000 {
+                          label = "tclinux_slave";
+                          reg = <0x02880000 0x02800000>;
+                        };
+
+                        rootfs_data@5080000 {
+                          label = "rootfs_data";
+                          reg = <0x5080000 0x00800000>;
+                        };
+                    };
+                };
+            };
+        };
+    };
-- 
2.45.2


