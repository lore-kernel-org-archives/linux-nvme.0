Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4494C11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 07:51:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A270C61D49
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 07:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A270C61D49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xS9+4Nh4rX+6M8O/BDZbDkhw4Nc7mB+EXkHy/ErrDq8=; b=CefM2qws0Ggu5N
	Xs0KsgxNP9YeDg5QogUU/OUSSakQQArHqc+xQcC0PLwts3je5NtpHruWP8ab3kTUmP9vo3fVJLikO
	xlkvOjkZc5AbjRqRVY4lNv83fST4tLPafz4ohC2zXPZg5Su46iasEpCe0KPwJDwEaru+Oz6wYWvBc
	2+wU4UkQlGHvnf9rXY6WYPkeS/crixnye34ENpLhz41Di+TchNcRAVTaatpkMNAsKdywoDGmftre0
	I0p9zaENhmIxCDG1l507C5h5hbIgNOTEVT6sCh/Ti1/SBj+I/H9KdfLURWWPlNZsfz6uVuO+/2/bK
	ROJ6qjGUkiq/lNoYrtMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ly8W8-00A6Nr-Kb; Tue, 29 Jun 2021 07:50:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ly8Vo-00A6ID-To
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 07:50:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624953028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fb3NfJSaKCyP+3LF0nxY2+VvsfNZpDDwj+kt0oYzUHc=;
 b=A/awopu7Mi9/f+vFCMC3KS/1hjY/AXHGUVGvFIwYhOf7XLZ6XSa0XZYpwhRmVm1RWbDBzk
 k64qOfwOV6ezVMTu3rjcr7RvB3yMa+4LFO6F8i+kDd06DZ0M1xydZUoWafka+uzyIPDxQ8
 53WrnbhfLjxpW00ArNOvWUk3paYBTPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-efNjEU4RMf-k80bsUSTaXg-1; Tue, 29 Jun 2021 03:50:25 -0400
X-MC-Unique: efNjEU4RMf-k80bsUSTaXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B54231023F44;
 Tue, 29 Jun 2021 07:50:23 +0000 (UTC)
Received: from localhost (ovpn-13-8.pek2.redhat.com [10.72.13.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEB8B369A;
 Tue, 29 Jun 2021 07:50:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for
 fc/rdma/tcp/loop
Date: Tue, 29 Jun 2021 15:49:51 +0800
Message-Id: <20210629074951.1981284-3-ming.lei@redhat.com>
In-Reply-To: <20210629074951.1981284-1-ming.lei@redhat.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_005029_086164_2EB51776 
X-CRM114-Status: GOOD (  16.76  )
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

All the 4 host drivers don't use managed irq for completing request, so
it is correct to pass the flag to blk-mq.

Secondly with this flag, blk-mq will help us dispatch connect request
allocated via blk_mq_alloc_request_hctx() to driver even though all
CPU in the specified hctx's cpumask are offline.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/fc.c     | 3 ++-
 drivers/nvme/host/rdma.c   | 3 ++-
 drivers/nvme/host/tcp.c    | 3 ++-
 drivers/nvme/target/loop.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 256e87721a01..c563a2b6e9fc 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2876,7 +2876,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
 	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 	ctrl->tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 			    ctrl->lport->ops->fcprqst_priv_sz);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37943dc4c2c1..4b7bdc829109 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -817,7 +817,8 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = nctrl->sqsize + 1;
 		set->reserved_tags = NVMF_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE |
+			BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
 		if (nctrl->max_integrity_segments)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 34f4b3402f7c..0125463b7d77 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1600,7 +1600,8 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = nctrl->sqsize + 1;
 		set->reserved_tags = NVMF_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING |
+			BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb30cb942e1d..bf032249e010 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -524,7 +524,8 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
 	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
 	ctrl->tag_set.driver_data = ctrl;
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
