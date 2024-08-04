Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B7EC3DA7F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=; b=VVqRGIpHBysHts2UXSgIdcdkX/
	PnMASm0bvYMgAORAb+LO8Cqk4jQHBGd/nBhEFbi5QDy6l6W4tNdG2W9uy6T1nEu95bmkSMshm5xQs
	mR4WuCf2dtUaL0nfXjBAj+kSnbUDcykHkxBQVxXROPgB+J+5l+D6traIqxjsK9AsJGJU4lSzk8php
	K264frkhv0m968aCPN020my4847zCXjSlQ/ZUAKeIWdWAU/fgoqQJWX3fN9F9Q5YzKtFf0SeLZur7
	waKeRdtnLGeURI/XFLV/8q9YE1nXWKc2TCZ3pbomFHt0rlHuvKBzEavhz4SDJaChkBI/h1jJd9ScV
	2PJ0I73g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHc-0000000DgyP-1KUP;
	Sun, 04 Aug 2024 17:44:40 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHY-0000000DgvW-39Px;
	Sun, 04 Aug 2024 17:44:38 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-42812945633so68224705e9.0;
        Sun, 04 Aug 2024 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793475; x=1723398275; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=Y7gkkzaOzvTApkhkTq+6YytY60Zkn1Mq4XJo2Oj2HIdQzHWFvWqjahFt6AT0GnfKnn
         bbVcxSPiYl4LNWJVEJo4zU0KKJ/wfdFGFIm40gD79I4mVSM2pJqeRxh04otqIIkhxYGW
         7n21C0WMkJGCHdCAodHxkfJIkjJWLP+rYqKTccdQjUr3i4eDSuRSfAxuo2AqHg/imvuw
         grVXAjKcFwThs6TV5dWgR8b9KhBOxmW7cpBxnHwy+0XmmocT9X0fIu6nC0o+20aFPj9G
         WPIX5UXfn491xqMd1qQbSElxNZ7IFttKTrvO+YQmoEodbmkp+ZmZCEYICl3K3EuCImRE
         99BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793475; x=1723398275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=hwNAOqpnUpFmiL1F81MIoI4CzWbvjmnj0jEFI9VlcWsZ/hlOJjgXDfwneUPtOgE5nC
         lAuvVQ6oBlcOFkKAL5/KnEJsUdHKF2MzEqp45i3ICwnDAJCPlaWPSMdOG4E1V0zX9BUu
         XW4pvHhAlOUaNVnc8/njjjVecAGoHCjDdNpovB535Ax6TqrUgci2T4NdZkbUpSkcavJV
         GW+rW9GMqAXCQUN2Zc87I0W8wi72J9iD0xPwTMNyRhT5oo/j1ExabRN+qeXQtLaf+n4s
         IFcW1rvCKLOTVYVrzhc2oVIttpV4B0aCX1j+gucMgH+q5FrK43aK4chsTF1mOX+lKNUj
         XdAA==
X-Forwarded-Encrypted: i=1; AJvYcCXurwKD2uoTPGsrMbODwAifew9fsWkU0gGTg+t73/FiLs1OHiyLCXt0UCjF6Juf41MKUzk3G/i3BXCbzlqjXbj4SXKsGMfqRg7lpg1GctxVAx4+W5zdmza92VtB9FtZJuXRc7Y/SL6EurVpOztX
X-Gm-Message-State: AOJu0Yw8tyXD8aHokAWkD9qNdpHhFkciGxuR/07SugAvAqfXXEEb264i
	cqwo2PUNAnCz8w8BBHpE+s4/SkRLXm7HW/wu45QLrsgDiDfsgi+y
X-Google-Smtp-Source: AGHT+IFN8eD9eeHRek82k2yYE+fWbJDyGcXBovLeKVHyNRAcWSy58vdincZxAdx4fAZXLwmahnfYCg==
X-Received: by 2002:a05:600c:3acc:b0:426:5f7d:addc with SMTP id 5b1f17b1804b1-428e6b8380dmr57122375e9.37.1722793474565;
        Sun, 04 Aug 2024 10:44:34 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:34 -0700 (PDT)
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
Subject: [PATCH v2 3/6] dt-bindings: mmc: add property for partitions node in mmc-card node
Date: Sun,  4 Aug 2024 19:44:07 +0200
Message-ID: <20240804174414.18171-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804174414.18171-1-ansuelsmth@gmail.com>
References: <20240804174414.18171-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_104436_798307_9DD4B062 
X-CRM114-Status: GOOD (  12.37  )
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

Add property for defining partitions node in mmc-card node to define
partitions in DT by the use of the block2mtd module to use block
devices as MTD.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index fd347126449a..0f32d24417bc 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -26,6 +26,9 @@ properties:
       Use this to indicate that the mmc-card has a broken hpi
       implementation, and that hpi should not be used.
 
+  partitions:
+    $ref: /schemas/mtd/partitions/partitions.yaml
+
 required:
   - compatible
   - reg
@@ -45,4 +48,41 @@ examples:
         };
     };
 
+    mmc1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        card@0 {
+            compatible = "mmc-card";
+            reg = <0>;
+            broken-hpi;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                bootloader@0 {
+                  label = "bootloader";
+                  reg = <0x00000000 0x00080000>;
+                };
+
+                tclinux@80000 {
+                  label = "tclinux";
+                  reg = <0x00080000 0x02800000>;
+                };
+
+                tclinux_slave@2880000 {
+                  label = "tclinux_slave";
+                  reg = <0x02880000 0x02800000>;
+                };
+
+                rootfs_data@5080000 {
+                  label = "rootfs_data";
+                  reg = <0x5080000 0x00800000>;
+                };
+            };
+        };
+    };
+
 ...
-- 
2.45.2


