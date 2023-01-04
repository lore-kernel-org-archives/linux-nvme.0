Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB873C46467
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oLgSnDPoPuvsHqHGpN53E/WHYKUwDeQDxvXCpDIWEHA=; b=ijlcpR6jaHNyjlkmgkXLIUsRdt
	jYdmweTOu9nQ4sMn4KC42ZYqRgdVSutAFvE/7czojkmiee45kWQ0kvRGl+bDudSVj1feNcd2Dc6Ih
	YS/Ow/7/Gf4Z2wMP1nRRNGPz87poF3hRSis+DR98/VUac7i/fi97e5OgJzffXEFtfc1TSwSJu8q2e
	BeJOBmKYTDFc1Vou9Xtfzdq1/c4KD31drQnCIx4ctO3jsC8OZ5A7XUdtltr+lty1FZhHScaypz/PZ
	W1ACHe1xwjeN+3RB+NUPu0Mqg7cUI7swAq7SCtEl2QU5V/zO2reNh8UKBs30PaqrGjyHPTzdFy489
	Am6fV5XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD019-0081Oc-3X; Wed, 04 Jan 2023 09:25:03 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCzzE-0080aR-SG; Wed, 04 Jan 2023 09:23:06 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 17FB73FB17;
	Wed,  4 Jan 2023 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1672824177; bh=a/im3KZyFNA2CosMlHGYViz9KJgGel1xGdkiZFIsEhA=;
	h=From:To:Cc:Subject:Date;
	b=q3ykqFnW9CcCW+jYax8JWGulJzj5jwpSKtNbVmhM2gB/sINfo4SHaVatgZ5+WJbB7
	 nkMZmKC9DdF7GD1FOIA4HoizeIe1+HB+A+uJRSKXgk0JnM0CXFnIrqEMLg6feUAO83
	 6Z87SFZhOXjhRyD9JJTMgmYZL2tU13mtlb86oCH8pQfoJukFPa/MT4PIf4LDfdV/5D
	 yfJ5nanF9GH0FR8j5vHD75UF8ri3lWu9gTLr8zym2dh6pElE8f4gBvOAD9KsyQ1rA2
	 u3dhKx7Ot9W9Hx9gmi80r83tiryUB+ocHHPohO9lEiziNL9bAOoDYYBTsJPIGnYRnY
	 7/Mpx3E1xgw9g==
From: Hector Martin <marcan@marcan.st>
To: Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Uday Shankar <ushankar@purestorage.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: [PATCH] nvme-apple: Add NVME_QUIRK_IDENTIFY_CNS quirk to fix regression
Date: Wed,  4 Jan 2023 18:21:49 +0900
Message-Id: <20230104092148.15578-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_012305_339659_90F6A87D 
X-CRM114-Status: GOOD (  15.26  )
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

From the get-go, this driver and the ANS syslog have been complaining
about namespace identification. In 6.2-rc1, commit 811f4de0344d ("nvme:
avoid fallback to sequential scan due to transient issues") regressed
the driver by no longer allowing fallback to sequential namespace scans,
leaving us with no namespaces.

It turns out that the real problem is that this controller claiming
NVMe 1.1 compat is treating the CNS field as a binary field, as in NVMe
1.0. This already has a quirk, NVME_QUIRK_IDENTIFY_CNS, so set it for
the controller to fix all this nonsense (including other errors
triggered by other CNS commands).

Fixes: 811f4de0344d ("nvme: avoid fallback to sequential scan due to transient issues")
Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvme/host/apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index e17d3a8a0107..e13a992b6096 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1553,7 +1553,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	}

 	ret = nvme_init_ctrl(&anv->ctrl, anv->dev, &nvme_ctrl_ops,
-			     NVME_QUIRK_SKIP_CID_GEN);
+			     NVME_QUIRK_SKIP_CID_GEN | NVME_QUIRK_IDENTIFY_CNS);
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to initialize nvme_ctrl");
 		goto put_dev;
--
2.35.1


