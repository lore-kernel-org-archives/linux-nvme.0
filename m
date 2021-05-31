Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3855AC47082
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 23:27:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11916127C
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 23:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11916127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vOM/cnAFZ/71KTu1lFpdUNrSEAKSKK4Z7SANzojZKEM=; b=mFtofCR169/MOl
	SkUyPKb4y04+MkNHyvwS2C+tG9cBlLf9f8eJqN9VEhisV2kSUGo7h88aeMTDh0rpkxkojbnWn3SKN
	AFkF1VglfMQ9f+4fKeaLoHlMWMVYzhhq/NgxB9WjomiA9BxwSagshjdZku7l4VKsJL9+XeQJwSfCv
	vBBC0kMTJDpEqmlEMqtmqGy8tZc0l7KIcpjVBeSQDI8l0x/CCQQtzR5Edh5OxZ8XS79NWULbCrwdP
	ZU1dF6YL1kD1jI7hH+40vz6P0BrhvoZhDnjuIbuZ+Wp3r+7EpVQCoah+pGqfiY8N3CutKa4NxJNnT
	tf7tn/lLopuo9LkNzO5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnrJP-00Dr8G-AV; Mon, 31 May 2021 23:27:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnqp0-00DhwX-CV
 for linux-nvme@bombadil.infradead.org; Mon, 31 May 2021 22:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zphGHe3hgIa13LmKFFLu2ouCIes9+6viLiac6/53jXk=; b=glEO+Py/+qnfmpIQOTfmO12X0Y
 mYVlcJMRrv0j+mflgWCYMUgvD9BbaXVaUxznRSHqNyxXE3ffbuoHpCnAv3Fx207fVcCxiA8zDW8de
 sDNJJHYiQUhasBg09nZWP/Ouv8UVEXnp5Uk4JFNgUmTWJlQq1EzRwyCLRuIpjl+VOQubvtkLk9lt2
 d/iagAEdom11KePwPpifM/i4WfiXmHckTCk45ZRCeBR2X562Y8vDYc5DZb7GbFGod/ElfvObF/57Y
 TqnjxjCgz0dSdKOmaCdP34zjwbxsQrKyLX1FWnsn90IjcUHdr9W0c18jZuMBRrv3aTZbJeiTHBz2h
 X8TcK0sA==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnqoq-002NW4-6R
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 22:55:45 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14VMporN002250; Mon, 31 May 2021 15:55:38 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38vtnja4rb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 31 May 2021 15:55:37 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 31 May 2021 15:55:35 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 31 May 2021 15:55:32 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v7 26/27] qedn: Add Connection and IO level recovery flows
Date: Tue, 1 Jun 2021 01:52:21 +0300
Message-ID: <20210531225222.16992-27-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210531225222.16992-1-smalin@marvell.com>
References: <20210531225222.16992-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: lI-hB0wrk9xjswo-9eqAk8Pmw3-zBGmq
X-Proofpoint-ORIG-GUID: lI-hB0wrk9xjswo-9eqAk8Pmw3-zBGmq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-31_15:2021-05-31,
 2021-05-31 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_235543_246263_CF132ED1 
X-CRM114-Status: GOOD (  24.42  )
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

This patch will present the connection level functionalities:
 - conn clear-sq: will release the FW restrictions in order to flush all
   the pending IOs.
 - drain: in case clear-sq is stuck, will release all the device FW
   restrictions in order to flush all the pending IOs.
 - task cleanup - will flush the IO level resources.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/hw/qedn/qedn.h      |   8 ++
 drivers/nvme/hw/qedn/qedn_conn.c | 128 ++++++++++++++++++++++++++++++-
 drivers/nvme/hw/qedn/qedn_main.c |   6 ++
 drivers/nvme/hw/qedn/qedn_task.c |  27 ++++++-
 4 files changed, 166 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index a83eccf9bfab..286d2f984a41 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -41,6 +41,8 @@
 
 #define QEDN_FW_CQ_FP_WQ_WORKQUEUE "qedn_fw_cq_fp_wq"
 
+#define QEDN_DRAIN_MAX_ATTEMPTS 3
+
 /* Protocol defines */
 #define QEDN_MAX_IO_SIZE QED_NVMETCP_MAX_IO_SIZE
 #define QEDN_MAX_PDU_SIZE 0x80000 /* 512KB */
@@ -91,6 +93,8 @@
 /* Timeouts and delay constants */
 #define QEDN_WAIT_CON_ESTABLSH_TMO 10000 /* 10 seconds */
 #define QEDN_RLS_CONS_TMO 5000 /* 5 sec */
+#define QEDN_TASK_CLEANUP_TMO 3000 /* 3 sec */
+#define QEDN_DRAIN_TMO 1000 /* 1 sec */
 
 enum qedn_state {
 	QEDN_STATE_CORE_PROBED = 0,
@@ -173,7 +177,9 @@ struct qedn_ctx {
 };
 
 enum qedn_task_flags {
+	QEDN_TASK_IS_ICREQ,
 	QEDN_TASK_USED_BY_FW,
+	QEDN_TASK_WAIT_FOR_CLEANUP,
 };
 
 struct qedn_task_ctx {
@@ -321,6 +327,8 @@ struct qedn_conn_ctx {
 	struct list_head active_task_list;
 	atomic_t num_active_tasks;
 	atomic_t num_active_fw_tasks;
+	atomic_t task_cleanups_cnt;
+	wait_queue_head_t cleanup_waitq;
 
 	/* Connection resources - turned on to indicate what resource was
 	 * allocated, to that it can later be released.
diff --git a/drivers/nvme/hw/qedn/qedn_conn.c b/drivers/nvme/hw/qedn/qedn_conn.c
index e2da6a33acef..5fd6483f5287 100644
--- a/drivers/nvme/hw/qedn/qedn_conn.c
+++ b/drivers/nvme/hw/qedn/qedn_conn.c
@@ -612,6 +612,11 @@ static int qedn_handle_icresp(struct qedn_conn_ctx *conn_ctx)
 	return rc;
 }
 
+void qedn_error_recovery(struct nvme_ctrl *nctrl)
+{
+	nvme_tcp_ofld_error_recovery(nctrl);
+}
+
 /* Slowpath EQ Callback */
 int qedn_event_cb(void *context, u8 fw_event_code, void *event_ring_data)
 {
@@ -673,6 +678,7 @@ int qedn_event_cb(void *context, u8 fw_event_code, void *event_ring_data)
 		}
 
 		break;
+
 	case NVMETCP_EVENT_TYPE_ASYN_TERMINATE_DONE:
 		if (conn_ctx->state != CONN_STATE_WAIT_FOR_DESTROY_DONE)
 			pr_err("CID=0x%x - ASYN_TERMINATE_DONE: Unexpected connection state %u\n",
@@ -681,6 +687,19 @@ int qedn_event_cb(void *context, u8 fw_event_code, void *event_ring_data)
 			queue_work(qctrl->sp_wq, &conn_ctx->sp_wq_entry);
 
 		break;
+
+	case NVMETCP_EVENT_TYPE_ASYN_CLOSE_RCVD:
+	case NVMETCP_EVENT_TYPE_ASYN_ABORT_RCVD:
+	case NVMETCP_EVENT_TYPE_ASYN_MAX_RT_TIME:
+	case NVMETCP_EVENT_TYPE_ASYN_MAX_RT_CNT:
+	case NVMETCP_EVENT_TYPE_ASYN_SYN_RCVD:
+	case NVMETCP_EVENT_TYPE_ASYN_MAX_KA_PROBES_CNT:
+	case NVMETCP_EVENT_TYPE_NVMETCP_CONN_ERROR:
+	case NVMETCP_EVENT_TYPE_TCP_CONN_ERROR:
+		qedn_error_recovery(&conn_ctx->ctrl->nctrl);
+
+		break;
+
 	default:
 		pr_err("CID=0x%x - Recv Unknown Event %u\n", conn_ctx->fw_cid, fw_event_code);
 		break;
@@ -816,9 +835,116 @@ static int qedn_prep_and_offload_queue(struct qedn_conn_ctx *conn_ctx)
 	return -EINVAL;
 }
 
+static void qedn_cleanup_fw_task(struct qedn_ctx *qedn, struct qedn_task_ctx *qedn_task)
+{
+	struct qedn_conn_ctx *conn_ctx = qedn_task->qedn_conn;
+	struct nvmetcp_task_params task_params;
+	struct nvmetcp_wqe *chain_sqe;
+	struct nvmetcp_wqe local_sqe;
+	unsigned long lock_flags;
+
+	/* Take lock to prevent race with fastpath, we don't want to
+	 * invoke cleanup flows on tasks that already returned.
+	 */
+	spin_lock_irqsave(&qedn_task->lock, lock_flags);
+	if (!qedn_task->valid) {
+		spin_unlock_irqrestore(&qedn_task->lock, lock_flags);
+
+		return;
+	}
+	/* Skip tasks not used by FW */
+	if (!test_bit(QEDN_TASK_USED_BY_FW, &qedn_task->flags)) {
+		spin_unlock_irqrestore(&qedn_task->lock, lock_flags);
+
+		return;
+	}
+	/* Skip tasks that were already invoked for cleanup */
+	if (unlikely(test_bit(QEDN_TASK_WAIT_FOR_CLEANUP, &qedn_task->flags))) {
+		spin_unlock_irqrestore(&qedn_task->lock, lock_flags);
+
+		return;
+	}
+	set_bit(QEDN_TASK_WAIT_FOR_CLEANUP, &qedn_task->flags);
+	spin_unlock_irqrestore(&qedn_task->lock, lock_flags);
+
+	atomic_inc(&conn_ctx->task_cleanups_cnt);
+
+	task_params.sqe = &local_sqe;
+	task_params.itid = qedn_task->itid;
+	qed_ops->init_task_cleanup(&task_params);
+
+	/* spin_lock - doorbell is accessed  both Rx flow and response flow */
+	spin_lock(&conn_ctx->ep.doorbell_lock);
+	chain_sqe = qed_chain_produce(&conn_ctx->ep.fw_sq_chain);
+	memcpy(chain_sqe, &local_sqe, sizeof(local_sqe));
+	qedn_ring_doorbell(conn_ctx);
+	spin_unlock(&conn_ctx->ep.doorbell_lock);
+}
+
+inline int qedn_drain(struct qedn_conn_ctx *conn_ctx)
+{
+	int drain_iter = QEDN_DRAIN_MAX_ATTEMPTS;
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	int wrc;
+
+	while (drain_iter) {
+		qed_ops->common->drain(qedn->cdev);
+		msleep(100);
+
+		wrc = wait_event_interruptible_timeout(conn_ctx->cleanup_waitq,
+						       !atomic_read(&conn_ctx->task_cleanups_cnt),
+						       msecs_to_jiffies(QEDN_DRAIN_TMO));
+		if (!wrc) {
+			drain_iter--;
+			continue;
+		}
+
+		return 0;
+	}
+
+	pr_err("CID 0x%x: cleanup after drain failed - need hard reset.\n", conn_ctx->fw_cid);
+
+	return -EINVAL;
+}
+
+void qedn_cleanup_all_fw_tasks(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_task_ctx *qedn_task, *task_tmp;
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	int wrc;
+
+	list_for_each_entry_safe_reverse(qedn_task, task_tmp, &conn_ctx->active_task_list, entry) {
+		qedn_cleanup_fw_task(qedn, qedn_task);
+	}
+
+	wrc = wait_event_interruptible_timeout(conn_ctx->cleanup_waitq,
+					       atomic_read(&conn_ctx->task_cleanups_cnt) == 0,
+					       msecs_to_jiffies(QEDN_TASK_CLEANUP_TMO));
+	if (!wrc) {
+		if (qedn_drain(conn_ctx))
+			return;
+	}
+}
+
+static void qedn_clear_fw_sq(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	int rc;
+
+	rc = qed_ops->clear_sq(qedn->cdev, conn_ctx->conn_handle);
+	if (rc)
+		pr_warn("clear_sq failed - rc %u\n", rc);
+}
+
 void qedn_cleanp_fw(struct qedn_conn_ctx *conn_ctx)
 {
-	/* Placeholder - task cleanup */
+	if (atomic_read(&conn_ctx->num_active_fw_tasks)) {
+		conn_ctx->abrt_flag = QEDN_ABORTIVE_TERMINATION;
+		qedn_clear_fw_sq(conn_ctx);
+		qedn_cleanup_all_fw_tasks(conn_ctx);
+	} else {
+		conn_ctx->abrt_flag = QEDN_NON_ABORTIVE_TERMINATION;
+	}
 }
 
 void qedn_destroy_connection(struct qedn_conn_ctx *conn_ctx)
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index d4e2a1bfa5fb..d2f8124a8267 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -252,12 +252,17 @@ static int qedn_setup_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 
 static int qedn_release_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 {
+	struct nvme_ctrl *nctrl = &ctrl->nctrl;
 	struct qedn_ctrl *qctrl;
 
 	qctrl = (struct qedn_ctrl *)ctrl->private_data;
 	if (!qctrl)
 		return -ENODEV;
 
+	if (nctrl->state == NVME_CTRL_CONNECTING ||
+	    nctrl->state == NVME_CTRL_RESETTING)
+		return 0;
+
 	if (test_and_clear_bit(LLH_FILTER, &qctrl->agg_state) &&
 	    qctrl->llh_filter) {
 		qedn_dec_llh_filter(qctrl->qedn, qctrl->llh_filter);
@@ -322,6 +327,7 @@ static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
 	qedn_set_pdu_params(conn_ctx);
 
 	init_waitqueue_head(&conn_ctx->conn_waitq);
+	init_waitqueue_head(&conn_ctx->cleanup_waitq);
 	atomic_set(&conn_ctx->est_conn_indicator, 0);
 	atomic_set(&conn_ctx->destroy_conn_indicator, 0);
 
diff --git a/drivers/nvme/hw/qedn/qedn_task.c b/drivers/nvme/hw/qedn/qedn_task.c
index 5be93264df48..2ac41b251292 100644
--- a/drivers/nvme/hw/qedn/qedn_task.c
+++ b/drivers/nvme/hw/qedn/qedn_task.c
@@ -316,6 +316,17 @@ void qedn_return_active_tasks(struct qedn_conn_ctx *conn_ctx)
 	/* Return tasks that aren't "Used by FW" to the pool */
 	list_for_each_entry_safe(qedn_task, task_tmp,
 				 &conn_ctx->active_task_list, entry) {
+		/* If we got this far, cleanup was already done
+		 * in which case we want to return the task to the pool and
+		 * release it. So we make sure the cleanup indication is down
+		 */
+		clear_bit(QEDN_TASK_WAIT_FOR_CLEANUP, &qedn_task->flags);
+
+		/* Special handling in case of ICREQ task */
+		if (unlikely(conn_ctx->state ==	CONN_STATE_WAIT_FOR_IC_COMP &&
+			     test_bit(QEDN_TASK_IS_ICREQ, &(qedn_task)->flags)))
+			qedn_common_clear_fw_sgl(&qedn_task->sgl_task_params);
+
 		qedn_clear_task(conn_ctx, qedn_task);
 		num_returned_tasks++;
 	}
@@ -653,7 +664,8 @@ void qedn_io_work_cq(struct qedn_ctx *qedn, struct nvmetcp_fw_cqe *cqe)
 		return;
 
 	if (likely(cqe->cqe_type == NVMETCP_FW_CQE_TYPE_NORMAL)) {
-		/* Placeholder - verify the connection was established */
+		if (unlikely(test_bit(QEDN_TASK_WAIT_FOR_CLEANUP, &qedn_task->flags)))
+			return;
 
 		switch (cqe->task_type) {
 		case NVMETCP_TASK_TYPE_HOST_WRITE:
@@ -694,6 +706,17 @@ void qedn_io_work_cq(struct qedn_ctx *qedn, struct nvmetcp_fw_cqe *cqe)
 			pr_info("Could not identify task type\n");
 		}
 	} else {
-		/* Placeholder - Recovery flows */
+		if (cqe->cqe_type == NVMETCP_FW_CQE_TYPE_CLEANUP) {
+			clear_bit(QEDN_TASK_WAIT_FOR_CLEANUP, &qedn_task->flags);
+			qedn_return_task_to_pool(conn_ctx, qedn_task);
+			atomic_dec(&conn_ctx->task_cleanups_cnt);
+			wake_up_interruptible(&conn_ctx->cleanup_waitq);
+
+			return;
+		}
+
+		 /* The else is NVMETCP_FW_CQE_TYPE_DUMMY - in which don't return the task.
+		  * The task will return during NVMETCP_FW_CQE_TYPE_CLEANUP.
+		  */
 	}
 }
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
