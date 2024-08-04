Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A7C3DA64
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=; b=umsMJNGVStAm8LMwO/kkOkSO5/
	7E82TvmyNB8SVGljkFy/k0OxXyveIuu6yUCrxFZNJaakDWu6TEGAgKWg6jjoP/qlfjIPIi95Ug9Oh
	/RfJlhZKQcrq9vZmdrElZgYh9lcWqV+XkUBGfh+zsm24uSAtGUElI6UZxms5jTOx0HTyjapl7Odjl
	nnRiLJo2WVTHjfEj7t6+6PF+S/bxRrh2ogr8C3OWg9hZp8dwgWOYC6zNtCgoP7I8yZY0Wr/cvykC6
	wPQX+3JPuk2fWR9lW3/rYMyMCrldy+SDJ/TWqvAFWADmiJ+PF/8MgGUkxSJGaJfPuDkNAmk0zzWkF
	wMgROLLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZcm-0000000DAda-0MkG;
	Sun, 04 Aug 2024 11:42:08 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZch-0000000DAZG-2Ilz;
	Sun, 04 Aug 2024 11:42:05 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3687fb526b9so4893053f8f.0;
        Sun, 04 Aug 2024 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771722; x=1723376522; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=X1sALkUGMwTwySy5w6q6McVqYlkUEtNXILm674jFdvYWvjp1c3CoERZZELxtAI9A92
         iURUIDf8epdzctlE/5HrhsSZo+mxGdVmLUSJJC0CPg1prlpiENzj/yegheSe0XNgCf8j
         PuvA0cu39zRr1/RzFDdFjZqC1wh/gd9vK7NURX65Ih1Ovte3vXBNgiCSwImmfq86R6ts
         DCzYXPOWeOvQj3SbvqYGkAJ9Pbbmlb+hk7ShPTQEohswgqESFsD0akToFU5OeRQu3m8T
         +z/aAj73RInd22AIWYWewnoXcXY5AIxJaB8CZ56CkBZDC6se7uBdoDMBMR1ZLFDCyb6s
         feFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771722; x=1723376522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=DKQgrE+iQO2KKxrB5FQgJuExqBXnNbl5uraOhBpBdCXKeUTUwLFxA1gEN92oxexUMp
         UObjL5kB5xKGVmdYpJyVVhE1aTfn0jh9nfYdc2oq3CdlWU0IvyO9tac0FRJrn4SeM9nB
         K4iBNh07pmwkHHCIhsoo0eFBAGpReEL+ofasfigGAgen3vPdYDE/w7nTBouy0jimTjfc
         YmrdZPT0hLgM/HXkkJeBVBJ65uLMR7MmLfgFw71bv/NxWbgPjArBwsZZ5hyk6hXA4fce
         bGspniiNHYX0w6kV2wzlz2eZEKEgb4KWn57M38RlIiysuL2fTZmrX3gD/L/Hz0XAXeWf
         Ai+w==
X-Forwarded-Encrypted: i=1; AJvYcCWOXYOIXIeSFbiyvOexgiPkPF/xHMRD/jcGaeX66JM0PxsJAwpF4EBAiJeWnfF7F28pEivW5XzJkAcLxB/LIcXuUzcM22+/kWkItfvlg7iiaMHlP32Fln++UDh4ypuBtJAAjUgDrzkqigrx1QO2
X-Gm-Message-State: AOJu0Ywe1NOjlHoCjo5Ud0dvzHqgo2s3Rx1FdXfAIPbmxM9ezRtptjNz
	DxaUCE30KIx2to0nNIGDnpmX+AbolSLp9+1ZP3qMmpsc0b6p2eaz
X-Google-Smtp-Source: AGHT+IGEFh9LhSO6onNwyiaQPUVg7gbETIoF2d9fushpmHT41a6bZNRtUSOPmyLpIODrXsVeGWvaOw==
X-Received: by 2002:a5d:6104:0:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-36bbc0c69camr4994727f8f.10.1722771721698;
        Sun, 04 Aug 2024 04:42:01 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:42:01 -0700 (PDT)
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
Subject: [PATCH 3/6] dt-bindings: mmc: add property for partitions node in mmc-card node
Date: Sun,  4 Aug 2024 13:41:03 +0200
Message-ID: <20240804114108.1893-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804114108.1893-1-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_044203_612340_686378D3 
X-CRM114-Status: GOOD (  12.44  )
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


