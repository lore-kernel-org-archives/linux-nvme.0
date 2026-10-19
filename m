Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1C5CCA46C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30E3WmxCHpzxTNipae/RfGuwW1t1OnAEfmZnal2HKWk=; b=JKbsPU2G1mb+9Wv1H7e+0nXvqe
	rwzgemKEWJ3mWsMbC/zSaaeIxlg0YelSFqrdCQo65nM239xxJ3e0WxvQfmJ27NXZYrU/1VSvg/8L7
	xVax5ieb60Lr/XObp1Y/yyenVlPeIrdTw3DNYjrQUsY0fOLfyVufJonqbEzuKaaELP32I/NqL720a
	RIZ/UMcv2njXhY9LDN1+KZXmQ3n+QxHdjWHMtaUgFAQRFoieqe2EgQlkQtnuDmFOyCa3o5sGXO/7s
	OCv0UFz1aOpLgr7imiBnaDOZlwcC2Tnh5cFFz324wJiG9uG5hnQ3pkyNb0VYS6O/c4Rye+0Hred9y
	bVfVeraQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAx-00000006XfK-2EDv;
	Mon, 19 Oct 2026 03:36:39 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAt-00000006Xcf-1u20
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792380993; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=30E3WmxCHpzxTNipae/RfGuwW1t1OnAEfmZnal2HKWk=;
	b=qDsCJWpgLZdUVg1mPJ+hcACix8w5hn1hGDZKIv/gl6I32dD08zVLjJGZV6Q50s92mMgcE+0kzU76C2RtIji8+jlukozBJamx/0OFu5g5uLw4WTcd0IRAVuqVvLRuthY+qbf+tPQAi5LWddY986ZbBXTiy+5zk3PBkdDdbByYnLY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD-ZCMO_1792380992;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD-ZCMO_1792380992 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 11:36:32 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 03/11] nvme: export nvme_bdev_ops
Date: Mon, 19 Oct 2026 11:36:16 +0800
Message-ID: <20261019033624.402337-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019033624.402337-1-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_203636_700056_6B206D1E 
X-CRM114-Status: UNSURE (   8.72  )
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


