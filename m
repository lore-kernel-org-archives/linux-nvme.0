Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC45EC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:42:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FE364EF8
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FE364EF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=34PHmoKNrLgIQ87aaX70h0CH6aFnNAokewAl1DizK8c=; b=K/ZYlqwihQhOitBCuk3Jq1DCd
	z4afrsJVbjsUzrJpF4r4vTfGm77H/s3ZgmhEObv71jaaGX+556PHV6Ln/QVj9sHEdnvDksyP1yc0F
	r1A3h0DP9fHIvtJV0S43AudxY1J4z2i/gWjUlMP6idNMcbdrm0WtocXP6LzXQTy7z9U5PeoFkg1eT
	/4ureoGxKMZ14Wd34yVSKZNMj2k5T0TYx08T7VZAMhwtC/gq2wdWh2XoTtAjg+FSMBpEqEoBrfULl
	S0TPPRv7nXiBww4OwGY8OM6DTDol2RsCtyKKQqvWb5nY+0RbovgqZlTpIgJedM95hldc6sTVX3vbv
	sa2KXhoVA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHYJP-006Shf-89; Wed, 03 Mar 2021 20:41:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT6d-005J7b-TL
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:08:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=dnAd6QSODglka7bDGTo5n0pxHIsHB7fFZ1A72j31SoU=; b=rJO3NDbvbY6xZZLxV1G3KOemp1
 4WgPxsoY71xTgiMPH/s3WlM6s0AupmB8WcQCgAszoDdVNWO6NgsKh9FCPDG5GfaFcNOR6wMoQ//qM
 Vf3k6KPuQXHzb60RDCaX1Av/s4N9YE80hhz6jJsDetBN8FBoA5PieW7Cyfv1MadVm0HIYzMHGHRcG
 Vgdg0kCYKoXCkmnj49KcroCiCV1wlkEfw1vb2TW0dqi19D6jupeyLnMYTLGkLHa454fUBk0Kt61HY
 /lyF9CoPnrX4E8SKD6NwmEjs63cG3VH3xYUM4xi/GXEAm97d8+yqlh3vEwvwbLoq3aBYFHbTGafJK
 M1OXfRUg==;
Received: from [2001:4bb8:180:9884:624:26dd:6387:40e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lHR0D-002cNT-H5; Wed, 03 Mar 2021 12:53:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme-fabrics: only reserve a single tag
Date: Wed,  3 Mar 2021 13:53:02 +0100
Message-Id: <20210303125304.1200789-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210303125304.1200789-1-hch@lst.de>
References: <20210303125304.1200789-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fabrics drivers currently reserve two tags on the admin queue.  But
given that the connect command is only run on a freshly created queue
or after all commands have been force aborted we only need to reserve
a single tag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fabrics.h | 7 +++++++
 drivers/nvme/host/fc.c      | 4 ++--
 drivers/nvme/host/rdma.c    | 4 ++--
 drivers/nvme/host/tcp.c     | 4 ++--
 drivers/nvme/target/loop.c  | 4 ++--
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 733010d2eafd80..888b108d87a400 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,6 +18,13 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
+/*
+ * Reserved one command for internal usage.  This command is used for sending
+ * the connect command, as well as for the keep alive command on the admin
+ * queue once live.
+ */
+#define NVMF_RESERVED_TAGS	1
+
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
  * allow the override it when creating controllers.  This is both to provide
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 20dadd86e98121..0f8b9784cbcd30 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2862,7 +2862,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_fc_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
+	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size =
@@ -3484,7 +3484,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = 2; /* fabric connect + Keep-Alive */
+	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 53ac4d7442ba9c..7855103e05d25f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -798,7 +798,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = 2; /* connect + keep-alive */
+		set->reserved_tags = NVMF_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
@@ -811,7 +811,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = 1; /* fabric connect */
+		set->reserved_tags = NVMF_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799b8..c535836e7065b9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1575,7 +1575,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = 2; /* connect + keep-alive */
+		set->reserved_tags = NVMF_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
@@ -1587,7 +1587,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = 1; /* fabric connect */
+		set->reserved_tags = NVMF_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb6f86572b24ad..3e189e753bcf5a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -349,7 +349,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
+	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
@@ -520,7 +520,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_loop_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
+	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
