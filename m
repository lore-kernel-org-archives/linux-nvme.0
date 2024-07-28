Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2594FC3DA61
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jul 2024 00:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YzRASQaNIFk/zsZun+KJ26BwU1T0bZNxI2bNa2g9GOA=; b=YdKxiijHuyd6aj/HZtcPmNqUaT
	QNMbUE+ILbMskhvr/Jb2PxxGUAnFIx5ef+vEozKRSTO91vLH353OpFp/QJXebra8Ldgw8VD9r6wmG
	hQopWd6THVUvpGGpjM8ZaKRYoVFZSnyPr3/2ix7kf/eU5ruI0FKEJOceDByBieRw6MAjSosqYiOwW
	P+OjkVRUqoDPiAnmU3S69IM0hbAzFW91UG+57iIsoaLzX6uYgQCNimV/QuhwtTYGH617Vo56weDTm
	MW2uHRpSYZ6Y6DmPjxUZB0kz38bCisnKyeAvM/JY9oumefdBN8Ah+IBesdicK1XsZOfIuDzxn5kWa
	/bixn8lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXs5Q-00000007YxL-0cn3;
	Sun, 28 Jul 2024 00:48:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXs50-00000007Yq3-0BA8;
	Sun, 28 Jul 2024 00:48:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 394DE6110F;
	Sun, 28 Jul 2024 00:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7208DC4AF07;
	Sun, 28 Jul 2024 00:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127682;
	bh=khxLmE/KexPrqmoJqixnEExY2F0di46Bbsj2Br7SAmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pq+NXOZLcJbOtXKJkzuAzBAuIMVKya0zDssHlfMIeIMR48wDSe5glAQBCKSeF6fo2
	 XvuWk19EtxpEN9hurx0km0gE9X4w820XTpR6ghuEX552ENIyLsZSLa3LVPDhG7Fj5q
	 DOwx4PP7wXUXAvl7lyBnvrX3LgTiRFFYcd5fQQTZqHxBfgzDcGPoTC4+oVaZGF/kxS
	 ov7FIPotqsoXNCr2QMQ8ikDj/byBdlBmhHNfpBFYEa6MN5U+E16r/YhZM9HXAbsNL/
	 lEsACZN6VSYLR6xotFhM8s1Fgnv506a7SXUQvnOXDMbDZRUqWFSxPZM9uDyYEC2l8Z
	 noXeQLcIgUNnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	marcan@marcan.st,
	sven@svenpeter.dev,
	sagi@grimberg.me,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 12/16] nvme: apple: fix device reference counting
Date: Sat, 27 Jul 2024 20:47:29 -0400
Message-ID: <20240728004739.1698541-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004739.1698541-1-sashal@kernel.org>
References: <20240728004739.1698541-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240727_174806_156675_A86DBC29 
X-CRM114-Status: GOOD (  14.05  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit b9ecbfa45516182cd062fecd286db7907ba84210 ]

Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
Split the allocation side out to make the error handling boundary easier
to navigate. The apple driver had been doing this wrong, leaking the
controller device memory on a tagset failure.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/apple.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 0cfa39361d3b6..25ecc1a005c5a 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1388,7 +1388,7 @@ static void devm_apple_nvme_mempool_destroy(void *data)
 	mempool_destroy(data);
 }
 
-static int apple_nvme_probe(struct platform_device *pdev)
+static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct apple_nvme *anv;
@@ -1396,7 +1396,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 
 	anv = devm_kzalloc(dev, sizeof(*anv), GFP_KERNEL);
 	if (!anv)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	anv->dev = get_device(dev);
 	anv->adminq.is_adminq = true;
@@ -1516,10 +1516,26 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		goto put_dev;
 	}
 
+	return anv;
+put_dev:
+	put_device(anv->dev);
+	return ERR_PTR(ret);
+}
+
+static int apple_nvme_probe(struct platform_device *pdev)
+{
+	struct apple_nvme *anv;
+	int ret;
+
+	anv = apple_nvme_alloc(pdev);
+	if (IS_ERR(anv))
+		return PTR_ERR(anv);
+
 	anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
 	if (IS_ERR(anv->ctrl.admin_q)) {
 		ret = -ENOMEM;
-		goto put_dev;
+		anv->ctrl.admin_q = NULL;
+		goto out_uninit_ctrl;
 	}
 
 	nvme_reset_ctrl(&anv->ctrl);
@@ -1527,8 +1543,9 @@ static int apple_nvme_probe(struct platform_device *pdev)
 
 	return 0;
 
-put_dev:
-	put_device(anv->dev);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(&anv->ctrl);
+	nvme_put_ctrl(&anv->ctrl);
 	return ret;
 }
 
-- 
2.43.0


