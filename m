Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7649FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LvTFgyuT6fo8/ALdMBfQmoYn1gXAh4wW/Q62m4CJdjY=; b=2CtYft5DE/CaVSamhHvmFf6HlO
	apRCz5pSZhnb0hhX9qhvXxghTqeThgiJ3gMPQK5QiFISxMPi8r5NLCu1C7Ls8wFSXLRDCux+yjupa
	JZf+0BbqTpfAzyYEl+RSKae1QBJeLNNjm969FxR+1P5fDpJgnnjKqZHKfenhWc0R6+PP4jiY8jL+t
	XWRd7RHP1w4FzUVrAzi31lnbmuUUGGBJAnm3z0YKZ46C36e7JsK1LZxrBMe4CXnqWUkmG7Fyxkxz9
	r+Fs0SbxsiJlMpkjlIfPZTY/G0lWjDZdsJBqiXWB4RDzMDIm8d+FgS068T9WwKUGuxmyioeRhkb4s
	2+9CgE1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIwL-00AyI9-5J; Mon, 18 Jul 2022 05:05:05 +0000
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIwI-00AyGk-Iv; Mon, 18 Jul 2022 05:05:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: marcan@marcan.st,
	sven@svenpeter.dev
Cc: alyssa@rosenzweig.io,
	linux-nvme@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] nvme-apple: stop casting function pointer signatures
Date: Mon, 18 Jul 2022 07:05:00 +0200
Message-Id: <20220718050500.227804-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

Casting function pointers breaks control flow enforcement and is
generally a horrible coding style.

Add two wrapper to get rid of these casts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 7816b5a7d0e1b..3cf607bb9ee6c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1220,6 +1220,11 @@ static void apple_nvme_async_probe(void *data, async_cookie_t cookie)
 	nvme_put_ctrl(&anv->ctrl);
 }
 
+static void devm_apple_nvme_put_tag_set(void *data)
+{
+	blk_mq_free_tag_set(data);
+}
+
 static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 {
 	int ret;
@@ -1236,8 +1241,7 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	ret = blk_mq_alloc_tag_set(&anv->admin_tagset);
 	if (ret)
 		return ret;
-	ret = devm_add_action_or_reset(anv->dev,
-				       (void (*)(void *))blk_mq_free_tag_set,
+	ret = devm_add_action_or_reset(anv->dev, devm_apple_nvme_put_tag_set,
 				       &anv->admin_tagset);
 	if (ret)
 		return ret;
@@ -1261,8 +1265,8 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	ret = blk_mq_alloc_tag_set(&anv->tagset);
 	if (ret)
 		return ret;
-	ret = devm_add_action_or_reset(
-		anv->dev, (void (*)(void *))blk_mq_free_tag_set, &anv->tagset);
+	ret = devm_add_action_or_reset(anv->dev, devm_apple_nvme_put_tag_set,
+					&anv->tagset);
 	if (ret)
 		return ret;
 
@@ -1363,6 +1367,11 @@ static int apple_nvme_attach_genpd(struct apple_nvme *anv)
 	return 0;
 }
 
+static void devm_apple_nvme_mempool_destroy(void *data)
+{
+	mempool_destroy(data);
+}
+
 static int apple_nvme_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1460,8 +1469,8 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto put_dev;
 	}
-	ret = devm_add_action_or_reset(
-		anv->dev, (void (*)(void *))mempool_destroy, anv->iod_mempool);
+	ret = devm_add_action_or_reset(anv->dev,
+			devm_apple_nvme_mempool_destroy, anv->iod_mempool);
 	if (ret)
 		goto put_dev;
 
-- 
2.30.2


