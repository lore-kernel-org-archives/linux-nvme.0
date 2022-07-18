Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F21C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wMzLUSZdoLVyO8wAGPcC9l5aUaiZrLm37cTPO2KHOG8=; b=kj73R0ftQnAbgnxuh+Ee4ziT66
	ONkZEkzpHnfzi7zjOxi2qHgJBBNz8S1EqChgfOlGAJRjKyBtDp6uLMNmuwSgkjCtUCeZCmTIjLuhP
	JBYw6VYolYAvZTCzd8cXb88Dipl/vYCtn4I55WnX+GrF+04kHuV1/PIx0RD3TMWc1Ok/YTk8cwynp
	0m2U9MD0NjOLZGLZqr/QanuoqkIIwGGaQtm1bbu7UbZGiezD8tt5990gBsX7SJaX9KR2ZUQnwvYpF
	sy82MNDqUc2w0b05H68KQL5Cbe+Mp40SvZyDaOWOJYr9uwDIYpK1PA4XaZJUSPbpZAan3eUduxlmU
	b0+f9SaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIvJ-00Ay5G-1t; Mon, 18 Jul 2022 05:04:01 +0000
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIvH-00Ay4G-2k; Mon, 18 Jul 2022 05:03:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: linux@roeck-us.net,
	hare@suse.de,
	sagi@grimberg.me
Subject: [PATCH] nvmet: fix a format specifier in nvmet_auth_ctrl_exponential
Date: Mon, 18 Jul 2022 07:03:56 +0200
Message-Id: <20220718050356.227647-1-hch@lst.de>
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

dh_keysize is a size_t, use the proper format specifier for printing it.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b41c7bbcc4366..cf690df347758 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -488,7 +488,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 		return -ENOKEY;
 	}
 	if (buf_size != ctrl->dh_keysize) {
-		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
+		pr_warn("ctrl %d DH public key size mismatch, need %zu is %d\n",
 			ctrl->cntlid, ctrl->dh_keysize, buf_size);
 		ret = -EINVAL;
 	} else {
-- 
2.30.2


