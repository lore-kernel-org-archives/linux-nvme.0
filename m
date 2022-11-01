Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C926AC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLmgUevMzzrLRuQx97jRlnGVQcnqlnKGWkKm3cCI3M0=; b=pKfmAIIoEPiNiW3QygYveppcsg
	62UdtrOopCHfO3pwMdJyowaGhCwUyY1FLOz4d4CfEh1Z2kBIfQ4xcO9V0UN1F9Iw2Ce1dgeMIA4a5
	YZSIK/FuYnf3gdzdsN7m0Oc54otG0cZoceOpue+nO00RlIOdoGvGQGWF0v/feG6hqNDzfYFBSW2QA
	gJFZvT1D6sjMg2HmTQ1jAORyxsjZEIU9B3Pu/3Etw1P8Dzwjpsvv7Y8+RrGdwNd0f4sCR/yAqRcBs
	JKKnoMwPvRb0ANBUKRVswczc/vjx8Keg/ZC31VLFV1Xa7eMxTIJZ3eQOvclm66euGS/4mNayk0TRf
	8ULAAQjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslg-005gxl-Ln; Tue, 01 Nov 2022 15:01:32 +0000
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslN-005gkj-Vh; Tue, 01 Nov 2022 15:01:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 06/14] nvme: don't unquiesce the admin queue in nvme_kill_queues
Date: Tue,  1 Nov 2022 16:00:42 +0100
Message-Id: <20221101150050.3510-7-hch@lst.de>
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

None of the callers of nvme_kill_queues needs it to unquiesce the
admin queues, as all of them already do it themselves:

 1) nvme_reset_work explicit call nvme_start_admin_queue toward the
    beginning of the function.  The extra call to nvme_start_admin_queue
    in nvme_reset_work this won't do anything as
    NVME_CTRL_ADMIN_Q_STOPPED will already be cleared.
 2) nvme_remove calls nvme_dev_disable with shutdown flag set to true at
    the very beginning of the function if the PCIe device was not present,
    which is the precondition for the call to nvme_kill_queues.
    nvme_dev_disable already calls nvme_start_admin_queue toward the
    end of the function when the shutdown flag is set to true, so the
    admin queue is already enabled at this point.
 3) nvme_remove_dead_ctrl schedules a workqueue to unbind the driver,
    which will end up in nvme_remove, which calls nvme_dev_disable with
    the shutdown flag.  This case will call nvme_start_admin_queue a bit
    later than before.
 4) apple_nvme_remove uses the same sequence as nvme_remove_dead_ctrl
    above.
 5) nvme_remove_namespaces only calls nvme_kill_queues when the
    controller is in the DEAD state.  That can only happen in the PCIe
    driver, and only from nvme_remove. See item 2) above for the
    conditions there.

So it is safe to just remove the call to nvme_start_admin_queue in
nvme_kill_queues without replacement.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 871a8ab7ec199..bb62803de5b21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5135,10 +5135,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 
-	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
-		nvme_start_admin_queue(ctrl);
-
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_set_queue_dying(ns);
 
-- 
2.30.2


