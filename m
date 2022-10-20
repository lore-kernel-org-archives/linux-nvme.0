Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF20C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+GxbU8XddRKisDnJi5ZsT+m92/bzA7OGk+xp+QKoLQ=; b=Ywn2KlyUiIrF5oNanrh7NgNIsq
	iAqaT/ayj/FpRZltSJc7nrSuzTU+qAxArQaFlioArCYYcbPYTWV6STSPja8e7IfcnVeMXnVHUcl7W
	B03CONIcJd/Uq5tCVnBVmG7DCPBWzXm9ccaVp/7lDHfrEIIzzftmWoSTI2JbMolKd3TQDqpyOzqBA
	cPv6bQnOCVZ14lSHtpJ64pUXZ6sOcFZKDruZeyTIGkVAgHEJGnlPVkDr2NnsH9lfYwcoXlwop7N37
	MFcUN6bruFxFqZW5rRnW68PKxzMcA2MfAnCpDmvkU4LcAMvrk9/Ac6RmaKbDcZ1H2LYlTh4912L1A
	3+N9+EwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olUFK-00EQjD-TJ; Thu, 20 Oct 2022 12:01:58 +0000
Received: from [88.128.92.117] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olTEB-00DqrG-No; Thu, 20 Oct 2022 10:56:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 7/8] nvme: remove nvme_set_queue_dying
Date: Thu, 20 Oct 2022 12:56:07 +0200
Message-Id: <20221020105608.1581940-8-hch@lst.de>
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

This helper is pretty pointless now, and also in the way of per-tagset
quiesce.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7fdb744979c..0ab3a18fd9f85 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5104,17 +5104,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 		blk_mq_wait_quiesce_done(ns->queue->tag_set);
 }
 
-/*
- * Prepare a queue for teardown.
- *
- * This must forcibly unquiesce queues to avoid blocking dispatch.
- */
-static void nvme_set_queue_dying(struct nvme_ns *ns)
-{
-	blk_mark_disk_dead(ns->disk);
-	nvme_start_ns_queue(ns);
-}
-
 /**
  * nvme_kill_queues(): Ends all namespace queues
  * @ctrl: the dead controller that needs to end
@@ -5130,10 +5119,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		nvme_start_admin_queue(ctrl);
-
 	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
-		list_for_each_entry(ns, &ctrl->namespaces, list)
-			nvme_set_queue_dying(ns);
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			blk_mark_disk_dead(ns->disk);
+			nvme_start_ns_queue(ns);
+		}
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
-- 
2.30.2


