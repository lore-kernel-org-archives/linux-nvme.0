Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F36DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UvoCEZV2iNYmrEf0Gl3v1FkuJK/y6NUl/vMG5P+QSfE=; b=Qvr4V7MwYsUGe8AWuj+WchQA5r
	C8jxqCwOmYzU/5sD3LZW5LRYWAhpCMH2H4A37yDead3rDS47fMwnFxaXzffDhc69hInfW2uU2wt+5
	2Wv+YTPqCdugrXDjGCtygobk+jly1ahFRf2iKveSnbypJPUaLwMFFfr2HpEZ29G9LzaqAakp4lnu+
	AFFtiRLzkrbi7RMdy5z7OHZM77kn3NZUIQK8eIhWh/BveTddf9V9CIzAu6W0w58zRwyGlCd8/qGYQ
	LMMZvb4Dk4npS8+4UC4k5oU5NiqmrWJSAqTblZckKsysPrdrP7WZznI7WGrMRrx7J9hlmGp/cRDVa
	8t8JlLVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njRbl-00G5QX-NL; Tue, 26 Apr 2022 20:16:25 +0000
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njRbI-00G5FJ-LK; Tue, 26 Apr 2022 20:15:58 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 310595C0043;
 Tue, 26 Apr 2022 16:15:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Tue, 26 Apr 2022 16:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1651004150; x=1651090550; bh=UvoCEZV2iN
 YmrEf0Gl3v1FkuJK/y6NUl/vMG5P+QSfE=; b=ET0RQP18f8/Tic5fZOJ13JJKpg
 1Cyoa9sdGbqgBmEA373pkCuMcwasDMwa9k1V5b042Sy5XtJND9bIMr/7ZmUWfZUy
 s4mtzxDGf7ar7SYpOcs0e8tyBL9WTw04dYzi8ocIFd6nTFxAUBh1u2DzZ26MLU5T
 v6gpyru/w/rlBrGC9fAbFhkTWsDyRKWaTWDJy2CZy7QfnsfvtEINf/OEDOaGkAmF
 5ktOcUMOW+kzDC6YKQOOar5seiShNk+qHdjgUTpwSAI9qCcJII1yjlHDWiQebPys
 V1L1bMY2a7T04Gsr7pauKZRYJiq7ysQjGzq/U5skqV3DTtaFtWxIvyyVdOlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1651004150; x=1651090550; bh=U
 voCEZV2iNYmrEf0Gl3v1FkuJK/y6NUl/vMG5P+QSfE=; b=Gcfcf0Bbr7NmvtmK7
 k8+TH0maJKfpxxqb3VJRkByIrcgMwhmdXnhMrtcnCmHflaiI9x7+sVahvUldWBoa
 V98UoNXgqa5Cq2oVAwWEtOtJBOV5/o8LQGCGH1vPwuRGAxRotUqz3wzQfE/O87eB
 vZ3akF3AmI7Pro3GqfH3VmHjogDedB7VAQXb+306lo4m3x4RXtgstPt1OfdmfdmR
 wjTHeyB3Mr18IUB99BhHYcC09S1TWmiYRjAUxHc+diCcYyAA12TYIAWIP38VJ/1h
 qXKksR2P4vMtFNFoc/7wnu3xANo196KCaA0eBDBt7BLRgPH+R2e6+hoHRJYigeJ+
 BPEyQ==
X-ME-Sender: <xms:9VJoYtrRpW4lYNgU6LzBAmvN79qHNsns6vXMhla5hOesXhF9YZOGXQ>
 <xme:9VJoYvpREuD_WsTg0VyQsdFTWPnSgK9w1r-x1trEo1wNGE6stiYFG0Ot3KaGrC9Sc
 bz-1iXj99aLrybLlI0>
X-ME-Received: <xmr:9VJoYqPbSzP2D2JRPEVP4IRwzS3us41auUhWQPLJj4xF9Rhyz8sF69APGXQlMxvbeOvCmcoL8ScX46FFuOCxeekeX3VaeTB8RFC8ChYvA4lqJBN_cC51ZQ1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedm
 necujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnuc
 frvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgv
 rhhnpefggeduffduleefueegtdejueegheeuffduveevgeevkedthfeuheeuueefleehve
 enucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:9VJoYo5iyBfFydfXf-oO8QrlGYl5XR__7CLLpCF6pJPiO5Fdy2cdHw>
 <xmx:9VJoYs5OCWRZ8-yDD8-Dj5u0r8ODQang3_DkLrF0MfmAbaJaYOWyDg>
 <xmx:9VJoYgg-kr9bFl2wFinFz-7-SJcvjzpi2-YexdWB0w6Fr0BKofXAkA>
 <xmx:9lJoYrTBWFznWQFHILKcD2RA-Uin9bPbXxXq_PDvDAXnL1PIdpALRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 16:15:47 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: 
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
Date: Tue, 26 Apr 2022 22:15:33 +0200
Message-Id: <20220426201539.12829-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_131557_225484_5D9A5290 
X-CRM114-Status: GOOD (  10.28  )
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

Hi,

This series includes everything[*] required to get NVMe up and running on
Apple's M1, M1 Pro and M1 Max SoCs.

v1: https://lore.kernel.org/linux-nvme/20220321165049.35985-1-sven@svenpeter.dev/T/
v2: https://lore.kernel.org/linux-nvme/20220415142055.30873-1-sven@svenpeter.dev/T/

Thanks everyone for the reviews of v2 again! There are just some minor
changes since v2 listed in the individual commits again.

Thanks,

Sven

[*] The only missing part in this series are the device tree updates
    but since these will go through arm-soc anyway I haven't included
    them here but will instead submit them once this series is in a shape
    where it can be merged.

Sven Peter (6):
  dt-bindings: iommu: Add Apple SART DMA address filter
  dt-bindings: nvme: Add Apple ANS NVMe
  soc: apple: Always include Makefile
  soc: apple: Add SART driver
  soc: apple: Add RTKit IPC library
  nvme-apple: Add initial Apple SoC NVMe driver

 .../devicetree/bindings/iommu/apple,sart.yaml |   52 +
 .../bindings/nvme/apple,nvme-ans.yaml         |  111 ++
 MAINTAINERS                                   |    4 +
 drivers/nvme/host/Kconfig                     |   13 +
 drivers/nvme/host/Makefile                    |    3 +
 drivers/nvme/host/apple.c                     | 1598 +++++++++++++++++
 drivers/soc/Makefile                          |    2 +-
 drivers/soc/apple/Kconfig                     |   24 +
 drivers/soc/apple/Makefile                    |    6 +
 drivers/soc/apple/rtkit-crashlog.c            |  154 ++
 drivers/soc/apple/rtkit-internal.h            |   62 +
 drivers/soc/apple/rtkit.c                     |  958 ++++++++++
 drivers/soc/apple/sart.c                      |  328 ++++
 include/linux/soc/apple/rtkit.h               |  159 ++
 include/linux/soc/apple/sart.h                |   57 +
 15 files changed, 3530 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,sart.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 create mode 100644 drivers/nvme/host/apple.c
 create mode 100644 drivers/soc/apple/rtkit-crashlog.c
 create mode 100644 drivers/soc/apple/rtkit-internal.h
 create mode 100644 drivers/soc/apple/rtkit.c
 create mode 100644 drivers/soc/apple/sart.c
 create mode 100644 include/linux/soc/apple/rtkit.h
 create mode 100644 include/linux/soc/apple/sart.h

-- 
2.25.1


