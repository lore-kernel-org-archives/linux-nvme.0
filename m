Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB8DC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AJym+K/s0ppxPjKLKxbKoyZECEhljQvNE8HtaC36uJ4=; b=Ky3DVRLRHQiYNXKxRMPEChn9Wa
	XXUUn5fznLXsWHxOCYWQ0OCRSbLCSJhenoi9iXw86JE68strqjiBMMBUEou4/DFYaGi/JZfEAEVfN
	m91EUzcI/Etc19g5VTB4jqfWNBRGU2k53RhLnLTHLTQYAqsEQ4EH6D3Hd9Yd73ufs8+9wRbKe+9NO
	uPTAzunus1YlD6Gex0RBK/d7UPo1EHW1k2/yWlOqlYtZYm6cTMwc4OjJkU10GHEZBqWgp2uCIN8GD
	HqnhXF52J3c9nb4uZyTIcpkTBbUeqRgQ2lR+bGnHDKYuYySO8T8MI1ZnxsOxHArjcc392sH7dZXyK
	AT8HoBwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL8R-005rA4-Se; Tue, 25 Oct 2022 14:42:31 +0000
Received: from [12.47.128.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6Q-005ppG-2X; Tue, 25 Oct 2022 14:40:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/17] nvme: use blk_mq_[un]quiesce_tagset
Date: Tue, 25 Oct 2022 07:40:20 -0700
Message-Id: <20221025144020.260458-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
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

From: Chao Leng <lengchao@huawei.com>

All controller namespaces share the same tagset, so we can use this
interface which does the optimal operation for parallel quiesce based on
the tagset type(e.g. blocking tagsets and non-blocking tagsets).

nvme connect_q should not be quiesced when quiesce tagset, so set the
QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.

Currently we use NVME_NS_STOPPED to ensure pairing quiescing and
unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
In addition, we never really quiesce a single namespace. It is a better
choice to move the flag from ns to ctrl.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[hch: rebased on top of prep patches]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 34 ++++++++--------------------------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 012ef0772f5b3..ff9ed2467fb30 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4880,6 +4880,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
+		blk_queue_flag_set(QUEUE_FLAG_SKIP_TAGSET_QUIESCE,
+				   ctrl->connect_q);
 	}
 
 	ctrl->tagset = set;
@@ -5079,20 +5081,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
-static void nvme_start_ns_queue(struct nvme_ns *ns)
-{
-	if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
-		blk_mq_unquiesce_queue(ns->queue);
-}
-
-static void nvme_stop_ns_queue(struct nvme_ns *ns)
-{
-	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
-		blk_mq_quiesce_queue(ns->queue);
-	else
-		blk_mq_wait_quiesce_done(ns->queue->tag_set);
-}
-
 /* let I/O to all namespaces fail in preparation for surprise removal */
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 {
@@ -5155,23 +5143,17 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_stop_ns_queue(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		blk_mq_quiesce_tagset(ctrl->tagset);
+	else
+		blk_mq_wait_quiesce_done(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_start_ns_queue(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		blk_mq_unquiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1cd7168002438..f9df10653f3c5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -237,6 +237,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FAILFAST_EXPIRED	= 0,
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
 	NVME_CTRL_STARTED_ONCE		= 2,
+	NVME_CTRL_STOPPED		= 3,
 };
 
 struct nvme_ctrl {
@@ -486,7 +487,6 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
-#define NVME_NS_STOPPED		5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.30.2


