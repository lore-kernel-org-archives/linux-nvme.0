Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B87C11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 13:01:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE7061DC0
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 13:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE7061DC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d1VxuYxUXjvaP3wDbb5xButvADYt3930vI0DZPhVzoE=; b=YuMo5aU29otv9C
	PNtRpCCaP0ayn3lex9aZ8z9pmEzEQG0sRCEVsXBeNPt4VkdHKAqBrfNwaUy1sgNrU2NlcRxIVAe4v
	iwIMpeqp6nNuI9F2WgnNUgBmF6mgz8n+es2/Kzy5VuP6gSIf6k17Qp4HdN6uV+C+pVRwIH36irNIS
	keMy6rnMFRl/9DHZDeiaGDhMscg8csJF0GcNHy+cc3P5ax9DNiorckxbwhTXs6xeb9ymBctk6R5ZW
	6VZTQlj+tDlkso9bcuuBj7NYuMUnIynFu9NkGTvirf0qsRh98uD8zXN22nm7QshxYy7ajFKsPwEUs
	u0Fzv2pjytXzuQmY9aIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyDMu-00Avdp-4u; Tue, 29 Jun 2021 13:01:36 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyDAu-00AsSG-9j
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 12:49:15 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15TCjNKP014081; Tue, 29 Jun 2021 05:49:05 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 39f964duq0-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 29 Jun 2021 05:49:04 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 29 Jun 2021 05:49:01 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Tue, 29 Jun 2021 05:48:58 -0700
From: Prabhakar Kushwaha <pkushwaha@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
 <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH v4 16/20] qedn: Add support of Task and SGL
Date: Tue, 29 Jun 2021 15:47:39 +0300
Message-ID: <20210629124743.6898-17-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210629124743.6898-1-pkushwaha@marvell.com>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: h7QYHrH-iy8PjpI0lh_ON7MqQO4ebSmw
X-Proofpoint-GUID: h7QYHrH-iy8PjpI0lh_ON7MqQO4ebSmw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-29_06:2021-06-28,
 2021-06-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_054912_585993_7A4C807E 
X-CRM114-Status: GOOD (  27.91  )
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

This patch will add support of Task and SGL which is used
for slowpath and fast path IO. here Task is IO granule used
by firmware to perform tasks

The internal implementation:
- Create task/sgl resources used by all connection
- Provide APIs to allocate and free task.
- Add task support during connection establishment i.e. slowpath

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/hw/qedn/qedn.h      |  61 ++++++
 drivers/nvme/hw/qedn/qedn_conn.c |  46 ++++-
 drivers/nvme/hw/qedn/qedn_main.c |  34 +++-
 drivers/nvme/hw/qedn/qedn_task.c | 326 +++++++++++++++++++++++++++++++
 4 files changed, 463 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index 13d63f420a23..78efa8c02810 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -40,6 +40,16 @@
 
 #define QEDN_FW_CQ_FP_WQ_WORKQUEUE "qedn_fw_cq_fp_wq"
 
+/* Protocol defines */
+#define QEDN_MAX_IO_SIZE QED_NVMETCP_MAX_IO_SIZE
+
+#define QEDN_FW_SLOW_IO_MIN_SGE_LIMIT (9700 / 6)
+
+#define QEDN_MAX_HW_SECTORS (QEDN_MAX_IO_SIZE / 512)
+#define QEDN_MAX_SEGMENTS 2048
+
+#define QEDN_INVALID_ITID 0xFFFF
+
 /*
  * TCP offload stack default configurations and defines.
  * Future enhancements will allow controlling the configurable
@@ -84,6 +94,15 @@ enum qedn_state {
 	QEDN_STATE_MODULE_REMOVE_ONGOING,
 };
 
+struct qedn_io_resources {
+	/* Lock for IO resources */
+	spinlock_t resources_lock;
+	struct list_head task_free_list;
+	u32 num_alloc_tasks;
+	u32 num_free_tasks;
+	u32 no_avail_resrc_cnt;
+};
+
 /* Per CPU core params */
 struct qedn_fp_queue {
 	struct qed_chain cq_chain;
@@ -93,6 +112,10 @@ struct qedn_fp_queue {
 	struct qed_sb_info *sb_info;
 	unsigned int cpu;
 	struct work_struct fw_cq_fp_wq_entry;
+
+	/* IO related resources for host */
+	struct qedn_io_resources host_resrc;
+
 	u16 sb_id;
 	char irqname[QEDN_IRQ_NAME_LEN];
 };
@@ -116,12 +139,35 @@ struct qedn_ctx {
 	/* Connections */
 	DECLARE_HASHTABLE(conn_ctx_hash, 16);
 
+	u32 num_tasks_per_pool;
+
 	/* Fast path queues */
 	u8 num_fw_cqs;
 	struct qedn_fp_queue *fp_q_arr;
 	struct nvmetcp_glbl_queue_entry *fw_cq_array_virt;
 	dma_addr_t fw_cq_array_phy; /* Physical address of fw_cq_array_virt */
 	struct workqueue_struct *fw_cq_fp_wq;
+
+	/* Fast Path Tasks */
+	struct qed_nvmetcp_tid	tasks;
+};
+
+struct qedn_task_ctx {
+	struct qedn_conn_ctx *qedn_conn;
+	struct qedn_ctx *qedn;
+	void *fw_task_ctx;
+	struct qedn_fp_queue *fp_q;
+	struct scatterlist *nvme_sg;
+	struct nvme_tcp_ofld_req *req; /* currently proccessed request */
+	struct list_head entry;
+	spinlock_t lock; /* To protect task resources */
+	bool valid;
+	unsigned long flags; /* Used by qedn_task_flags */
+	u32 task_size;
+	u16 itid;
+	u16 cccid;
+	int req_direction;
+	struct storage_sgl_task_params sgl_task_params;
 };
 
 struct qedn_endpoint {
@@ -219,6 +265,7 @@ struct qedn_conn_ctx {
 	struct nvme_tcp_ofld_ctrl *ctrl;
 	u32 conn_handle;
 	u32 fw_cid;
+	u8 default_cq;
 
 	atomic_t est_conn_indicator;
 	atomic_t destroy_conn_indicator;
@@ -236,6 +283,11 @@ struct qedn_conn_ctx {
 	dma_addr_t host_cccid_itid_phy_addr;
 	struct qedn_endpoint ep;
 	int abrt_flag;
+	/* Spinlock for accessing active_task_list */
+	spinlock_t task_list_lock;
+	struct list_head active_task_list;
+	atomic_t num_active_tasks;
+	atomic_t num_active_fw_tasks;
 
 	/* Connection resources - turned on to indicate what resource was
 	 * allocated, to that it can later be released.
@@ -255,6 +307,7 @@ struct qedn_conn_ctx {
 enum qedn_conn_resources_state {
 	QEDN_CONN_RESRC_FW_SQ,
 	QEDN_CONN_RESRC_ACQUIRE_CONN,
+	QEDN_CONN_RESRC_TASKS,
 	QEDN_CONN_RESRC_CCCID_ITID_MAP,
 	QEDN_CONN_RESRC_TCP_PORT,
 	QEDN_CONN_RESRC_DB_ADD,
@@ -278,5 +331,13 @@ int qedn_queue_request(struct qedn_conn_ctx *qedn_conn,
 		       struct nvme_tcp_ofld_req *req);
 void qedn_nvme_req_fp_wq_handler(struct work_struct *work);
 void qedn_io_work_cq(struct qedn_ctx *qedn, struct nvmetcp_fw_cqe *cqe);
+int qedn_alloc_tasks(struct qedn_conn_ctx *conn_ctx);
+inline int qedn_qid(struct nvme_tcp_ofld_queue *queue);
+void qedn_common_clear_fw_sgl(struct storage_sgl_task_params *sgl_task_params);
+void qedn_return_active_tasks(struct qedn_conn_ctx *conn_ctx);
+struct qedn_task_ctx *
+qedn_get_free_task_from_pool(struct qedn_conn_ctx *conn_ctx, u16 cccid);
+void qedn_destroy_free_tasks(struct qedn_fp_queue *fp_q,
+			     struct qedn_io_resources *io_resrc);
 
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_conn.c b/drivers/nvme/hw/qedn/qedn_conn.c
index 962c88a4f345..5c5b365df522 100644
--- a/drivers/nvme/hw/qedn/qedn_conn.c
+++ b/drivers/nvme/hw/qedn/qedn_conn.c
@@ -29,6 +29,11 @@ static const char * const qedn_conn_state_str[] = {
 	NULL
 };
 
+inline int qedn_qid(struct nvme_tcp_ofld_queue *queue)
+{
+	return queue - queue->ctrl->queues;
+}
+
 int qedn_set_con_state(struct qedn_conn_ctx *conn_ctx,
 		       enum qedn_conn_state new_state)
 {
@@ -170,6 +175,11 @@ static void qedn_release_conn_ctx(struct qedn_conn_ctx *conn_ctx)
 		clear_bit(QEDN_CONN_RESRC_ACQUIRE_CONN, &conn_ctx->resrc_state);
 	}
 
+	if (test_bit(QEDN_CONN_RESRC_TASKS, &conn_ctx->resrc_state)) {
+		clear_bit(QEDN_CONN_RESRC_TASKS, &conn_ctx->resrc_state);
+			qedn_return_active_tasks(conn_ctx);
+	}
+
 	if (test_bit(QEDN_CONN_RESRC_CCCID_ITID_MAP, &conn_ctx->resrc_state)) {
 		dma_free_coherent(&qedn->pdev->dev,
 				  conn_ctx->sq_depth *
@@ -272,6 +282,7 @@ static int qedn_nvmetcp_offload_conn(struct qedn_conn_ctx *conn_ctx)
 	offld_prms.max_rt_time = QEDN_TCP_MAX_RT_TIME;
 	offld_prms.sq_pbl_addr =
 		(u64)qed_chain_get_pbl_phys(&qedn_ep->fw_sq_chain);
+	offld_prms.default_cq = conn_ctx->default_cq;
 
 	rc = qed_ops->offload_conn(qedn->cdev,
 				   conn_ctx->conn_handle,
@@ -420,7 +431,10 @@ void qedn_prep_db_data(struct qedn_conn_ctx *conn_ctx)
 static int qedn_prep_and_offload_queue(struct qedn_conn_ctx *conn_ctx)
 {
 	struct qedn_ctx *qedn = conn_ctx->qedn;
+	struct qedn_io_resources *io_resrc;
+	struct qedn_fp_queue *fp_q;
 	size_t dma_size;
+	u8 qid;
 	int rc;
 
 	rc = qedn_alloc_fw_sq(qedn, &conn_ctx->ep);
@@ -431,6 +445,9 @@ static int qedn_prep_and_offload_queue(struct qedn_conn_ctx *conn_ctx)
 
 	set_bit(QEDN_CONN_RESRC_FW_SQ, &conn_ctx->resrc_state);
 
+	atomic_set(&conn_ctx->num_active_tasks, 0);
+	atomic_set(&conn_ctx->num_active_fw_tasks, 0);
+
 	rc = qed_ops->acquire_conn(qedn->cdev,
 				   &conn_ctx->conn_handle,
 				   &conn_ctx->fw_cid,
@@ -444,7 +461,34 @@ static int qedn_prep_and_offload_queue(struct qedn_conn_ctx *conn_ctx)
 		 conn_ctx->conn_handle);
 	set_bit(QEDN_CONN_RESRC_ACQUIRE_CONN, &conn_ctx->resrc_state);
 
-	/* Placeholder - Allocate task resources and initialize fields */
+	qid = qedn_qid(conn_ctx->queue);
+
+	/* default_cq is mapped 1:1 with qid (with cpu core) which are
+	 * assigned for the driver
+	 */
+	conn_ctx->default_cq = qid ? qid - 1 : 0;
+	fp_q = &qedn->fp_q_arr[conn_ctx->default_cq];
+	conn_ctx->fp_q = fp_q;
+	io_resrc = &fp_q->host_resrc;
+
+	/* The first connection on each fp_q will fill task
+	 * resources
+	 */
+	spin_lock(&io_resrc->resources_lock);
+	if (io_resrc->num_alloc_tasks == 0) {
+		rc = qedn_alloc_tasks(conn_ctx);
+		if (rc) {
+			pr_err("Failed allocating tasks: CID=0x%x\n",
+			       conn_ctx->fw_cid);
+			spin_unlock(&io_resrc->resources_lock);
+			goto rel_conn;
+		}
+	}
+	spin_unlock(&io_resrc->resources_lock);
+
+	spin_lock_init(&conn_ctx->task_list_lock);
+	INIT_LIST_HEAD(&conn_ctx->active_task_list);
+	set_bit(QEDN_CONN_RESRC_TASKS, &conn_ctx->resrc_state);
 
 	rc = qedn_fetch_tcp_port(conn_ctx);
 	if (rc)
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index 975949ce6fb0..42c8ad6ac2d6 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -29,6 +29,12 @@ __be16 qedn_get_in_port(struct sockaddr_storage *sa)
 		: ((struct sockaddr_in6 *)sa)->sin6_port;
 }
 
+static void qedn_init_io_resc(struct qedn_io_resources *io_resrc)
+{
+	spin_lock_init(&io_resrc->resources_lock);
+	INIT_LIST_HEAD(&io_resrc->task_free_list);
+}
+
 struct qedn_llh_filter *qedn_add_llh_filter(struct qedn_ctx *qedn, u16 tcp_port)
 {
 	struct qedn_llh_filter *llh_filter = NULL;
@@ -436,6 +442,8 @@ static struct nvme_tcp_ofld_ops qedn_ofld_ops = {
 		 *	NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 		 *	NVMF_OPT_NR_POLL_QUEUES | NVMF_OPT_TOS
 		 */
+	.max_hw_sectors = QEDN_MAX_HW_SECTORS,
+	.max_segments = QEDN_MAX_SEGMENTS,
 	.claim_dev = qedn_claim_dev,
 	.setup_ctrl = qedn_setup_ctrl,
 	.release_ctrl = qedn_release_ctrl,
@@ -640,8 +648,24 @@ static inline int qedn_core_probe(struct qedn_ctx *qedn)
 	return rc;
 }
 
+static void qedn_call_destroy_free_tasks(struct qedn_fp_queue *fp_q,
+					 struct qedn_io_resources *io_resrc)
+{
+	if (list_empty(&io_resrc->task_free_list))
+		return;
+
+	if (io_resrc->num_alloc_tasks != io_resrc->num_free_tasks)
+		pr_err("Task Pool:Not all returned allocated=0x%x, free=0x%x\n",
+		       io_resrc->num_alloc_tasks, io_resrc->num_free_tasks);
+
+	qedn_destroy_free_tasks(fp_q, io_resrc);
+	if (io_resrc->num_free_tasks)
+		pr_err("Expected num_free_tasks to be 0\n");
+}
+
 static void qedn_free_function_queues(struct qedn_ctx *qedn)
 {
+	struct qedn_io_resources *host_resrc;
 	struct qed_sb_info *sb_info = NULL;
 	struct qedn_fp_queue *fp_q;
 	int i;
@@ -653,6 +677,9 @@ static void qedn_free_function_queues(struct qedn_ctx *qedn)
 	/* Free the fast path queues*/
 	for (i = 0; i < qedn->num_fw_cqs; i++) {
 		fp_q = &qedn->fp_q_arr[i];
+		host_resrc = &fp_q->host_resrc;
+
+		qedn_call_destroy_free_tasks(fp_q, host_resrc);
 
 		/* Free SB */
 		sb_info = fp_q->sb_info;
@@ -740,7 +767,8 @@ static int qedn_alloc_function_queues(struct qedn_ctx *qedn)
 		goto mem_alloc_failure;
 	}
 
-	/* placeholder - create task pools */
+	qedn->num_tasks_per_pool =
+		qedn->pf_params.nvmetcp_pf_params.num_tasks / qedn->num_fw_cqs;
 
 	for (i = 0; i < qedn->num_fw_cqs; i++) {
 		fp_q = &qedn->fp_q_arr[i];
@@ -782,7 +810,7 @@ static int qedn_alloc_function_queues(struct qedn_ctx *qedn)
 		fp_q->qedn = qedn;
 		INIT_WORK(&fp_q->fw_cq_fp_wq_entry, qedn_fw_cq_fq_wq_handler);
 
-		/* Placeholder - Init IO-path resources */
+		qedn_init_io_resc(&fp_q->host_resrc);
 	}
 
 	return 0;
@@ -964,7 +992,7 @@ static int __qedn_probe(struct pci_dev *pdev)
 
 	/* NVMeTCP start HW PF */
 	rc = qed_ops->start(qedn->cdev,
-			    NULL /* Placeholder for FW IO-path resources */,
+			    &qedn->tasks,
 			    qedn,
 			    qedn_event_cb);
 	if (rc) {
diff --git a/drivers/nvme/hw/qedn/qedn_task.c b/drivers/nvme/hw/qedn/qedn_task.c
index a3af55fba95c..7b228b5c5169 100644
--- a/drivers/nvme/hw/qedn/qedn_task.c
+++ b/drivers/nvme/hw/qedn/qedn_task.c
@@ -11,6 +11,332 @@
 /* Driver includes */
 #include "qedn.h"
 
+static void qedn_free_nvme_sg(struct qedn_task_ctx *qedn_task)
+{
+	kfree(qedn_task->nvme_sg);
+	qedn_task->nvme_sg = NULL;
+}
+
+static void qedn_free_fw_sgl(struct qedn_task_ctx *qedn_task)
+{
+	struct qedn_ctx *qedn = qedn_task->qedn;
+	dma_addr_t sgl_pa;
+
+	sgl_pa = HILO_DMA_REGPAIR(qedn_task->sgl_task_params.sgl_phys_addr);
+	dma_free_coherent(&qedn->pdev->dev,
+			  QEDN_MAX_SEGMENTS * sizeof(struct nvmetcp_sge),
+			  qedn_task->sgl_task_params.sgl,
+			  sgl_pa);
+	qedn_task->sgl_task_params.sgl = NULL;
+}
+
+static void qedn_destroy_single_task(struct qedn_task_ctx *qedn_task)
+{
+	u16 itid;
+
+	itid = qedn_task->itid;
+	list_del(&qedn_task->entry);
+	qedn_free_nvme_sg(qedn_task);
+	qedn_free_fw_sgl(qedn_task);
+	kfree(qedn_task);
+	qedn_task = NULL;
+}
+
+void qedn_destroy_free_tasks(struct qedn_fp_queue *fp_q,
+			     struct qedn_io_resources *io_resrc)
+{
+	struct qedn_task_ctx *qedn_task, *task_tmp;
+
+	/* Destroy tasks from the free task list */
+	list_for_each_entry_safe(qedn_task, task_tmp,
+				 &io_resrc->task_free_list, entry) {
+		qedn_destroy_single_task(qedn_task);
+		io_resrc->num_free_tasks -= 1;
+	}
+}
+
+static int qedn_alloc_nvme_sg(struct qedn_task_ctx *qedn_task)
+{
+	int rc;
+
+	qedn_task->nvme_sg = kcalloc(QEDN_MAX_SEGMENTS,
+				     sizeof(*qedn_task->nvme_sg), GFP_KERNEL);
+	if (!qedn_task->nvme_sg) {
+		rc = -ENOMEM;
+
+		return rc;
+	}
+
+	return 0;
+}
+
+static int qedn_alloc_fw_sgl(struct qedn_task_ctx *qedn_task)
+{
+	struct nvmetcp_sge **sgl = &qedn_task->sgl_task_params.sgl;
+	struct qedn_ctx *qedn = qedn_task->qedn_conn->qedn;
+	dma_addr_t sgl_phys;
+	u32 sz;
+
+	sz = QEDN_MAX_SEGMENTS * sizeof(struct nvmetcp_sge);
+	*sgl = dma_alloc_coherent(&qedn->pdev->dev, sz, &sgl_phys, GFP_KERNEL);
+	if (!*sgl) {
+		pr_err("Couldn't allocate FW sgl\n");
+
+		return -ENOMEM;
+	}
+
+	DMA_REGPAIR_LE(qedn_task->sgl_task_params.sgl_phys_addr, sgl_phys);
+
+	return 0;
+}
+
+static inline void *qedn_get_fw_task(struct qed_nvmetcp_tid *info, u16 itid)
+{
+	return (void *)(info->blocks[itid / info->num_tids_per_block] +
+			(itid % info->num_tids_per_block) * info->size);
+}
+
+static struct qedn_task_ctx *qedn_alloc_task(struct qedn_conn_ctx *conn_ctx,
+					     u16 itid)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	struct qedn_task_ctx *qedn_task;
+	void *fw_task_ctx;
+	int rc = 0;
+
+	qedn_task = kzalloc(sizeof(*qedn_task), GFP_KERNEL);
+	if (!qedn_task)
+		return NULL;
+
+	spin_lock_init(&qedn_task->lock);
+	fw_task_ctx = qedn_get_fw_task(&qedn->tasks, itid);
+	if (!fw_task_ctx) {
+		pr_err("iTID: 0x%x; Failed getting fw_task_ctx memory\n", itid);
+		goto release_task;
+	}
+
+	/* No need to memset fw_task_ctx - its done in the HSI func */
+	qedn_task->qedn_conn = conn_ctx;
+	qedn_task->qedn = qedn;
+	qedn_task->fw_task_ctx = fw_task_ctx;
+	qedn_task->valid = 0;
+	qedn_task->flags = 0;
+	qedn_task->itid = itid;
+	rc = qedn_alloc_fw_sgl(qedn_task);
+	if (rc) {
+		pr_err("iTID: 0x%x; Failed allocating FW sgl\n", itid);
+		goto release_task;
+	}
+
+	rc = qedn_alloc_nvme_sg(qedn_task);
+	if (rc) {
+		pr_err("iTID: 0x%x; Failed allocating FW sgl\n", itid);
+		goto release_fw_sgl;
+	}
+
+	return qedn_task;
+
+release_fw_sgl:
+	qedn_free_fw_sgl(qedn_task);
+release_task:
+	kfree(qedn_task);
+
+	return NULL;
+}
+
+int qedn_alloc_tasks(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	struct qedn_task_ctx *qedn_task = NULL;
+	struct qedn_io_resources *io_resrc;
+	u16 itid, start_itid, offset;
+	struct qedn_fp_queue *fp_q;
+	int i, rc;
+
+	fp_q = conn_ctx->fp_q;
+
+	offset = fp_q->sb_id;
+	io_resrc = &fp_q->host_resrc;
+
+	start_itid = qedn->num_tasks_per_pool * offset;
+	for (i = 0; i < qedn->num_tasks_per_pool; ++i) {
+		itid = start_itid + i;
+		qedn_task = qedn_alloc_task(conn_ctx, itid);
+		if (!qedn_task) {
+			pr_err("Failed allocating task\n");
+			rc = -ENOMEM;
+			goto release_tasks;
+		}
+
+		qedn_task->fp_q = fp_q;
+		io_resrc->num_free_tasks += 1;
+		list_add_tail(&qedn_task->entry, &io_resrc->task_free_list);
+	}
+
+	io_resrc->num_alloc_tasks = io_resrc->num_free_tasks;
+
+	return 0;
+
+release_tasks:
+	qedn_destroy_free_tasks(fp_q, io_resrc);
+
+	return rc;
+}
+
+void qedn_common_clear_fw_sgl(struct storage_sgl_task_params *sgl_task_params)
+{
+	u16 sge_cnt = sgl_task_params->num_sges;
+
+	memset(&sgl_task_params->sgl[(sge_cnt - 1)], 0,
+	       sizeof(struct nvmetcp_sge));
+	sgl_task_params->total_buffer_size = 0;
+	sgl_task_params->small_mid_sge = false;
+	sgl_task_params->num_sges = 0;
+}
+
+inline void qedn_host_reset_cccid_itid_entry(struct qedn_conn_ctx *conn_ctx,
+					     u16 cccid)
+{
+	conn_ctx->host_cccid_itid[cccid].itid = cpu_to_le16(QEDN_INVALID_ITID);
+}
+
+inline void qedn_host_set_cccid_itid_entry(struct qedn_conn_ctx *conn_ctx,
+					   u16 cccid, u16 itid)
+{
+	conn_ctx->host_cccid_itid[cccid].itid = cpu_to_le16(itid);
+}
+
+static void qedn_clear_sgl(struct qedn_ctx *qedn,
+			   struct qedn_task_ctx *qedn_task)
+{
+	struct storage_sgl_task_params *sgl_task_params;
+	enum dma_data_direction dma_dir;
+	u32 sge_cnt;
+
+	sgl_task_params = &qedn_task->sgl_task_params;
+	sge_cnt = sgl_task_params->num_sges;
+
+	/* Nothing to do if no SGEs were used */
+	if (!qedn_task->task_size || !sge_cnt)
+		return;
+
+	dma_dir = (qedn_task->req_direction == WRITE ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	dma_unmap_sg(&qedn->pdev->dev, qedn_task->nvme_sg, sge_cnt, dma_dir);
+	memset(&qedn_task->nvme_sg[(sge_cnt - 1)], 0,
+	       sizeof(struct scatterlist));
+	qedn_common_clear_fw_sgl(sgl_task_params);
+	qedn_task->task_size = 0;
+}
+
+static void qedn_clear_task(struct qedn_conn_ctx *conn_ctx,
+			    struct qedn_task_ctx *qedn_task)
+{
+	/* Task lock isn't needed since it is no longer in use */
+	qedn_clear_sgl(conn_ctx->qedn, qedn_task);
+	qedn_task->valid = 0;
+	qedn_task->flags = 0;
+
+	atomic_dec(&conn_ctx->num_active_tasks);
+}
+
+void qedn_return_active_tasks(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_fp_queue *fp_q = conn_ctx->fp_q;
+	struct qedn_task_ctx *qedn_task, *task_tmp;
+	struct qedn_io_resources *io_resrc;
+	int num_returned_tasks = 0;
+	int num_active_tasks;
+
+	io_resrc = &fp_q->host_resrc;
+
+	/* Return tasks that aren't "Used by FW" to the pool */
+	list_for_each_entry_safe(qedn_task, task_tmp,
+				 &conn_ctx->active_task_list, entry) {
+		qedn_clear_task(conn_ctx, qedn_task);
+		num_returned_tasks++;
+	}
+
+	if (num_returned_tasks) {
+		spin_lock(&io_resrc->resources_lock);
+		/* Return tasks to FP_Q pool in one shot */
+
+		list_splice_tail_init(&conn_ctx->active_task_list,
+				      &io_resrc->task_free_list);
+		io_resrc->num_free_tasks += num_returned_tasks;
+		spin_unlock(&io_resrc->resources_lock);
+	}
+
+	num_active_tasks = atomic_read(&conn_ctx->num_active_tasks);
+	if (num_active_tasks)
+		pr_err("num_active_tasks is %u after cleanup.\n",
+		       num_active_tasks);
+}
+
+void qedn_return_task_to_pool(struct qedn_conn_ctx *conn_ctx,
+			      struct qedn_task_ctx *qedn_task)
+{
+	struct qedn_fp_queue *fp_q = conn_ctx->fp_q;
+	struct qedn_io_resources *io_resrc;
+	unsigned long lock_flags;
+
+	io_resrc = &fp_q->host_resrc;
+
+	spin_lock_irqsave(&qedn_task->lock, lock_flags);
+	qedn_task->valid = 0;
+	qedn_task->flags = 0;
+	qedn_clear_sgl(conn_ctx->qedn, qedn_task);
+	spin_unlock_irqrestore(&qedn_task->lock, lock_flags);
+
+	spin_lock(&conn_ctx->task_list_lock);
+	list_del(&qedn_task->entry);
+	qedn_host_reset_cccid_itid_entry(conn_ctx, qedn_task->cccid);
+	spin_unlock(&conn_ctx->task_list_lock);
+
+	atomic_dec(&conn_ctx->num_active_tasks);
+	atomic_dec(&conn_ctx->num_active_fw_tasks);
+
+	spin_lock(&io_resrc->resources_lock);
+	list_add_tail(&qedn_task->entry, &io_resrc->task_free_list);
+	io_resrc->num_free_tasks += 1;
+	spin_unlock(&io_resrc->resources_lock);
+}
+
+struct qedn_task_ctx *
+qedn_get_free_task_from_pool(struct qedn_conn_ctx *conn_ctx, u16 cccid)
+{
+	struct qedn_task_ctx *qedn_task = NULL;
+	struct qedn_io_resources *io_resrc;
+	struct qedn_fp_queue *fp_q;
+
+	fp_q = conn_ctx->fp_q;
+	io_resrc = &fp_q->host_resrc;
+
+	spin_lock(&io_resrc->resources_lock);
+	qedn_task = list_first_entry_or_null(&io_resrc->task_free_list,
+					     struct qedn_task_ctx, entry);
+	if (unlikely(!qedn_task)) {
+		spin_unlock(&io_resrc->resources_lock);
+
+		return NULL;
+	}
+	list_del(&qedn_task->entry);
+	io_resrc->num_free_tasks -= 1;
+	spin_unlock(&io_resrc->resources_lock);
+
+	spin_lock(&conn_ctx->task_list_lock);
+	list_add_tail(&qedn_task->entry, &conn_ctx->active_task_list);
+	qedn_host_set_cccid_itid_entry(conn_ctx, cccid, qedn_task->itid);
+	spin_unlock(&conn_ctx->task_list_lock);
+
+	atomic_inc(&conn_ctx->num_active_tasks);
+	qedn_task->cccid = cccid;
+	qedn_task->qedn_conn = conn_ctx;
+	qedn_task->valid = 1;
+
+	return qedn_task;
+}
+
 int qedn_queue_request(struct qedn_conn_ctx *qedn_conn,
 		       struct nvme_tcp_ofld_req *req)
 {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
