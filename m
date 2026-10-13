Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1315CCA9ED0
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 02:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30E3WmxCHpzxTNipae/RfGuwW1t1OnAEfmZnal2HKWk=; b=MWPL51yOStmZ51HFJAlZqlKRcE
	YJZLZ1W229zArUDTD69iD7MJq6HJMvN3aOGC2RV2AMd0UzZesnpTMJEwzhVRJnihjLykYhSaL0WN2
	Odh0bIq6f5RirYsmCDG+XEBekqPUsfGOkcoIaYoAx5A3GGGwT/4BruEy/PqeMHlCc7ZCa7Hg9CKYH
	X0Ueay2LltG8c9TzOhBCEPDK7UunUOHgu2BmaS0/dwpjMsTJouiLBabrnOG5ERBVZJAEw/2qB1Wem
	X6RIIr4pkAu5afsdaL/64xpwvkBgQvADFo73Xt3Db17Q4EFHyeOBSUNo4MU3FPskLeIjE0plQSEK7
	2EQPmlCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8t-0000000BmVy-2yl2;
	Tue, 13 Oct 2026 02:21:27 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8q-0000000BmSa-189A
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 02:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791858080; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=30E3WmxCHpzxTNipae/RfGuwW1t1OnAEfmZnal2HKWk=;
	b=ZVLVgqX+5zDk+srNh2eaahAuPN3zBBWX92dQGhqYCnZv2Ti+5fOl9umno6/RhDa7MVkaIUagWKlS5akqVlAqXcuOU3hVDlMqMK3BxQpbHcZ2spvcOolepC5Ps0HJCUQMfqAWV9p0e7sb2THCg7CQRjkfWxJKb3HcxXIDnb/D/Ok=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCk3N11_1791858078;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCk3N11_1791858078 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 10:21:18 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 03/11] nvme: export nvme_bdev_ops
Date: Tue, 13 Oct 2026 10:21:01 +0800
Message-ID: <20261013022109.1507911-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261013022109.1507911-1-kanie@linux.alibaba.com>
References: <20261013022109.1507911-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_192124_482992_F6B2FF0A 
X-CRM114-Status: UNSURE (   8.29  )
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

Export the NVMe block device operations so that other subsystems can
recognize a block device as an NVMe namespace through its operations
pointer and reach the NVMe structures behind it.  The NVMe target FDP
bridge uses this to detect an NVMe backing device of a namespace.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1322c678f4eb8..b22aebc802920 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2712,6 +2712,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
+EXPORT_SYMBOL_GPL(nvme_bdev_ops);
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 		u32 timeout, const char *op)
-- 
2.43.7


