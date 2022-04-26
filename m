Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B245C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c61W8AmgSSZBwemgriOb8pL9lmJR0zJYE48dHUOeG6o=; b=VVOLqe/ddhQ1ygMODuuZcFYbNP
	PAPkrrtY6KxQD7BTyCau37vjahn2SjTfCXCWbJ9zvUQfPpk+TNqLNGDaLb9lp8O/V/0ruxsU4xL0K
	9Jr/QtHWdpwB87ETgsSSLGQbXTYJ/8SujReW9rKL3nucaFSVjiqz8wH9gnZzWWYeUpks6aVdLtUTr
	j6INpOzjIAx9+kJVVfVVpANtdVqZW4euUAnfhya/k1qnDA5op9Du/CA4gIcKq4pAC4vF8OcEqIqZ5
	te2tM6rrHR0VPx0Ht/ON1NNAt3U6vzDJO7vR/gzEFQbocmg8k21sSeD9f7kyuiPauxdAzb58LTB9x
	DKeiJE+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njRdM-00G6Gv-0W; Tue, 26 Apr 2022 20:18:04 +0000
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njRbL-00G5I0-2j; Tue, 26 Apr 2022 20:16:00 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 71E5C5C0110;
 Tue, 26 Apr 2022 16:15:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 26 Apr 2022 16:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1651004158; x=
 1651090558; bh=c61W8AmgSSZBwemgriOb8pL9lmJR0zJYE48dHUOeG6o=; b=g
 JMFsYCsOA+ZjjpAvN4gvro8Uyr6wKoSm0bjbXqeizBvcgnrDUA6aAKQexiSDHgrT
 Zanb+jvgm33OY6qkPwiMNCZH41OuZ/W8PUVZsTX64Knl7ldhoR+EA7qjKMBvDBaJ
 r5b9HZTR9YKf0xDH51Uyi8+l18lMcEyzylEX0KS0+nlzYRPqKD5SnEkHossN3jZN
 sVwkht5BUrEFfc9Tf1l20PeOeB+fAiG2ES3VJMwUqwFjqSTYR0+O1qmXbh5hp1jR
 AjMkc8tiuTqBab8WndThn2VscAk5ytj/robFF8Ip1vDnpJDb8EdmefODWkE1n35y
 kxR0zW/TQJ/xJ0psDQo2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1651004158; x=1651090558; bh=c61W8AmgSSZBwemgriOb8pL9lmJR0zJYE48
 dHUOeG6o=; b=ijTVKyZjdgxnIbsWyhglotPgux7zhPN5Xn7Nm3JxUQneciIcuHQ
 XIu+WxApbZhFr3rdQz1g3ZqvLN0oy3HZL3xz6VYJhjyyX/WbV04H+h+sbtcT9KTQ
 nQuRoiMoy8r80Dv4K+iYmjsAdNM6M4A1IRYzLWrYz7gOccrPTO2ArzxzQvhRjN3D
 e9v3+YE7JRRMueTKhKlaQ8MSM8TdOppwud9WqC7QLCQN1+A9CukcsDUIiVtdHO/q
 4MLWU4BkMoczKNuUxhKZJ/Z2HY2g/Vw3weQ300RSUD6XtMvIxqmhbN0bRJtE0q3J
 G3mlsr7szbU/dYo2aJ+QiX4hRocv/TQMAJQ==
X-ME-Sender: <xms:_lJoYv8-BsoJm-yiXnfzNq9vm7Gl8tVYaIEUJMo8i3wCe4rp9Dm_iw>
 <xme:_lJoYrsITB79PvFXoOc_Zjn6YqFGxfkBO0hagj_koQVljONFCNCp1L_W4G9Qr5er4
 9mJVRLW5M3CKS4pubM>
X-ME-Received: <xmr:_lJoYtAR_GNV8ALvxqDxpN_dGJCDfondrEtCFkHJF0NSkx83qpxYdQ9rBoz5xcoOsGpOKb_VRsCNpaDmZ5W_BQP9wOMqYBJhRyZxqT2hnVvBdy8UWEnK98sR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
 ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
 gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
 gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:_lJoYrfh9xrNdleB6lhcn2f0XO9bKNVFJ7pYsAcWmjq3DhSsc_UhXQ>
 <xmx:_lJoYkNJTTOvjeM73VVlhNSCUMPQQ6hiGM_8vpEja9rCDz2w7VHm7A>
 <xmx:_lJoYtn_ZGydc9p5QgZqHVh7uKkIQ1aPDnXqzOU1WVwoGh7HVN0QDA>
 <xmx:_lJoYrmJirgpkNYXdyJBcbf1HQrK7-RiLqcVvoPVTVkf57DgWIYYew>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 16:15:56 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 Janne Grunau <j@jannau.net>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v3 3/6] soc: apple: Always include Makefile
Date: Tue, 26 Apr 2022 22:15:36 +0200
Message-Id: <20220426201539.12829-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220426201539.12829-1-sven@svenpeter.dev>
References: <20220426201539.12829-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_131559_246195_8432264E 
X-CRM114-Status: GOOD (  10.79  )
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
no changes since v1

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


