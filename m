Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41247C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rc4X/7ko+xjEY0h4azgIlZy8VgmLDuQMzy5hkf3b2uU=; b=TVlSVTOyzCmBIZixug5aG8dnIS
	i3EV9zbXL6rN//GlpX1VuhEphcRzOJaMyJU9UYiupgGtDOJwSq/JwqSCDJg1XfX2Q5wUQFy+prPeI
	RkGZaZDhjCsuGUH8vchDM7rXr7c2vTRDTJQIIAytwxS0zdktpa1kDDefJ3P9B/DnVjI/jzzyAkk7H
	4klxDUVUTpiqKtSDWogFvZ0wy13wTWDzDcq0ZSXN7BAuAyZL4jtWzUHcnPOMAJ15yqB6IJ82neIYn
	iGiCNFZLGVMH1PKA3I/8KIIp4zc8z0wvLCvGFiscJiXyKQ/lei9JUQ1SzwUl8PzN4k6lAangek0SM
	hyLEKBiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIt7-00Axch-MV; Mon, 18 Jul 2022 05:01:45 +0000
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIt6-00AxbO-7e; Mon, 18 Jul 2022 05:01:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me,
	hare@suse.de,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmet: don't check for NULL pointer before kfree in nvmet_host_release
Date: Mon, 18 Jul 2022 07:01:41 +0200
Message-Id: <20220718050141.226774-1-hch@lst.de>
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

And add an empty line after the variable declaration.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 1b11f6a83bb6c..79ff382a5b145 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1788,9 +1788,9 @@ static struct configfs_attribute *nvmet_host_attrs[] = {
 static void nvmet_host_release(struct config_item *item)
 {
 	struct nvmet_host *host = to_host(item);
+
 #ifdef CONFIG_NVME_TARGET_AUTH
-	if (host->dhchap_secret)
-		kfree(host->dhchap_secret);
+	kfree(host->dhchap_secret);
 #endif
 	kfree(host);
 }
-- 
2.30.2


