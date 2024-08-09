Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACE8C52D7D
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=; b=T+cdWVRq1wueGJXUjxa9WCfEBv
	YP1y9BKzIdPPHNXG+hXT5o0fEtv28XvkbFaG7/AV3dJpVqVvELZ9Ms2fFNvgJS1EIyKRMGmO5aOAf
	WMm5YEL6Y4P9yX+tN1Z7fO83OdwiNsem8+zFyeDrC+lhI1BYza2Hxdw3XQQi/pwWyQtsWPqriOkAZ
	b4KkV9KZuFlUtm9KCavqLfMaPWz1E3iEQqYI4+7mqnZc6myKBYkYal4R9PSazLtMzO34fENUHn+lO
	7/kbgvbdVB0P4SnUA5p+q1eiX704H4Dq7PhIrIe3eSoqwJEuAMS/4nJNohsLWZUv3a6JzdftMVwB5
	DnSm214w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYd1-0000000Ci24-1Sis;
	Fri, 09 Aug 2024 23:02:35 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYcv-0000000Ci0F-20Sr;
	Fri, 09 Aug 2024 23:02:33 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso18723845e9.1;
        Fri, 09 Aug 2024 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244548; x=1723849348; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=iH3sAZ7omCW5B6bQGLkWPAicGzkESkNQerxKHT/dPwmH+sQgv0c/H9vHiJkWQf4Noh
         WHHsdMf9aBA/NqraJywnTEGlzxiIwP/7E/qIItD2rv8cktg2/dPL6G0GiUYqiNUbvWlC
         9yTePbCG0L7yPrYkryY8FXFn9plU30wgkh+RkqP5ZhgSUiDwfbbNP2eBzDWR78laOlU2
         9cyFFs+TXkjy/oN3DbvPTGcHhZz7HJ+qHlUs5wz4Wkl/mGrC8wvmw6wMVcTpZ462mfid
         99SxAsIoZCfREEYX+cN4Z0kfVoMgZIMR47VjjqdlzwPcjwl/zGaM797J/Gkd97cIeLhD
         bbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244548; x=1723849348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=Lsy9j7qRc7hdiHqET3tFCi7n31UrqXYAauSQ4+xWcZvw2Y6PCDthf7AwqefWcO9YZL
         jCAclCJC3Am9jega+q3U4jsn662zWyj/1FJLGHXRPHpu0kKHOUOF8ILaQaquXE4ZiB05
         NegRxY4CXXgvnAHUALyGdPpa5c/3lPrK7RYjlHP8TV/+Jr+nQNfuuANCnaepz56ft7BI
         VzFhbhGfPpFnxCj9XGfj9xkRX7ul9Ifj/3B5Cfiwjb5RTGzmvDTaTud+DgtccOyDjHBq
         upQb/PyTjiWOiluNJ38HvXewtCSVF3J9lVGNM4X46sIssQnnWWwKmZWHgCLKWk28lx/O
         MSOg==
X-Forwarded-Encrypted: i=1; AJvYcCVhgOHou2l6BJaQbDeyaqbEw0dooM0djtfFH+8IWEp0kCxAoupIquvCqVudbq74SXC6Ubswsv7CGQL4V8sBJoBN/6S005dkdKIhcTmGtW0zPTXRKhDot/0Bjk3rxjelFgnPWZsh/VFqaa0NI/Ma
X-Gm-Message-State: AOJu0YwfcV79XUT++EvWVilU18oIGuSgB4x2393zFEU6a9bPuP/UsYWW
	m554DUb8hKFgcqDzQc+yYMWZj/L1ccpHBEF9J8FecpXwyFm9Do7K
X-Google-Smtp-Source: AGHT+IHFgbKyEx10eub1CxAs8MOPrz33JkUp9CHrjEA+O5aqKs/q4nCgeahl2FdAWSLxkS0xZ29OAQ==
X-Received: by 2002:a05:600c:568f:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-429c3a52c4cmr21777295e9.28.1723244547725;
        Fri, 09 Aug 2024 16:02:27 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:27 -0700 (PDT)
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
Subject: [PATCH v4 1/7] dt-bindings: nvme: Document nvme-card compatible
Date: Fri,  9 Aug 2024 19:20:59 +0200
Message-ID: <20240809172106.25892-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_160229_524793_104E2C05 
X-CRM114-Status: GOOD (  14.97  )
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


