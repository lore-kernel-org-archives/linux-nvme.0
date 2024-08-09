Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AD9C531DA
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 23:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=; b=YRyCrChQXR91bu95WuCBHRZf0b
	+HnVcQq0764XCagi4MUdQByMJn+OEYvfEWm86FLFwYg2CoTuWOtrVARB5EFfMcfcsAjeFFzEwnZ9M
	QQ1p2Zmf0uUZVK3o2WCzIov3spwG5TpfSjZcquNecRelfc34nutXcF6zPg11fdHAf1duATjjzz/u1
	3WaVt9fvOMW3Nuro6MNMv6Xe6ecAcFMb/jFW/DBBToFdFFIyapAtrcu/pd0ZhjYdYpaUUxwsVarAr
	68/QkXz6M5BRssKXfT4EcZTp8AP2I7KzTicURh2ZJQRmGwAozjKUmxjUBsW85OPLCqhAXwEUTFN08
	m/IVJGKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYdE-0000000CiCZ-3me1;
	Fri, 09 Aug 2024 23:02:48 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYd5-0000000Ci3O-45Za;
	Fri, 09 Aug 2024 23:02:43 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so14781185e9.1;
        Fri, 09 Aug 2024 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244557; x=1723849357; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=;
        b=SKGgeOMF4oHNJ8MzClKdm20RQiFGbbN3G41EwJ40NDEWwXMHmHhnDPY4FyFKlHHw2C
         U2Oqf0iH4GtvKXofg3R44R67aUaGL5c5aqASyTQJkqXIcgrGBs5KoUVwfoCnsGRLnIFy
         cDlnt3cICJy5NSHFoPyfG+WaxyprFb/GvGVAymuJLSdH8mN70feCp4DotbJF0ifvaxoK
         asxSzA2twiRHZEv6Mj/PLgMWzGGoQz+TlAEPmuRCZWNRJ7n4mEQEfa35IzhN3u0TYgwf
         QZTapmnBIH1WaGEuEKIJElSfpaOw/56g+7t9uwRAz6nuPppELhXvtXtf+zLnXLD70hfY
         ZUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244557; x=1723849357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xBEuESArl0fBfjXYsEhDBEbTfGt9gI5ouD6sU73/GU=;
        b=LzDQJ+R3Uh2tyEv4MrbUZWazqoI7bZMgTrQa1eFGZQ0v6X/k7ODOSxz6r9O16iN9w2
         FonCj0db79drM9F6g71B4E9Z8EMgKQiG9cYccG1ZKKUwVQvFOjux+so/H9CgL0Do/v1b
         IZe7jYNldgohZufGi8YSJM6DWnwbM1wXZ9Z9wcROFAwqNlU49oJK5JLAkh2HJMHa8j5f
         xcj/GrraZprGmUGvCoT8MOFlkrAVhEr4X9FBT/1lXhmejqgY64dPpkW9i2EDpS+k7NSA
         jJhEB8ETZXmx2YlhNlanDLR2+ZnvDLKeqBclP4kQqWawqYJOKoR60BFU3k60X5uR8S1G
         +mOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR5PO2g7tlZV8f5IcXJsjslKuPgBZ2zvZVtzztclPSMWj/uKijV0q+J/gIqlfDenpYGHLDW10A7cHHseCq7uIwCALlJoWiFY3SAfhARZ6O4mAOoV2Hb9ErgZofrCWWsRVUEV82vkejp005D1Nb
X-Gm-Message-State: AOJu0YwwhBBsRZlTTZ+cUREkBjjwewQa7xeDfRVR5GZroZfXOVBRQrq+
	dMr5XMB9IdSKLQMTVFsCIgDpfxRgDLKBG3VdQ6rDQFxwfyBqBp4L
X-Google-Smtp-Source: AGHT+IFaIZzfJMZGEZqQdwrs5TglTqfV4r7biRyhTVd339hoMEUvKuDwHH0rtXy2N3qYTRaD/OaGZA==
X-Received: by 2002:a05:600c:1394:b0:428:9c0:2ad with SMTP id 5b1f17b1804b1-4290b8deddbmr49137295e9.18.1723244557103;
        Fri, 09 Aug 2024 16:02:37 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:36 -0700 (PDT)
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
Subject: [PATCH v4 6/7] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Fri,  9 Aug 2024 19:21:04 +0200
Message-ID: <20240809172106.25892-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_160240_084912_DE2FB246 
X-CRM114-Status: GOOD (  18.52  )
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


