Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CEFC43462
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 08:13:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7408D600EF
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 08:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7408D600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7jzwDd/S+jbpS6bPWIFSUB3EdvsD5ptOAmOhrHgDGus=; b=IxpgGzCzP91eLAsyF7+JHg01j/
	+4iqP7sebpSTUpYNfHv3a/hgTmRViFUdRlX8Ax7D1ad588I0GXBy4TWXC8q0yifl9KMhhjsc3QuU9
	xeaoBlLhaWahWDv+r7L2cX+7HedXW1nYsNJ1/RufNvczZ6yJe0wh+A315vnJ88rFuditGMm3V3uIn
	bRx6/XoiHtUuTd4GNZstXPge88d73LfpoD4FI2xMsedJRdaqYukQezcS3bNaInvPUBqpeBhDjlMSG
	vVZf3pdumGm+DQYnRb4u2Acl913ZeO3TdDHJmGnBVVnJy8Xw1ETlwLagDcCvyieVBHdRfeaRYeNGQ
	IJoRstmQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVrgv-0064Mw-Cx; Mon, 12 Apr 2021 08:13:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrgr-0064MF-Hh
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 08:13:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=tpiViasTP3h3Z5SnmA2Wpk6Kw40U+CypP15POJv1EkI=; b=xSmu7Nrn5x1YCKXGjlZRyRXZW6
 M3bXvttjnGA/jB0EAHRFSitijaLx1w5nfGBhSW7QHH6rVPZOVYlIS6FHK0n042CDmXb0Aw8saxylk
 xJDgXfiDOm99ImYxXXrgeZZg+5xW9QQGX4i8LYyKrZ3+Wp+N3TKdRDx4wnPnRYpJiFhOmjUtoI2RA
 KIuwRoIZpVeYrf96Jmr5NcWvHPQ2AwSpSkOeCtRXn7jghIVYuO5ive7CTF34r/mI0I3VKlJ3EidLI
 gQ/q0AjaVCo/QX+jIfOyYgI77EWzU3Vh9hQg8p4VScObf4nVtO40hy8dc8RVAP560VmRJjp7AvAtr
 GNp6mo2A==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrgp-005xln-EX; Mon, 12 Apr 2021 08:12:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: mb@lightnvm.io,
	axboe@kernel.dk,
	javier@javigon.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
Date: Mon, 12 Apr 2021 10:12:57 +0200
Message-Id: <20210412081257.2585860-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Lightnvm was an innovative idea to expose more low-level control over SSDs.
But it failed to get properly standardized and remains a non-standarized
extension to NVMe that requires vendor specific quirks for a few now mostly
obsolete SSD devices.  The standardized ZNS command set for NVMe has take
over a lot of the approaches and allows for fully standardized operation.

Remove the Linux code to support open channel SSDs as the few production
deployments of the above mentioned SSDs are using userspace driver stacks
instead of the fairly limited Linux support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/lightnvm/Kconfig | 4 +++-
 drivers/lightnvm/core.c  | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 4c2ce210c1237d..04caa0f2d445c7 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menuconfig NVM
-	bool "Open-Channel SSD target support"
+	bool "Open-Channel SSD target support (DEPRECATED)"
 	depends on BLOCK
 	help
 	  Say Y here to get to enable Open-channel SSDs.
@@ -15,6 +15,8 @@ menuconfig NVM
 	  If you say N, all options in this submenu will be skipped and disabled
 	  only do this if you know what you are doing.
 
+	  This code is deprecated and will be removed in Linux 5.15.
+
 if NVM
 
 config NVM_PBLK
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 28ddcaa5358b14..4394f47c81296a 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
 {
 	int ret, exp_pool_size;
 
+	pr_warn_once("lightnvm support is deprecated and will be removed in Linux 5.15.\n");
+
 	if (!dev->q || !dev->ops) {
 		kref_put(&dev->ref, nvm_free);
 		return -EINVAL;
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
