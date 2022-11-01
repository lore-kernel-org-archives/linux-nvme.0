Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439B9C43217
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFIffKMuruxaQXIDQ4KlSxJoVoIR2c5sW2+Wi5AWYDI=; b=vBQWGqoKnngx+j1yeeC3rcyl4Q
	LlsPkYWoDAprWkq6PRtiOZpz5fUCyIdEOjTDcHb/k04H0CrCO3L8xcM/ynH7opdnj7+KF2j4iLcRF
	BXxcmewvxoH/K7+3eTbLJRes9KJOz6oj3IQQqFds8Tb0JwfZTixLWYcdfNHfJKlSrWYP/bzYJXbkZ
	xLwW+YlfL8CYyDCL6T5FtFI4eb/8KLgS/mugPAwhQIoGvvPlBEiKaFrAfY+q7sup3PVZBdMIs0nv4
	ghx6p5GpqReUVABOPdTvwIepIWBC4t03VHaOnjgwMEeE50Aim1//5ZapMART7jFTVFBUQm9r8juUR
	ICyXGDDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opsm3-005hGn-8T; Tue, 01 Nov 2022 15:01:55 +0000
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opsla-005gqg-2H; Tue, 01 Nov 2022 15:01:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/14] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Date: Tue,  1 Nov 2022 16:00:46 +0100
Message-Id: <20221101150050.3510-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
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
so skip doing any synchronization.  No non-mq driver should be calling
this, but for now we have core callers that unconditionally call into it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 623e8a506539c..b8f37cfd3ae22 100644
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


