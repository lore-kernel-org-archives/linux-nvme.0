Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE39C79FA0
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 20:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ifr8dfzJ3fmn/enavi5lqZlBqhGNx/GKUeKdq458mOU=; b=GIWz1RsvAiEllHKffJ/2Slw1h4
	NZyyUuvRZ5Ahtn1ZMQxC7bqbTinG93eZ8XwmEjWX6B+o5+rM8pQM6oNlL0ACT0Y+6KwEBRM9+0nMs
	VoDRhrT2O52dwHU22cDWvy77lsmvpBJCQ6fDyyl7LYvu2bUX+GkBpJLsVbD+dn0webFngGkDJmD/4
	DDFlN6JDx4Cj/nhybOpQcJ5zhLtLGou5b+BHCoA9CQro8If5VO+Y8YUVaE61NV9RNsJhlMWJJj/gr
	P/2qslvlH41KbzF/wCKxLX0ljDFnXsisTZ4+tJPtNqyh7VAIJ82udMo0ISoLUN28GbRBlybgDYZwv
	NDM3qNtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3JHZ-00000005Xdt-2vrm;
	Sun, 06 Sep 2026 20:16:05 +0000
Received: from [2a0f:4ac0::3a11] (helo=mail.cyberchaos.dev)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3JHU-00000005XaR-32BY;
	Sun, 06 Sep 2026 20:16:03 +0000
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788725747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifr8dfzJ3fmn/enavi5lqZlBqhGNx/GKUeKdq458mOU=;
	b=QY/0Z20jwGnKx9iu+pv2rhm+3lwrEs6xpK2Hmy8s1h4LxTsrvM4fTuq0fsn4pNPe/gNem0
	JVB287T93XomRVlk4FWhi7vfnSe7sjG82Q/rZQcAR3YYCYe6q2YzuNHDHrFnA+3QlH+/ry
	Nb/u0ytSSUgK7V17VACWgfO3g8oy9FE=
Date: Sun, 06 Sep 2026 22:15:29 +0200
Subject: [PATCH v2 1/2] dt-bindings: nvme: Add apple,t8132-nvme-ans2
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-apple-nvme-t8132-v2-1-ac0328590823@cyberchaos.dev>
References: <20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev>
In-Reply-To: <20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev>
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
X-CRM114-CacheID: sfid-20260906_131602_932154_B7A3B1A8 
X-CRM114-Status: GOOD (  10.17  )
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
which requires the IO queues to be registered using additional MMIO writes.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index 4c0b1f90aff8..a1e5b1831468 100644
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

-- 
2.55.0


