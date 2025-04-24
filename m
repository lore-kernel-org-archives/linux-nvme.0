Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765E2C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 05:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FnxnE33Om/2O2SAzQlyxp21+ZlEdkIuU/WPYkbRdnps=; b=G+hBExixwKglVF+cB+FFCWnLvA
	ynMv+TECZO/5uFtjD/a0nt8KVYf5oLVL5pdPYgfIiBQxbI/DOx3+/Y4qhdRbim/zmCGjCm15Yzh2Y
	irBeXzAsXsIZ/+vt9UrszMp7wTz1zCG8Wx8J9MDYNTysioBFcZj3QCCc/gA7tz1Ev1HRXnYPCjdnX
	wt3tuGavtqUAvlpIN5ilDpxQuex32G5sXOrZLP2wZJNPhPtRQWWcMgWZB+V13h7OoZp2E9/K8jRed
	b/bAd12ZfnTvvHAMGyeVfexFoGj/7vCZ3imPk8WDV5sAS7h7wYYtaUUh91GrlQMZFbyF9RRsFWIIs
	2nVMPDHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ov9-0000000CrUB-3CGP;
	Thu, 24 Apr 2025 05:14:47 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ov7-0000000CrSu-1TkX
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 05:14:47 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-af51596da56so368113a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 22:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745471684; x=1746076484; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnxnE33Om/2O2SAzQlyxp21+ZlEdkIuU/WPYkbRdnps=;
        b=CzXK9qFkNuucR51FV4p9shnjCSewTrVejWADtdtdV4xOwCP9nqqthXrCuEVZ0CEgMG
         Dkb0A2+vsdljXhliyefGloj+E4r0BXjOXwirZsExlbs/+4e1FWPC1dOyvXmc80znomyS
         JCd9SBYInESi7eYPSQbtL1W6y+5gM6TSH6NZmiDXLbix7Q/IqqCbzSQ3sr47xcORhDIG
         tSaJlGjLjOSvNuah0fDNl7oCU2anUv5CW3YyArNvKfX7F7JDqRcxV6R0qtF1gvkH+Ab2
         uWIAvnGPaad+f2VWOvdOEHdaVM3LTX/dfQ+iQOGopNAoFld+H3pEgypMlK/KeZMwsaM9
         Ashg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745471684; x=1746076484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnxnE33Om/2O2SAzQlyxp21+ZlEdkIuU/WPYkbRdnps=;
        b=grs+0LA310vVSbLxUQadX0soGEtXMbGT6dlDPb+goL2e1PofPzxptEya/gCdxxR1rH
         EumCyLfsec8uXqVIvWDxe1XBe5Kc7GCbaPYaWZ1EAaFYXgUPWsBEZGJ2aeRP7vs9qO6p
         g6wV6jyEimGJFap6f91Uc+bS/qYf3cpPjca8JTdIh5hwkg93IY5zMxdbBHFHeEkUWeBb
         AYNbzC3kgRA7sidMq/KY7u0fhUNp5vYypbuPvgNMN6Tnl+cXiaxtXI3SlC6TW8mepfHF
         NYcE2zykCTv8nAVdRrL3kVI0nSFG9GjTH1/XH5m8/AfzVtXKRTgQTEln/URlrjX46Mbd
         I22g==
X-Gm-Message-State: AOJu0YxK5BiXLyMNHIVSGPF9slXT5K2WMh1XwWSIfnR/pVa4c24ASqrb
	hw/C3nJpuMu0U2lVdXfrvfUVASia5Finq2899Qt8D7jR7QXE3y/5mqjhMlqS
X-Gm-Gg: ASbGncsMI5lU0A+B41C6Tc6hBtwPDkI6e82U2EhQImpW+vBeOX2y+p5XJBFUe73GjBJ
	a6AoPDWFBE6gcKFjpMsYpNq5XBRctyiRP6VFujy++GM/daWog1hnRBQ/gqBv86tSi3lNMqhnpxs
	8hvqjw+Ek7Ya/tU31O3nUGCaUlzRnOtK46PZ7yqstnqT9fjXAKI2yMgxW8DryyqH4o79fv5opL/
	nxzGM4hkZvMXMeBD7Ai6hEdsbpE0UDsB2l6TXRMd9m/5rEZJ+R60SbRCyr+MjOKdpd4ENi7trlv
	xZ+3sgCnP058jicisb8pNRD130qW00o5gj61Bn+5hJQXIAc=
X-Google-Smtp-Source: AGHT+IG17/PESEJB44zitK1ekKExiI8+C5/FKaoHB7fQuDlVzEToYDumMz5oPnx0Vx2uhCrWD5nXEw==
X-Received: by 2002:a17:90b:3a46:b0:2ef:31a9:95c6 with SMTP id 98e67ed59e1d1-309ed270b0emr2278824a91.14.1745471684011;
        Wed, 23 Apr 2025 22:14:44 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097bdbsm324771a91.26.2025.04.23.22.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 22:14:43 -0700 (PDT)
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
Subject: [PATCH 4/5] nvmet: support completion queue sharing
Date: Thu, 24 Apr 2025 15:13:52 +1000
Message-ID: <20250424051352.7980-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_221445_402193_671B41D2 
X-CRM114-Status: GOOD (  24.68  )
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

The NVMe PCI transport specification allows for completion queues to be
shared by different submission queues.

This patch allows a submission queue to keep track of the completion queue
it is using with reference counting. As such, it can be ensured that a
completion queue is not deleted while a submission queue is actively
using it.

This patch enables completion queue sharing in the pci-epf target driver.
For fabrics drivers, completion queue sharing is not enabled as it is
not possible as per the fabrics specification. However, this patch
modifies the fabrics drivers to correctly integrate the new API that
supports completion queue sharing.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 19 ++++++++++---------
 drivers/nvme/target/core.c      | 17 ++++++++++++++---
 drivers/nvme/target/fc.c        |  2 +-
 drivers/nvme/target/loop.c      |  4 ++--
 drivers/nvme/target/nvmet.h     |  9 +++++----
 drivers/nvme/target/pci-epf.c   |  9 +++++----
 drivers/nvme/target/rdma.c      |  2 +-
 drivers/nvme/target/tcp.c       |  2 +-
 8 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e3699973d56..c7317299078d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -63,14 +63,9 @@ static void nvmet_execute_create_sq(struct nvmet_req *req)
 	if (status != NVME_SC_SUCCESS)
 		goto complete;
 
-	/*
-	 * Note: The NVMe specification allows multiple SQs to use the same CQ.
-	 * However, the target code does not really support that. So for now,
-	 * prevent this and fail the command if sqid and cqid are different.
-	 */
-	if (!cqid || cqid != sqid) {
-		pr_err("SQ %u: Unsupported CQID %u\n", sqid, cqid);
-		status = NVME_SC_CQ_INVALID | NVME_STATUS_DNR;
+	status = nvmet_check_io_cqid(ctrl, cqid, false);
+	if (status != NVME_SC_SUCCESS) {
+		pr_err("SQ %u: Invalid CQID %u\n", sqid, cqid);
 		goto complete;
 	}
 
@@ -79,7 +74,7 @@ static void nvmet_execute_create_sq(struct nvmet_req *req)
 		goto complete;
 	}
 
-	status = ctrl->ops->create_sq(ctrl, sqid, sq_flags, qsize, prp1);
+	status = ctrl->ops->create_sq(ctrl, sqid, cqid, sq_flags, qsize, prp1);
 
 complete:
 	nvmet_req_complete(req, status);
@@ -100,6 +95,12 @@ static void nvmet_execute_delete_cq(struct nvmet_req *req)
 	if (status != NVME_SC_SUCCESS)
 		goto complete;
 
+	if (!ctrl->cqs[cqid] || nvmet_cq_in_use(ctrl->cqs[cqid])) {
+		/* Some SQs are still using this CQ */
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
 	status = ctrl->ops->delete_cq(ctrl, cqid);
 
 complete:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a622a6b886cb..d989880bbafc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -902,6 +902,11 @@ u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 	if (status != NVME_SC_SUCCESS)
 		return status;
 
+	if (!kref_get_unless_zero(&ctrl->ref))
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
+	cq->ctrl = ctrl;
+
+	nvmet_cq_init(cq);
 	nvmet_cq_setup(ctrl, cq, qid, size);
 
 	return NVME_SC_SUCCESS;
@@ -925,7 +930,7 @@ u16 nvmet_check_sqid(struct nvmet_ctrl *ctrl, u16 sqid,
 }
 
 u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
-		    u16 sqid, u16 size)
+		    struct nvmet_cq *cq, u16 sqid, u16 size)
 {
 	u16 status;
 	int ret;
@@ -937,7 +942,7 @@ u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 	if (status != NVME_SC_SUCCESS)
 		return status;
 
-	ret = nvmet_sq_init(sq);
+	ret = nvmet_sq_init(sq, cq);
 	if (ret) {
 		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 		goto ctrl_put;
@@ -969,6 +974,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
 	nvmet_auth_sq_free(sq);
+	nvmet_cq_put(sq->cq);
 
 	/*
 	 * we must reference the ctrl again after waiting for inflight IO
@@ -1001,18 +1007,23 @@ static void nvmet_sq_free(struct percpu_ref *ref)
 	complete(&sq->free_done);
 }
 
-int nvmet_sq_init(struct nvmet_sq *sq)
+int nvmet_sq_init(struct nvmet_sq *sq, struct nvmet_cq *cq)
 {
 	int ret;
 
+	if (!nvmet_cq_get(cq))
+		return ret;
+
 	ret = percpu_ref_init(&sq->ref, nvmet_sq_free, 0, GFP_KERNEL);
 	if (ret) {
 		pr_err("percpu_ref init failed!\n");
+		nvmet_cq_put(cq);
 		return ret;
 	}
 	init_completion(&sq->free_done);
 	init_completion(&sq->confirm_done);
 	nvmet_auth_sq_init(sq);
+	sq->cq = cq;
 
 	return 0;
 }
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7c2a4e2eb315..2e813e51549c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -817,7 +817,7 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	nvmet_fc_prep_fcp_iodlist(assoc->tgtport, queue);
 
 	nvmet_cq_init(&queue->nvme_cq);
-	ret = nvmet_sq_init(&queue->nvme_sq);
+	ret = nvmet_sq_init(&queue->nvme_sq, &queue->nvme_cq);
 	if (ret)
 		goto out_fail_iodlist;
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 85a97f843dd5..9354a58456e0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -330,7 +330,7 @@ static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
 	for (i = 1; i <= nr_io_queues; i++) {
 		ctrl->queues[i].ctrl = ctrl;
 		nvmet_cq_init(&ctrl->queues[i].nvme_cq);
-		ret = nvmet_sq_init(&ctrl->queues[i].nvme_sq);
+		ret = nvmet_sq_init(&ctrl->queues[i].nvme_sq, &ctrl->queues[i].nvme_cq);
 		if (ret) {
 			nvmet_cq_put(&ctrl->queues[i].nvme_cq);
 			goto out_destroy_queues;
@@ -366,7 +366,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	ctrl->queues[0].ctrl = ctrl;
 	nvmet_cq_init(&ctrl->queues[0].nvme_cq);
-	error = nvmet_sq_init(&ctrl->queues[0].nvme_sq);
+	error = nvmet_sq_init(&ctrl->queues[0].nvme_sq, &ctrl->queues[0].nvme_cq);
 	if (error) {
 		nvmet_cq_put(&ctrl->queues[0].nvme_cq);
 		return error;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c87f6fb458e8..d3795b09fcc4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -150,6 +150,7 @@ struct nvmet_cq {
 struct nvmet_sq {
 	struct nvmet_ctrl	*ctrl;
 	struct percpu_ref	ref;
+	struct nvmet_cq		*cq;
 	u16			qid;
 	u16			size;
 	u32			sqhd;
@@ -427,7 +428,7 @@ struct nvmet_fabrics_ops {
 	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
 
 	/* Operations mandatory for PCI target controllers */
-	u16 (*create_sq)(struct nvmet_ctrl *ctrl, u16 sqid, u16 flags,
+	u16 (*create_sq)(struct nvmet_ctrl *ctrl, u16 sqid, u16 cqid, u16 flags,
 			 u16 qsize, u64 prp1);
 	u16 (*delete_sq)(struct nvmet_ctrl *ctrl, u16 sqid);
 	u16 (*create_cq)(struct nvmet_ctrl *ctrl, u16 cqid, u16 flags,
@@ -588,10 +589,10 @@ bool nvmet_cq_in_use(struct nvmet_cq *cq);
 u16 nvmet_check_sqid(struct nvmet_ctrl *ctrl, u16 sqid, bool create);
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
 		u16 size);
-u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
-		u16 size);
+u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
+	struct nvmet_cq *cq, u16 qid, u16 size);
 void nvmet_sq_destroy(struct nvmet_sq *sq);
-int nvmet_sq_init(struct nvmet_sq *sq);
+int nvmet_sq_init(struct nvmet_sq *sq, struct nvmet_cq *cq);
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 7dda4156d86c..e5030bca18ee 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1346,16 +1346,17 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 	nvmet_pci_epf_drain_queue(cq);
 	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
 	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
-	tctrl->cqs[cqid] = NULL;
+	nvmet_cq_put(&cq->nvme_cq);
 
 	return NVME_SC_SUCCESS;
 }
 
 static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
-		u16 sqid, u16 flags, u16 qsize, u64 pci_addr)
+		u16 sqid, u16 cqid, u16 flags, u16 qsize, u64 pci_addr)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
 	struct nvmet_pci_epf_queue *sq = &ctrl->sq[sqid];
+	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
 	u16 status;
 
 	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
@@ -1378,7 +1379,7 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 		sq->qes = ctrl->io_sqes;
 	sq->pci_size = sq->qes * sq->depth;
 
-	status = nvmet_sq_create(tctrl, &sq->nvme_sq, sqid, sq->depth);
+	status = nvmet_sq_create(tctrl, &sq->nvme_sq, &cq->nvme_cq, sqid, sq->depth);
 	if (status != NVME_SC_SUCCESS)
 		return status;
 
@@ -1873,7 +1874,7 @@ static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 
 	qsize = aqa & 0x00000fff;
 	pci_addr = asq & GENMASK_ULL(63, 12);
-	status = nvmet_pci_epf_create_sq(ctrl->tctrl, 0, NVME_QUEUE_PHYS_CONTIG,
+	status = nvmet_pci_epf_create_sq(ctrl->tctrl, 0, 0, NVME_QUEUE_PHYS_CONTIG,
 					 qsize, pci_addr);
 	if (status != NVME_SC_SUCCESS) {
 		dev_err(ctrl->dev, "Failed to create admin submission queue\n");
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 3ad9b4d1fad2..2e5c32298818 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1438,7 +1438,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	}
 
 	nvmet_cq_init(&queue->nvme_cq);
-	ret = nvmet_sq_init(&queue->nvme_sq);
+	ret = nvmet_sq_init(&queue->nvme_sq, &queue->nvme_cq);
 	if (ret) {
 		ret = NVME_RDMA_CM_NO_RSC;
 		goto out_free_queue;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5045d1bc0412..2223cfd00b58 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1949,7 +1949,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		goto out_ida_remove;
 
 	nvmet_cq_init(&queue->nvme_cq);
-	ret = nvmet_sq_init(&queue->nvme_sq);
+	ret = nvmet_sq_init(&queue->nvme_sq, &queue->nvme_cq);
 	if (ret)
 		goto out_free_connect;
 
-- 
2.49.0


