Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261CAC5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zWgebfTo+zH4rv/0W8syIrgWklYULrmOZZ7dxgV0NL8=; b=x4V1YC315Ak5MCWDypWgziLMPb
	FP2+BEg80jXeNti4eAj5hpXnZCf4uN+zeGtaAhdHzz8nW6MjIsFGGaSenS3KXd7nybTJGqRS1cYtL
	NTz9CHWakF4XYRvK0r+l3cleSeuq191liDsVMcJTKLjbbPtd5jiY30K5bWblk5cGxRWZborXaftcL
	qJ4D98JlI40hPwzEt6zBgUW6TA63Z8elLoSMeD4EfYvG62MJslEpUWHfrCc1Xx4tg3KBAaaVCFC3U
	OKuDEjqNBRIONmU7E7o9eXLVSOFc++VjmrRndgs4kbWt44nRJuptL4GNoEJE29YUbW3yXz/Bs2NnF
	P+GI6lnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttQO-0000000Ewzm-2BuM;
	Tue, 11 Aug 2026 20:50:16 +0000
Received: from [2a0f:4ac0::3a11] (helo=mail.cyberchaos.dev)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttQL-0000000Ewwv-41tR;
	Tue, 11 Aug 2026 20:50:15 +0000
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786481398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWgebfTo+zH4rv/0W8syIrgWklYULrmOZZ7dxgV0NL8=;
	b=xcpNcv6rP+jccLZRxcyOFlFyrH4cftZpwiJx18fsx6YQqQYXjMVqlsMoAARkz0Kbpj8v9U
	ycsmSy/a5LE2YS7WiEWc+VtcH0LzaVk0P3HFZ+f3WE9kOitSPaWRCyyBnaYb/hfEVixaWF
	ceZ0f8Qni0OhT6qno+2bxrRSoETMYow=
Date: Tue, 11 Aug 2026 22:49:47 +0200
Subject: [PATCH 1/2] dt-bindings: nvme: Add apple,t8132-nvme-ans2
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-apple-nvme-t8132-v1-1-865be32e42c3@cyberchaos.dev>
References: <20260811-apple-nvme-t8132-v1-0-865be32e42c3@cyberchaos.dev>
In-Reply-To: <20260811-apple-nvme-t8132-v1-0-865be32e42c3@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Yureka Lilian <yureka@cyberchaos.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_135014_243994_E969C5C9 
X-CRM114-Status: GOOD (  10.36  )
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

Add a new base compatible for the ANS2 NVMe on the Apple t8132 (M4) SoC,
which uses a separate MMIO base for its NVMMU.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   | 77 ++++++++++++++--------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index 4c0b1f90aff8..c8a41b268b9c 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -16,6 +16,7 @@ properties:
       - items:
           - const: apple,t6020-nvme-ans2
           - const: apple,t8103-nvme-ans2
+      - const: apple,t8132-nvme-ans2
       - items:
           - enum:
               # Do not add additional SoC to this list.
@@ -24,16 +25,6 @@ properties:
               - apple,t6000-nvme-ans2
           - const: apple,nvme-ans2
 
-  reg:
-    items:
-      - description: NVMe and NVMMU registers
-      - description: ANS2 co-processor control registers
-
-  reg-names:
-    items:
-      - const: nvme
-      - const: ans
-
   resets:
     maxItems: 1
 
@@ -68,25 +59,53 @@ properties:
 
       The SART address filter is documented in iommu/apple,sart.yaml.
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - apple,t6000-nvme-ans2
-          - apple,t6020-nvme-ans2
-then:
-  properties:
-    power-domains:
-      minItems: 3
-    power-domain-names:
-      minItems: 3
-else:
-  properties:
-    power-domains:
-      maxItems: 2
-    power-domain-names:
-      maxItems: 2
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: apple,t8132-nvme-ans2
+    then:
+      properties:
+        reg:
+          items:
+            - description: NVMMU registers
+            - description: NVMe registers
+            - description: ANS2 co-processor control registers
+        reg-names:
+          items:
+            - const: nvmmu
+            - const: nvme
+            - const: ans
+    else:
+      properties:
+        reg:
+          items:
+            - description: NVMe and NVMMU registers
+            - description: ANS2 co-processor control registers
+        reg-names:
+          items:
+            - const: nvme
+            - const: ans
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - apple,t6000-nvme-ans2
+              - apple,t6020-nvme-ans2
+    then:
+      properties:
+        power-domains:
+          minItems: 3
+        power-domain-names:
+          minItems: 3
+    else:
+      properties:
+        power-domains:
+          maxItems: 2
+        power-domain-names:
+          maxItems: 2
 
 required:
   - compatible

-- 
2.55.0


