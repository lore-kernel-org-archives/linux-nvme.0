Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6BBC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 06:37:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7CC223E8
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 06:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7CC223E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mdkvTiQQgJDDy4NgUCMFka5N73E88QYVeoQl+AII4EA=; b=zwsXgCyw56rQ5m7vcYCN+2uIqc
	DaOZWMDb/R5KIghZ7wx/cp65nGiwgsBwBXp15UscELbMcQF5BArP7c/UlAApduEeeWMm/njPqW6tH
	IfNFIVVxj1WksuRcYX0tTE0ZCiaKRt+pBBedHOHL6h73i4fVGpkxngYtAPPGf83Sjg40Xg1Vcro7Y
	X73QLOwWKeKEmuIGLdpuxVXq2u463LFNZmvpVT9MnYAzPU4IX7IP/946OxnFhDdFl5zmcXf+cbJP6
	uyj6KblWsMwEd0j+Vec1ZNuRNuFlPiSrcpvU1x22wVqhMps4OfpRxZEJZe2BL/ZPHLfFVFEdjHFOz
	KyoYDsGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kx2RD-0000au-3A; Wed, 06 Jan 2021 06:36:55 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kx2R9-0000Yp-1L
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 06:36:52 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D9fl40sfLzj31l;
 Wed,  6 Jan 2021 14:36:00 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Wed, 6 Jan 2021
 14:36:36 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-rdma: avoid repeated request completion for concurrent
 nvme_rdma_timeout
Date: Wed, 6 Jan 2021 14:36:35 +0800
Message-ID: <20210106063635.7452-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_013651_933949_00E1DE26 
X-CRM114-Status: GOOD (  11.63  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A crash happens when inject completing request long time(nearly 30s).
Each name space has a request queue, when inject completing request long
time, multi request queues may has time out requests at the same time,
nvme_rdma_timeout will execute concurrently. Multi requests in different
request queues may be queued in the same rdma queue, multi
nvme_rdma_timeout may call nvme_rdma_stop_queue at the same time.
The first nvme_rdma_timeout will clear NVME_RDMA_Q_LIVE and continue
stopping the rdma queue(drain qp), but the others check NVME_RDMA_Q_LIVE
is already cleared, and then directly complete the requests, but the
rdma queue may be not stopped and the request may be already completed
in qp and wait treated, the request will be repeated completed.
Add a multex lock to serialize nvme_rdma_stop_queue.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index df9f6f4549f1..d5c66e3eeb4a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -97,6 +97,7 @@ struct nvme_rdma_queue {
 	struct completion	cm_done;
 	bool			pi_support;
 	int			cq_size;
+	struct mutex		queue_lock;
 };
 
 struct nvme_rdma_ctrl {
@@ -579,6 +580,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	int ret;
 
 	queue = &ctrl->queues[idx];
+	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
@@ -598,7 +600,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	if (IS_ERR(queue->cm_id)) {
 		dev_info(ctrl->ctrl.device,
 			"failed to create CM ID: %ld\n", PTR_ERR(queue->cm_id));
-		return PTR_ERR(queue->cm_id);
+		ret = PTR_ERR(queue->cm_id);
+		goto out_destroy_mutex;
 	}
 
 	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
@@ -628,6 +631,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 out_destroy_cm_id:
 	rdma_destroy_id(queue->cm_id);
 	nvme_rdma_destroy_queue_ib(queue);
+out_destroy_mutex:
+	mutex_destroy(&queue->queue_lock);
 	return ret;
 }
 
@@ -639,9 +644,10 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
-	if (!test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
-		return;
-	__nvme_rdma_stop_queue(queue);
+	mutex_lock(&queue->queue_lock);
+	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
+		__nvme_rdma_stop_queue(queue);
+	mutex_unlock(&queue->queue_lock);
 }
 
 static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
@@ -649,6 +655,7 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
 		return;
 
+	mutex_destroy(&queue->queue_lock);
 	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 }
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
