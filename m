Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8131BC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1n154abD7ykqXhSpvM/N9XK6PsmXZsE/UnXOBast6MU=; b=agbq7OmFZh1OO882c0O6dizPKC
	JDQB+UdeZa1czbQbS1KbWFKiGEI40gDKoIJ2DwobLb+ldXJda2wkNNiQhE+s6qGUfyDSBhTtYHhkl
	G6QPuc27H4ZuW3c3nAQhqpM/sz9HfaH4K0UHKw/Ln7Ei552wIM4DR2hs9pUNYjga+54vUPZi52jlu
	FDepmSEXs2XbpNEsUrkGqkDPEx1kG2WviA4vsrrSqQGsJMtn7gqahRLvsqpGIGCRqbcjAL/cdOWiN
	exbO5MQJzZDy8aLAsvZzNEhUvMlZ4rpQ1o+r5kXLY14S1FBmJsuZo9zI8nifM2FXY5in6RBAA7fQP
	FXxb3gdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagr9-005LTz-HV; Tue, 20 Sep 2022 17:16:23 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagr5-005LSI-FC; Tue, 20 Sep 2022 17:16:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 01/13] nvme: add common helpers to allocate and free tagsets
Date: Tue, 20 Sep 2022 19:15:59 +0200
Message-Id: <20220920171611.1289361-2-hch@lst.de>
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

Add common helpers to allocate and tear down the admin and I/O tag sets,
including the special queues allocated with them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 100 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   8 ++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8c9c1176624da..f8d9f32adc87c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4800,6 +4800,106 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
+int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int flags,
+		unsigned int cmd_size)
+{
+	int ret;
+
+	memset(set, 0, sizeof(*set));
+	set->ops = ops;
+	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		set->reserved_tags = NVMF_RESERVED_TAGS;
+	set->numa_node = ctrl->numa_node;
+	set->flags = flags;
+	set->cmd_size = cmd_size;
+	set->driver_data = ctrl;
+	set->nr_hw_queues = 1;
+	set->timeout = NVME_ADMIN_TIMEOUT;
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret)
+		return ret;
+
+	ctrl->admin_q = blk_mq_init_queue(set);
+	if (IS_ERR(ctrl->admin_q)) {
+		ret = PTR_ERR(ctrl->admin_q);
+		goto out_free_tagset;
+	}
+
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
+		ctrl->fabrics_q = blk_mq_init_queue(set);
+		if (IS_ERR(ctrl->fabrics_q)) {
+			ret = PTR_ERR(ctrl->fabrics_q);
+			goto out_cleanup_admin_q;
+		}
+	}
+
+	ctrl->admin_tagset = set;
+	return 0;
+
+out_cleanup_admin_q:
+	blk_mq_destroy_queue(ctrl->fabrics_q);
+out_free_tagset:
+	blk_mq_free_tag_set(ctrl->admin_tagset);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
+
+void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
+{
+	blk_mq_destroy_queue(ctrl->admin_q);
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		blk_mq_destroy_queue(ctrl->fabrics_q);
+	blk_mq_free_tag_set(ctrl->admin_tagset);
+}
+EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
+
+int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int flags,
+		unsigned int cmd_size)
+{
+	int ret;
+
+	memset(set, 0, sizeof(*set));
+	set->ops = ops;
+	set->queue_depth = ctrl->sqsize + 1;
+	set->reserved_tags = NVMF_RESERVED_TAGS;
+	set->numa_node = ctrl->numa_node;
+	set->flags = flags;
+	set->cmd_size = cmd_size,
+	set->driver_data = ctrl;
+	set->nr_hw_queues = ctrl->queue_count - 1;
+	set->timeout = NVME_IO_TIMEOUT;
+	if (ops->map_queues)
+		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret)
+		return ret;
+
+	ctrl->connect_q = blk_mq_init_queue(set);
+        if (IS_ERR(ctrl->connect_q)) {
+		ret = PTR_ERR(ctrl->connect_q);
+		goto out_free_tag_set;
+	}
+
+	ctrl->tagset = set;
+	return 0;
+
+out_free_tag_set:
+	blk_mq_free_tag_set(set);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_alloc_io_tag_set);
+
+void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		blk_mq_destroy_queue(ctrl->connect_q);
+	blk_mq_free_tag_set(ctrl->tagset);
+}
+EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
+
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1bdf714dcd9e4..6dec8a3bef1aa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -722,6 +722,14 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl);
+int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int flags,
+		unsigned int cmd_size);
+void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl);
+int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int flags,
+		unsigned int cmd_size);
+void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
-- 
2.30.2


