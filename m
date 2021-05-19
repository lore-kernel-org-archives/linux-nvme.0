Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF68EC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 12:45:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A29860FF0
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 12:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A29860FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dzdKgdbKW29+GEd9JrDV11tSBlzaKPZHP/JgHvM15Qc=; b=dny9Cw+TTXMs0hP1/1r6nR5Vk
	gEKNjPT4CiYEN5dYJNvsF6/ilize4CqXCEbjrE2PNvkFpRsIboPEvAWCn/i38viM7+XOHYqcwFyfD
	hzr3rzc3YBT+cS79gT0cmLa5UmdmhHSUtVi1u990TArzmd0GAhD71tVZF1ObkMGbCSyN7opV+gIxB
	OOJO8KYXixDFHBB/M7NwyQ2fVscGHQ2U51h3RVEarP9GAir356fbj24NZrw7BQF8CcpNGo7IY0s7u
	+X2NiMZU3z/h5d5rgR89PLa9wJBShdGiqcWQo2iGQ+sfOHaqZt+bB0/idIExLr3WP2HTd4uE7sf7j
	rQw35/N3w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljLZP-003x9H-02; Wed, 19 May 2021 12:45:03 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKBp-003jQK-BU
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 11:16:41 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14JBBDJJ008736; Wed, 19 May 2021 04:16:31 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38mqcwhy8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 19 May 2021 04:16:31 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 19 May 2021 04:16:29 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 19 May 2021 04:16:26 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v5 27/27] qedn: Add support of ASYNC
Date: Wed, 19 May 2021 14:13:40 +0300
Message-ID: <20210519111340.20613-28-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210519111340.20613-1-smalin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: LgxFIFbySmknIrQxQ-jTmhp68rqlvTO7
X-Proofpoint-ORIG-GUID: LgxFIFbySmknIrQxQ-jTmhp68rqlvTO7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-19_04:2021-05-19,
 2021-05-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_121638_820080_DDE468FE 
X-CRM114-Status: GOOD (  21.58  )
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

From: Prabhakar Kushwaha <pkushwaha@marvell.com>

This patch implement ASYNC request and response event notification
handling at qedn driver level.

NVME Ofld layer's ASYNC request is treated similar to read with
fake CCCID. This CCCID used to route ASYNC notification back to
the NVME ofld layer.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/hw/qedn/qedn.h      |   8 ++
 drivers/nvme/hw/qedn/qedn_main.c |   1 +
 drivers/nvme/hw/qedn/qedn_task.c | 156 +++++++++++++++++++++++++++++--
 3 files changed, 156 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index e01584bd8d20..8964eaac65c7 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -110,6 +110,9 @@
 #define QEDN_TASK_CLEANUP_TMO 3000 /* 3 sec */
 #define QEDN_DRAIN_TMO 1000 /* 1 sec */
 
+#define QEDN_MAX_OUTSTAND_ASYNC 32
+#define QEDN_INVALID_CCCID (-1)
+
 enum qedn_state {
 	QEDN_STATE_CORE_PROBED = 0,
 	QEDN_STATE_CORE_OPEN,
@@ -192,6 +195,7 @@ struct qedn_ctx {
 
 enum qedn_task_flags {
 	QEDN_TASK_IS_ICREQ,
+	QEDN_TASK_ASYNC,
 	QEDN_TASK_USED_BY_FW,
 	QEDN_TASK_WAIT_FOR_CLEANUP,
 };
@@ -356,6 +360,10 @@ struct qedn_conn_ctx {
 	struct nvme_tcp_icresp_pdu icresp;
 	struct qedn_icreq_padding *icreq_pad;
 
+	DECLARE_BITMAP(async_cccid_idx_map, QEDN_MAX_OUTSTAND_ASYNC);
+	/* Spinlock for fetching pseudo CCCID for async request */
+	spinlock_t async_cccid_bitmap_lock;
+
 	/* "dummy" socket */
 	struct socket *sock;
 };
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index 2a1135fb4ae3..2430e59f2af5 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -304,6 +304,7 @@ static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid, size_t
 	atomic_set(&conn_ctx->destroy_conn_indicator, 0);
 
 	spin_lock_init(&conn_ctx->conn_state_lock);
+	spin_lock_init(&conn_ctx->async_cccid_bitmap_lock);
 
 	conn_ctx->qid = qid;
 
diff --git a/drivers/nvme/hw/qedn/qedn_task.c b/drivers/nvme/hw/qedn/qedn_task.c
index 4fca9a4707cd..9e0672d536e2 100644
--- a/drivers/nvme/hw/qedn/qedn_task.c
+++ b/drivers/nvme/hw/qedn/qedn_task.c
@@ -259,10 +259,45 @@ void qedn_common_clear_fw_sgl(struct storage_sgl_task_params *sgl_task_params)
 	sgl_task_params->num_sges = 0;
 }
 
-inline void qedn_host_reset_cccid_itid_entry(struct qedn_conn_ctx *conn_ctx,
-					     u16 cccid)
+inline void qedn_host_reset_cccid_itid_entry(struct qedn_conn_ctx *conn_ctx, u16 cccid, bool async)
 {
 	conn_ctx->host_cccid_itid[cccid].itid = cpu_to_le16(QEDN_INVALID_ITID);
+	if (unlikely(async))
+		clear_bit(cccid - NVME_AQ_DEPTH,
+			  conn_ctx->async_cccid_idx_map);
+}
+
+static int qedn_get_free_idx(struct qedn_conn_ctx *conn_ctx, unsigned int size)
+{
+	int idx;
+
+	spin_lock(&conn_ctx->async_cccid_bitmap_lock);
+	idx = find_first_zero_bit(conn_ctx->async_cccid_idx_map, size);
+	if (unlikely(idx >= size)) {
+		idx = -1;
+		spin_unlock(&conn_ctx->async_cccid_bitmap_lock);
+		goto err_idx;
+	}
+	set_bit(idx, conn_ctx->async_cccid_idx_map);
+	spin_unlock(&conn_ctx->async_cccid_bitmap_lock);
+
+err_idx:
+
+	return idx;
+}
+
+int qedn_get_free_async_cccid(struct qedn_conn_ctx *conn_ctx)
+{
+	int async_cccid;
+
+	async_cccid =
+		qedn_get_free_idx(conn_ctx, QEDN_MAX_OUTSTAND_ASYNC);
+	if (unlikely(async_cccid == QEDN_INVALID_CCCID))
+		pr_err("No available CCCID for Async.\n");
+	else
+		async_cccid += NVME_AQ_DEPTH;
+
+	return async_cccid;
 }
 
 inline void qedn_host_set_cccid_itid_entry(struct qedn_conn_ctx *conn_ctx, u16 cccid, u16 itid)
@@ -363,10 +398,12 @@ void qedn_return_task_to_pool(struct qedn_conn_ctx *conn_ctx,
 	struct qedn_fp_queue *fp_q = conn_ctx->fp_q;
 	struct qedn_io_resources *io_resrc;
 	unsigned long lock_flags;
+	bool async;
 
 	io_resrc = &fp_q->host_resrc;
 
 	spin_lock_irqsave(&qedn_task->lock, lock_flags);
+	async = test_bit(QEDN_TASK_ASYNC, &(qedn_task)->flags);
 	qedn_task->valid = 0;
 	qedn_task->flags = 0;
 	qedn_clear_sgl(conn_ctx->qedn, qedn_task);
@@ -374,7 +411,7 @@ void qedn_return_task_to_pool(struct qedn_conn_ctx *conn_ctx,
 
 	spin_lock(&conn_ctx->task_list_lock);
 	list_del(&qedn_task->entry);
-	qedn_host_reset_cccid_itid_entry(conn_ctx, qedn_task->cccid);
+	qedn_host_reset_cccid_itid_entry(conn_ctx, qedn_task->cccid, async);
 	spin_unlock(&conn_ctx->task_list_lock);
 
 	atomic_dec(&conn_ctx->num_active_tasks);
@@ -447,6 +484,65 @@ qedn_get_task_from_pool_insist(struct qedn_conn_ctx *conn_ctx, u16 cccid)
 	return qedn_task;
 }
 
+void qedn_send_async_event_cmd(struct qedn_task_ctx *qedn_task,
+			       struct qedn_conn_ctx *conn_ctx)
+{
+	struct nvme_tcp_ofld_req *async_req = qedn_task->req;
+	struct nvme_command *nvme_cmd = &async_req->nvme_cmd;
+	struct storage_sgl_task_params *sgl_task_params;
+	struct nvmetcp_task_params task_params;
+	struct nvme_tcp_cmd_pdu cmd_hdr;
+	struct nvmetcp_wqe *chain_sqe;
+	struct nvmetcp_wqe local_sqe;
+	u32 max_burst_length;
+
+	set_bit(QEDN_TASK_ASYNC, &qedn_task->flags);
+	nvme_cmd->common.command_id = qedn_task->cccid;
+	qedn_task->task_size = 0;
+
+	/* Initialize sgl params */
+	sgl_task_params = &qedn_task->sgl_task_params;
+	sgl_task_params->total_buffer_size = 0;
+	sgl_task_params->num_sges = 0;
+	sgl_task_params->small_mid_sge = false;
+
+	task_params.opq.lo = cpu_to_le32(((u64)(qedn_task)) & 0xffffffff);
+	task_params.opq.hi = cpu_to_le32(((u64)(qedn_task)) >> 32);
+
+	/* Initialize task params */
+	task_params.context = qedn_task->fw_task_ctx;
+	task_params.sqe = &local_sqe;
+	task_params.tx_io_size = 0;
+	task_params.rx_io_size = 0;
+	task_params.conn_icid = (u16)conn_ctx->conn_handle;
+	task_params.itid = qedn_task->itid;
+	task_params.cq_rss_number = conn_ctx->default_cq;
+	task_params.send_write_incapsule = 0;
+
+	/* Initialize conn params */
+	max_burst_length = QEDN_MAX_IO_SIZE;
+
+	/* Internal impl. - async is treated like zero len read */
+	cmd_hdr.hdr.type = nvme_tcp_cmd;
+	cmd_hdr.hdr.flags = 0;
+	cmd_hdr.hdr.hlen = sizeof(cmd_hdr);
+	cmd_hdr.hdr.pdo = 0x0;
+	/* Swapping requirement will be removed in future FW versions */
+	cmd_hdr.hdr.plen = cpu_to_le32(__swab32(cmd_hdr.hdr.hlen));
+
+	qed_ops->init_read_io(&task_params, max_burst_length, &cmd_hdr,
+			      nvme_cmd, &qedn_task->sgl_task_params);
+
+	set_bit(QEDN_TASK_USED_BY_FW, &qedn_task->flags);
+	atomic_inc(&conn_ctx->num_active_fw_tasks);
+
+	spin_lock(&conn_ctx->ep.doorbell_lock);
+	chain_sqe = qed_chain_produce(&conn_ctx->ep.fw_sq_chain);
+	memcpy(chain_sqe, &local_sqe, sizeof(local_sqe));
+	qedn_ring_doorbell(conn_ctx);
+	spin_unlock(&conn_ctx->ep.doorbell_lock);
+}
+
 int qedn_send_read_cmd(struct qedn_task_ctx *qedn_task, struct qedn_conn_ctx *conn_ctx)
 {
 	struct nvme_command *nvme_cmd = &qedn_task->req->nvme_cmd;
@@ -568,6 +664,24 @@ int qedn_send_write_cmd(struct qedn_task_ctx *qedn_task, struct qedn_conn_ctx *c
 	return 0;
 }
 
+static void qedn_return_error_req(struct nvme_tcp_ofld_req *req)
+{
+	__le16 status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+	union nvme_result res = {};
+	struct request *rq;
+
+	if (!req)
+		return;
+
+	rq = blk_mq_rq_from_pdu(req);
+
+	/* Call request done to compelete the request */
+	if (req->done)
+		req->done(req, &res, status);
+	else
+		pr_err("request done not set !!!\n");
+}
+
 int qedn_queue_request(struct qedn_conn_ctx *qedn_conn, struct nvme_tcp_ofld_req *req)
 {
 	struct qedn_task_ctx *qedn_task;
@@ -577,9 +691,17 @@ int qedn_queue_request(struct qedn_conn_ctx *qedn_conn, struct nvme_tcp_ofld_req
 
 	rq = blk_mq_rq_from_pdu(req);
 
-	/* Placeholder - async */
+	if (unlikely(req->async)) {
+		cccid = qedn_get_free_async_cccid(qedn_conn);
+		if (cccid == QEDN_INVALID_CCCID) {
+			qedn_return_error_req(req);
+
+			return BLK_STS_NOTSUPP;
+		}
+	} else {
+		cccid = rq->tag;
+	}
 
-	cccid = rq->tag;
 	qedn_task = qedn_get_task_from_pool_insist(qedn_conn, cccid);
 	if (unlikely(!qedn_task)) {
 		pr_err("Not able to allocate task context resource\n");
@@ -590,7 +712,11 @@ int qedn_queue_request(struct qedn_conn_ctx *qedn_conn, struct nvme_tcp_ofld_req
 	req->private_data = qedn_task;
 	qedn_task->req = req;
 
-	/* Placeholder - handle (req->async) */
+	if (unlikely(req->async)) {
+		qedn_send_async_event_cmd(qedn_task, qedn_conn);
+
+		return BLK_STS_TRANSPORT;
+	}
 
 	/* Check if there are physical segments in request to determine the task size.
 	 * The logic of nvme_tcp_set_sg_null() will be implemented as part of
@@ -660,16 +786,28 @@ static inline int qedn_comp_valid_task(struct qedn_task_ctx *qedn_task,
 
 int qedn_process_nvme_cqe(struct qedn_task_ctx *qedn_task, struct nvme_completion *cqe)
 {
+	struct qedn_conn_ctx *conn_ctx = qedn_task->qedn_conn;
+	struct nvme_tcp_ofld_req *req;
 	int rc = 0;
+	bool async;
+
+	async = test_bit(QEDN_TASK_ASYNC, &(qedn_task)->flags);
 
 	/* CQE arrives swapped
 	 * Swapping requirement will be removed in future FW versions
 	 */
 	qedn_swap_bytes((u32 *)cqe, (sizeof(*cqe) / sizeof(u32)));
 
-	/* Placeholder - async */
-
-	rc = qedn_comp_valid_task(qedn_task, &cqe->result, cqe->status);
+	if (unlikely(async)) {
+		qedn_return_task_to_pool(conn_ctx, qedn_task);
+		req = qedn_task->req;
+		if (req->done)
+			req->done(req, &cqe->result, cqe->status);
+		else
+			pr_err("request done not set for async request !!!\n");
+	} else {
+		rc = qedn_comp_valid_task(qedn_task, &cqe->result, cqe->status);
+	}
 
 	return rc;
 }
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
