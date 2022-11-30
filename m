Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD118C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DYGO5Vr2HI4i9RPHwAWvaLkYKH2txTqx98sSJ7VByKU=; b=nq/za6VfjkUPGj6HdmLdobUlz6
	axieEgqsLyIjC34OEQE3jnszk/gx7ahylyc1VKay42pWJxWWZp1axy3ek3jFrOL0/mgfWT230Kqc6
	NkkD+0DiP83akXnazqbrEdRP2u41W1E6qQ4WppOvxgCDJu1A6O9L8Y4tWGFjuCDA8vcc7NJ84mHkA
	15au1iWNjcRZ60BwSU7+HK8G4jswfAzpMzdwp0UUsieWlOJ0yrgXiFa0yLU26OQr64fDgEpjEGM7X
	HNd5MLjPd4grhQHf4eLpUeSdSOUGINIS1rn+u/yEXhnHWvXExrPsq+7yXoLuMAifHnJdFSK4n/LIB
	ylvNlrKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0RLr-001Ht1-1I; Wed, 30 Nov 2022 17:58:31 +0000
Received: from [2001:4bb8:192:26e7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0R6b-0017Vg-UQ; Wed, 30 Nov 2022 17:42:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/5] nvme: pass nr_maps explicitly to nvme_alloc_io_tag_set
Date: Wed, 30 Nov 2022 18:42:35 +0100
Message-Id: <20221130174240.227616-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130174240.227616-1-hch@lst.de>
References: <20221130174240.227616-1-hch@lst.de>
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

Don't look at ctrl->ops as only RDMA and TCP actually support multiple
maps.

Fixes: 6dfba1c09c10 ("nvme-fc: use the tagset alloc/free helpers")
Fixes: ceee1953f923 ("nvme-loop: use the tagset alloc/free helpers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c   | 5 ++---
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 2 +-
 drivers/nvme/host/rdma.c   | 4 +++-
 drivers/nvme/host/tcp.c    | 1 +
 drivers/nvme/target/loop.c | 2 +-
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 30717f7cfc94bc..3b369900928fde 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4891,7 +4891,7 @@ EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
 
 int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int flags,
-		unsigned int cmd_size)
+		unsigned int nr_maps, unsigned int cmd_size)
 {
 	int ret;
 
@@ -4905,8 +4905,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->driver_data = ctrl;
 	set->nr_hw_queues = ctrl->queue_count - 1;
 	set->timeout = NVME_IO_TIMEOUT;
-	if (ops->map_queues)
-		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
+	set->nr_maps = nr_maps;
 	ret = blk_mq_alloc_tag_set(set);
 	if (ret)
 		return ret;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9cb9e067969c7a..60656e7fd945ca 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2904,7 +2904,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_init_io_queues(ctrl);
 
 	ret = nvme_alloc_io_tag_set(&ctrl->ctrl, &ctrl->tag_set,
-			&nvme_fc_mq_ops, BLK_MQ_F_SHOULD_MERGE,
+			&nvme_fc_mq_ops, BLK_MQ_F_SHOULD_MERGE, 1,
 			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 				    ctrl->lport->ops->fcprqst_priv_sz));
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cad9f6f2282cd..6c4565435fd90f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -747,7 +747,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl);
 int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int flags,
-		unsigned int cmd_size);
+		unsigned int nr_maps, unsigned int cmd_size);
 void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cc61a1b8311b16..cf8f500405b195 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -798,7 +798,9 @@ static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *ctrl)
 			    NVME_RDMA_METADATA_SGL_SIZE;
 
 	return nvme_alloc_io_tag_set(ctrl, &to_rdma_ctrl(ctrl)->tag_set,
-			&nvme_rdma_mq_ops, BLK_MQ_F_SHOULD_MERGE, cmd_size);
+			&nvme_rdma_mq_ops, BLK_MQ_F_SHOULD_MERGE,
+			ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
+			cmd_size);
 }
 
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 95e54e9c1bb1fc..fa245a50f630b8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1859,6 +1859,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
 				&nvme_tcp_mq_ops,
 				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING,
+				ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
 				sizeof(struct nvme_tcp_request));
 		if (ret)
 			goto out_free_io_queues;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0015aed5c16996..da32727e6232d8 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -494,7 +494,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 		return ret;
 
 	ret = nvme_alloc_io_tag_set(&ctrl->ctrl, &ctrl->tag_set,
-			&nvme_loop_mq_ops, BLK_MQ_F_SHOULD_MERGE,
+			&nvme_loop_mq_ops, BLK_MQ_F_SHOULD_MERGE, 1,
 			sizeof(struct nvme_loop_iod) +
 			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
 	if (ret)
-- 
2.30.2


