Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EBCC531DC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=; b=RZ3mwxnslg3pCWgZngYhgJ4AU2
	dHJCt3sO9i5qtd53oQ+6OH4gE6hADBued/LRp1BfUPd3dAaJWUYM1/2jilRRCnrQI5/5ivQQfTnXU
	Ry0eH6wz3AzeIepKLHfRPgWN4X0naqUzI7wRdokTmmSli495DihuBff3R4Tl/Owcn1pr93ddcIImW
	4uJSoboQ+9hPjG6JMFV40OWUa3RiWr5siAAvAHinA1UrrdugilNJYIMtR63aFXuHJZx6uD+NqtI6k
	GIEDoa8zTkvxeUHB0diZO26fLsZ5/xtdjnMSiq1VUn3LevlHd6C4Y15jww2pa+CnUauvGG5TxeM+R
	575PVEwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYd5-0000000Ci4q-2Eq4;
	Fri, 09 Aug 2024 23:02:39 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYcz-0000000Ci17-1Gm4;
	Fri, 09 Aug 2024 23:02:36 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso20614425e9.0;
        Fri, 09 Aug 2024 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244552; x=1723849352; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=KHIaUxqJ7wDUJdgCroF++swHBkUfT8/djy+ZZY3h7jy4t688/XD7rGFof5SzXUiFxE
         vJChGVEhT5wh9feSl0+kjUC4/Fd6FTDyOZuTOZsOAQOh1nihreOShnUzNLYTGQ86dpE2
         2M+yhjfQLfX2KZhcObK+sBHjPE3d5F/VgKJxMLAwU+/DkE8vFgEHh9MoQiKiR1vye19V
         f75tw/MVFovGNgfe8vZeVyIUaN38My7wfB0c6o1/O/mdGHCYoDP34ejDDyXII6tKhVTM
         pc2t3PWJkTbOyqxJUopQ7Z+bBiOD2zAzCwlVRFdQWtf+soHpnhh4MQbGh7lXwO3/fltS
         Z1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244552; x=1723849352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=lu3ERMcVzoMw2nC/Zut6ObSOypWUnWqIZbqW7XAXkYMElp3ZU5RomVfVD10NJXvUi0
         PscF152WU6jCEgH5aVFZQmpZD74I1F57OU6lWXq3bJfrv3hX8NynayEl7lbBG/qT1OiP
         zBo3FvpUOEWnvn/6btlFjzFk9JFuDoE17QTWhPSFsztfxok31inDD60oEQaT2Pcy2fYy
         bKsduE/eDO7nfj4dxy5C4zE7jYO6fek4gLDRTZOVyA8OTQnz2Wjw+B6/Ar8kARjGSsFr
         OxC5FPYsUvmVw6MyNdJqiRuKv07jATfzgXuJDDkohlhqej7cc9/heCztWFnM4cQaSG+L
         g/bA==
X-Forwarded-Encrypted: i=1; AJvYcCW41SxpGz59lKUbGvc0spflC5vu4INPuzLC7n/Ibe9eJGwjW5ErL+gFXCcQvEgnR7zwuajtv11LYXG31NBUIfxZ0AOeyluhNx1r1ZI4v+5WwQhmXopEOsdS1I23TcZRwSfdweQ7rZlbr+ASoLXp
X-Gm-Message-State: AOJu0YyaTW/7RmB9zHVZ2iPCqzIBS7aYe/Z1xVLblIxe9Pj6ALwiVc1g
	CYJeD2/ce3vKyam9MKAbmIoZUt1twbXUf1ykiycgt1Q6t4hoxlqE
X-Google-Smtp-Source: AGHT+IFxZor+5gNGTlA+oAGQcOKniA7tCPtYOXKQQ764BxqhepnN1UfZ1qeLzc7ivDbkqqu6KUpp8w==
X-Received: by 2002:a05:600c:4e8d:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-4290b8dee6dmr56055055e9.17.1723244551486;
        Fri, 09 Aug 2024 16:02:31 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:31 -0700 (PDT)
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
Subject: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions node in mmc-card node
Date: Fri,  9 Aug 2024 19:21:01 +0200
Message-ID: <20240809172106.25892-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_160233_359235_DEA32592 
X-CRM114-Status: GOOD (  12.84  )
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


