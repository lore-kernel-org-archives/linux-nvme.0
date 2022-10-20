Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36208C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rdh/ukHkGwTBSIvYNfMZv3IMoj7GaM7F+XPHF6FU2sI=; b=2tlkRKgwCs1aS7YjSTcdYuqwK2
	MC1YNvRHuaLV0q8MZ8HPjwJR4C6PPwBoi/ITVoh0ISYD13jBL0q855lUmlKRj9Oc9RV86pPWPdLkS
	cASJBCaP5yjbn9q16voqqlX2QOPtF0SCzX/jShrOM4vC+la5jtzjBre8B2lT3H/DFVUrN9ro86BYt
	wU7pVpzlHhqQve6lKDkszGLUi+f1GCj4RYMzLVm+DPnrnt5sAsji/A2Gv7Vj1IGYvFWuM+yf52oQ4
	8bSpYzVxcTCEZ8niK1jdfYn77UQ7ziU9w+03JI61YM/9/5p7pSqNo0xDFsoVtoMLniCtk3888T57m
	QY2OasCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olUCz-00EPCv-8M; Thu, 20 Oct 2022 11:59:33 +0000
Received: from [88.128.92.117] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olTDv-00Dqfc-90; Thu, 20 Oct 2022 10:56:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Date: Thu, 20 Oct 2022 12:56:02 +0200
Message-Id: <20221020105608.1581940-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
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

For submit_bio based queues there is no (S)RCU critical section during
I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
so skip doing any synchronization.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33292c01875d5..df967c8af9fee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -280,7 +280,9 @@ EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
 	blk_mq_quiesce_queue_nowait(q);
-	blk_mq_wait_quiesce_done(q);
+	/* nothing to wait for non-mq queues */
+	if (queue_is_mq(q))
+		blk_mq_wait_quiesce_done(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
-- 
2.30.2


