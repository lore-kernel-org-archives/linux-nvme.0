Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FBFC11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 13:04:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C33461DC0
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 13:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C33461DC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WhQuRQjYUAw4tZNx9XbilK9gHpr6gx0hgezYovEVY30=; b=CfXu7LDaOaIZk9
	Xc+T9H+nCmUjuujvCIrj1keh0+Z3AdWXpNJkfsUz2cHUcA3i0fju81eFBHC4wM+lDxpwOP9079fAj
	EH8N7Sai5cFGrmGYeLLVPO31vzAg5tIzgge0no3WtDeeTZy4RmR/JqpRUrVsDlwJKimEtn0W1YKCr
	/A9T8ZnDU//3g9VKPsM3J1iF86j3QT34Fj18wwqRnCFaTu4tXJm1nQEoU7f5Umk/ooN1YI9jaf5Dq
	okx2aSB5vKllDp7U0CYd+fHj+jOA1unPYTRLKrcBsCu/oAZN3wsslLnMiyiCM9iD4R+4YjJjYGjrZ
	D6yXyaQkHjZyiAJPhb5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyDOx-00Aw1L-F2; Tue, 29 Jun 2021 13:03:43 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyDAu-00AsSg-Ju
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 12:49:16 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15TCknnY026866; Tue, 29 Jun 2021 05:49:07 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 39fuw51wuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 29 Jun 2021 05:49:07 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 29 Jun 2021 05:49:06 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Tue, 29 Jun 2021 05:49:03 -0700
From: Prabhakar Kushwaha <pkushwaha@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
 <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH v4 17/20] qedn: Add support of NVME ICReq & ICResp
Date: Tue, 29 Jun 2021 15:47:40 +0300
Message-ID: <20210629124743.6898-18-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210629124743.6898-1-pkushwaha@marvell.com>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: J3Z46bUdwxhcYcFtA11m1bU4E0UV1pA2
X-Proofpoint-GUID: J3Z46bUdwxhcYcFtA11m1bU4E0UV1pA2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-29_06:2021-06-28,
 2021-06-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_054912_744429_69BB28E2 
X-CRM114-Status: GOOD (  22.59  )
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

Once a TCP connection established, the host sends an Initialize
Connection Request (ICReq) PDU to the controller.
Further Initialize Connection Response (ICResp) PDU received from
controller is processed by host to establish a connection and
exchange connection configuration parameters.

This patch present support of generation of ICReq and processing of
ICResp. It also update host configuration based on exchanged parameters.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/hw/qedn/qedn.h      |  38 ++++
 drivers/nvme/hw/qedn/qedn_conn.c | 334 ++++++++++++++++++++++++++++++-
 drivers/nvme/hw/qedn/qedn_main.c |  14 ++
 drivers/nvme/hw/qedn/qedn_task.c |   8 +-
 4 files changed, 390 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index 78efa8c02810..829d474b3ab1 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -16,6 +16,7 @@
 
 /* Driver includes */
 #include "../../host/tcp-offload.h"
+#include <linux/nvme-tcp.h>
 
 #define QEDN_MODULE_NAME "qedn"
 
@@ -42,6 +43,8 @@
 
 /* Protocol defines */
 #define QEDN_MAX_IO_SIZE QED_NVMETCP_MAX_IO_SIZE
+#define QEDN_MAX_PDU_SIZE 0x80000 /* 512KB */
+#define QEDN_MAX_OUTSTANDING_R2T_PDUS 0 /* 0 Based == 1 max R2T */
 
 #define QEDN_FW_SLOW_IO_MIN_SGE_LIMIT (9700 / 6)
 
@@ -50,6 +53,13 @@
 
 #define QEDN_INVALID_ITID 0xFFFF
 
+#define QEDN_ICREQ_FW_PAYLOAD (sizeof(struct nvme_tcp_icreq_pdu) -\
+			       QED_NVMETCP_NON_IO_HDR_SIZE)
+#define QEDN_ICREQ_FW_PAYLOAD_START 8
+
+/* The FW will handle the ICReq as CCCID 0 (FW internal design) */
+#define QEDN_ICREQ_CCCID 0
+
 /*
  * TCP offload stack default configurations and defines.
  * Future enhancements will allow controlling the configurable
@@ -120,6 +130,16 @@ struct qedn_fp_queue {
 	char irqname[QEDN_IRQ_NAME_LEN];
 };
 
+struct qedn_negotiation_params {
+	u32 maxh2cdata; /* Negotiation */
+	u32 maxr2t; /* Validation */
+	u16 pfv; /* Validation */
+	bool hdr_digest; /* Negotiation */
+	bool data_digest; /* Negotiation */
+	u8 cpda; /* Negotiation */
+	u8 hpda; /* Validation */
+};
+
 struct qedn_ctx {
 	struct pci_dev *pdev;
 	struct qed_dev *cdev;
@@ -176,6 +196,9 @@ struct qedn_endpoint {
 	struct nvmetcp_db_data db_data;
 	void __iomem *p_doorbell;
 
+	/* Spinlock for accessing FW queue */
+	spinlock_t doorbell_lock;
+
 	/* TCP Params */
 	__be32 dst_addr[4]; /* In network order */
 	__be32 src_addr[4]; /* In network order */
@@ -252,6 +275,12 @@ struct qedn_ctrl {
 	atomic_t host_num_active_conns;
 };
 
+struct qedn_icreq_padding {
+	u32 *buffer;
+	dma_addr_t pa;
+	struct nvmetcp_sge sge;
+};
+
 /* Connection level struct */
 struct qedn_conn_ctx {
 	/* IO path */
@@ -300,6 +329,11 @@ struct qedn_conn_ctx {
 
 	size_t sq_depth;
 
+	struct qedn_negotiation_params required_params;
+	struct qedn_negotiation_params pdu_params;
+	struct nvme_tcp_icresp_pdu icresp;
+	struct qedn_icreq_padding *icreq_pad;
+
 	/* "dummy" socket */
 	struct socket *sock;
 };
@@ -308,6 +342,7 @@ enum qedn_conn_resources_state {
 	QEDN_CONN_RESRC_FW_SQ,
 	QEDN_CONN_RESRC_ACQUIRE_CONN,
 	QEDN_CONN_RESRC_TASKS,
+	QEDN_CONN_RESRC_ICREQ_PAD,
 	QEDN_CONN_RESRC_CCCID_ITID_MAP,
 	QEDN_CONN_RESRC_TCP_PORT,
 	QEDN_CONN_RESRC_DB_ADD,
@@ -339,5 +374,8 @@ struct qedn_task_ctx *
 qedn_get_free_task_from_pool(struct qedn_conn_ctx *conn_ctx, u16 cccid);
 void qedn_destroy_free_tasks(struct qedn_fp_queue *fp_q,
 			     struct qedn_io_resources *io_resrc);
+void qedn_prep_icresp(struct qedn_conn_ctx *conn_ctx,
+		      struct nvmetcp_fw_cqe *cqe);
+void qedn_ring_doorbell(struct qedn_conn_ctx *conn_ctx);
 
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_conn.c b/drivers/nvme/hw/qedn/qedn_conn.c
index 5c5b365df522..b4c0a1a3e890 100644
--- a/drivers/nvme/hw/qedn/qedn_conn.c
+++ b/drivers/nvme/hw/qedn/qedn_conn.c
@@ -34,6 +34,18 @@ inline int qedn_qid(struct nvme_tcp_ofld_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
+void qedn_ring_doorbell(struct qedn_conn_ctx *conn_ctx)
+{
+	u16 prod_idx;
+
+	prod_idx = qed_chain_get_prod_idx(&conn_ctx->ep.fw_sq_chain);
+	conn_ctx->ep.db_data.sq_prod = cpu_to_le16(prod_idx);
+
+	/* wmb - Make sure fw idx is coherent */
+	wmb();
+	writel(*(u32 *)&conn_ctx->ep.db_data, conn_ctx->ep.p_doorbell);
+}
+
 int qedn_set_con_state(struct qedn_conn_ctx *conn_ctx,
 		       enum qedn_conn_state new_state)
 {
@@ -143,6 +155,71 @@ int qedn_initialize_endpoint(struct qedn_endpoint *ep, u8 *local_mac_addr,
 	return -1;
 }
 
+static int qedn_alloc_icreq_pad(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	struct qedn_icreq_padding *icreq_pad;
+	u32 *buffer;
+	int rc = 0;
+
+	icreq_pad = kzalloc(sizeof(*icreq_pad), GFP_KERNEL);
+	if (!icreq_pad)
+		return -ENOMEM;
+
+	conn_ctx->icreq_pad = icreq_pad;
+	memset(&icreq_pad->sge, 0, sizeof(icreq_pad->sge));
+	buffer = dma_alloc_coherent(&qedn->pdev->dev,
+				    QEDN_ICREQ_FW_PAYLOAD,
+				    &icreq_pad->pa,
+				    GFP_KERNEL);
+	if (!buffer) {
+		pr_err("Could not allocate icreq_padding SGE buffer.\n");
+		rc =  -ENOMEM;
+		goto release_icreq_pad;
+	}
+
+	DMA_REGPAIR_LE(icreq_pad->sge.sge_addr, icreq_pad->pa);
+	icreq_pad->sge.sge_len = cpu_to_le32(QEDN_ICREQ_FW_PAYLOAD);
+	icreq_pad->buffer = buffer;
+	set_bit(QEDN_CONN_RESRC_ICREQ_PAD, &conn_ctx->resrc_state);
+
+	return 0;
+
+release_icreq_pad:
+	kfree(icreq_pad);
+	conn_ctx->icreq_pad = NULL;
+
+	return rc;
+}
+
+static void qedn_free_icreq_pad(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	struct qedn_icreq_padding *icreq_pad;
+	u32 *buffer;
+
+	icreq_pad = conn_ctx->icreq_pad;
+	if (unlikely(!icreq_pad)) {
+		pr_err("null ptr in icreq_pad in conn_ctx\n");
+		goto finally;
+	}
+
+	buffer = icreq_pad->buffer;
+	if (buffer) {
+		dma_free_coherent(&qedn->pdev->dev,
+				  QEDN_ICREQ_FW_PAYLOAD,
+				  (void *)buffer,
+				  icreq_pad->pa);
+		icreq_pad->buffer = NULL;
+	}
+
+	kfree(icreq_pad);
+	conn_ctx->icreq_pad = NULL;
+
+finally:
+	clear_bit(QEDN_CONN_RESRC_ICREQ_PAD, &conn_ctx->resrc_state);
+}
+
 static void qedn_release_conn_ctx(struct qedn_conn_ctx *conn_ctx)
 {
 	struct qedn_ctx *qedn = conn_ctx->qedn;
@@ -175,6 +252,9 @@ static void qedn_release_conn_ctx(struct qedn_conn_ctx *conn_ctx)
 		clear_bit(QEDN_CONN_RESRC_ACQUIRE_CONN, &conn_ctx->resrc_state);
 	}
 
+	if (test_bit(QEDN_CONN_RESRC_ICREQ_PAD, &conn_ctx->resrc_state))
+		qedn_free_icreq_pad(conn_ctx);
+
 	if (test_bit(QEDN_CONN_RESRC_TASKS, &conn_ctx->resrc_state)) {
 		clear_bit(QEDN_CONN_RESRC_TASKS, &conn_ctx->resrc_state);
 			qedn_return_active_tasks(conn_ctx);
@@ -336,6 +416,215 @@ void qedn_terminate_connection(struct qedn_conn_ctx *conn_ctx)
 	queue_work(qctrl->sp_wq, &conn_ctx->sp_wq_entry);
 }
 
+static int qedn_nvmetcp_update_conn(struct qedn_ctx *qedn,
+				    struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_negotiation_params *pdu_params = &conn_ctx->pdu_params;
+	struct qed_nvmetcp_params_update *conn_info;
+	int rc;
+
+	conn_info = kzalloc(sizeof(*conn_info), GFP_KERNEL);
+	if (!conn_info)
+		return -ENOMEM;
+
+	conn_info->hdr_digest_en = pdu_params->hdr_digest;
+	conn_info->data_digest_en = pdu_params->data_digest;
+	conn_info->max_recv_pdu_length = QEDN_MAX_PDU_SIZE;
+	conn_info->max_io_size = QEDN_MAX_IO_SIZE;
+	conn_info->max_send_pdu_length = pdu_params->maxh2cdata;
+
+	rc = qed_ops->update_conn(qedn->cdev, conn_ctx->conn_handle, conn_info);
+	if (rc) {
+		pr_err("Could not update connection\n");
+		rc = -ENXIO;
+	}
+
+	kfree(conn_info);
+
+	return rc;
+}
+
+static int qedn_update_ramrod(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	int rc = 0;
+
+	rc = qedn_set_con_state(conn_ctx, CONN_STATE_WAIT_FOR_UPDATE_EQE);
+	if (rc)
+		return rc;
+
+	rc = qedn_nvmetcp_update_conn(qedn, conn_ctx);
+	if (rc)
+		return rc;
+
+	if (conn_ctx->state != CONN_STATE_WAIT_FOR_UPDATE_EQE) {
+		pr_err("cid 0x%x: Unexpected state 0x%x after update ramrod\n",
+		       conn_ctx->fw_cid, conn_ctx->state);
+
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
+static int qedn_send_icreq(struct qedn_conn_ctx *conn_ctx)
+{
+	struct storage_sgl_task_params *sgl_task_params;
+	struct nvmetcp_task_params task_params;
+	struct qedn_task_ctx *qedn_task = NULL;
+	struct nvme_tcp_icreq_pdu icreq;
+	struct nvmetcp_wqe *chain_sqe;
+	struct nvmetcp_wqe local_sqe;
+
+	qedn_task = qedn_get_free_task_from_pool(conn_ctx, QEDN_ICREQ_CCCID);
+	if (!qedn_task)
+		return -EINVAL;
+
+	memset(&icreq, 0, sizeof(icreq));
+	memset(&local_sqe, 0, sizeof(local_sqe));
+
+	/* Initialize ICReq */
+	icreq.hdr.type = nvme_tcp_icreq;
+	icreq.hdr.hlen = sizeof(icreq);
+	icreq.hdr.pdo = 0;
+	icreq.hdr.plen = cpu_to_le32(icreq.hdr.hlen);
+	icreq.pfv = cpu_to_le16(conn_ctx->required_params.pfv);
+	icreq.maxr2t = cpu_to_le32(conn_ctx->required_params.maxr2t);
+	icreq.hpda = conn_ctx->required_params.hpda;
+	if (conn_ctx->required_params.hdr_digest)
+		icreq.digest |= NVME_TCP_HDR_DIGEST_ENABLE;
+	if (conn_ctx->required_params.data_digest)
+		icreq.digest |= NVME_TCP_DATA_DIGEST_ENABLE;
+
+	/* Initialize task params */
+	task_params.opq.lo = cpu_to_le32(((u64)(qedn_task)) & 0xffffffff);
+	task_params.opq.hi = cpu_to_le32(((u64)(qedn_task)) >> 32);
+	task_params.context = qedn_task->fw_task_ctx;
+	task_params.sqe = &local_sqe;
+	task_params.conn_icid = (u16)conn_ctx->conn_handle;
+	task_params.itid = qedn_task->itid;
+	task_params.cq_rss_number = conn_ctx->default_cq;
+	task_params.tx_io_size = QEDN_ICREQ_FW_PAYLOAD;
+	task_params.rx_io_size = 0; /* Rx doesn't use SGL for icresp */
+
+	/* Init SGE for ICReq padding */
+	sgl_task_params = &qedn_task->sgl_task_params;
+	sgl_task_params->total_buffer_size = task_params.tx_io_size;
+	sgl_task_params->small_mid_sge = false;
+	sgl_task_params->num_sges = 1;
+	memcpy(sgl_task_params->sgl, &conn_ctx->icreq_pad->sge,
+	       sizeof(conn_ctx->icreq_pad->sge));
+
+	/* ICReq is sent as two parts.
+	 * First part: (16 bytes + First 8 bytes of icreq.rsvd2[]) are sent
+	 *             via task context which is initialized above in icreq
+	 * Second part: Rest bytes are sent via SGE, happening here
+	 */
+	memcpy(conn_ctx->icreq_pad->buffer,
+	       &icreq.rsvd2[QEDN_ICREQ_FW_PAYLOAD_START],
+	       QEDN_ICREQ_FW_PAYLOAD);
+
+	qed_ops->init_icreq_exchange(&task_params, &icreq,
+				     sgl_task_params,  NULL);
+
+	qedn_set_con_state(conn_ctx, CONN_STATE_WAIT_FOR_IC_COMP);
+	atomic_inc(&conn_ctx->num_active_fw_tasks);
+
+	/* spin_lock - doorbell is accessed  both Rx flow and response flow */
+	spin_lock(&conn_ctx->ep.doorbell_lock);
+	chain_sqe = qed_chain_produce(&conn_ctx->ep.fw_sq_chain);
+	memcpy(chain_sqe, &local_sqe, sizeof(local_sqe));
+	qedn_ring_doorbell(conn_ctx);
+	spin_unlock(&conn_ctx->ep.doorbell_lock);
+
+	return 0;
+}
+
+void qedn_prep_icresp(struct qedn_conn_ctx *conn_ctx,
+		      struct nvmetcp_fw_cqe *cqe)
+{
+	struct nvmetcp_icresp_mdata *icresp_from_cqe =
+		(struct nvmetcp_icresp_mdata *)&cqe->cqe_data.icresp_mdata;
+	struct nvme_tcp_icresp_pdu *icresp = &conn_ctx->icresp;
+	struct nvme_tcp_ofld_ctrl *ctrl = conn_ctx->ctrl;
+	struct qedn_ctrl *qctrl = NULL;
+
+	qctrl = (struct qedn_ctrl *)ctrl->private_data;
+	if (!qctrl)
+		return;
+
+	icresp->pfv = cpu_to_le16(icresp_from_cqe->pfv);
+	icresp->cpda = icresp_from_cqe->cpda;
+	icresp->digest = icresp_from_cqe->digest;
+	icresp->maxdata = cpu_to_le32(icresp_from_cqe->maxdata);
+
+	qedn_set_sp_wa(conn_ctx, HANDLE_ICRESP);
+	queue_work(qctrl->sp_wq, &conn_ctx->sp_wq_entry);
+}
+
+static int qedn_handle_icresp(struct qedn_conn_ctx *conn_ctx)
+{
+	struct nvme_tcp_icresp_pdu *icresp = &conn_ctx->icresp;
+	struct qedn_negotiation_params *pdu_params;
+	int rc = 0;
+	u16 pfv;
+
+	/* Swapping requirement will be removed in future FW versions */
+	pfv = __swab16(le16_to_cpu(icresp->pfv));
+
+	qedn_free_icreq_pad(conn_ctx);
+
+	/* Validate ICResp */
+	if (pfv != conn_ctx->required_params.pfv) {
+		pr_err("cid %u: unsupported pfv %u\n", conn_ctx->fw_cid, pfv);
+
+		return -EINVAL;
+	}
+
+	if (icresp->cpda > conn_ctx->required_params.cpda) {
+		pr_err("cid %u: unsupported cpda %u\n",
+		       conn_ctx->fw_cid, icresp->cpda);
+
+		return -EINVAL;
+	}
+
+	if ((NVME_TCP_HDR_DIGEST_ENABLE & icresp->digest) !=
+	    conn_ctx->required_params.hdr_digest) {
+		if ((NVME_TCP_HDR_DIGEST_ENABLE & icresp->digest) >
+		    conn_ctx->required_params.hdr_digest) {
+			pr_err("cid 0x%x: invalid header digest bit\n",
+			       conn_ctx->fw_cid);
+		}
+	}
+
+	if ((NVME_TCP_DATA_DIGEST_ENABLE & icresp->digest) !=
+	    conn_ctx->required_params.data_digest) {
+		if ((NVME_TCP_DATA_DIGEST_ENABLE & icresp->digest) >
+		    conn_ctx->required_params.data_digest) {
+			pr_err("cid 0x%x: invalid data digest bit\n",
+			       conn_ctx->fw_cid);
+	}
+	}
+
+	pdu_params = &conn_ctx->pdu_params;
+	memset(pdu_params, 0, sizeof(conn_ctx->pdu_params));
+	/* Swapping requirement will be removed in future FW versions */
+	pdu_params->maxh2cdata = __swab32(le32_to_cpu(icresp->maxdata));
+	pdu_params->maxh2cdata = QEDN_MAX_PDU_SIZE;
+	if (pdu_params->maxh2cdata > QEDN_MAX_PDU_SIZE)
+		pdu_params->maxh2cdata = QEDN_MAX_PDU_SIZE;
+
+	pdu_params->pfv = pfv;
+	pdu_params->cpda = icresp->cpda;
+	pdu_params->hpda = conn_ctx->required_params.hpda;
+	pdu_params->hdr_digest = NVME_TCP_HDR_DIGEST_ENABLE & icresp->digest;
+	pdu_params->data_digest = NVME_TCP_DATA_DIGEST_ENABLE & icresp->digest;
+	pdu_params->maxr2t = conn_ctx->required_params.maxr2t;
+	rc = qedn_update_ramrod(conn_ctx);
+
+	return rc;
+}
+
 /* Slowpath EQ Callback */
 int qedn_event_cb(void *context, u8 fw_event_code, void *event_ring_data)
 {
@@ -393,7 +682,8 @@ int qedn_event_cb(void *context, u8 fw_event_code, void *event_ring_data)
 			if (rc)
 				return rc;
 
-			/* Placeholder - for ICReq flow */
+			qedn_set_sp_wa(conn_ctx, SEND_ICREQ);
+			queue_work(qctrl->sp_wq, &conn_ctx->sp_wq_entry);
 		}
 
 		break;
@@ -445,6 +735,8 @@ static int qedn_prep_and_offload_queue(struct qedn_conn_ctx *conn_ctx)
 
 	set_bit(QEDN_CONN_RESRC_FW_SQ, &conn_ctx->resrc_state);
 
+	spin_lock_init(&conn_ctx->ep.doorbell_lock);
+
 	atomic_set(&conn_ctx->num_active_tasks, 0);
 	atomic_set(&conn_ctx->num_active_fw_tasks, 0);
 
@@ -509,6 +801,11 @@ static int qedn_prep_and_offload_queue(struct qedn_conn_ctx *conn_ctx)
 
 	memset(conn_ctx->host_cccid_itid, 0xFF, dma_size);
 	set_bit(QEDN_CONN_RESRC_CCCID_ITID_MAP, &conn_ctx->resrc_state);
+
+	rc = qedn_alloc_icreq_pad(conn_ctx);
+		if (rc)
+			goto rel_conn;
+
 	rc = qedn_set_con_state(conn_ctx, CONN_STATE_WAIT_FOR_CONNECT_DONE);
 	if (rc)
 		goto rel_conn;
@@ -581,6 +878,9 @@ void qedn_sp_wq_handler(struct work_struct *work)
 
 	qedn = conn_ctx->qedn;
 	if (test_bit(DESTROY_CONNECTION, &conn_ctx->agg_work_action)) {
+		if (test_bit(HANDLE_ICRESP, &conn_ctx->agg_work_action))
+			qedn_clr_sp_wa(conn_ctx, HANDLE_ICRESP);
+
 		qedn_destroy_connection(conn_ctx);
 
 		return;
@@ -595,6 +895,38 @@ void qedn_sp_wq_handler(struct work_struct *work)
 			return;
 		}
 	}
+
+	if (test_bit(SEND_ICREQ, &conn_ctx->agg_work_action)) {
+		qedn_clr_sp_wa(conn_ctx, SEND_ICREQ);
+		rc = qedn_send_icreq(conn_ctx);
+		if (rc)
+			return;
+
+		return;
+	}
+
+	if (test_bit(HANDLE_ICRESP, &conn_ctx->agg_work_action)) {
+		rc = qedn_handle_icresp(conn_ctx);
+
+		qedn_clr_sp_wa(conn_ctx, HANDLE_ICRESP);
+		if (rc) {
+			pr_err("IC handling returned with 0x%x\n", rc);
+			if (test_and_set_bit(DESTROY_CONNECTION,
+					     &conn_ctx->agg_work_action))
+				return;
+
+			qedn_destroy_connection(conn_ctx);
+
+			return;
+		}
+
+		atomic_inc(&conn_ctx->est_conn_indicator);
+		qedn_set_con_state(conn_ctx,
+				   CONN_STATE_NVMETCP_CONN_ESTABLISHED);
+		wake_up_interruptible(&conn_ctx->conn_waitq);
+
+		return;
+	}
 }
 
 /* Clear connection aggregative slowpath work action */
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index 42c8ad6ac2d6..3cf913d527c0 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -286,6 +286,19 @@ static int qedn_release_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 	return 0;
 }
 
+static void qedn_set_pdu_params(struct qedn_conn_ctx *conn_ctx)
+{
+	/* Enable digest once supported */
+	conn_ctx->required_params.hdr_digest = 0;
+	conn_ctx->required_params.data_digest = 0;
+
+	conn_ctx->required_params.maxr2t = QEDN_MAX_OUTSTANDING_R2T_PDUS;
+	conn_ctx->required_params.pfv = NVME_TCP_PFV_1_0;
+	conn_ctx->required_params.cpda = 0;
+	conn_ctx->required_params.hpda = 0;
+	conn_ctx->required_params.maxh2cdata = QEDN_MAX_PDU_SIZE;
+}
+
 static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
 			     size_t queue_size)
 {
@@ -317,6 +330,7 @@ static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
 	conn_ctx->ctrl = ctrl;
 	conn_ctx->sq_depth = queue_size;
 	mutex_init(&conn_ctx->send_mutex);
+	qedn_set_pdu_params(conn_ctx);
 
 	init_waitqueue_head(&conn_ctx->conn_waitq);
 	atomic_set(&conn_ctx->est_conn_indicator, 0);
diff --git a/drivers/nvme/hw/qedn/qedn_task.c b/drivers/nvme/hw/qedn/qedn_task.c
index 7b228b5c5169..e52460f9650e 100644
--- a/drivers/nvme/hw/qedn/qedn_task.c
+++ b/drivers/nvme/hw/qedn/qedn_task.c
@@ -392,9 +392,11 @@ void qedn_io_work_cq(struct qedn_ctx *qedn, struct nvmetcp_fw_cqe *cqe)
 			break;
 
 		case NVMETCP_TASK_TYPE_INIT_CONN_REQUEST:
-
-			/* Placeholder - ICReq flow */
-
+			/* Clear ICReq-padding SGE from SGL */
+			qedn_common_clear_fw_sgl(&qedn_task->sgl_task_params);
+			/* Task is not required for icresp processing */
+			qedn_return_task_to_pool(conn_ctx, qedn_task);
+			qedn_prep_icresp(conn_ctx, cqe);
 			break;
 		default:
 			pr_info("Could not identify task type\n");
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
