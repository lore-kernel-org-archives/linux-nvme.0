Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3213FC47089
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:44:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AB8613BF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AB8613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i0DuOo6rd5MY30qTcQ/oovJNhbN9v5LPUSOpXf78U3Y=; b=Iw1xHNRQzed3KH
	jUDCc4o6R79Nc6xwaTvVU8mxtPCgOisfjXsjLTbTPog3tYKW3mLRQFf4Td+XYpN2zkQi7oVjR8jXn
	QDyWEVay6X035rUGdyhj5EI/VV2jL3vahEL4EDYLly9AtzEHfn2E6H09RFqy9E5to5m5HJIXeHqpC
	BWuHp2UoOcwPnQsYxIoSRZ+BBIRppRc690xsCwcYB+7veghuBU5D8ckW9eosEF148+nTWUwDgV+Cp
	1A9GREtnxfkX2HUEIkcO7Com1wslQg2gQ6ixh0mskaEie28Exop2+xDMslxL5Gw7KuqSvKoiwleUv
	jLBdloCdCQpsFJVYCM1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmQbS-00AfcW-Db; Fri, 28 May 2021 00:43:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmQVq-00AdJ3-GC
 for linux-nvme@bombadil.infradead.org; Fri, 28 May 2021 00:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Pqr58Cq9hS8eA8UuwALQhLE7taRPvPNhn/m34w4mkAc=; b=VNLbp/OxvW0eD7nlhWZPxijwsH
 I3FOnMWuAD8eG0saDi/2iV1YU2odaOjPZt4iGAMiTVREUDvFno/fvYo3/pcsjL9orcrd6KWzH0uxj
 g9GVewhb/kboCW0yMZ9m8kGKz75/028s/uqeGLE4yIBdYVBQZnABS2ZhPrQ9EL9NaF60nZwZQbw2N
 CEO1l8Gg7Lav5aN0gk8svxY4Tvwi3213wgPE18b2jmr3HgpZIbVURBIghQidqA4tyOIfx4j421lMo
 tRUmm4jAwcjUKbgSYRXEcVk1wdD8H4AnZ8whqlw8oi7gQ+yahXN79BlRUB5ZkOoWvlFbkjLcgmOkI
 MWgk20dQ==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmPx7-0019aV-Mm
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 00:02:22 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14S014tl008023; Thu, 27 May 2021 17:02:14 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38sxpmd06g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 27 May 2021 17:02:14 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 May 2021 17:02:11 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 May 2021 17:02:08 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v6 27/27] qedn: Add support of ASYNC
Date: Fri, 28 May 2021 02:59:02 +0300
Message-ID: <20210527235902.2185-28-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210527235902.2185-1-smalin@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: Hw0dyQr6MhuX8lqBO1soKVel1iPnkt29
X-Proofpoint-GUID: Hw0dyQr6MhuX8lqBO1soKVel1iPnkt29
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-27_13:2021-05-27,
 2021-05-27 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_010220_902332_01081A1D 
X-CRM114-Status: GOOD (  20.24  )
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
 drivers/nvme/hw/qedn/qedn_task.c | 148 +++++++++++++++++++++++++++++--
 3 files changed, 148 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index d3b8fabbcf23..808d711e11f4 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -100,6 +100,9 @@
 #define QEDN_TASK_CLEANUP_TMO 3000 /* 3 sec */
 #define QEDN_DRAIN_TMO 1000 /* 1 sec */
 
+#define QEDN_MAX_OUTSTAND_ASYNC 32
+#define QEDN_INVALID_CCCID (-1)
+
 enum qedn_state {
 	QEDN_STATE_CORE_PROBED = 0,
 	QEDN_STATE_CORE_OPEN,
@@ -182,6 +185,7 @@ struct qedn_ctx {
 
 enum qedn_task_flags {
 	QEDN_TASK_IS_ICREQ,
+	QEDN_TASK_ASYNC,
 	QEDN_TASK_USED_BY_FW,
 	QEDN_TASK_WAIT_FOR_CLEANUP,
 };
@@ -351,6 +355,10 @@ struct qedn_conn_ctx {
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
index abd0388b8f0f..eb130a607696 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -334,6 +334,7 @@ static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
 	atomic_set(&conn_ctx->destroy_conn_indicator, 0);
 
 	spin_lock_init(&conn_ctx->conn_state_lock);
+	spin_lock_init(&conn_ctx->async_cccid_bitmap_lock);
 
 	conn_ctx->qid = qid;
 
diff --git a/drivers/nvme/hw/qedn/qedn_task.c b/drivers/nvme/hw/qedn/qedn_task.c
index 525effdef0bb..e4bd911465b9 100644
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
@@ -421,6 +458,60 @@ qedn_get_free_task_from_pool(struct qedn_conn_ctx *conn_ctx, u16 cccid)
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
+	/* Internal impl. - async is treated like zero len read */
+	cmd_hdr.hdr.type = nvme_tcp_cmd;
+	cmd_hdr.hdr.flags = 0;
+	cmd_hdr.hdr.hlen = sizeof(cmd_hdr);
+	cmd_hdr.hdr.pdo = 0x0;
+	cmd_hdr.hdr.plen = cpu_to_le32(cmd_hdr.hdr.hlen);
+
+	qed_ops->init_read_io(&task_params, &cmd_hdr, nvme_cmd,
+			      &qedn_task->sgl_task_params);
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
@@ -532,6 +623,21 @@ int qedn_send_write_cmd(struct qedn_task_ctx *qedn_task, struct qedn_conn_ctx *c
 	return 0;
 }
 
+static void qedn_return_error_req(struct nvme_tcp_ofld_req *req)
+{
+	__le16 status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+	union nvme_result res = {};
+
+	if (!req)
+		return;
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
@@ -541,9 +647,17 @@ int qedn_queue_request(struct qedn_conn_ctx *qedn_conn, struct nvme_tcp_ofld_req
 
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
 	qedn_task = qedn_get_free_task_from_pool(qedn_conn, cccid);
 	if (unlikely(!qedn_task)) {
 		pr_err("Not able to allocate task context resource\n");
@@ -554,7 +668,11 @@ int qedn_queue_request(struct qedn_conn_ctx *qedn_conn, struct nvme_tcp_ofld_req
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
@@ -624,16 +742,28 @@ static inline int qedn_comp_valid_task(struct qedn_task_ctx *qedn_task,
 
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
