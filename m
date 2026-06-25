Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C15CDE00E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t4BwWVBvnlyUMkUU6VF2UEwXIcp46kv2CLab4+aVLSg=; b=y5yxpyyvT5dO8C14FHkGUQLXG6
	lS/CSKzRLyDqKLfogxDa4hvp9Vt+y6THaD8p+0PlS3gxvKhlcyQqnxq6yn93g76FjF2/v873L8nwH
	l5uHAc+MO1svgJGl77VbccXxKb31MfZP9pHQ11vE5JyjRM2MQpp95H1QvsXfVEEzLUmgSQbweCEK5
	dL9BvmNUYxXWnZSBdx1nNhN7GD6tqG4oNS56t+jdraun1FjM281FoYNnhPkERNi2g6DI4oznA8rDk
	k0ztgaoJNqZybZH4s0ufFl9cGO9YGqCAd38aYhznegACLfgNfGzVM28pxpU2ENPxOAY3FGCsDNA5p
	8/5efCjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcrbs-00000009s6t-29Ri;
	Thu, 25 Jun 2026 21:27:44 +0000
Received: from mail-qt1-x864.google.com ([2607:f8b0:4864:20::864])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcrbq-00000009s6G-04Af
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 21:27:43 +0000
Received: by mail-qt1-x864.google.com with SMTP id d75a77b69052e-5177945a22eso1958911cf.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2026 14:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782422861; x=1783027661; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4BwWVBvnlyUMkUU6VF2UEwXIcp46kv2CLab4+aVLSg=;
        b=c0c631Vi3wfg3saoTvXcHOLcRZN0orGQt/NgLb+gJRPAJTjqQh3mTG5+2AD3OlDpnu
         2CIkwhKOGeGDRlaPL8muzhXMmVgI8v4oySwCMyZOfZ3gRANIk7eKy5BNsnZrb6rPTgTR
         EuTenVFmBGmgFpolS/sVQFd5khNAO4p0VNGF7Yuz+w7i18JGt95cOUKgCNKwFaj/rQoQ
         5aYT6VXsr4Yl/8tGXT/4+eY8LtYW0oLkRR38rz2cDN1anYTCWPYy4nAxDPPyeblowYAG
         3Rj4EtmGYiYvglKOCFW1/kuMAGQQM/e+ag1uj7GOK3lkmeRipM1pNWxV3eAasN2lmorn
         Z99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782422861; x=1783027661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4BwWVBvnlyUMkUU6VF2UEwXIcp46kv2CLab4+aVLSg=;
        b=OE1PfpBhs4dYBlqXzQbG5HMMeq0OWBj5CXzUUZoeyNfgm+d56jtLwwQLFKAwerqiuS
         pb3nXtNnH+xy7WttBTWSBGRtml4XilJGwQllkBdhvEdOaFz8RQ48Nz3lab8zed1Bbz9o
         wFGvXIT/h2ZGcSG/fwx4g5WTvldEvFx1kjuUDi/5lzWUIPXQ82G6m84qSgT+xumGf68a
         i2DDtAvFzUdIho87jp6gAu/hXfKlS+ifNZcBouKIVa3IVvU/J/pwnRaG/3vewxKCJmqO
         okC59ehfwY/wO01EMY49CJjKAMR9F1qZhBRFYp+roYWikbP9AkVopFL0lt8Vp3cjJ6tj
         1QKA==
X-Gm-Message-State: AOJu0Ywmi0GqZ8RXhIBgFYExnI1dS8UgmQjpEPun2vhQ4lkHWFDR4ZI2
	1W8FDwX2vxR3q5dqt/KC/1R0dALI0lV4ETU30DGibOMwuhJPZbb2uXq11Bzi+mCzNVA38uyS9mn
	zfOL0LoN8kIAxy5K8f6z8pLTqhOgdEOmpbDajoYC3TrvlHRleYX1G
X-Gm-Gg: AfdE7cl01diPEYUb6PaQ5CN1Fj+Xt9f5EkZceKpGoX75u3o2AMWPYkvusAr5DpcpfOe
	zqTWNoaaQbNftV2yFYRMlRwPrfJ32fzpdh3PfNRplxAHJ99+4J1a+0gjFAMtnil/bd4hNN0XZF+
	07P/KT5KKijKEmJk8j8khYTPM+ZUrF6/9aEWrJABVqiHGqnAuBU5dLIGERYRYrbG1IBfpM8sVy8
	F4PaUbxKXPPLOndPKNI8C5xHyGnF5LLLq5OwGFvGFmMm5CqvWYMdwKKZbjYXllp1xa6VULDLPuX
	qHnwhyUDg5bvvfGFvjqlPkWL1Gu4AiCuY/EnE628FqekW0gX3GlLgoyFE+18fOXgUyw3LGthx89
	abJYnk+3EZCBlcsDx16T+EAfXtIY=
X-Received: by 2002:a05:622a:4291:b0:517:6435:c4ce with SMTP id d75a77b69052e-51a72822e58mr60054881cf.49.1782422860006;
        Thu, 25 Jun 2026 14:27:40 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8df82b6856dsm13100326d6.20.2026.06.25.14.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:27:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 686F3401FD;
	Thu, 25 Jun 2026 15:27:39 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 65FAB51222; Thu, 25 Jun 2026 15:27:39 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v3 1/2] nvme-rdma: refactor nvme_rdma_alloc_queue() to take a queue pointer
Date: Thu, 25 Jun 2026 15:27:21 -0600
Message-ID: <20260625212722.1302344-2-sgogte@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625212722.1302344-1-sgogte@purestorage.com>
References: <20260625212722.1302344-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_142742_065583_B87C9E6B 
X-CRM114-Status: GOOD (  14.07  )
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

Callers are responsible for initializing queue->ctrl and queue->queue_size
before calling nvme_rdma_alloc_queue(), which now derives ctrl and idx
from the queue pointer directly. This removes redundant assignments inside
the function and simplifies the interface.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
 drivers/nvme/host/rdma.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..6b0b0a3dea62 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -566,16 +566,14 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
-static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
-		int idx, size_t queue_size)
+static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 {
-	struct nvme_rdma_queue *queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+	int idx = nvme_rdma_queue_idx(queue);
 	struct sockaddr *src_addr = NULL;
 	int ret;
 
-	queue = &ctrl->queues[idx];
 	mutex_init(&queue->queue_lock);
-	queue->ctrl = ctrl;
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
 	else
@@ -587,8 +585,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
 
-	queue->queue_size = queue_size;
-
 	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
 			RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(queue->cm_id)) {
@@ -736,8 +732,9 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 	nvmf_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
+		ctrl->queues[i].ctrl = ctrl;
+		ctrl->queues[i].queue_size = ctrl->ctrl.sqsize + 1;
+		ret = nvme_rdma_alloc_queue(&ctrl->queues[i]);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -783,7 +780,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	ctrl->queues[0].ctrl = ctrl;
+	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
+	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);
 	if (error)
 		return error;
 
-- 
2.54.0


