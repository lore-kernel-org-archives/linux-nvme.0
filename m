Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598CAC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wySahytB2Ta4DvPdTT8lSPVWAO36Jkpqk6NhDD4tG+Q=; b=oB+NaH9qLP2Oc/Dznm3Qh3em7s
	XTFJI2tzpLYLTX4sEKro07qriiOUuI2+ZJsf1JABUqB6L3Glb9UzFfVt/6KcDLVjaV3NL+ceb5yOG
	NyEUFUq0wxsamrD2sAtGuU2n258jk50ncWcgv1kMccuwhl9RWRuu/xE9iZwWkWpAJ1xRBMYnbejJ1
	GFROFNMhKSMUlL1WzmlhiL+9t62J89Sb7gdf1TIAv9h3MNmKcRjhulN1Esb7HwLqGpISsZd/+t0sC
	nJfSZUotoMVXA6xjzf37e7/KbPgzphb6edEEe6ez4w0332zkjH4R6AVZ9LhRE3Txqbn3AWV5NfKiq
	w25i3oig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWen-0000000DOgF-2PpN;
	Mon, 24 Feb 2025 11:29:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWUO-0000000DJmt-0fy7;
	Mon, 24 Feb 2025 11:19:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B0F1E5C697C;
	Mon, 24 Feb 2025 11:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009FAC4CEE6;
	Mon, 24 Feb 2025 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395947;
	bh=G23AKcUUhcPBQNTXagmQkFOIFePG7LUUEUlJGCkB2o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmyDgwrEuN3wRoi/6j8fSlveG6yK5hqsF2xtXm40I1SejK5WqtCyXUzOo/VurLChY
	 GYT7BmVXmriyrN6WiH+rBv5zH17lC4ojzrdZmNjZnkru0RflQrTpVB1N0yLKRyI0wG
	 ZdMWqBKNG57stU/7RrOPAnc6vx3bKNBE9wOyYtVWNKLVOkrJqCh/ATsZWf22D2uwDB
	 XIYKJKqSqjgsNZYVt96SkG0RtfG04HOtYu8gbrEjg/7kBEeXiuEzqS6ZDezuva2ZTF
	 Qfai7sm7AR5BZOpE1/ccinEx5p5voF4fNq7M9UB0JHMd71qjfInur4RdJf9q+2ThXw
	 NeBVQJCDxwgFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	j@jannau.net,
	sagi@grimberg.me,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 24/28] apple-nvme: Release power domains when probe fails
Date: Mon, 24 Feb 2025 06:17:55 -0500
Message-Id: <20250224111759.2213772-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_031908_239214_53938642 
X-CRM114-Status: UNSURE (   7.95  )
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

From: Hector Martin <marcan@marcan.st>

[ Upstream commit eefa72a15ea03fd009333aaa9f0e360b2578e434 ]

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b1387dc459a32..df054cd38c3e3 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1518,6 +1518,7 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 
 	return anv;
 put_dev:
+	apple_nvme_detach_genpd(anv);
 	put_device(anv->dev);
 	return ERR_PTR(ret);
 }
@@ -1551,6 +1552,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	nvme_uninit_ctrl(&anv->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&anv->ctrl);
+	apple_nvme_detach_genpd(anv);
 	return ret;
 }
 
-- 
2.39.5


