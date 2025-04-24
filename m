Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69BCC369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 05:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Qnir6TsW0jqdC3UgRS1dcIrqakzi43bp33lFCZWGnM=; b=HqnlJzbhvpCdTfF1U+SCA246Cu
	ux7QNuxIdupxRKFh0Ihv1YXMy/JJK8O5LSsjlXXbYOpD3z4E8BHH27nZQKE3VO7fvsFzefM4qfyoC
	A4PlPKqNKuWxjmS0V5oppyQEQwyjzAVq8wIt/5wcJxjrxDhL/kHEgeZHWNXawvERUDKtkmxG8FxGc
	REoRNmNX0ekfhuITPgAGG3SU7AYMksUfHVqp5/23e7UsZq4zAiSzJuSrajQdXaDsVAcEa96/cy6sg
	Rk3ZS6fR49N8TTU38Ezs0/PhxPi55F3TTZy8rYzjIuUO2JFFiFe6Nqi19IdEqFZHdhTxH7MaGWP5Z
	WuzmBIog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ov4-0000000CrRM-0W7f;
	Thu, 24 Apr 2025 05:14:42 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ov1-0000000CrQ5-1yBY
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 05:14:41 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-22c33ac23edso5358815ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 22:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745471678; x=1746076478; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qnir6TsW0jqdC3UgRS1dcIrqakzi43bp33lFCZWGnM=;
        b=THQZkmyQvwzsi/oD+8am4JH/dswTWpci9zDDzzUbIP79UmCArFuYbZSFX4SlXxUgkL
         sl7+kgjnE0WUjg4Ls4+4Zj3vXRvwnL2RyNzmCh//nDZ8mNo/oMOxkmSWA3bhh1d+8291
         GbzoG/mloGuxUEbhPXWElkzgaD1NJlFURvH8MJr7/dskzMVP/TVpfuyGmTM5SFcym3w/
         3XSy4E/SsUaVQz2OyvQ9hhpMnCpCSLBVSo+quvG417F7W85hiZ5bTxWMkHvXnAI5CmMP
         X7x5dmT27xU+/W53k8j/98gW2k8yH27EhoTm91fEijDyV5Jb8HSmpxc7iN5jNpRfH6cJ
         y++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745471678; x=1746076478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qnir6TsW0jqdC3UgRS1dcIrqakzi43bp33lFCZWGnM=;
        b=nw6qoonV/ErzXU9Ygv1aNr3Bu5bK6kGzX4DhwkEElbBwCgiD6iDBAsNXKn0Ix/mkeU
         XNTectlTtht0kSTYmIMkCAPdbKBiOqbJHwXRk7y55kQztCRQoc/S6bjYuk0KoWMorK+Z
         juRQu+CsQUSyo8HVvkedvtKVazTmlAVDwIDIEr7oBKIyZKfbMm+sRGVhUro6x6ljiFW2
         5g86m6MtjODmAYIQbysGyE8OsJYUDWy0BOUOlQB+20w0CfxuUUMpMFqTPBekRyxtM1KN
         zE9fhzh0qre2n1hvCj8cufDaSpjVYAM5Qldu2YObOil5X1qM6X+pBoQFiaW4Ji71PosH
         BHYg==
X-Gm-Message-State: AOJu0YxXxeOeeR4sWPoZh7+2Tf1lwG/wCNqiROCVF+/FARLNoPDwMNa3
	kbVx7H61pW7vmP4dZty5GkDQlfNvAS/4/dMqTb8W5tx0wBCNlA0ladj6ZaZR
X-Gm-Gg: ASbGncuW0bwByuJmVWbuhZQgTF3NeVA5HC9zk8wSo4TpfuZMuQbQJ4/SV8HBBxpH4Vr
	Q8tCneU3A5gfGABhamOt9wCr+dWjkcAAHyM3hTynhd4ERUCx0dfmSnlXu0SV445ek+BNO0NIItw
	uPoEyAROs8XSOG4cQMQ2u2b59JwR6UYU5T+0Giuhf0PxrSm9hJfjKYH10xRx1wdrxA86td/rWKv
	NImjeJjE30sRp/9Tr9ak427dCi9oCP1hphSCPGh3SG4r9iz6+bSJIQXyEBms8CZLkkQnYPh77eL
	ypUYTyrReyZuFEaEVFev2nmDOVq8IRlW+byKkFDOFkmqp/w=
X-Google-Smtp-Source: AGHT+IGAPMS1GrIxdyM8/lfBZrTM/isYDFNH5GSzsb7fyBDtDrt7XT24RC5/LaJO9ij+zBk4jyOIwA==
X-Received: by 2002:a17:90b:5488:b0:305:5f32:d9f5 with SMTP id 98e67ed59e1d1-309ed24d381mr2185902a91.7.1745471677973;
        Wed, 23 Apr 2025 22:14:37 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097bdbsm324771a91.26.2025.04.23.22.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 22:14:37 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: dlemoal@kernel.org,
	alistair.francis@wdc.com,
	cassel@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 3/5] nvmet: fabrics: add CQ init and destroy
Date: Thu, 24 Apr 2025 15:13:51 +1000
Message-ID: <20250424051352.7980-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_221439_515239_67E058A3 
X-CRM114-Status: GOOD (  15.66  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

With struct nvmet_cq now having a reference count, this patch
amends the target fabrics call chain to initialize and destroy/put a
completion queue.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/target/fabrics-cmd.c |  8 ++++++++
 drivers/nvme/target/fc.c          |  3 +++
 drivers/nvme/target/loop.c        | 13 +++++++++++--
 drivers/nvme/target/rdma.c        |  3 +++
 drivers/nvme/target/tcp.c         |  3 +++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index f012bdf89850..3fb4a7010d8e 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -208,6 +208,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 	}
 
+	kref_get(&ctrl->ref);
+	old = cmpxchg(&req->cq->ctrl, NULL, ctrl);
+	if (old) {
+		pr_warn("queue already connected!\n");
+		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
+		return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
+	}
+
 	/* note: convert queue size from 0's-based value to 1's-based value */
 	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
 	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7b50130f10f6..7c2a4e2eb315 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -816,6 +816,7 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 
 	nvmet_fc_prep_fcp_iodlist(assoc->tgtport, queue);
 
+	nvmet_cq_init(&queue->nvme_cq);
 	ret = nvmet_sq_init(&queue->nvme_sq);
 	if (ret)
 		goto out_fail_iodlist;
@@ -826,6 +827,7 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	return queue;
 
 out_fail_iodlist:
+	nvmet_cq_put(&queue->nvme_cq);
 	nvmet_fc_destroy_fcp_iodlist(assoc->tgtport, queue);
 	destroy_workqueue(queue->work_q);
 out_free_queue:
@@ -934,6 +936,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 	flush_workqueue(queue->work_q);
 
 	nvmet_sq_destroy(&queue->nvme_sq);
+	nvmet_cq_put(&queue->nvme_cq);
 
 	nvmet_fc_tgt_q_put(queue);
 }
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a5c41144667c..85a97f843dd5 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -273,6 +273,7 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
+	nvmet_cq_put(&ctrl->queues[0].nvme_cq);
 	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
 
@@ -302,6 +303,7 @@ static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
 		clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
 		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
+		nvmet_cq_put(&ctrl->queues[i].nvme_cq);
 	}
 	ctrl->ctrl.queue_count = 1;
 	/*
@@ -327,9 +329,12 @@ static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
 
 	for (i = 1; i <= nr_io_queues; i++) {
 		ctrl->queues[i].ctrl = ctrl;
+		nvmet_cq_init(&ctrl->queues[i].nvme_cq);
 		ret = nvmet_sq_init(&ctrl->queues[i].nvme_sq);
-		if (ret)
+		if (ret) {
+			nvmet_cq_put(&ctrl->queues[i].nvme_cq);
 			goto out_destroy_queues;
+		}
 
 		ctrl->ctrl.queue_count++;
 	}
@@ -360,9 +365,12 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	int error;
 
 	ctrl->queues[0].ctrl = ctrl;
+	nvmet_cq_init(&ctrl->queues[0].nvme_cq);
 	error = nvmet_sq_init(&ctrl->queues[0].nvme_sq);
-	if (error)
+	if (error) {
+		nvmet_cq_put(&ctrl->queues[0].nvme_cq);
 		return error;
+	}
 	ctrl->ctrl.queue_count = 1;
 
 	error = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
@@ -401,6 +409,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_sq:
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
+	nvmet_cq_put(&ctrl->queues[0].nvme_cq);
 	return error;
 }
 
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 2a4536ef6184..3ad9b4d1fad2 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1353,6 +1353,7 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 	pr_debug("freeing queue %d\n", queue->idx);
 
 	nvmet_sq_destroy(&queue->nvme_sq);
+	nvmet_cq_put(&queue->nvme_cq);
 
 	nvmet_rdma_destroy_queue_ib(queue);
 	if (!queue->nsrq) {
@@ -1436,6 +1437,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 		goto out_reject;
 	}
 
+	nvmet_cq_init(&queue->nvme_cq);
 	ret = nvmet_sq_init(&queue->nvme_sq);
 	if (ret) {
 		ret = NVME_RDMA_CM_NO_RSC;
@@ -1517,6 +1519,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 out_destroy_sq:
 	nvmet_sq_destroy(&queue->nvme_sq);
 out_free_queue:
+	nvmet_cq_put(&queue->nvme_cq);
 	kfree(queue);
 out_reject:
 	nvmet_rdma_cm_reject(cm_id, ret);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f2d0c920269b..5045d1bc0412 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1612,6 +1612,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_sq_put_tls_key(&queue->nvme_sq);
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
+	nvmet_cq_put(&queue->nvme_cq);
 	cancel_work_sync(&queue->io_work);
 	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	/* ->sock will be released by fput() */
@@ -1947,6 +1948,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_ida_remove;
 
+	nvmet_cq_init(&queue->nvme_cq);
 	ret = nvmet_sq_init(&queue->nvme_sq);
 	if (ret)
 		goto out_free_connect;
@@ -1990,6 +1992,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 	nvmet_sq_destroy(&queue->nvme_sq);
 out_free_connect:
+	nvmet_cq_put(&queue->nvme_cq);
 	nvmet_tcp_free_cmd(&queue->connect);
 out_ida_remove:
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
-- 
2.49.0


