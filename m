Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5251DC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=32gcBcTOoEyNa7WE7SYl74DLUGEDvSjsJaXSa9wpXZI=; b=2SGi+iXtK8Av50+2csr1TWJBDE
	eGghvIVh1uA9yjgi0pvaBWRX9XpHWnu5dqQdIwp6C6w8mD074LRnHPNVoo4Z2TQvh1Ww5MLDjTI2C
	esrRlwemE31RxYwzRQfs5qQPaO/45LfGViy4wZ2OOV/Lm9UXm257CTl6HrhjMkyj4yyx8kAmi0xiT
	l1FOSKzHKXlqjCfFPPWE8KupCf0T9z2B5NNd39SLGRJvzGZd7Echfl4xvR3gu1aesH7NON7yhey3T
	IdqvUGP8lwPEyvfCBlflD7ePskUqYWmgNCgfKcJw13Is8CaSHvCqcpVh5EbBeLu5kg2MuZMMIWTfn
	9VaYpZgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPcm-000yjR-Mz; Thu, 21 Jul 2022 06:25:28 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPca-000yYN-PY; Thu, 21 Jul 2022 06:25:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme-tcp: split nvme_tcp_alloc_tagset
Date: Thu, 21 Jul 2022 08:25:06 +0200
Message-Id: <20220721062506.1712176-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721062506.1712176-1-hch@lst.de>
References: <20220721062506.1712176-1-hch@lst.de>
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

Split nvme_tcp_alloc_tagset into one helper for the admin tag_set and
one for the I/O tag set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/tcp.c | 82 ++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a37c374e974..e9d5b052b2bb6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1688,45 +1688,49 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	return ret;
 }
 
-static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
-		bool admin)
+static int nvme_tcp_alloc_admin_tag_set(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
-	struct blk_mq_tag_set *set;
+	struct blk_mq_tag_set *set = &ctrl->admin_tag_set;
 	int ret;
 
-	if (admin) {
-		set = &ctrl->admin_tag_set;
-		memset(set, 0, sizeof(*set));
-		set->ops = &nvme_tcp_admin_mq_ops;
-		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
-		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_BLOCKING;
-		set->cmd_size = sizeof(struct nvme_tcp_request);
-		set->driver_data = ctrl;
-		set->nr_hw_queues = 1;
-		set->timeout = NVME_ADMIN_TIMEOUT;
-	} else {
-		set = &ctrl->tag_set;
-		memset(set, 0, sizeof(*set));
-		set->ops = &nvme_tcp_mq_ops;
-		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
-		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
-		set->cmd_size = sizeof(struct nvme_tcp_request);
-		set->driver_data = ctrl;
-		set->nr_hw_queues = nctrl->queue_count - 1;
-		set->timeout = NVME_IO_TIMEOUT;
-		set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
-	}
-
+	memset(set, 0, sizeof(*set));
+	set->ops = &nvme_tcp_admin_mq_ops;
+	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
+	set->reserved_tags = NVMF_RESERVED_TAGS;
+	set->numa_node = nctrl->numa_node;
+	set->flags = BLK_MQ_F_BLOCKING;
+	set->cmd_size = sizeof(struct nvme_tcp_request);
+	set->driver_data = ctrl;
+	set->nr_hw_queues = 1;
+	set->timeout = NVME_ADMIN_TIMEOUT;
 	ret = blk_mq_alloc_tag_set(set);
-	if (ret)
-		return ERR_PTR(ret);
+	if (!ret)
+		nctrl->admin_tagset = set;
+	return ret;
+}
 
-	return set;
+static int nvme_tcp_alloc_tag_set(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int ret;
+
+	memset(set, 0, sizeof(*set));
+	set->ops = &nvme_tcp_mq_ops;
+	set->queue_depth = nctrl->sqsize + 1;
+	set->reserved_tags = NVMF_RESERVED_TAGS;
+	set->numa_node = nctrl->numa_node;
+	set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	set->cmd_size = sizeof(struct nvme_tcp_request);
+	set->driver_data = ctrl;
+	set->nr_hw_queues = nctrl->queue_count - 1;
+	set->timeout = NVME_IO_TIMEOUT;
+	set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
+	ret = blk_mq_alloc_tag_set(set);
+	if (!ret)
+		nctrl->tagset = set;
+	return ret;
 }
 
 static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
@@ -1902,11 +1906,9 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		return ret;
 
 	if (new) {
-		ctrl->tagset = nvme_tcp_alloc_tagset(ctrl, false);
-		if (IS_ERR(ctrl->tagset)) {
-			ret = PTR_ERR(ctrl->tagset);
+		ret = nvme_tcp_alloc_tag_set(ctrl);
+		if (ret)
 			goto out_free_io_queues;
-		}
 
 		ret = nvme_ctrl_init_connect_q(ctrl);
 		if (ret)
@@ -1971,11 +1973,9 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 		return error;
 
 	if (new) {
-		ctrl->admin_tagset = nvme_tcp_alloc_tagset(ctrl, true);
-		if (IS_ERR(ctrl->admin_tagset)) {
-			error = PTR_ERR(ctrl->admin_tagset);
+		error = nvme_tcp_alloc_admin_tag_set(ctrl);
+		if (error)
 			goto out_free_queue;
-		}
 
 		ctrl->fabrics_q = blk_mq_init_queue(ctrl->admin_tagset);
 		if (IS_ERR(ctrl->fabrics_q)) {
-- 
2.30.2


