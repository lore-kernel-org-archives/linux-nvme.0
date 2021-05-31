Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5529EC47080
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 23:29:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027CE61263
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 23:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027CE61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5t3RwukDDTbUFLtvNumH9fSYKq7ALCwAVwoeqQAAbkI=; b=UzUCfoR/K7rxRh
	6f6XJ59JqbWIZQW7jnVDwykwFIont90/StLq2NgOC2bsGZHluEp2rsXMwK5Zby68MB30pd+R16Fac
	H8iyzY9dIRaaWCMf6cY4PHI6cglqxeq4N+R2U4vc0XFmMTtT5QCzjQSzpCPuxQVmlh6BtQ8Br1vac
	GOyMCR6CCRs9wvwyuX5C68rc5hHpstqSIj8cgm3dh6aijm5gVEdLN/xuRVAHwO4qZquY0gKDZFnBP
	mL0eSJJWQbXwOy/D7G8t+MkRq4MVi2nRA3RdRi5ITOm17I8cjC6OyMt6D91xsP9fVrLXBovnobIwL
	XpzuS5BCzdVqm2yVlgDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnrLN-00DrVn-5M; Mon, 31 May 2021 23:29:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnqp1-00Dhx2-5B
 for linux-nvme@bombadil.infradead.org; Mon, 31 May 2021 22:55:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CPCHdp+aLnl9BKK0ljZkA5QThj1omiceiiYDZsFNyvM=; b=HEQv8cvkU7XL/DmjlC9qBJu1dX
 UVnytH6DPKNz8YBWQX8x5dpR53l9uvpNAKvV9gUie+MD4lQ08jZ/XKM+h2k4nhEYAOUmqm7hjjBZW
 nvomXUxpTerSA6r1s1A7P6dZTTLDAB6/q2jamqNuhUtidw6YIQDfUgjzuYM9hhd/Q3JeMEDp5b02J
 h1g97XN0cB/nUHE3FSxaCTT6zOTJVRuBdyQh9Jyid2E4/3wy9BmfuClMDHp8IyDnxNTmODQ5Bj2qi
 0Ca1UgcONWhyCYWvZg3eFZOc4PGYaBA8UvbRPEeE08AKP4c8kX3fvwimFqtoen7y3jTds5gKzp7gQ
 llgitMrw==;
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnqoq-002NW5-Ln
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 22:55:45 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14VMp3a6022364; Mon, 31 May 2021 15:55:32 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 38vjqj36vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 31 May 2021 15:55:32 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 31 May 2021 15:55:31 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 31 May 2021 15:55:27 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v7 25/27] qedn: Add IO level fastpath functionality
Date: Tue, 1 Jun 2021 01:52:20 +0300
Message-ID: <20210531225222.16992-26-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210531225222.16992-1-smalin@marvell.com>
References: <20210531225222.16992-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: kN2Abu5IKNaJNVuOF21aAdfsTFCwhREM
X-Proofpoint-ORIG-GUID: kN2Abu5IKNaJNVuOF21aAdfsTFCwhREM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-31_15:2021-05-31,
 2021-05-31 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_235543_876100_52955AF3 
X-CRM114-Status: GOOD (  23.90  )
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

This patch will present the IO level functionality of qedn
nvme-tcp-offload host mode. The qedn_task_ctx structure is containing
various params and state of the current IO, and is mapped 1x1 to the
fw_task_ctx which is a HW and FW IO context.
A qedn_task is mapped directly to its parent connection.
For every new IO a qedn_task structure will be assigned and they will be
linked for the entire IO's life span.

The patch will include 2 flows:
  1. Send new command to the FW:
	 The flow is: nvme_tcp_ofld_queue_rq() which invokes qedn_send_req()
	 which invokes qedn_queue_request() which will:
         - Assign fw_task_ctx.
	 - Prepare the Read/Write SG buffer.
	 - Initialize the HW and FW context.
	 - Pass the IO to the FW.

  2. Process the IO completion:
     The flow is: qedn_irq_handler() which invokes qedn_fw_cq_fp_handler()
	 which invokes qedn_io_work_cq() which will:
	 - process the FW completion.
	 - Return the fw_task_ctx to the task pool.
	 - complete the nvme req.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/hw/qedn/qedn.h      |   5 +
 drivers/nvme/hw/qedn/qedn_conn.c |   1 +
 drivers/nvme/hw/qedn/qedn_main.c |   8 +
 drivers/nvme/hw/qedn/qedn_task.c | 306 ++++++++++++++++++++++++++++++-
 4 files changed, 316 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index 9584021c4db1..a83eccf9bfab 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -172,6 +172,10 @@ struct qedn_ctx {
 	struct qed_nvmetcp_tid	tasks;
 };
 
+enum qedn_task_flags {
+	QEDN_TASK_USED_BY_FW,
+};
+
 struct qedn_task_ctx {
 	struct qedn_conn_ctx *qedn_conn;
 	struct qedn_ctx *qedn;
@@ -372,6 +376,7 @@ struct qedn_task_ctx *
 qedn_get_free_task_from_pool(struct qedn_conn_ctx *conn_ctx, u16 cccid);
 void qedn_destroy_free_tasks(struct qedn_fp_queue *fp_q,
 			     struct qedn_io_resources *io_resrc);
+void qedn_swap_bytes(u32 *p, int size);
 void qedn_prep_icresp(struct qedn_conn_ctx *conn_ctx, struct nvmetcp_fw_cqe *cqe);
 void qedn_ring_doorbell(struct qedn_conn_ctx *conn_ctx);
 
diff --git a/drivers/nvme/hw/qedn/qedn_conn.c b/drivers/nvme/hw/qedn/qedn_conn.c
index 9d5a7377ff1a..e2da6a33acef 100644
--- a/drivers/nvme/hw/qedn/qedn_conn.c
+++ b/drivers/nvme/hw/qedn/qedn_conn.c
@@ -519,6 +519,7 @@ static int qedn_send_icreq(struct qedn_conn_ctx *conn_ctx)
 	qed_ops->init_icreq_exchange(&task_params, &icreq, sgl_task_params,  NULL);
 
 	qedn_set_con_state(conn_ctx, CONN_STATE_WAIT_FOR_IC_COMP);
+	set_bit(QEDN_TASK_USED_BY_FW, &qedn_task->flags);
 	atomic_inc(&conn_ctx->num_active_fw_tasks);
 
 	/* spin_lock - doorbell is accessed  both Rx flow and response flow */
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index d262f9751322..d4e2a1bfa5fb 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -1035,6 +1035,14 @@ static int qedn_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return __qedn_probe(pdev);
 }
 
+void qedn_swap_bytes(u32 *p, int size)
+{
+	int i;
+
+	for (i = 0; i < size; ++i, ++p)
+		*p = __swab32(*p);
+}
+
 static struct pci_driver qedn_pci_driver = {
 	.name     = QEDN_MODULE_NAME,
 	.id_table = qedn_pci_tbl,
diff --git a/drivers/nvme/hw/qedn/qedn_task.c b/drivers/nvme/hw/qedn/qedn_task.c
index 1f484b6ffaca..5be93264df48 100644
--- a/drivers/nvme/hw/qedn/qedn_task.c
+++ b/drivers/nvme/hw/qedn/qedn_task.c
@@ -11,6 +11,73 @@
 /* Driver includes */
 #include "qedn.h"
 
+extern const struct qed_nvmetcp_ops *qed_ops;
+
+static bool qedn_sgl_has_small_mid_sge(struct nvmetcp_sge *sgl, u16 sge_count)
+{
+	u16 sge_num;
+
+	if (sge_count > 8) {
+		for (sge_num = 0; sge_num < sge_count; sge_num++) {
+			if (le32_to_cpu(sgl[sge_num].sge_len) <
+			    QEDN_FW_SLOW_IO_MIN_SGE_LIMIT)
+				return true; /* small middle SGE found */
+		}
+	}
+
+	return false; /* no small middle SGEs */
+}
+
+static int qedn_init_sgl(struct qedn_ctx *qedn, struct qedn_task_ctx *qedn_task)
+{
+	struct storage_sgl_task_params *sgl_task_params;
+	enum dma_data_direction dma_dir;
+	struct scatterlist *sg;
+	struct request *rq;
+	u16 num_sges;
+	int index;
+	int rc;
+
+	sgl_task_params = &qedn_task->sgl_task_params;
+	rq = blk_mq_rq_from_pdu(qedn_task->req);
+	if (qedn_task->task_size == 0) {
+		sgl_task_params->num_sges = 0;
+
+		return 0;
+	}
+
+	/* Convert BIO to scatterlist */
+	num_sges = blk_rq_map_sg(rq->q, rq, qedn_task->nvme_sg);
+	if (qedn_task->req_direction == WRITE)
+		dma_dir = DMA_TO_DEVICE;
+	else
+		dma_dir = DMA_FROM_DEVICE;
+
+	/* DMA map the scatterlist */
+	if (dma_map_sg(&qedn->pdev->dev, qedn_task->nvme_sg, num_sges, dma_dir) != num_sges) {
+		pr_err("Couldn't map sgl\n");
+		rc = -EPERM;
+
+		return rc;
+	}
+
+	sgl_task_params->total_buffer_size = qedn_task->task_size;
+	sgl_task_params->num_sges = num_sges;
+
+	for_each_sg(qedn_task->nvme_sg, sg, num_sges, index) {
+		DMA_REGPAIR_LE(sgl_task_params->sgl[index].sge_addr, sg_dma_address(sg));
+		sgl_task_params->sgl[index].sge_len = cpu_to_le32(sg_dma_len(sg));
+	}
+
+	/* Relevant for Host Write Only */
+	sgl_task_params->small_mid_sge = (qedn_task->req_direction == READ) ?
+		false :
+		qedn_sgl_has_small_mid_sge(sgl_task_params->sgl,
+					   sgl_task_params->num_sges);
+
+	return 0;
+}
+
 static void qedn_free_nvme_sg(struct qedn_task_ctx *qedn_task)
 {
 	kfree(qedn_task->nvme_sg);
@@ -332,13 +399,165 @@ qedn_get_free_task_from_pool(struct qedn_conn_ctx *conn_ctx, u16 cccid)
 	return qedn_task;
 }
 
-int qedn_queue_request(struct qedn_conn_ctx *qedn_conn, struct nvme_tcp_ofld_req *req)
+int qedn_send_read_cmd(struct qedn_task_ctx *qedn_task, struct qedn_conn_ctx *conn_ctx)
+{
+	struct nvme_command *nvme_cmd = &qedn_task->req->nvme_cmd;
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	struct nvmetcp_task_params task_params;
+	struct nvme_tcp_cmd_pdu cmd_hdr;
+	struct nvmetcp_wqe *chain_sqe;
+	struct nvmetcp_wqe local_sqe;
+	int rc;
+
+	rc = qedn_init_sgl(qedn, qedn_task);
+	if (rc)
+		return rc;
+
+	task_params.opq.lo = cpu_to_le32(((u64)(qedn_task)) & 0xffffffff);
+	task_params.opq.hi = cpu_to_le32(((u64)(qedn_task)) >> 32);
+
+	/* Initialize task params */
+	task_params.context = qedn_task->fw_task_ctx;
+	task_params.sqe = &local_sqe;
+	task_params.tx_io_size = 0;
+	task_params.rx_io_size = qedn_task->task_size;
+	task_params.conn_icid = (u16)conn_ctx->conn_handle;
+	task_params.itid = qedn_task->itid;
+	task_params.cq_rss_number = conn_ctx->default_cq;
+	task_params.send_write_incapsule = 0;
+
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
+
+	return 0;
+}
+
+int qedn_send_write_cmd(struct qedn_task_ctx *qedn_task, struct qedn_conn_ctx *conn_ctx)
 {
-	/* Process the request */
+	struct nvme_command *nvme_cmd = &qedn_task->req->nvme_cmd;
+	struct nvmetcp_task_params task_params;
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	struct nvme_tcp_cmd_pdu cmd_hdr;
+	u32 pdu_len = sizeof(cmd_hdr);
+	struct nvmetcp_wqe *chain_sqe;
+	struct nvmetcp_wqe local_sqe;
+	u8 send_write_incapsule;
+	int rc;
+
+	if (qedn_task->task_size <= nvme_tcp_ofld_inline_data_size(conn_ctx->queue) &&
+	    qedn_task->task_size) {
+		send_write_incapsule = 1;
+		pdu_len += qedn_task->task_size;
+
+		/* Add digest length once supported */
+		cmd_hdr.hdr.pdo = sizeof(cmd_hdr);
+	} else {
+		send_write_incapsule = 0;
+
+		cmd_hdr.hdr.pdo = 0x0;
+	}
+
+	rc = qedn_init_sgl(qedn, qedn_task);
+	if (rc)
+		return rc;
+
+	task_params.host_cccid = cpu_to_le16(qedn_task->cccid);
+	task_params.opq.lo = cpu_to_le32(((u64)(qedn_task)) & 0xffffffff);
+	task_params.opq.hi = cpu_to_le32(((u64)(qedn_task)) >> 32);
+
+	/* Initialize task params */
+	task_params.context = qedn_task->fw_task_ctx;
+	task_params.sqe = &local_sqe;
+	task_params.tx_io_size = qedn_task->task_size;
+	task_params.rx_io_size = 0;
+	task_params.conn_icid = (u16)conn_ctx->conn_handle;
+	task_params.itid = qedn_task->itid;
+	task_params.cq_rss_number = conn_ctx->default_cq;
+	task_params.send_write_incapsule = send_write_incapsule;
+
+	cmd_hdr.hdr.type = nvme_tcp_cmd;
+	cmd_hdr.hdr.flags = 0;
+	cmd_hdr.hdr.hlen = sizeof(cmd_hdr);
+	cmd_hdr.hdr.plen = cpu_to_le32(pdu_len);
+
+	qed_ops->init_write_io(&task_params, &cmd_hdr, nvme_cmd,
+			       &qedn_task->sgl_task_params);
+
+	set_bit(QEDN_TASK_USED_BY_FW, &qedn_task->flags);
+	atomic_inc(&conn_ctx->num_active_fw_tasks);
+
+	spin_lock(&conn_ctx->ep.doorbell_lock);
+	chain_sqe = qed_chain_produce(&conn_ctx->ep.fw_sq_chain);
+	memcpy(chain_sqe, &local_sqe, sizeof(local_sqe));
+	qedn_ring_doorbell(conn_ctx);
+	spin_unlock(&conn_ctx->ep.doorbell_lock);
 
 	return 0;
 }
 
+int qedn_queue_request(struct qedn_conn_ctx *qedn_conn, struct nvme_tcp_ofld_req *req)
+{
+	struct qedn_task_ctx *qedn_task;
+	struct request *rq;
+	int rc = 0;
+	u16 cccid;
+
+	rq = blk_mq_rq_from_pdu(req);
+
+	/* Placeholder - async */
+
+	cccid = rq->tag;
+	qedn_task = qedn_get_free_task_from_pool(qedn_conn, cccid);
+	if (unlikely(!qedn_task)) {
+		pr_err("Not able to allocate task context resource\n");
+
+		return BLK_STS_NOTSUPP;
+	}
+
+	req->private_data = qedn_task;
+	qedn_task->req = req;
+
+	/* Placeholder - handle (req->async) */
+
+	/* Check if there are physical segments in request to determine the task size.
+	 * The logic of nvme_tcp_set_sg_null() will be implemented as part of
+	 * qedn_set_sg_host_data().
+	 */
+	qedn_task->task_size = blk_rq_nr_phys_segments(rq) ? blk_rq_payload_bytes(rq) : 0;
+	qedn_task->req_direction = rq_data_dir(rq);
+	if (qedn_task->req_direction == WRITE)
+		rc = qedn_send_write_cmd(qedn_task, qedn_conn);
+	else
+		rc = qedn_send_read_cmd(qedn_task, qedn_conn);
+
+	if (unlikely(rc)) {
+		pr_err("Read/Write command failure\n");
+
+		return BLK_STS_TRANSPORT;
+	}
+
+	spin_lock(&qedn_conn->ep.doorbell_lock);
+	qedn_ring_doorbell(qedn_conn);
+	spin_unlock(&qedn_conn->ep.doorbell_lock);
+
+	return BLK_STS_OK;
+}
+
 struct qedn_task_ctx *qedn_cqe_get_active_task(struct nvmetcp_fw_cqe *cqe)
 {
 	struct regpair *p = &cqe->task_opaque;
@@ -347,8 +566,73 @@ struct qedn_task_ctx *qedn_cqe_get_active_task(struct nvmetcp_fw_cqe *cqe)
 					+ le32_to_cpu(p->lo)));
 }
 
+static struct nvme_tcp_ofld_req *qedn_decouple_req_task(struct qedn_task_ctx *qedn_task)
+{
+	struct nvme_tcp_ofld_req *ulp_req = qedn_task->req;
+
+	qedn_task->req = NULL;
+	if (ulp_req)
+		ulp_req->private_data = NULL;
+
+	return ulp_req;
+}
+
+static inline int qedn_comp_valid_task(struct qedn_task_ctx *qedn_task,
+				       union nvme_result *result, __le16 status)
+{
+	struct qedn_conn_ctx *conn_ctx = qedn_task->qedn_conn;
+	struct nvme_tcp_ofld_req *req;
+
+	req = qedn_decouple_req_task(qedn_task);
+	qedn_return_task_to_pool(conn_ctx, qedn_task);
+	if (!req) {
+		pr_err("req not found\n");
+
+		return -EINVAL;
+	}
+
+	/* Call request done to complete the request */
+	if (req->done)
+		req->done(req, result, status);
+	else
+		pr_err("request done not Set !!!\n");
+
+	return 0;
+}
+
+int qedn_process_nvme_cqe(struct qedn_task_ctx *qedn_task, struct nvme_completion *cqe)
+{
+	int rc = 0;
+
+	/* CQE arrives swapped
+	 * Swapping requirement will be removed in future FW versions
+	 */
+	qedn_swap_bytes((u32 *)cqe, (sizeof(*cqe) / sizeof(u32)));
+
+	/* Placeholder - async */
+
+	rc = qedn_comp_valid_task(qedn_task, &cqe->result, cqe->status);
+
+	return rc;
+}
+
+int qedn_complete_c2h(struct qedn_task_ctx *qedn_task)
+{
+	int rc = 0;
+
+	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
+	union nvme_result result = {};
+
+	rc = qedn_comp_valid_task(qedn_task, &result, status);
+
+	return rc;
+}
+
 void qedn_io_work_cq(struct qedn_ctx *qedn, struct nvmetcp_fw_cqe *cqe)
 {
+	int rc = 0;
+
+	struct nvme_completion *nvme_cqe = NULL;
 	struct qedn_task_ctx *qedn_task = NULL;
 	struct qedn_conn_ctx *conn_ctx = NULL;
 	u16 itid;
@@ -375,13 +659,27 @@ void qedn_io_work_cq(struct qedn_ctx *qedn, struct nvmetcp_fw_cqe *cqe)
 		case NVMETCP_TASK_TYPE_HOST_WRITE:
 		case NVMETCP_TASK_TYPE_HOST_READ:
 
-			/* Placeholder - IO flow */
+			/* Verify data digest once supported */
 
+			nvme_cqe = (struct nvme_completion *)&cqe->cqe_data.nvme_cqe;
+			rc = qedn_process_nvme_cqe(qedn_task, nvme_cqe);
+			if (rc) {
+				pr_err("Read/Write completion error\n");
+
+				return;
+			}
 			break;
 
 		case NVMETCP_TASK_TYPE_HOST_READ_NO_CQE:
 
-			/* Placeholder - IO flow */
+			/* Verify data digest once supported */
+
+			rc = qedn_complete_c2h(qedn_task);
+			if (rc) {
+				pr_err("Controller To Host Data Transfer error error\n");
+
+				return;
+			}
 
 			break;
 
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
