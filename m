Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72973C52D6D
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=; b=WT16LgsS+lEpfVMcwHRr5oX656
	QuoP8VYjn0W1qr7Y1LYJ3IwbiBVfIdOpyH9ZNyN389OBMEopbt1BGlOTyjWlppSpKUtc3cV/s3Ozm
	S3RFL7ihmvEwbOuh7JjphVCtEwaQX2Tg7oBPSgzEOmEGl32mg4qxOLoI+thANZPnVoBloRdSFSulG
	3UhGNDEKewW1R5mb/o4ojN4+Olsp5xOXehS6HCCT0uAvhqxbCLpODjrFLhhAfBHRBND6uTqXJ1XEu
	WXRd0R/RheQLhVdSe4XoHSnPejKOJOSvCYxVjdcZLAw7m+ijhu3/N/63T2U4xtbXSWEJt010+Afnz
	VmemVSyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHX-0000000DgvN-20kA;
	Sun, 04 Aug 2024 17:44:35 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHU-0000000Dgtw-1sum;
	Sun, 04 Aug 2024 17:44:33 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-368313809a4so2763383f8f.0;
        Sun, 04 Aug 2024 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793470; x=1723398270; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=g11TvcJtEdjUDt2DaViK0o8i4sVPz+L9lfvDJJOWPDOpMPaWf164kGSOezIoZ4ASS3
         5fhhtHHh8c41NJWkNsEvElTdN3SbQkBySerqv/E0NJcimoTLvy1NC1um1XHEL00zC1Yj
         lUtBdDYzX6XruAzvWHfBtarWPWfWLyGt118SOQjtfq+XZfa21G/qGT5j97OzRccgyjwz
         yVCXZ/THYQVgrMo2TlNO7r2BSAPssYQhZ9BkD1nfcUGNGM7rp7RTWfPEaB4sCsn19VUJ
         eMDl7FsfE3PorAOj6G03AbFFy8jC42Oa1OtzsE2wyPX0djhBF13DJvGb0cWFS5AuQO6W
         3V6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793470; x=1723398270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=U/aHKGDXUXR10JO6ypzHxFJuvVB1ahqHWcPgBSeLxmrFN7V6BxwQWm4JRQgluO2rjF
         YjZO+fRfiqsMiFO/j3PugUPHKvUrPaKjRhlmJbE0ZEV12zv4W4Nib+9xrHibX4DHIX17
         22CjVWiT2WkI+o4f47kF3+UComS+d7IpZaLuaRDzi/9o55Zfu0R7YAkWXxT9DXYE5WGo
         16mPfvontsyDYALxzn0sxRL/N/LXXCuXdxBVucskb0y5jljHY3rE4l9OZk2l1/DrhVIN
         /xKmWeMJbEZa1yqpECr9spftkDBEUkd7LmnK3lZmpWxefehE3VsSjJBfM2wY3pWK8yzK
         4Bzw==
X-Forwarded-Encrypted: i=1; AJvYcCUaKueC6NVF0corPexcjfEfprgFSKIFewsFS/n3LB2IS394uQow5sw/dpl4lfj5Lx5qgReXQQ9hEsrTk2kud1eLvOjdplGEi4FQmzzo/PLsLzdjf3xyUahdjJnDQ2JbbkoKExhhUkimdHu0oObB
X-Gm-Message-State: AOJu0YzAjA47Zu7t4aFart13AcyY9FInrJRnQubQebJaMaFrl2/lmH8k
	xJ36zm4WZzXofFzuADdPYizl03Uit1rnNyqjVNNhAmMx63vp594g
X-Google-Smtp-Source: AGHT+IEmGipmy6C03p1fUHWreExFigGkvjGoxjZh2tkYrSz+71MUHqO1UlAfqWKZFbKWjp32T3vinQ==
X-Received: by 2002:a05:6000:b50:b0:367:938f:550 with SMTP id ffacd0b85a97d-36bb35de344mr8566122f8f.25.1722793470174;
        Sun, 04 Aug 2024 10:44:30 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:29 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dt-bindings: nvme: Document nvme-card compatible
Date: Sun,  4 Aug 2024 19:44:05 +0200
Message-ID: <20240804174414.18171-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804174414.18171-1-ansuelsmth@gmail.com>
References: <20240804174414.18171-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_104432_497642_7C8F4538 
X-CRM114-Status: GOOD (  14.78  )
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


