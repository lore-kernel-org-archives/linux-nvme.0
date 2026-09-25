Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84430C9830D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 09:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uihSC9KjAUldcdli/RyIuTfjwESydH7W1hKdMi/92G8=; b=T08BwjSEqGVrqK
	fKxfAKkNNw1Eab4a4f3wsmxjL4wrEepDQxngyBZ31Q8mGrsVPtMFxJYZbvhYvdDkrzu1/5CVqaEMD
	7xL9QOZq8ch/TCVeeH2SvuKkMY9qH1OzXz0lyyKENxAMIdtTg0Q2qdUU8OR5jp7BEuUtp34L9QTfM
	3AUv5VY9RJ0ZNPtSFQAhaa0u3/yJj1a1b0/qwz2ZCc1IQJ6iB3Vmv5YLUIvNELUbHeWhpWUIWZb9a
	jsBdAMKSxY7knbO0BIc8JF3kv9o6LBZyhz3kH8Ysl/5ec+JcZAoNiXVK2Ga31AoWJTL4t4a/B3cPH
	Dgeyzh78lj3w1KPAZVeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2Wn-0000000D1Tq-2ael;
	Fri, 25 Sep 2026 09:47:37 +0000
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA2Wj-0000000D1Ra-44fN;
	Fri, 25 Sep 2026 09:47:35 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7682EEC0120;
	Fri, 25 Sep 2026 05:47:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 05:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1790329650; x=1790416050; bh=ui
	hSC9KjAUldcdli/RyIuTfjwESydH7W1hKdMi/92G8=; b=iWXrTGRUyPXXY6unNx
	w3qONh2k4xK99Z7j+wqvXooIRr/H7AZs5zjzs6qzNX5HgD3cv1JVjHeN3z2GmSw1
	hSeXABdPBYezxyP+o3nIC9TAWUk3vC+b1I3j3EWQdIuggbq1xyrYl787M8BVz1Fe
	r2iYIgbbtpt46xCpwZ5Y5aMHvHRE2TCeCdLsxhiCew3oMUzuQ6CIRR03Q8E4zQ6X
	2kxkbk+7eTBp20VxCVlbqRYvgLGTy/LY4MR42h79INZBGnNnZ8zGRkwbLc3I5HGA
	8AjZy4PtXqBTyCokcnrSPAaKWfAQv9Rf9iDA/y3DCG4pEdl9SOOj1WD1YKAFMm3M
	t3lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790329650; x=1790416050; bh=uihSC9KjAUldcdli/RyIuTfjwESy
	dH7W1hKdMi/92G8=; b=w8p7OO6JUEglT4qr4p4nIn+1nr9uF2NBCGDkJkRGVP79
	fkePKF8nw/68b8c7+aTK/kSBe3Nr8KkKh6HkHzXbebphnyhZxi2DlzoJwB8abUoO
	bxN9DTF2seRNS6piTZhm42otQIKStC5M4plAkMlIStmhHV5xr3vJAWz2RqaTqEUs
	c5Sq6a18BBSuqRB0p24pLJMtAd/xVUZCprqAnJePSI51qwjS9ZT0QyWnTzteXyaH
	Oht6N5oHS05qrObyQTi0tWPHuqwhtiqzDQQVwly6J36e9B31de964czJ/7FxR9R0
	qRqPjsW++HsCvZp0ZVCTrFnjRjV6zlXWGkfvuEXXzg==
X-ME-Sender: <xms:MUO2auVh9cAnVWmYik05PNQl48Qx-pftx_Hl8uBZW_9N6izyxvEnkg>
    <xme:MUO2arAz945oOI5a96KmbxDXfL0t5ePxOa2U_LWc0S6LJHE0rP0zi0x1ireuZ9tZ0
    x-u9O_gQiyFvvQLoGvq_qM7Rtq9RJmeetiExX7E5v_bFMFDIs7IBDXY>
X-ME-Received: <xmr:MUO2an1lrxIUyqF_sf-7ICjD8WNi_pUx3btY56STnkxOYTc11T7LoRKVzIgqsqcyc0h0G0E>
X-ME-Proxy-Cause: dmFkZTGjYHlpCg9LU5Jn3J5FgSvlVX/173/IVUVYMWwQr/+tJlQQ44eJp+vnUs9/+BFyT6
    ssREUNEo38vlQcl5fgvUKIXjtCp7Q7cCLjiDHehEfZ9S5lM1RKRi0KJLvYHSIosL2Jh8W7
    lbrCK9IlAw7h6eRFn9HSKeNdjNZIVWpRGTgUUxXXK2abyqIqpE2sO2wahuV7J79feIjE59
    Zp1wE5Ak2knYps3/NAGcxC7QpoFOIoA1V+o3foVvgy0Yqc7UxzbImNicvhxs6QsWOQZoyA
    XozFFyfxAgeYCZlNlOAP9+nO0BuPbV+J7JwHdsiTvJTy9cwlwoiDHQUG9HZJPQCaw52MQ9
    HIvi8qUWRJ8nfHaADc/WSajaQzChQGP7zhj/mYV/ZMv3g+LPTbsJjkI9i8z9Qknzd4dFmf
    HacFesobtlzNYgYmZJQ+ro/LizzLROIRsM2k+RGJRMAEeRnKzC33HAh6dsm0LUBBYxkpt1
    hSXL2IjQNMkPTmejFyVnMgi+Sz6Pob7mG8asUqOlM5+cn/lZkgGARrv3S4MZRy2Do1dZwc
    5d6CfMn7sCb/ermoec1j6rKtD1EEmFTcee3BrD3dId/FIsxyH0zpsSB7PApZkk/BLQfcu9
    47tvMsvvM3lKGEa/nT7f2mpCi2BmxYQteOv7p1gERWjkeicyAuccgFDra/JA
X-ME-Proxy: <xmx:MUO2ajTbUJUj8YkkZEEhHk02QLx11DVCsZcRUfC7Ksa9bCwCuf1-iw>
    <xmx:MUO2asaFBVwcTkSo9fmNbuBZ1k7N1U-IKotwiuhIenbhoQBiRlf-lw>
    <xmx:MUO2apDg2kAj6AVGGHhEUjJQ5KNIk_MCy53B2XXTRJjSByeOVQ7ddg>
    <xmx:MUO2arDidI69AOdKwssovOpVSX72VwEIb9k2JJulqrEuIPluFN5uEw>
    <xmx:MkO2asiNNChrS3nfi2lyidMdzVwt33pwhBfTwG6_b_DWAYD_VpmFC9GF>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:28 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/7] NVMe support for Apple M3, M3 Pro and M3 Max/Ultra
 devices
Date: Fri, 25 Sep 2026 10:22:47 +0200
Message-Id: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyMT3cSCgpxU3Vxj3byy3FRdC/MUi0SDRPPUFEtDJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaABKh39NxAAAA
X-Change-ID: 20260924-apple-m3-nvme-87d8a0a7ed91
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, iommu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678; i=j@jannau.net;
 h=from:subject:message-id; bh=4ypi7wfhWyu9nXF1ipHoM2VNkSkHsmWohYy1wS85fpI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtzpr7und9kT9plc1tp+Fs+bVrkq3Yf82CRUfjLHTOP
 NjldrmwYyILgxgXg6WYIkuS9ssOhtU1ijG1D8Jg5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix1jHSMGLk4BmOqOa4wM/y2O5XPlW7gbN+Rf4XjsFKijvNz1TKrV9NNOOi9DDj95w/C/YP2bLbc
 PPN/wJa7E/feOnbP2p+8uObllKt+kHQ9+e9dnsAEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_024734_467694_C213F193 
X-CRM114-Status: GOOD (  14.36  )
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

Hej,

this series adds NVMe support to all M3, M3 Pro and M3 Max/Ultra
devices. The hardware works the same way as T602x (M2 Pro/Max/Ultra). If
there were changes they don't affect the way the existing Linux drivers
use the hardware. So this series adds new per-SoC compatible strings to
the mailbox, SART (IOMMU) and ANS (NVMe host controller) bindings and
the device nodes.

Merge strategy:
The nvme tree has "dt-bindings: nvme: Add apple,t8132-nvme-ans2
compatible" [1] queued for apple,nvme-ans.yaml so "dt-bindings:
nvme: apple: Add Apple M3 compatibles" should go through the nvme tree
as well. The MAINTAINERS update can go with it.
The other dt-binding changes are trivial so there is a slight preference
to take them to the apple-soc tree with Acked-by: by their maintainers.
This keeps the number of `make dtbs_check` warnings in the apple-soc
tree low. Merging them through their maintainer's trees is not a
problem either.
The apple device tree changes are based on / depend on commit
eea4f3b5e9e1 ("Merge patch series "dt-check-style strict fixes for Apple
M3, M3 Pro/Max/Ultra"") apple-soc/dt-7.4.

I intentionally omitted the Fixes: in the MAINTAINERS update as I don't
see any value in adding this change to stable releases.

Link: https://lore.kernel.org/asahi/20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev/ [1]

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (5):
      MAINTAINERS: Add NVMe devicetree bindings
      dt-bindings: mailbox: Add Apple M3 compatibles
      dt-bindings: nvme: apple,nvme-ans: Add Apple M3 compatibles
      arm64: dts: apple: t6030: Add NVMe device nodes
      arm64: dts: apple: t6031: Add NVMe device nodes

Michael Reeves (2):
      dt-bindings: iommu: apple,sart: Add Apple M3 compatibles
      arm64: dts: apple: t8122: Add NVMe device nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |  3 ++
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |  3 ++
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  7 +++-
 MAINTAINERS                                        |  1 +
 arch/arm64/boot/dts/apple/t6030.dtsi               | 42 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-nvme.dtsi          | 46 ++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031.dtsi               |  1 +
 arch/arm64/boot/dts/apple/t6032.dtsi               |  1 +
 arch/arm64/boot/dts/apple/t8122.dtsi               | 40 +++++++++++++++++++
 9 files changed, 143 insertions(+), 1 deletion(-)
---
base-commit: eea4f3b5e9e19389af3b99af64cdf7352b67c298
change-id: 20260924-apple-m3-nvme-87d8a0a7ed91

Best regards,
--  
Janne Grunau <j@jannau.net>


