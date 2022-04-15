Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A953C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VDxVEy1kf3mSXO0HR8jVsRvxpFr08W0EkuoslbOHVU=; b=CLUbeCiFexuT8mDZXiL0Vu6gxD
	nYrvvtmF171RexHKIxb7xI5i46kXbXrv353ZH+IRo03uXgbgZ3jR2mFgpcGs1aUdQGC8ztPIJW6oz
	LgoRrncpeGSlj2aYNccRpfVvLPjCFWQBiEnaoLIoYmpHbmKnS+v58HVj/t8xHwkO8n/l8QFOeGOVa
	jQ/CZZwytJ5pZby24oyeTBcXpdvF5Lw/DWvhdapEO+/KcRkr7Q18sbuGfWuOIvUk6xO1ZVN+0sRJf
	2xsVTfVbU4ZT/4VsIarOn1bsJAfe33obMxcYP+F9u/9nWSQTss6W0A2UD6IqFLPtSDXLJnoMLEwpZ
	leLdMefA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfMpm-00AIbW-IJ; Fri, 15 Apr 2022 14:22:02 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfMox-00AIFr-LB; Fri, 15 Apr 2022 14:21:13 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 09DEF5C01D8;
 Fri, 15 Apr 2022 10:21:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 15 Apr 2022 10:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1650032471; x=
 1650118871; bh=1VDxVEy1kf3mSXO0HR8jVsRvxpFr08W0EkuoslbOHVU=; b=M
 6abm+zltKQ0YorUThv8lH1O419V/kqP5nmB67hqjXjVr1SUGOxu3IAhi0Xi1JgbT
 qwkNT1WaOBNCkcDuFBsuSDE0Vd9vB5dKPIeUhKsCespkgcKxrYpBXErTWtZ17Y60
 wkfwR4K6/tt833+1TUV8/ZgEnNHqoLVQ9LnjHxgUwsk32VHFavWkYAzokPrNcZWP
 f84jpxDUwtql/uWeSTNFf76RRKLyE2Dz0M5+zdi1irDx2qLDDIWK07FEBR8VzRxF
 7z8ewdytwepoh0q0PLWZMA89lpIMfRUTmvn9xINyWgTiuQU/AHE4t6Z6qwbq5YNB
 zPb5k0KbeT/HfPUFbLL5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1650032471; x=1650118871; bh=1VDxVEy1kf3mSXO0HR8jVsRvxpFr08W0Eku
 oslbOHVU=; b=y5goGdZ/DjTKQHrJHOyFUXIKyW07u5viLjCg0AXbTZrsoYPQmDc
 wVHgZ68dMiGRvT3E/7kXoXkErkke5VWgoxzCLb7DYeeesEbhK/HeQ+50p+ostJm5
 XjhEaTrNYnKmNgA2S7QUukS9YgB28v98fdy0GdyynMgImi6r8vnis/uSYyWDk5v9
 E7AcNtS4Vvam9gEPTvuWmSorE3HU8rrvL3aoBZ398qMSP8KVbR7vZZqD22Ty1gEu
 UvmqvNjE06ZCBjS505ZkCU7fspop5g4T/VjlMV3u0LNuELseX3IMgIu6d36GQ6/K
 8AHf+IPohwX0OJ7fvB43GmUh8PeBAcrO+yw==
X-ME-Sender: <xms:Vn9ZYoDRSPHr0lUy3dmKn6BTxYQy0XtaEZE02B-J_9oDMMZgIOMmFw>
 <xme:Vn9ZYqhPMJL1xUfR2LN535-rDellpbBsXtsDMo1pmJQpzfLF-TUGtQJTTbthIAAaE
 Ayo3TGDISFOjf01Viw>
X-ME-Received: <xmr:Vn9ZYrkyY7xizYzxdInWNZL4g-3DZn2HcfUHZxj61NPkewjgbhUkX-46SolpZVtgBgwxNaxoe_IYS5e80-mlDcT_sSbdbUAZ_ONWr2L83R9Df-_VnY-d5uZQAeXYiIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Vn9ZYuw6Psv4JDREC1z9hNo10aQOVHO8WCIlvIUd-8hbORd3qlwdnw>
 <xmx:Vn9ZYtTiQqi8SaiXvFu3v-0mTCxn-8n96CMob32UpBX2iEVqTG2mag>
 <xmx:Vn9ZYpaomzD3TSl_HvWXR-dqJc4d6eb9eXyiXwv1VPYENervTYxBLw>
 <xmx:V39ZYjCAQ8vBwNnqtSqvRugltdpd_MT2SCllHi3QjvEznjFkn1NZNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Apr 2022 10:21:08 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/6] soc: apple: Always include Makefile
Date: Fri, 15 Apr 2022 16:20:52 +0200
Message-Id: <20220415142055.30873-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220415142055.30873-1-sven@svenpeter.dev>
References: <20220415142055.30873-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_072111_807964_99768878 
X-CRM114-Status: GOOD (  10.80  )
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

We want to allow the code inside drivers/soc/apple to be compiled with
COMPILE_TEST but this will currently result in linking errors because
ARCH_APPLE is not set and make will never recurse into
drivers/soc/apple.
Let's just unconditionally recurse into apple/ since all drivers
in there are guarded by config options anyways.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 904eec2a7871..6ad4177595f3 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
-obj-$(CONFIG_ARCH_APPLE)	+= apple/
+obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
-- 
2.25.1


