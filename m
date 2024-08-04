Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE0C52D72
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=; b=AmTKHZp6p9PSVkKC7B61jpYXsH
	8qFuqwcX3L/366221GZmKM5y9nrGQNNYpBirfnnqCNWWIpKwEmzj9uH1iDnMpnm0AnbQSik0Hvo16
	R+ujFUTZm6YMOxtaSY8ZF6cKHwP5UfvGXZbrtz/5C6nNqidmdFGc9vwVyBIvbUE0FBLaUz7x9PCXD
	TCSfRMjai1HyXtN4qZQOpuVETZrvm/vJTa2IqB0sAxKThqgHh3YFLeeOJUslVRJwrYPgktY4c3ydr
	Jfl5sE6IU8R6sDGQ2fMCFOHRGbe6t+rJey2PIZfb741MvJOQqR67R61UAJC6ZPUNBG5Zf1CyFVHld
	kIyfTmCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZce-0000000DAY9-3JYF;
	Sun, 04 Aug 2024 11:42:00 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZca-0000000DAWy-3eaY;
	Sun, 04 Aug 2024 11:41:58 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-428119da952so62593125e9.0;
        Sun, 04 Aug 2024 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771715; x=1723376515; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=AEJnQugb52/S+1u5yPohmH4c0MqwkZW9IJ1RxuNqtsYQsw3Ru3WECwAFOsznOPcxvS
         gcZrS8/wiybpbsEsmHfax1ococ5+cRvKQAWfAMaby2FeN9wq4YR8wFgrA48RsLqdmZ4r
         LsXUynujDbT6RPrsV2IZLEEUm0Gaz4P7hVakFuAqoSviZlJSF0NSSet3X+wHS0i1dpME
         U0DuUsOPFJqeyvtHs4aStSsNC3EzL7tH/PJAH0/bGouH/WSevVgqk7k+W2fbaiBqVi9G
         sFXS7r3QszWvMtrcm3owt1lda7mrX4hYwJFEcIBVVVrvq4mxXWQi0xiGEVTfyxGPyupb
         bK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771715; x=1723376515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Tqx/xl+do4nmfv0ZFIXdX55krJHtI/dy8e3uyNR1Y=;
        b=STt9zIwsjzNXc4+OPwMEo+aWnxiQW2TSJPZrVi9DkzC0y4AcGbUKou1Rr2RZKdMz24
         fyaWcmU7tGlE4eMRWboQcIU5AULBNNI/EEZ9Z9yuHDUFJP9vXDUKjFqHyDStMlz7EYtc
         QlBfFTccdRmjqbFiPYnorxR++mAPTAC1+0/QgadsONeg40C5+ND9zYR/d9rR4eNBcrvD
         RaYKKcLj6KofSX28Lcwj95+AAmEA7SiElhcIFeaNjQh5q6DxR3Qzq33bsgIMR/jB2pbZ
         WXQu0RzfR8dCUgqBOl0GxMw3IQ35bw5uHDYGLXE+/pJyNTCOb4HaK7vhoFI1TI62mCZh
         QDkw==
X-Forwarded-Encrypted: i=1; AJvYcCU8OjQjOiV1YCmLnf7seiMPYHpmHfX8HlRp8kwS6uv4UwQjq16SmNBp8IIN0JexEoE187u4wLF+M6XPG+GMClWV9da2lNYWQ7NrwlTqBvJRtfC1zMqqIGvx2pR3eJTzXYnDJxgC8KxQAUTM53bi
X-Gm-Message-State: AOJu0YwnYVn8gxaI4dmzJnX7FmNZ7FftlDqFtCXBfZhU/XByGs7smPb/
	+HiBCPCg62zwLeKKUcqqJA9/KVDBCDprEyx3JR2mXQRe0LI3wx6K
X-Google-Smtp-Source: AGHT+IEh/fFRi3lvw24ntWxbY6FWDsuqyuWXPDM5pSemyCgBJ+obg3zad+nrGbuYwnLYxI5iYfKvgQ==
X-Received: by 2002:a05:600c:3b19:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-428e6af2e9amr57295055e9.4.1722771714552;
        Sun, 04 Aug 2024 04:41:54 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:41:54 -0700 (PDT)
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
Subject: [PATCH 1/6] dt-bindings: nvme: Document nvme-card compatible
Date: Sun,  4 Aug 2024 13:41:01 +0200
Message-ID: <20240804114108.1893-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804114108.1893-1-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_044156_935250_2B83CF01 
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


