Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD00C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 05:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ta7qCmDS5qrMjMtteq3ylr92RTTV8eT/kSEYwIS8108=; b=SbS63HIA2t67zQ/ByEi3JBbC3N
	T6qzj7OwbBXyd76Khz/49G4HvhsYuaRM5hJAaQgcnTAdPVgRmTxLIdLIzSQ+NxgBnXdcu8Atpv9Iq
	zPpg9NtMQQq5LwS+g8MoypgZpKXA2HkYXSWTspvQ1z3vWGn8yw9COurnDn3VE2DbyrXcBc2f0q82B
	xRVcYvDSz+2STPo9U8BpAdROrGoCU7c8CFjsrqmJsQzw7S7F3Q5kB4c53Ln3Bp9txjHJdywDABgD1
	RnDzf/qKrjKdc0SsyuMHa5hnS2oODr79FPWgBrA4TN2koavK0Xra5zn9FjcmBS9WrbMhs+Xq8z9Gy
	1ntAzKXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ovH-0000000CrYN-0JSM;
	Thu, 24 Apr 2025 05:14:55 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ovE-0000000CrWm-2K59
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 05:14:53 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3031354f134so495732a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745471691; x=1746076491; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta7qCmDS5qrMjMtteq3ylr92RTTV8eT/kSEYwIS8108=;
        b=GPxECJaNNHuh8sswCRUQNhfDcW1BQau503S1Q5Q8nAMuHP0K3qqEN0m94dD28+5plo
         +4p7sPJluQ91ChYMFqptTMFF8EzIeIha3ixE+tN+pkyNqAMcT6gd0R/6GUeszVEJXiZU
         B5ZeHSgCX3ZiAvAy9Y3KmlJUh1v0IDqd29Djt2b+1Wkn51tFL8iUxI5lGFNZM463cR2s
         ORCDRj76bGBxQ1/yEM7Mw0WFEHlmhgOsC3FnI+Yx5oCwewCZ7PX7EFILC0oGWV+tVVvG
         HoCtiyduPNOC8lhI/P/ZavTIHOCPI9yUBk9GTXgldUA7FLW0MLPaLW+lIVcMsV54wmJV
         0VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745471691; x=1746076491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta7qCmDS5qrMjMtteq3ylr92RTTV8eT/kSEYwIS8108=;
        b=iSkZLnBPdJH1JNYPfZZvPJL+56ikxLRewcif3FtUJnWGNnEKN+prL0DQsEczyYVNzw
         QjTrHfARzXaelnmyWMkhtfluffqhDs9O/YrpL2NVZ1HAcL5oUoGsrtF6JB1D7pIvQ7Ut
         pC5hBBuY2+yyyabqtc2X4RUn6c8bCVZkcPcPD0AH4qBgGOGW/CaIdqNx6wbIEkurhdtt
         nlIuZ94dW8Cx4GFJENSRm6ByEl8UAsbch9X+1hpEYIMaLp5xDcqi97tX+MMeA4uG+bC1
         fsUxu02sb6Wo/RfkK7zH3G7ExCkrelpLHNH9nxQnEp9UMRyINaK2CQ/e9S4IIaItlBJH
         kLRg==
X-Gm-Message-State: AOJu0Yw40BoN9+QrQrcSankKkpOUR9xQenysu9MtOe74QzHbHXUP21pw
	ibmz50R3W17bTA+4M2Lan6ByiPM30nTCOgFueSJbDewrGE4eE/p/GRo2jpja
X-Gm-Gg: ASbGnct7eiVgcPKSu1uWWgihJKJMWPIc7U5xMSf/zW2NHSkSR9aSKa+pG5EyohNGlqH
	HU4UWoZRITulmrO+d5SOu4sbUF6lCRftw3ZgB7nGtX5wFOXqYOBggfaFk5kpJx0yz9CZo74vBcs
	4XhRE94ixWMh+E95pirnwxBRyE39Olq/YT34KO44WBMAw8M0UNhBEMfDMY4GKgvz18Um8mHFJIB
	gji3QQvvqjJ2ULWdiaXKldOS8chiZlar4lSe+SgMvIaqIlMs2gfFgMxF6IhCdPwSf+Xsgb9l1oe
	YV9+a9doeTLxnxzsfPEsOCQOW7TFp1ck5p3rrB7bbEt4i4w=
X-Google-Smtp-Source: AGHT+IFBpGdT4y2Wafu+hQ+G03IYU3TIFgAMNjgjbKIRqBwz0bqAcrUsLMfCsC4przWGxox9QQFE+A==
X-Received: by 2002:a17:90b:6c3:b0:2f9:c144:9d13 with SMTP id 98e67ed59e1d1-309ed31aeeemr2202937a91.24.1745471691083;
        Wed, 23 Apr 2025 22:14:51 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097bdbsm324771a91.26.2025.04.23.22.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 22:14:50 -0700 (PDT)
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
Subject: [PATCH 5/5] nvmet: Simplify nvmet_req_init() interface
Date: Thu, 24 Apr 2025 15:13:53 +1000
Message-ID: <20250424051352.7980-7-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_221452_601244_AAAD434E 
X-CRM114-Status: GOOD (  14.35  )
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

Now that a submission queue holds a reference to its completion queue,
there is no need to pass the cq argument to nvmet_req_init(), so remove it.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/target/core.c    | 6 +++---
 drivers/nvme/target/fc.c      | 5 +----
 drivers/nvme/target/loop.c    | 6 ++----
 drivers/nvme/target/nvmet.h   | 4 ++--
 drivers/nvme/target/pci-epf.c | 3 +--
 drivers/nvme/target/rdma.c    | 3 +--
 drivers/nvme/target/tcp.c     | 3 +--
 7 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d989880bbafc..042039011d7c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1153,13 +1153,13 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	return ret;
 }
 
-bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
-		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops)
+bool nvmet_req_init(struct nvmet_req *req, struct nvmet_sq *sq,
+		const struct nvmet_fabrics_ops *ops)
 {
 	u8 flags = req->cmd->common.flags;
 	u16 status;
 
-	req->cq = cq;
+	req->cq = sq->cq;
 	req->sq = sq;
 	req->ops = ops;
 	req->sg = NULL;
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 2e813e51549c..6d3344726f84 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2534,10 +2534,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	fod->data_sg = NULL;
 	fod->data_sg_cnt = 0;
 
-	ret = nvmet_req_init(&fod->req,
-				&fod->queue->nvme_cq,
-				&fod->queue->nvme_sq,
-				&nvmet_fc_tgt_fcp_ops);
+	ret = nvmet_req_init(&fod->req, &fod->queue->nvme_sq, &nvmet_fc_tgt_fcp_ops);
 	if (!ret) {
 		/* bad SQE content or invalid ctrl state */
 		/* nvmet layer has already called op done to send rsp. */
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9354a58456e0..80f8281a98c3 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -148,8 +148,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	nvme_start_request(req);
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = queue->ctrl->port;
-	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvme_loop_ops))
+	if (!nvmet_req_init(&iod->req, &queue->nvme_sq, &nvme_loop_ops))
 		return BLK_STS_OK;
 
 	if (blk_rq_nr_phys_segments(req)) {
@@ -181,8 +180,7 @@ static void nvme_loop_submit_async_event(struct nvme_ctrl *arg)
 	iod->cmd.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 
-	if (!nvmet_req_init(&iod->req, &queue->nvme_cq, &queue->nvme_sq,
-			&nvme_loop_ops)) {
+	if (!nvmet_req_init(&iod->req, &queue->nvme_sq, &nvme_loop_ops)) {
 		dev_err(ctrl->ctrl.device, "failed async event work\n");
 		return;
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d3795b09fcc4..df69a9dee71c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -561,8 +561,8 @@ u32 nvmet_fabrics_admin_cmd_data_len(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_io_cmd(struct nvmet_req *req);
 u32 nvmet_fabrics_io_cmd_data_len(struct nvmet_req *req);
 
-bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
-		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
+bool nvmet_req_init(struct nvmet_req *req, struct nvmet_sq *sq,
+		const struct nvmet_fabrics_ops *ops);
 void nvmet_req_uninit(struct nvmet_req *req);
 size_t nvmet_req_transfer_len(struct nvmet_req *req);
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index e5030bca18ee..99a46b6bd231 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1596,8 +1596,7 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 		goto complete;
 	}
 
-	if (!nvmet_req_init(req, &iod->cq->nvme_cq, &iod->sq->nvme_sq,
-			    &nvmet_pci_epf_fabrics_ops))
+	if (!nvmet_req_init(req, &iod->sq->nvme_sq, &nvmet_pci_epf_fabrics_ops))
 		goto complete;
 
 	iod->data_len = nvmet_req_transfer_len(req);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 2e5c32298818..432bdf7cd49e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -976,8 +976,7 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		cmd->send_sge.addr, cmd->send_sge.length,
 		DMA_TO_DEVICE);
 
-	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvmet_rdma_ops))
+	if (!nvmet_req_init(&cmd->req, &queue->nvme_sq, &nvmet_rdma_ops))
 		return;
 
 	status = nvmet_rdma_map_sgl(cmd);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 2223cfd00b58..493e680ddcf7 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1077,8 +1077,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
-- 
2.49.0


