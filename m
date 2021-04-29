Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AADFC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:54:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8637D60FE4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8637D60FE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=El7P8vMxHSlsJj70AThM3yODEIKNebdrSPIOEVYXt4o=; b=HpdQQvBQ98oKyD64Sp6I0O+Jr
	rjqSb0+VDyWRreuAtTIeKR8QRkPOsFGtAnqdCr3Mi8AuvSajkwLj8TKr6CbSU6xXDrjBQSs/I4YYz
	JN9XcpmmP4WwODYD3yYiF9a36b1VOZOOoQLJP7oLDIkXwhH5JRzb7UIkUkiccXc3ZLew/yqTde6xs
	7UY/HFICUogT7Yr4Nc5H4ELnz5h4J6ftP/joOm924tMSwcePNL/7lmuhul0l/VYcLtQExADsp2j4O
	94BOxLB583/yobZgHB4CmPisxe7JVBOLx0jM3N8urAnv3vJ/hybdUzDuyIFPBh8kYbJGDVOD4r/5p
	QzglKP6yw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcCjD-006LQD-7X; Thu, 29 Apr 2021 19:53:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC4Z-006Fdg-FF
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 19:11:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vcKGqswreD5kegVxWhpCK/0bNVNpaBctigjH7A3KNF0=; b=rYqTWkNQqbUvf3OiLB6mBvISQ1
 OVDayJAW6pAoNOl95ZnJiWxFRX/6F1vaTXclQL7JEohTDq/+sKsfVLp33v+1P5EqzETqu/dSu7qKn
 z62sIv8fcTDRFqX3NBj8QQY97vlxWLiIdYVpNkotgxQq12jRj8XHH4BavWNqcjmGMCzOeWZwY8+BX
 lgdFJZayCXehgQbs0DITnkMaaaoTla+bD+Ih5z0dU+W9b/jH1QL/YWDPsO9wfvtDYFE/7hAPk+MQz
 ecW2pUqxotXRZt/gM+iVTNgHasMs70GsVg97xLWaqs/d5bMxHvpx8BAjc6W/nD9Hpme6PpNsiDO99
 +QvINpDw==;
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC4W-000sje-FA
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 19:11:38 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13TJ6QMN019652; Thu, 29 Apr 2021 12:11:32 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 387erumw77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 29 Apr 2021 12:11:32 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 29 Apr 2021 12:11:30 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 29 Apr 2021 12:11:27 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: =?UTF-8?q?David=20S=20=2E=20Miller=20davem=20=40=20davemloft=20=2E=20net=20=C2=A0--cc=3DJakub=20Kicinski?=
 <kuba@kernel.org>,
 <smalin@marvell.com>, <aelior@marvell.com>, <mkalderon@marvell.com>,
 <okulkarni@marvell.com>, <pkushwaha@marvell.com>, <malin1024@gmail.com>
Subject: [RFC PATCH v4 27/27] qedn: Add support of ASYNC
Date: Thu, 29 Apr 2021 22:09:26 +0300
Message-ID: <20210429190926.5086-28-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210429190926.5086-1-smalin@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: jZJA06uKBK6Om4KgjLtrVG3eQRAdBkRl
X-Proofpoint-ORIG-GUID: jZJA06uKBK6Om4KgjLtrVG3eQRAdBkRl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-29_10:2021-04-28,
 2021-04-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_121136_568321_48E51649 
X-CRM114-Status: GOOD (  21.76  )
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
---
 drivers/nvme/hw/qedn/qedn.h      |   8 ++
 drivers/nvme/hw/qedn/qedn_main.c |   1 +
 drivers/nvme/hw/qedn/qedn_task.c | 156 +++++++++++++++++++++++++++++--
 3 files changed, 156 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index fed4252392e0..067dc45027d4 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -109,6 +109,9 @@
 #define QEDN_TASK_CLEANUP_TMO 3000 /* 3 sec */
 #define QEDN_DRAIN_TMO 1000 /* 1 sec */
 
+#define QEDN_MAX_OUTSTAND_ASYNC 32
+#define QEDN_INVALID_CCCID (-1)
+
 enum qedn_state {
 	QEDN_STATE_CORE_PROBED = 0,
 	QEDN_STATE_CORE_OPEN,
@@ -196,6 +199,7 @@ struct qedn_ctx {
 
 enum qedn_task_flags {
 	QEDN_TASK_IS_ICREQ,
+	QEDN_TASK_ASYNC,
 	QEDN_TASK_USED_BY_FW,
 	QEDN_TASK_WAIT_FOR_CLEANUP,
 };
@@ -373,6 +377,10 @@ struct qedn_conn_ctx {
 	struct nvmetcp_icresp_hdr_psh icresp;
 	struct qedn_icreq_padding *icreq_pad;
 
+	DECLARE_BITMAP(async_cccid_idx_map, QEDN_MAX_OUTSTAND_ASYNC);
+	/* Spinlock for fetching pseudo CCCID for async request */
+	spinlock_t async_cccid_bitmap_lock;
+
 	/* "dummy" socket */
 	struct socket *sock;
 };
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index 63a4e88d826d..d2575767be47 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -328,6 +328,7 @@ static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid, size_t
 	atomic_set(&conn_ctx->destroy_conn_indicator, 0);
 
 	spin_lock_init(&conn_ctx->conn_state_lock);
+	spin_lock_init(&conn_ctx->async_cccid_bitmap_lock);
 
 	INIT_WORK(&conn_ctx->nvme_req_fp_wq_entry, qedn_nvme_req_fp_wq_handler);
 	conn_ctx->nvme_req_fp_wq = qedn->nvme_req_fp_wq;
diff --git a/drivers/nvme/hw/qedn/qedn_task.c b/drivers/nvme/hw/qedn/qedn_task.c
index 4ae6c0f66258..9ed6bc6c5c8a 100644
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
@@ -447,6 +484,67 @@ qedn_get_task_from_pool_insist(struct qedn_conn_ctx *conn_ctx, u16 cccid)
 	return qedn_task;
 }
 
+void qedn_send_async_event_cmd(struct qedn_task_ctx *qedn_task,
+			       struct qedn_conn_ctx *conn_ctx)
+{
+	struct nvme_tcp_ofld_req *async_req = qedn_task->req;
+	struct nvme_command *nvme_cmd = &async_req->nvme_cmd;
+	struct storage_sgl_task_params *sgl_task_params;
+	struct nvmetcp_task_params task_params;
+	struct nvmetcp_cmd_capsule_hdr cmd_hdr;
+	struct nvmetcp_conn_params conn_params;
+	struct nvmetcp_wqe *chain_sqe;
+	struct nvmetcp_wqe local_sqe;
+	int i;
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
+	conn_params.max_burst_length = QEDN_MAX_IO_SIZE;
+
+	/* Internal impl. - async is treated like zero len read */
+	cmd_hdr.chdr.pdu_type = nvme_tcp_cmd;
+	cmd_hdr.chdr.flags = 0;
+	cmd_hdr.chdr.hlen = sizeof(cmd_hdr);
+	cmd_hdr.chdr.pdo = 0x0;
+	cmd_hdr.chdr.plen_swapped = cpu_to_le32(__swab32(cmd_hdr.chdr.hlen));
+
+	for (i = 0; i < 16; i++)
+		cmd_hdr.pshdr.raw_swapped[i] = cpu_to_le32(__swab32(((u32 *)nvme_cmd)[i]));
+
+	qed_ops->init_read_io(&task_params, &conn_params, &cmd_hdr, &qedn_task->sgl_task_params);
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
@@ -580,6 +678,24 @@ static void qedn_fetch_request(struct qedn_conn_ctx *qedn_conn)
 	spin_unlock(&qedn_conn->nvme_req_lock);
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
 static bool qedn_process_req(struct qedn_conn_ctx *qedn_conn)
 {
 	struct qedn_task_ctx *qedn_task;
@@ -595,9 +711,16 @@ static bool qedn_process_req(struct qedn_conn_ctx *qedn_conn)
 	req = qedn_conn->req;
 	rq = blk_mq_rq_from_pdu(req);
 
-	/* Placeholder - async */
+	if (unlikely(req->async)) {
+		cccid = qedn_get_free_async_cccid(qedn_conn);
+		if (cccid == QEDN_INVALID_CCCID) {
+			qedn_return_error_req(req);
+			goto doorbell;
+		}
+	} else {
+		cccid = rq->tag;
+	}
 
-	cccid = rq->tag;
 	qedn_task = qedn_get_task_from_pool_insist(qedn_conn, cccid);
 	if (unlikely(!qedn_task)) {
 		pr_err("Not able to allocate task context\n");
@@ -607,7 +730,10 @@ static bool qedn_process_req(struct qedn_conn_ctx *qedn_conn)
 	req->private_data = qedn_task;
 	qedn_task->req = req;
 
-	/* Placeholder - handle (req->async) */
+	if (unlikely(req->async)) {
+		qedn_send_async_event_cmd(qedn_task, qedn_conn);
+		goto doorbell;
+	}
 
 	/* Check if there are physical segments in request to determine the task size.
 	 * The logic of nvme_tcp_set_sg_null() will be implemented as part of
@@ -732,14 +858,26 @@ static inline int qedn_comp_valid_task(struct qedn_task_ctx *qedn_task,
 
 int qedn_process_nvme_cqe(struct qedn_task_ctx *qedn_task, struct nvme_completion *cqe)
 {
+	struct qedn_conn_ctx *conn_ctx = qedn_task->qedn_conn;
+	struct nvme_tcp_ofld_req *req;
 	int rc = 0;
+	bool async;
+
+	async = test_bit(QEDN_TASK_ASYNC, &(qedn_task)->flags);
 
 	/* cqe arrives swapped */
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
