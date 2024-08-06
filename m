Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9715C3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=; b=3EPNNR5z1hVaZfV/Qunc7k8BAB
	ICU2P1r3Rdf66eXyMScs586h8FoW/i3JduudNET9vxLHvwMYkzlGrmK2KaTqGC4H8v4eyouFQQUR8
	QqQtXSvs9KDY2DT1IKQ7AcxFIAtF8VRZFS0MUT72SJRjDzAFB1SbJQuJUQH8taQf8VnHwtEVdgjdx
	iqnZD+/K0KLXUFzThFEhwlIzxOh9zms95DD7KVfjKNJNL7hVY5PRai9wUJwHaiepsK/l+8qW9br0Y
	dBcMabB5RKH/0tOqjOkoxm5472ue9VAvsA1hU9HJJaAKOWfuOIqRTuamQzJp0+vLRqf2krmRhNg2n
	2IRp7yVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZa-00000001NLz-2Tl2;
	Tue, 06 Aug 2024 11:41:50 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZK-00000001N7a-1uAP;
	Tue, 06 Aug 2024 11:41:46 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso3384585e9.0;
        Tue, 06 Aug 2024 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944492; x=1723549292; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=A94PNFhgxfu/rHv3OEq2RS9Nlsmhu2iv30n7oTiy2yavsHLf7esv924cq1c9zrJ9/d
         +EPZiFzqkUYP52xqbpubQ+bP/jz1nPJYLoEHHblVFxcoWI8fS7CMhk8qB+2xrzHkCzLZ
         uoclFOdR4cac9R9DfZ1J2P4K94jLIC6SB8lUSlFpRzTc6JeYSWNrzgO2eXDEg3i/HtS9
         SgRgSmnwFsoxgG15pWpJD7ufkfgRvWTWHLwEeS9sSg79w8tlkVrct+E5ZqXr1BwI7lct
         Yxfmr972Helj+rMcIfIDCjnxxzCU/1duRJg86EDh3ynqAHXPxNSmAPfXVrmO98AVJU4/
         FBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944492; x=1723549292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJtL0MfF3HGZoWE7QS0/OcrDoRKxdV59VhkJ0rmXwsw=;
        b=JCOLMKph+I9+G4bhMKhbRY5cxoXxuUWWwcYsc61ixzWB9oeH1GgdLquU0B6WjJg21P
         Dd0Fku3wCVMVqpekcsOuNw/1m4oUsv99FP2uVfbEo+dR4819Quhtb/7GSVTBzFT4+FJ1
         XV6gvllfqNaxNHlhRiGVHpmR+efc9Fo8k9wTydK//6c6y/phQReFBPqBC7/EL8FEY0OL
         HHOGDKHDQMxUrcQRUG54M2N037opbXPKCXQH0tj163dRNDhns0Q431dk1DcOFApDtZQ5
         lNYjKKeRDZzxV7SY6c1svXhIH2h4pykIW9FROy4XnYuT//WFgR1TnLmxHrLerF5iKU80
         ojow==
X-Forwarded-Encrypted: i=1; AJvYcCUItVY1x1eagrAWALxACZtkBv2TCXaiRan39rAY8ETFG/cZrN6GRRciuSkQIVumlfd6aDt4MEBy4B/h5rl61qA3Oe/iqNEILcgpT4IesIPARMtc2n1WQjG0il5I9PG4ct1tOGOMDdB2InNKsOCf
X-Gm-Message-State: AOJu0YzlBaOh181LqFF8Q2ICGeWIPNsHStGE6ko2HUCktRghvS9Ni75I
	pSMgPfloh2Q2R1edwxEZfYiMUpK9v4tLVz0b8M7vJ7L33oYud1Wa
X-Google-Smtp-Source: AGHT+IEtsLb9ubCDZAG9HKspu+Ejg5Bny2dpdCF+3riHPRWpHuMWqRmG9LivPX6D4Zet1J/ot/MWyg==
X-Received: by 2002:a05:600c:1d89:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-428e6b92d50mr97449265e9.37.1722944492093;
        Tue, 06 Aug 2024 04:41:32 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:31 -0700 (PDT)
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
Subject: [PATCH v3 3/6] dt-bindings: mmc: add property for partitions node in mmc-card node
Date: Tue,  6 Aug 2024 13:41:13 +0200
Message-ID: <20240806114118.17198-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806114118.17198-1-ansuelsmth@gmail.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_044134_532828_115E83B0 
X-CRM114-Status: GOOD (  12.75  )
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


