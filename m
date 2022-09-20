Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2630AC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZljDBsc03DOJO+UjSTrJVNDMVFYDunuw8dLJBTFZeQ=; b=gBivR7kyKNiw+Mj+67j+8xRsmF
	BeWtpowFJsG6NdDcCrkHl/ywAx+y7UdOeqY4n6HTtbuh88+Y4zEBJhJ8AzBUegqHrW4IlvSzF/HsF
	si26AVrBnJs3Qtg3c7zYSAW3X0OQok+tU+sBXTaFvytzzVOVeELbNF2H98Dma9zByF07RBo3Ol+0X
	nHQwJwOeUaIg+r5zmTvmlGvgTDmfR9iZMeaB5VqBjDjRUShSJo7RtWetKttRoGqn2J+Se15qt2CoP
	BtCUydaCRN5+suedCn9JWaQrWxGVPWsdFW6A1gIYyjEfcyX2GMHfqDazwWmgIGjKfYqYHYntWnifu
	q9LjuYOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrX-005LfV-ON; Tue, 20 Sep 2022 17:16:47 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrH-005LVt-F0; Tue, 20 Sep 2022 17:16:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 04/13] nvme-tcp: use the tagset alloc/free helpers
Date: Tue, 20 Sep 2022 19:16:02 +0200
Message-Id: <20220920171611.1289361-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920171611.1289361-1-hch@lst.de>
References: <20220920171611.1289361-1-hch@lst.de>
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

Use the common helpers to allocate and free the tagsets.  To make this
work the generic nvme_ctrl now needs to be stored in the hctx private
data instead of the nvme_tcp_ctrl.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/tcp.c | 101 +++++++---------------------------------
 1 file changed, 16 insertions(+), 85 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 863e985085d4d..3e7b29d07c713 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1687,51 +1687,6 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	return ret;
 }
 
-static int nvme_tcp_alloc_admin_tag_set(struct nvme_ctrl *nctrl)
-{
-	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
-	struct blk_mq_tag_set *set = &ctrl->admin_tag_set;
-	int ret;
-
-	memset(set, 0, sizeof(*set));
-	set->ops = &nvme_tcp_admin_mq_ops;
-	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	set->reserved_tags = NVMF_RESERVED_TAGS;
-	set->numa_node = nctrl->numa_node;
-	set->flags = BLK_MQ_F_BLOCKING;
-	set->cmd_size = sizeof(struct nvme_tcp_request);
-	set->driver_data = &ctrl->ctrl;
-	set->nr_hw_queues = 1;
-	set->timeout = NVME_ADMIN_TIMEOUT;
-	ret = blk_mq_alloc_tag_set(set);
-	if (!ret)
-		nctrl->admin_tagset = set;
-	return ret;
-}
-
-static int nvme_tcp_alloc_tag_set(struct nvme_ctrl *nctrl)
-{
-	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
-	struct blk_mq_tag_set *set = &ctrl->tag_set;
-	int ret;
-
-	memset(set, 0, sizeof(*set));
-	set->ops = &nvme_tcp_mq_ops;
-	set->queue_depth = nctrl->sqsize + 1;
-	set->reserved_tags = NVMF_RESERVED_TAGS;
-	set->numa_node = nctrl->numa_node;
-	set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
-	set->cmd_size = sizeof(struct nvme_tcp_request);
-	set->driver_data = &ctrl->ctrl;
-	set->nr_hw_queues = nctrl->queue_count - 1;
-	set->timeout = NVME_IO_TIMEOUT;
-	set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
-	ret = blk_mq_alloc_tag_set(set);
-	if (!ret)
-		nctrl->tagset = set;
-	return ret;
-}
-
 static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
 {
 	if (to_tcp_ctrl(ctrl)->async_req.pdu) {
@@ -1890,10 +1845,8 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_tcp_stop_io_queues(ctrl);
-	if (remove) {
-		blk_mq_destroy_queue(ctrl->connect_q);
-		blk_mq_free_tag_set(ctrl->tagset);
-	}
+	if (remove)
+		nvme_remove_io_tag_set(ctrl);
 	nvme_tcp_free_io_queues(ctrl);
 }
 
@@ -1906,13 +1859,12 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		return ret;
 
 	if (new) {
-		ret = nvme_tcp_alloc_tag_set(ctrl);
+		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
+				&nvme_tcp_mq_ops,
+				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING,
+				sizeof(struct nvme_tcp_request));
 		if (ret)
 			goto out_free_io_queues;
-
-		ret = nvme_ctrl_init_connect_q(ctrl);
-		if (ret)
-			goto out_free_tag_set;
 	}
 
 	/*
@@ -1959,10 +1911,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 out_cleanup_connect_q:
 	nvme_cancel_tagset(ctrl);
 	if (new)
-		blk_mq_destroy_queue(ctrl->connect_q);
-out_free_tag_set:
-	if (new)
-		blk_mq_free_tag_set(ctrl->tagset);
+		nvme_remove_io_tag_set(ctrl);
 out_free_io_queues:
 	nvme_tcp_free_io_queues(ctrl);
 	return ret;
@@ -1971,11 +1920,8 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_tcp_stop_queue(ctrl, 0);
-	if (remove) {
-		blk_mq_destroy_queue(ctrl->admin_q);
-		blk_mq_destroy_queue(ctrl->fabrics_q);
-		blk_mq_free_tag_set(ctrl->admin_tagset);
-	}
+	if (remove)
+		nvme_remove_admin_tag_set(ctrl);
 	nvme_tcp_free_admin_queue(ctrl);
 }
 
@@ -1988,26 +1934,17 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 		return error;
 
 	if (new) {
-		error = nvme_tcp_alloc_admin_tag_set(ctrl);
+		error = nvme_alloc_admin_tag_set(ctrl,
+				&to_tcp_ctrl(ctrl)->admin_tag_set,
+				&nvme_tcp_admin_mq_ops, BLK_MQ_F_BLOCKING,
+				sizeof(struct nvme_tcp_request));
 		if (error)
 			goto out_free_queue;
-
-		ctrl->fabrics_q = blk_mq_init_queue(ctrl->admin_tagset);
-		if (IS_ERR(ctrl->fabrics_q)) {
-			error = PTR_ERR(ctrl->fabrics_q);
-			goto out_free_tagset;
-		}
-
-		ctrl->admin_q = blk_mq_init_queue(ctrl->admin_tagset);
-		if (IS_ERR(ctrl->admin_q)) {
-			error = PTR_ERR(ctrl->admin_q);
-			goto out_cleanup_fabrics_q;
-		}
 	}
 
 	error = nvme_tcp_start_queue(ctrl, 0);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_tagset;
 
 	error = nvme_enable_ctrl(ctrl);
 	if (error)
@@ -2027,15 +1964,9 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 out_stop_queue:
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
-out_cleanup_queue:
-	if (new)
-		blk_mq_destroy_queue(ctrl->admin_q);
-out_cleanup_fabrics_q:
-	if (new)
-		blk_mq_destroy_queue(ctrl->fabrics_q);
-out_free_tagset:
+out_cleanup_tagset:
 	if (new)
-		blk_mq_free_tag_set(ctrl->admin_tagset);
+		nvme_remove_admin_tag_set(ctrl);
 out_free_queue:
 	nvme_tcp_free_admin_queue(ctrl);
 	return error;
-- 
2.30.2


