Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C628C79F99
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/GbIwS69Z+7EmfwRnslAiweTO6LWu4/b5K4KmWKEcGk=; b=vBpmYVKDp7aZKc
	XMkiB0BUyV1af/oVsHu5+rp70fugPE8UF99dlyhWEQWs9bIZy6le3JcTUkG8x4P0iOvoaZrk5nWM0
	L3Xj3+wnIFVyLz4Pq4NRQRhMfr+ckI6cwyJc3kQBLNKUb7yy+0BJvec2IhlI3DYjVO62+jRY6T3JM
	cQaSVCD97lptwNpGBVOerNTNmT3gknAlPOR6zC9tzdfl85blEqyABeKSYikDkAOhYUFevCSo6E2VB
	EEXa5VeNs2vypwWyrgIG/t0a0zGovEUZpYiE3626R3bhEDQZfHt31e59F3/sQ46f1HPWegS0n23Cr
	yqxdF4nJdQBzoYBXJFDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3JHZ-00000005XeR-3wUS;
	Sun, 06 Sep 2026 20:16:05 +0000
Received: from [2a0f:4ac0::3a11] (helo=mail.cyberchaos.dev)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3JHU-00000005XaQ-31LR;
	Sun, 06 Sep 2026 20:16:04 +0000
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788725745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/GbIwS69Z+7EmfwRnslAiweTO6LWu4/b5K4KmWKEcGk=;
	b=fD3ba7N2rfFxisDxO0mPhyFUZiCVuiw/kLXpRuVxj6fsS8ZgLrItrERf2cCYfcQcg6wZTr
	PTlI+9hliSfvoJnaGLWLNXTwNjJi1aGDB+7Tq6fBl9WrlgFQ/nhnJ/7onSxCZpiKujxtFu
	lTfR2xwfz3jCkrTY+fVBsVZR2+xMu58=
Subject: [PATCH v2 0/2] nvme: apple: add t8132 (M4) ANS2 NVMe support
Date: Sun, 06 Sep 2026 22:15:28 +0200
Message-Id: <20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPyw6CMBBFf4XM2iG0VQRW/odhUcogNfKwLY2E8
 O8WcOvyJOfeubOAJaPJQhEtYMhrq4c+AD9FoFrZPwh1HRh4wtMkYwzlOL4Ie98RuowJjoKJPK/
 TJmNSQoiNhhr92Svv5cF2qp6k3NbzMwy9p3DLHRpU0hKqoeu0KyJ/jQUaxWBLt9q6wcz7Ps92+
 f8UzzDBLL1UJDiduRI3NVdkwiODjWvyUK7r+gVsUeG08wAAAA==
X-Change-ID: 20260811-apple-nvme-t8132-31399d6f81aa
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
X-CRM114-CacheID: sfid-20260906_131602_924901_34C6C3E7 
X-CRM114-Status: GOOD (  13.71  )
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

This patch series adds dt-bindings and driver support for ANS2 NVMe on
the Apple t8132 (M4) SoC.

This variant requires the IO queues to be registered using additional
MMIO writes. Otherwise it is largerly the same as the ANS2 NVMe variants
present on Apple M1-M3 SoCs.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Changes in v2:
- Reverted the separate_nvmmu_base part, since reg[9] from the Apple
  device tree works for both nvme and nvmmu regs.
- Differentiate the meaning of mmio_nvme+0x1210 between t8103 and t8132
  resolves an ANS crash caused by the IO completion queue size mismatching
  between our data structures (64) and the ANS (65).
- Link to v1: https://patch.msgid.link/20260811-apple-nvme-t8132-v1-0-865be32e42c3@cyberchaos.dev

To: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>
To: Neal Gompa <neal@gompa.dev>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
models: On t8132 this now sets the IO queue sizes and is 0-based. This

---
Yureka Lilian (2):
      dt-bindings: nvme: Add apple,t8132-nvme-ans2 compatible
      nvme: apple: add t8132 (M4) ANS2 NVMe support

 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  1 +
 drivers/nvme/host/apple.c                          | 39 +++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260811-apple-nvme-t8132-31399d6f81aa

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>


