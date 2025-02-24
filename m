Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1967C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oS6LsnRdIQwDO0QxVneuSfXM62G9F51L3J0+Lw7VrmA=; b=Z518qnGoBNI78bjLK6lViEGbLA
	tdG2aOvC3nvpyUsnIu1av6c91o8+InaYPWyBapRo0Ho/MeH3Qe9AgWX+9tXFaRudI5saIU4S8nQ1m
	lhlz/QRfQd12E0ASA8aTkmCpF6rqCoKer50RWIWN7w3MImsGK0Q+cW1ArFOjVkWsrreq3weRKyCiK
	bP+2D67+VWYLUZdQpEr1G84pBn8GP7XE3vToYlxvOjsjIwuUzJOWVvpe6gxPf9QUTMciaEByTb0Mr
	gNu+SdaD7fkDKnigHEWEwPda3h63Bt/31n93d11Mo7cQdktxi4Kcr+BzZLJ6SeAuK5VXo4Z2CWZA3
	1V5Vrpxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWdK-0000000DNqV-0noG;
	Mon, 24 Feb 2025 11:28:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWT8-0000000DJIN-15YN;
	Mon, 24 Feb 2025 11:17:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EC3F2611A9;
	Mon, 24 Feb 2025 11:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7DC4CED6;
	Mon, 24 Feb 2025 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395869;
	bh=LDVGiLQYV/om9iCPbzlHs+RRDrKvhxgu/48IGJERWAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4EvfZ3iTdpzan8dwcam1q0+i0m3CGliAH7xeZW5ZVIi1Cplfs8xpfxfp6TUsHXg7
	 bAO4vnXe4Br6CbHlW74pFnFApi+DQZ/eJU1DzJzzCj14XIYX26oUNmyo7p5vIgRNIM
	 iTZKMDgKHMKGHpDlNJQSyQNSInBLkG8ivCAfaV7KP5iwoZc4Sxx/tzRPFpznv0GGW1
	 BEg0aSHKdx7bPbYeL1JmEUEEoC/9bAs2fv9pMVg2erlWkYQhqFc2Hj1rAQSn5clyUH
	 I8D7bY1gpJ6E6Vm7Zh/oXjRDYI6XAdByzIXUQnrL+ag/EYDNidBKi2M20BM1/PLR8z
	 pS0RHJwSA/MNw==
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
Subject: [PATCH AUTOSEL 6.13 26/32] apple-nvme: Release power domains when probe fails
Date: Mon, 24 Feb 2025 06:16:32 -0500
Message-Id: <20250224111638.2212832-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit
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
index 4319ab50c10d1..0bca33dc48cc9 100644
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


