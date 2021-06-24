Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661AAC49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:35:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31847613E3
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31847613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gWzTLAsbiEyyOKwpS617KrCgUNS9ttngesxCEna0748=; b=2yd6u8/EO28do7
	U1r7JwRfLQJpV8/FhRvp5y0PYgsNe8eBix3seozY+nOFPXlw+7xOIt2T/Coyarxj36eu1VzPYfiem
	9dAZGzPT+69UM6D4rnYeQOGhMqVStCAnMFpUq7/I2fDlzG9S+wHLybNCebULF2nd67hpHXnQyBsRZ
	1kFzdC/ZNmD67p6/LklekSs3h1HhHGK51QW65u+ZKYtvTXnyrSKCZGL/LD8ATNEMkE+SCOdXAlTwt
	yQnDm4NYHUF654oyb3SEWZRGknSzhAOHk6z3YWegp2c06tA/mh+WKRoB0OhMp8IJAI71dy+ZDMqFf
	TsGALwZ88ol64RDiFjGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwTGS-00FgC5-Nf; Thu, 24 Jun 2021 17:35:44 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwT6q-00FdLC-PA
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 17:25:53 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15OH9leW017525; Thu, 24 Jun 2021 10:25:36 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 39cgc8bmap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 24 Jun 2021 10:25:35 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 24 Jun 2021 10:25:34 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 24 Jun 2021 10:25:31 -0700
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <aelior@marvell.com>,
 <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [PATCH v3 15/20] qedn: Add IO level qedn_send_req and fw_cq workqueue
Date: Thu, 24 Jun 2021 20:24:05 +0300
Message-ID: <20210624172410.14225-16-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210624172410.14225-1-smalin@marvell.com>
References: <20210624172410.14225-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: h-EpMhYYTrpC7OAOuKegJsQBHb73gBDI
X-Proofpoint-GUID: h-EpMhYYTrpC7OAOuKegJsQBHb73gBDI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-24_12:2021-06-24,
 2021-06-24 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_102548_894515_04B3F7F1 
X-CRM114-Status: GOOD (  26.96  )
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

This patch will present the IO level skeleton flows:

- qedn_send_req(): process new requests, similar to nvme_tcp_queue_rq().

- qedn_fw_cq_fp_wq():   process new FW completions, the flow starts from
			the IRQ handler and for a single interrupt it will
			process all the pending NVMeoF Completions under
			polling mode.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/hw/qedn/Makefile    |  2 +-
 drivers/nvme/hw/qedn/qedn.h      | 14 ++++++
 drivers/nvme/hw/qedn/qedn_conn.c |  2 +
 drivers/nvme/hw/qedn/qedn_main.c | 84 +++++++++++++++++++++++++++++---
 drivers/nvme/hw/qedn/qedn_task.c | 79 ++++++++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 9 deletions(-)
 create mode 100644 drivers/nvme/hw/qedn/qedn_task.c

diff --git a/drivers/nvme/hw/qedn/Makefile b/drivers/nvme/hw/qedn/Makefile
index ece84772d317..888d466fa5ed 100644
--- a/drivers/nvme/hw/qedn/Makefile
+++ b/drivers/nvme/hw/qedn/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_NVME_QEDN) += qedn.o
-qedn-y := qedn_main.o qedn_conn.o
+qedn-y := qedn_main.o qedn_conn.o qedn_task.o
\ No newline at end of file
diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index 9e16297fa323..13d63f420a23 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -38,6 +38,8 @@
 #define QEDN_NON_ABORTIVE_TERMINATION 0
 #define QEDN_ABORTIVE_TERMINATION 1
 
+#define QEDN_FW_CQ_FP_WQ_WORKQUEUE "qedn_fw_cq_fp_wq"
+
 /*
  * TCP offload stack default configurations and defines.
  * Future enhancements will allow controlling the configurable
@@ -90,6 +92,7 @@ struct qedn_fp_queue {
 	struct qedn_ctx	*qedn;
 	struct qed_sb_info *sb_info;
 	unsigned int cpu;
+	struct work_struct fw_cq_fp_wq_entry;
 	u16 sb_id;
 	char irqname[QEDN_IRQ_NAME_LEN];
 };
@@ -118,6 +121,7 @@ struct qedn_ctx {
 	struct qedn_fp_queue *fp_q_arr;
 	struct nvmetcp_glbl_queue_entry *fw_cq_array_virt;
 	dma_addr_t fw_cq_array_phy; /* Physical address of fw_cq_array_virt */
+	struct workqueue_struct *fw_cq_fp_wq;
 };
 
 struct qedn_endpoint {
@@ -204,6 +208,12 @@ struct qedn_ctrl {
 
 /* Connection level struct */
 struct qedn_conn_ctx {
+	/* IO path */
+	struct qedn_fp_queue *fp_q;
+	/* mutex for queueing request */
+	struct mutex send_mutex;
+	int qid;
+
 	struct qedn_ctx *qedn;
 	struct nvme_tcp_ofld_queue *queue;
 	struct nvme_tcp_ofld_ctrl *ctrl;
@@ -264,5 +274,9 @@ int qedn_set_con_state(struct qedn_conn_ctx *conn_ctx,
 void qedn_terminate_connection(struct qedn_conn_ctx *conn_ctx);
 void qedn_cleanp_fw(struct qedn_conn_ctx *conn_ctx);
 __be16 qedn_get_in_port(struct sockaddr_storage *sa);
+int qedn_queue_request(struct qedn_conn_ctx *qedn_conn,
+		       struct nvme_tcp_ofld_req *req);
+void qedn_nvme_req_fp_wq_handler(struct work_struct *work);
+void qedn_io_work_cq(struct qedn_ctx *qedn, struct nvmetcp_fw_cqe *cqe);
 
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_conn.c b/drivers/nvme/hw/qedn/qedn_conn.c
index 04c45a6fa14b..962c88a4f345 100644
--- a/drivers/nvme/hw/qedn/qedn_conn.c
+++ b/drivers/nvme/hw/qedn/qedn_conn.c
@@ -190,6 +190,7 @@ static void qedn_release_conn_ctx(struct qedn_conn_ctx *conn_ctx)
 		pr_err("Conn resources state isn't 0 as expected 0x%lx\n",
 		       conn_ctx->resrc_state);
 
+	mutex_destroy(&conn_ctx->send_mutex);
 	atomic_inc(&conn_ctx->destroy_conn_indicator);
 	qedn_set_con_state(conn_ctx, CONN_STATE_DESTROY_COMPLETE);
 	wake_up_interruptible(&conn_ctx->conn_waitq);
@@ -429,6 +430,7 @@ static int qedn_prep_and_offload_queue(struct qedn_conn_ctx *conn_ctx)
 	}
 
 	set_bit(QEDN_CONN_RESRC_FW_SQ, &conn_ctx->resrc_state);
+
 	rc = qed_ops->acquire_conn(qedn->cdev,
 				   &conn_ctx->conn_handle,
 				   &conn_ctx->fw_cid,
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index 3cadec6d6f5d..975949ce6fb0 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -310,6 +310,7 @@ static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
 	conn_ctx->queue = queue;
 	conn_ctx->ctrl = ctrl;
 	conn_ctx->sq_depth = queue_size;
+	mutex_init(&conn_ctx->send_mutex);
 
 	init_waitqueue_head(&conn_ctx->conn_waitq);
 	atomic_set(&conn_ctx->est_conn_indicator, 0);
@@ -317,6 +318,8 @@ static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
 
 	spin_lock_init(&conn_ctx->conn_state_lock);
 
+	conn_ctx->qid = qid;
+
 	qedn_initialize_endpoint(&conn_ctx->ep, qedn->local_mac_addr, ctrl);
 
 	atomic_inc(&qctrl->host_num_active_conns);
@@ -408,9 +411,18 @@ static int qedn_poll_queue(struct nvme_tcp_ofld_queue *queue)
 
 static int qedn_send_req(struct nvme_tcp_ofld_req *req)
 {
-	/* Placeholder - qedn_send_req */
+	struct qedn_conn_ctx *qedn_conn;
+	int rc = 0;
 
-	return 0;
+	qedn_conn = (struct qedn_conn_ctx *)req->queue->private_data;
+	if (unlikely(!qedn_conn))
+		return -ENXIO;
+
+	mutex_lock(&qedn_conn->send_mutex);
+	rc = qedn_queue_request(qedn_conn, req);
+	mutex_unlock(&qedn_conn->send_mutex);
+
+	return rc;
 }
 
 static struct nvme_tcp_ofld_ops qedn_ofld_ops = {
@@ -450,9 +462,58 @@ struct qedn_conn_ctx *qedn_get_conn_hash(struct qedn_ctx *qedn, u16 icid)
 }
 
 /* Fastpath IRQ handler */
+void qedn_fw_cq_fp_handler(struct qedn_fp_queue *fp_q)
+{
+	u16 sb_id, cq_prod_idx, cq_cons_idx;
+	struct qedn_ctx *qedn = fp_q->qedn;
+	struct nvmetcp_fw_cqe *cqe = NULL;
+
+	sb_id = fp_q->sb_id;
+	qed_sb_update_sb_idx(fp_q->sb_info);
+
+	/* rmb - to prevent missing new cqes */
+	rmb();
+
+	/* Read the latest cq_prod from the SB */
+	cq_prod_idx = *fp_q->cq_prod;
+	cq_cons_idx = qed_chain_get_cons_idx(&fp_q->cq_chain);
+
+	while (cq_cons_idx != cq_prod_idx) {
+		cqe = qed_chain_consume(&fp_q->cq_chain);
+		if (likely(cqe))
+			qedn_io_work_cq(qedn, cqe);
+		else
+			pr_err("Failed consuming cqe\n");
+
+		cq_cons_idx = qed_chain_get_cons_idx(&fp_q->cq_chain);
+
+		/* Check if new completions were posted */
+		if (unlikely(cq_prod_idx == cq_cons_idx)) {
+			/* rmb - to prevent missing new cqes */
+			rmb();
+
+			/* Update the latest cq_prod from the SB */
+			cq_prod_idx = *fp_q->cq_prod;
+		}
+	}
+}
+
+static void qedn_fw_cq_fq_wq_handler(struct work_struct *work)
+{
+	struct qedn_fp_queue *fp_q = container_of(work, struct qedn_fp_queue,
+						  fw_cq_fp_wq_entry);
+
+	qedn_fw_cq_fp_handler(fp_q);
+	qed_sb_ack(fp_q->sb_info, IGU_INT_ENABLE, 1);
+}
+
 static irqreturn_t qedn_irq_handler(int irq, void *dev_id)
 {
-	/* Placeholder */
+	struct qedn_fp_queue *fp_q = dev_id;
+	struct qedn_ctx *qedn = fp_q->qedn;
+
+	qed_sb_ack(fp_q->sb_info, IGU_INT_DISABLE, 0);
+	queue_work_on(fp_q->cpu, qedn->fw_cq_fp_wq, &fp_q->fw_cq_fp_wq_entry);
 
 	return IRQ_HANDLED;
 }
@@ -586,6 +647,8 @@ static void qedn_free_function_queues(struct qedn_ctx *qedn)
 	int i;
 
 	/* Free workqueues */
+	destroy_workqueue(qedn->fw_cq_fp_wq);
+	qedn->fw_cq_fp_wq = NULL;
 
 	/* Free the fast path queues*/
 	for (i = 0; i < qedn->num_fw_cqs; i++) {
@@ -653,7 +716,14 @@ static int qedn_alloc_function_queues(struct qedn_ctx *qedn)
 	u64 cq_phy_addr;
 	int i;
 
-	/* Place holder - IO-path workqueues */
+	qedn->fw_cq_fp_wq = alloc_workqueue(QEDN_FW_CQ_FP_WQ_WORKQUEUE,
+					    WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!qedn->fw_cq_fp_wq) {
+		rc = -ENODEV;
+		pr_err("Unable to create fastpath FW CQ workqueue!\n");
+
+		return rc;
+	}
 
 	qedn->fp_q_arr = kcalloc(qedn->num_fw_cqs,
 				 sizeof(struct qedn_fp_queue), GFP_KERNEL);
@@ -681,8 +751,7 @@ static int qedn_alloc_function_queues(struct qedn_ctx *qedn)
 		chain_params.mode = QED_CHAIN_MODE_PBL,
 		chain_params.cnt_type = QED_CHAIN_CNT_TYPE_U16,
 		chain_params.num_elems = QEDN_FW_CQ_SIZE;
-		/* Placeholder - sizeof(struct nvmetcp_fw_cqe)*/
-		chain_params.elem_size = 64;
+		chain_params.elem_size = sizeof(struct nvmetcp_fw_cqe);
 
 		rc = qed_ops->common->chain_alloc(qedn->cdev,
 						  &fp_q->cq_chain,
@@ -711,8 +780,7 @@ static int qedn_alloc_function_queues(struct qedn_ctx *qedn)
 		sb = fp_q->sb_info->sb_virt;
 		fp_q->cq_prod = (u16 *)&sb->pi_array[QEDN_PROTO_CQ_PROD_IDX];
 		fp_q->qedn = qedn;
-
-		/* Placeholder - Init IO-path workqueue */
+		INIT_WORK(&fp_q->fw_cq_fp_wq_entry, qedn_fw_cq_fq_wq_handler);
 
 		/* Placeholder - Init IO-path resources */
 	}
diff --git a/drivers/nvme/hw/qedn/qedn_task.c b/drivers/nvme/hw/qedn/qedn_task.c
new file mode 100644
index 000000000000..a3af55fba95c
--- /dev/null
+++ b/drivers/nvme/hw/qedn/qedn_task.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Marvell. All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+ /* Kernel includes */
+#include <linux/kernel.h>
+
+/* Driver includes */
+#include "qedn.h"
+
+int qedn_queue_request(struct qedn_conn_ctx *qedn_conn,
+		       struct nvme_tcp_ofld_req *req)
+{
+	/* Process the request */
+
+	return 0;
+}
+
+struct qedn_task_ctx *qedn_cqe_get_active_task(struct nvmetcp_fw_cqe *cqe)
+{
+	struct regpair *p = &cqe->task_opaque;
+
+	return (struct qedn_task_ctx *)((((u64)(le32_to_cpu(p->hi)) << 32)
+					+ le32_to_cpu(p->lo)));
+}
+
+void qedn_io_work_cq(struct qedn_ctx *qedn, struct nvmetcp_fw_cqe *cqe)
+{
+	struct qedn_task_ctx *qedn_task = NULL;
+	struct qedn_conn_ctx *conn_ctx = NULL;
+	u16 itid;
+	u32 cid;
+
+	conn_ctx = qedn_get_conn_hash(qedn, le16_to_cpu(cqe->conn_id));
+	if (unlikely(!conn_ctx)) {
+		pr_err("CID 0x%x: Failed to fetch conn_ctx from hash\n",
+		       le16_to_cpu(cqe->conn_id));
+
+		return;
+	}
+
+	cid = conn_ctx->fw_cid;
+	itid = le16_to_cpu(cqe->itid);
+	qedn_task = qedn_cqe_get_active_task(cqe);
+	if (unlikely(!qedn_task))
+		return;
+
+	if (likely(cqe->cqe_type == NVMETCP_FW_CQE_TYPE_NORMAL)) {
+		/* Placeholder - verify the connection was established */
+
+		switch (cqe->task_type) {
+		case NVMETCP_TASK_TYPE_HOST_WRITE:
+		case NVMETCP_TASK_TYPE_HOST_READ:
+
+			/* Placeholder - IO flow */
+
+			break;
+
+		case NVMETCP_TASK_TYPE_HOST_READ_NO_CQE:
+
+			/* Placeholder - IO flow */
+
+			break;
+
+		case NVMETCP_TASK_TYPE_INIT_CONN_REQUEST:
+
+			/* Placeholder - ICReq flow */
+
+			break;
+		default:
+			pr_info("Could not identify task type\n");
+		}
+	} else {
+		/* Placeholder - Recovery flows */
+	}
+}
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
