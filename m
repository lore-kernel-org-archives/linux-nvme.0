Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34384C5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 20:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sbjeC/eKrwmIFAfzQH2WILNTc8GDCe8HMwCd5dXp2nU=; b=IHAYDFku4Wl/uA
	4z3YcQy0KzIN/sGKJV1oe8lO23fGBFTpH8z7fp9YXbk44cUX2f8z9Kow6DCL7V+WBDbZc7PxJ8ChF
	ZvzIb49VsBBR2/PWTgKjOKfJvqvYVRQEF9R0tosuzcku73D0GAqjqFSKv3GYFoZNlzkMZ3Fe9iSjX
	vctNiGTtgo75C3Kek2sLx1Z+BbqiHr2xIWWvwl2dIaF2noj10oOFBEQ13RwUNq9qFvf3vs9gA/Zgw
	/KHZZDQEj5Dy0J6Hify2e5AgybXhKNCnMr9qoA9yKSqg5qgavZeZ7KSZOEjWCIp35oaR7yvuiYoVz
	lGsEQAqSCQdZBMQrQIQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttQO-0000000Ex02-2iDC;
	Tue, 11 Aug 2026 20:50:16 +0000
Received: from [195.39.247.168] (helo=mail.cyberchaos.dev)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttQM-0000000Ewwx-07ki;
	Tue, 11 Aug 2026 20:50:15 +0000
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786481397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sbjeC/eKrwmIFAfzQH2WILNTc8GDCe8HMwCd5dXp2nU=;
	b=IQuxDKpNze4lFSwtxbxx9nq/s8sMdqHksqio3+yXw3gMAToFagtPg9pfH0TZJkvjibMZkr
	AGZe+MPaN54tj6Hitu2nIk3AnIEXBZhQVmtCcMMdnGf5hiklX79+K8wJFrvI694rX2fppR
	H5b3/iI2vXIVEVApmj6Fb9hsE4no6a0=
Subject: [PATCH 0/2] nvme: apple: add t8132 (M4) ANS2 NVMe support
Date: Tue, 11 Aug 2026 22:49:46 +0200
Message-Id: <20260811-apple-nvme-t8132-v1-0-865be32e42c3@cyberchaos.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OwQ6CMBBEf6XZs2u6hUDprxgOLSxaI4htQRPCv
 4viweNLZt7MApGD5whGLBB49tHfhw3oIKC52OHM6NuNQUlVSE2EdhxvjMPcMyZNmcKMsqpqi06
 TtbDVxsCdf32Vp3rnOLkrN+nj+SUCP6ZtK+0xcDYyNve+98mIuTwqDE0J/x+M2B/IAl2+z3dP6
 zxKKTNdUK6dIjMT1Ov6BjESF1HVAAAA
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
X-CRM114-CacheID: sfid-20260811_135014_242889_4A3D2C3F 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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

This variant uses a separate MMIO base for its NVMMU and requires the IO
queues to be registered using an additional MMIO write.  Otherwise it is
largerly the same as the ANS2 NVMe variants present on Apple M1-M3 SoCs.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Yureka Lilian (2):
      dt-bindings: nvme: Add apple,t8132-nvme-ans2 compatible
      nvme: apple: add t8132 (M4) ANS2 NVMe support

 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   | 77 ++++++++++++++--------
 drivers/nvme/host/apple.c                          | 41 ++++++++++--
 2 files changed, 84 insertions(+), 34 deletions(-)
---
base-commit: 2ee859ebf156157609f71060ae472711c8cbc326
change-id: 20260811-apple-nvme-t8132-31399d6f81aa
prerequisite-change-id: 20260806-b4-nvme-fwabi-000386148b21:v1
prerequisite-patch-id: 6a5b048dc5206a5a885a48101737a4ef714b3daa
prerequisite-patch-id: 51dcb523ea7e4d3695599db362e9d93c00a35c72
prerequisite-patch-id: 2f55dd6933c9a1b7078da3cbaae848ec920b542d
prerequisite-patch-id: cd3d7c56f3a943d199838e6b1214110aa8e47a72
prerequisite-patch-id: 7e3fc920a0336ef3946d970a2d5517eee49997e5
prerequisite-patch-id: 92f6d325b1f4118311fa3bb8a9a762cadab027f9

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>


