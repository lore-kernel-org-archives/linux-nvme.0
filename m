Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9456FC54E66
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s/lKq9Jcz/HSLy7vuLZHLPh6PjqvM2ejFKvmo0MuiDw=; b=JHpkxhhA1PbXQfegtD17N9dtCY
	gv7/l6TTxbYHwjKJxiJZdEouJkECsez5XvauJCA+sgSv5OLn2wh1Yqb3mqxAlwjxM8SixzFzudFOz
	+TqJY2vQ9uSU4hjHE6aYi73YMu6cjs2e5e5cVbta5aqxc6AkxAhwVZXIziMhzTJ174euVk3b8f7qv
	abCjQfH2tP/HHyDQ7hUSYQAR0xBUas0vBKKek8iCcOIbBQ/N+4NxiT9L3GUxVn3fAIXcrDTp3fhW7
	H9iQk8YATW3cM8pb0Ws/xtxUHPscmw4NTgYZ1m6RROqTy847NR3Yadp9W2OBkl8Bin5aPdz+twCGZ
	XypgkoBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjwwr-00000004mPB-0qRM;
	Tue, 12 Mar 2024 07:53:21 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjwwo-00000004mNt-2tlB
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 07:53:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710229996; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=s/lKq9Jcz/HSLy7vuLZHLPh6PjqvM2ejFKvmo0MuiDw=;
	b=ebND/LCUUnwSKXB3FZ8YVTwXjIRMjG4jD9dlWR12ZS/0SxHu0nkpMFXkfwiFblaiOsaw6LdVNPCZXBK2sl+jA1S+9ZQnfyoYXA6pGR0ssw9QQaIexWAiiecYDFaX5d4wK4EdquLhlBOaQXNAYaduzz7UD/Y+kMtVfZ3utcXjr2s=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2L3uIz_1710229990;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2L3uIz_1710229990)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 15:53:15 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: use nvme_disk_is_ns_head helper
Date: Tue, 12 Mar 2024 15:53:10 +0800
Message-ID: <20240312075310.92594-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_005319_076567_522C7A63 
X-CRM114-Status: UNSURE (   7.89  )
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

Use nvme_disk_is_ns_head helper instead of check
fops directly.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f2832f70e7e0..ac8d622b5fc0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -240,7 +240,7 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 	int ret;
 
 	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
-	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+	    nvme_disk_is_ns_head(bdev->bd_disk))
 		ret = ns_head_update_nuse(head);
 	else
 		ret = ns_update_nuse(bdev->bd_disk->private_data);
-- 
2.43.0


