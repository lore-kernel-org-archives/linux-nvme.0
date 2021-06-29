Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FA0C11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A253361DE3
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A253361DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SxgDDNFk04fJsGzL9o5hewhTJ6kq9oMxShV8Aja0zZU=; b=rtOmoIVW36JchB
	nbgHaMAvy92nNpraolXoRsOYsNkqugLnKuohkBA4+hcyJObQguVDsbVRERwhREgdjHBnlUni7vrDr
	E8lwg+jsF18YMoOUshwDQksTNCbIu95BBSH5hG1bgspgsfNIynJkg4n92Oy54YuX2F3tu/iKeM4dj
	WZVEQ/uaMYHLeSnWqINFNAHoxH9V/Zy2Zd94AoW1/R8tEg6zniAhGyUui6I1dWz6ZQ0EzzrMuOFy0
	ycpA9xId/13R4Z+CxZBtiIV8jFqY5gzd1nyNQnxjleoJUyUm6GvGF0cp2oVccZCla97UayT3tfl5k
	+AxdgfRhLfYPrzfJVA1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyDIU-00Aubw-IQ; Tue, 29 Jun 2021 12:57:02 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyDAf-00AsNA-BY
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 12:49:01 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15TCjPm1014142; Tue, 29 Jun 2021 05:48:51 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 39f964dup6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 29 Jun 2021 05:48:51 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 29 Jun 2021 05:48:48 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Tue, 29 Jun 2021 05:48:45 -0700
From: Prabhakar Kushwaha <pkushwaha@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
 <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH v4 13/20] qedn: Add connection-level slowpath functionality
Date: Tue, 29 Jun 2021 15:47:36 +0300
Message-ID: <20210629124743.6898-14-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210629124743.6898-1-pkushwaha@marvell.com>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: dZubNbI8n7P4Y2AlHtBbdqqBmQArNw2D
X-Proofpoint-GUID: dZubNbI8n7P4Y2AlHtBbdqqBmQArNw2D
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-29_06:2021-06-28,
 2021-06-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_054857_662325_A1BC9D4D 
X-CRM114-Status: GOOD (  27.47  )
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

This patch will present the connection (queue) level slowpath
implementation relevant for create_queue flow.

The internal implementation:
- Add per controller slowpath workqeueue via pre_setup_ctrl

- qedn_main.c:
  Includes qedn's implementation of the create_queue op.

- qedn_conn.c will include main slowpath connection level functions,
  including:
    1. Per-queue resources allocation.
    2. Creating a new connection.
    3. Offloading the connection to the FW for TCP handshake.
    4. Destroy of a connection.
    5. Support of delete and free controller.
    6. TCP port management via qed_fetch_tcp_port, qed_return_tcp_port

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/hw/qedn/Makefile    |   5 +-
 drivers/nvme/hw/qedn/qedn.h      | 179 ++++++++++
 drivers/nvme/hw/qedn/qedn_conn.c | 564 +++++++++++++++++++++++++++++++
 drivers/nvme/hw/qedn/qedn_main.c | 210 +++++++++++-
 4 files changed, 948 insertions(+), 10 deletions(-)
 create mode 100644 drivers/nvme/hw/qedn/qedn_conn.c

diff --git a/drivers/nvme/hw/qedn/Makefile b/drivers/nvme/hw/qedn/Makefile
index 1422cd878680..ece84772d317 100644
--- a/drivers/nvme/hw/qedn/Makefile
+++ b/drivers/nvme/hw/qedn/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_NVME_QEDN) := qedn.o
-
-qedn-y := qedn_main.o
+obj-$(CONFIG_NVME_QEDN) += qedn.o
+qedn-y := qedn_main.o qedn_conn.o
diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index edb0836bca87..38ab4ff88999 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -6,6 +6,7 @@
 #ifndef _QEDN_H_
 #define _QEDN_H_
 
+#include <linux/qed/common_hsi.h>
 #include <linux/qed/qed_if.h>
 #include <linux/qed/qed_nvmetcp_if.h>
 #include <linux/qed/qed_nvmetcp_ip_services_if.h>
@@ -28,7 +29,41 @@
 #define QEDN_IRQ_NAME_LEN 24
 #define QEDN_IRQ_NO_FLAGS 0
 
+/* Destroy connection defines */
+#define QEDN_NON_ABORTIVE_TERMINATION 0
+#define QEDN_ABORTIVE_TERMINATION 1
+
+/*
+ * TCP offload stack default configurations and defines.
+ * Future enhancements will allow controlling the configurable
+ * parameters via devlink.
+ */
 #define QEDN_TCP_RTO_DEFAULT 280
+#define QEDN_TCP_ECN_EN 0
+#define QEDN_TCP_TS_EN 0
+#define QEDN_TCP_DA_EN 0
+#define QEDN_TCP_KA_EN 0
+#define QEDN_TCP_TOS 0
+#define QEDN_TCP_TTL 0xfe
+#define QEDN_TCP_FLOW_LABEL 0
+#define QEDN_TCP_KA_TIMEOUT 7200000
+#define QEDN_TCP_KA_INTERVAL 10000
+#define QEDN_TCP_KA_MAX_PROBE_COUNT 10
+#define QEDN_TCP_MAX_RT_TIME 30000
+#define QEDN_TCP_MAX_CWND 4
+#define QEDN_TCP_RCV_WND_SCALE 2
+#define QEDN_TCP_TS_OPTION_LEN 12
+
+/* SP Work queue defines */
+#define QEDN_SP_WORKQUEUE "qedn_sp_wq"
+#define QEDN_SP_WORKQUEUE_MAX_ACTIVE 1
+
+#define QEDN_HOST_MAX_SQ_SIZE (512)
+#define QEDN_SQ_SIZE (2 * QEDN_HOST_MAX_SQ_SIZE)
+
+/* Timeouts and delay constants */
+#define QEDN_WAIT_CON_ESTABLSH_TMO 10000 /* 10 seconds */
+#define QEDN_RLS_CONS_TMO 5000 /* 5 sec */
 
 enum qedn_state {
 	QEDN_STATE_CORE_PROBED = 0,
@@ -64,6 +99,12 @@ struct qedn_ctx {
 	/* Accessed with atomic bit ops, used with enum qedn_state */
 	unsigned long state;
 
+	u8 local_mac_addr[ETH_ALEN];
+	u16 mtu;
+
+	/* Connections */
+	DECLARE_HASHTABLE(conn_ctx_hash, 16);
+
 	/* Fast path queues */
 	u8 num_fw_cqs;
 	struct qedn_fp_queue *fp_q_arr;
@@ -71,4 +112,142 @@ struct qedn_ctx {
 	dma_addr_t fw_cq_array_phy; /* Physical address of fw_cq_array_virt */
 };
 
+struct qedn_endpoint {
+	/* FW Params */
+	struct qed_chain fw_sq_chain;
+	struct nvmetcp_db_data db_data;
+	void __iomem *p_doorbell;
+
+	/* TCP Params */
+	__be32 dst_addr[4]; /* In network order */
+	__be32 src_addr[4]; /* In network order */
+	u16 src_port;
+	u16 dst_port;
+	u16 vlan_id;
+	u8 src_mac[ETH_ALEN];
+	u8 dst_mac[ETH_ALEN];
+	u8 ip_type;
+};
+
+enum sp_work_agg_action {
+	CREATE_CONNECTION = 0,
+	SEND_ICREQ,
+	HANDLE_ICRESP,
+	DESTROY_CONNECTION,
+};
+
+enum qedn_ctrl_agg_state {
+	QEDN_CTRL_SET_TO_OFLD_CTRL = 0, /* CTRL set to OFLD_CTRL */
+	QEDN_STATE_SP_WORK_THREAD_SET, /* slow patch WQ was created*/
+	LLH_FILTER, /* LLH filter added */
+	QEDN_RECOVERY,
+	ADMINQ_CONNECTED, /* At least one connection has attempted offload */
+	ERR_FLOW,
+};
+
+enum qedn_ctrl_sp_wq_state {
+	QEDN_CTRL_STATE_UNINITIALIZED = 0,
+	QEDN_CTRL_STATE_FREE_CTRL,
+	QEDN_CTRL_STATE_CTRL_ERR,
+};
+
+/* Any change to this enum requires an update of qedn_conn_state_str */
+enum qedn_conn_state {
+	CONN_STATE_CONN_IDLE = 0,
+	CONN_STATE_CREATE_CONNECTION,
+	CONN_STATE_WAIT_FOR_CONNECT_DONE,
+	CONN_STATE_OFFLOAD_COMPLETE,
+	CONN_STATE_WAIT_FOR_UPDATE_EQE,
+	CONN_STATE_WAIT_FOR_IC_COMP,
+	CONN_STATE_NVMETCP_CONN_ESTABLISHED,
+	CONN_STATE_DESTROY_CONNECTION,
+	CONN_STATE_WAIT_FOR_DESTROY_DONE,
+	CONN_STATE_DESTROY_COMPLETE
+};
+
+struct qedn_ctrl {
+	struct list_head glb_entry;
+	struct list_head pf_entry;
+
+	struct qedn_ctx *qedn;
+	struct nvme_tcp_ofld_queue *queue;
+	struct nvme_tcp_ofld_ctrl *ctrl;
+
+	struct sockaddr remote_mac_addr;
+	u16 vlan_id;
+
+	struct workqueue_struct *sp_wq;
+	enum qedn_ctrl_sp_wq_state sp_wq_state;
+
+	struct work_struct sp_wq_entry;
+
+	struct qedn_llh_filter *llh_filter;
+
+	unsigned long agg_state;
+
+	atomic_t host_num_active_conns;
+};
+
+/* Connection level struct */
+struct qedn_conn_ctx {
+	struct qedn_ctx *qedn;
+	struct nvme_tcp_ofld_queue *queue;
+	struct nvme_tcp_ofld_ctrl *ctrl;
+	u32 conn_handle;
+	u32 fw_cid;
+
+	atomic_t est_conn_indicator;
+	atomic_t destroy_conn_indicator;
+	wait_queue_head_t conn_waitq;
+
+	struct work_struct sp_wq_entry;
+
+	/* Connection aggregative state.
+	 * Can have different states independently.
+	 */
+	unsigned long agg_work_action;
+
+	struct hlist_node hash_node;
+	struct nvmetcp_host_cccid_itid_entry *host_cccid_itid;
+	dma_addr_t host_cccid_itid_phy_addr;
+	struct qedn_endpoint ep;
+	int abrt_flag;
+
+	/* Connection resources - turned on to indicate what resource was
+	 * allocated, to that it can later be released.
+	 */
+	unsigned long resrc_state;
+
+	/* Connection state */
+	spinlock_t conn_state_lock;
+	enum qedn_conn_state state;
+
+	size_t sq_depth;
+
+	/* "dummy" socket */
+	struct socket *sock;
+};
+
+enum qedn_conn_resources_state {
+	QEDN_CONN_RESRC_FW_SQ,
+	QEDN_CONN_RESRC_ACQUIRE_CONN,
+	QEDN_CONN_RESRC_CCCID_ITID_MAP,
+	QEDN_CONN_RESRC_TCP_PORT,
+	QEDN_CONN_RESRC_DB_ADD,
+	QEDN_CONN_RESRC_MAX = 64
+};
+
+struct qedn_conn_ctx *qedn_get_conn_hash(struct qedn_ctx *qedn, u16 icid);
+int qedn_event_cb(void *context, u8 fw_event_code, void *event_ring_data);
+void qedn_sp_wq_handler(struct work_struct *work);
+void qedn_set_sp_wa(struct qedn_conn_ctx *conn_ctx, u32 bit);
+void qedn_clr_sp_wa(struct qedn_conn_ctx *conn_ctx, u32 bit);
+int qedn_initialize_endpoint(struct qedn_endpoint *ep, u8 *local_mac_addr,
+			     struct nvme_tcp_ofld_ctrl *ctrl);
+int qedn_wait_for_conn_est(struct qedn_conn_ctx *conn_ctx);
+int qedn_set_con_state(struct qedn_conn_ctx *conn_ctx,
+		       enum qedn_conn_state new_state);
+void qedn_terminate_connection(struct qedn_conn_ctx *conn_ctx);
+void qedn_cleanp_fw(struct qedn_conn_ctx *conn_ctx);
+
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_conn.c b/drivers/nvme/hw/qedn/qedn_conn.c
new file mode 100644
index 000000000000..04c45a6fa14b
--- /dev/null
+++ b/drivers/nvme/hw/qedn/qedn_conn.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Marvell. All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+ /* Kernel includes */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <net/tcp.h>
+
+/* Driver includes */
+#include "qedn.h"
+
+extern const struct qed_nvmetcp_ops *qed_ops;
+
+static const char * const qedn_conn_state_str[] = {
+	"CONN_IDLE",
+	"CREATE_CONNECTION",
+	"WAIT_FOR_CONNECT_DONE",
+	"OFFLOAD_COMPLETE",
+	"WAIT_FOR_UPDATE_EQE",
+	"WAIT_FOR_IC_COMP",
+	"NVMETCP_CONN_ESTABLISHED",
+	"DESTROY_CONNECTION",
+	"WAIT_FOR_DESTROY_DONE",
+	"DESTROY_COMPLETE",
+	NULL
+};
+
+int qedn_set_con_state(struct qedn_conn_ctx *conn_ctx,
+		       enum qedn_conn_state new_state)
+{
+	spin_lock_bh(&conn_ctx->conn_state_lock);
+	conn_ctx->state = new_state;
+	spin_unlock_bh(&conn_ctx->conn_state_lock);
+
+	return 0;
+}
+
+static void qedn_return_tcp_port(struct qedn_conn_ctx *conn_ctx)
+{
+	if (conn_ctx->sock && conn_ctx->sock->sk) {
+		qed_return_tcp_port(conn_ctx->sock);
+		conn_ctx->sock = NULL;
+	}
+
+	conn_ctx->ep.src_port = 0;
+}
+
+int qedn_wait_for_conn_est(struct qedn_conn_ctx *conn_ctx)
+{
+	u32 est_timeout = msecs_to_jiffies(QEDN_WAIT_CON_ESTABLSH_TMO);
+	atomic_t *conn_est_ind = &conn_ctx->est_conn_indicator;
+	int wrc, rc;
+
+	wrc = wait_event_interruptible_timeout(conn_ctx->conn_waitq,
+					       atomic_read(conn_est_ind) > 0,
+					       est_timeout);
+	atomic_set(conn_est_ind, 0);
+	if (!wrc ||
+	    conn_ctx->state != CONN_STATE_NVMETCP_CONN_ESTABLISHED) {
+		rc = -ETIMEDOUT;
+
+		/* If error was prior or during offload, conn_ctx was released.
+		 * If the error was after offload sync has completed, we need to
+		 * terminate the connection ourselves.
+		 */
+		if (conn_ctx &&
+		    conn_ctx->state >= CONN_STATE_WAIT_FOR_CONNECT_DONE &&
+		    conn_ctx->state <= CONN_STATE_NVMETCP_CONN_ESTABLISHED)
+			qedn_terminate_connection(conn_ctx);
+	} else {
+		rc = 0;
+	}
+
+	return rc;
+}
+
+int qedn_fill_ep_addr4(struct qedn_endpoint *ep,
+		       struct nvme_tcp_ofld_ctrl_con_params *conn_params)
+{
+	struct sockaddr_in *raddr, *laddr;
+
+	raddr = (struct sockaddr_in *)&conn_params->remote_ip_addr;
+	laddr = (struct sockaddr_in *)&conn_params->local_ip_addr;
+
+	ep->ip_type = TCP_IPV4;
+	ep->src_port = laddr->sin_port;
+	ep->dst_port = ntohs(raddr->sin_port);
+
+	ep->src_addr[0] = laddr->sin_addr.s_addr;
+	ep->dst_addr[0] = raddr->sin_addr.s_addr;
+
+	return 0;
+}
+
+int qedn_fill_ep_addr6(struct qedn_endpoint *ep,
+		       struct nvme_tcp_ofld_ctrl_con_params *conn_params)
+{
+	struct sockaddr_in6 *raddr6, *laddr6;
+	int i;
+
+	raddr6 = (struct sockaddr_in6 *)&conn_params->remote_ip_addr;
+	laddr6 = (struct sockaddr_in6 *)&conn_params->local_ip_addr;
+
+	ep->ip_type = TCP_IPV6;
+	ep->src_port = laddr6->sin6_port;
+	ep->dst_port = ntohs(raddr6->sin6_port);
+
+	for (i = 0; i < 4; i++) {
+		ep->src_addr[i] = laddr6->sin6_addr.in6_u.u6_addr32[i];
+		ep->dst_addr[i] = raddr6->sin6_addr.in6_u.u6_addr32[i];
+	}
+
+	return 0;
+}
+
+int qedn_initialize_endpoint(struct qedn_endpoint *ep, u8 *local_mac_addr,
+			     struct nvme_tcp_ofld_ctrl *ctrl)
+{
+	struct nvme_tcp_ofld_ctrl_con_params *conn_params = &ctrl->conn_params;
+	struct qedn_ctrl *qctrl;
+
+	qctrl = (struct qedn_ctrl *)ctrl->private_data;
+	if (!qctrl)
+		return -ENODEV;
+
+	ether_addr_copy(ep->dst_mac, qctrl->remote_mac_addr.sa_data);
+	ether_addr_copy(ep->src_mac, local_mac_addr);
+	ep->vlan_id = qctrl->vlan_id;
+	if (conn_params->remote_ip_addr.ss_family == AF_INET)
+		qedn_fill_ep_addr4(ep, conn_params);
+	else
+		qedn_fill_ep_addr6(ep, conn_params);
+
+	return -1;
+}
+
+static void qedn_release_conn_ctx(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	int rc = 0;
+
+	if (test_bit(QEDN_CONN_RESRC_FW_SQ, &conn_ctx->resrc_state)) {
+		qed_ops->common->chain_free(qedn->cdev,
+					    &conn_ctx->ep.fw_sq_chain);
+		clear_bit(QEDN_CONN_RESRC_FW_SQ, &conn_ctx->resrc_state);
+	}
+
+	if (test_bit(QEDN_CONN_RESRC_DB_ADD, &conn_ctx->resrc_state)) {
+		rc = qed_ops->common->db_recovery_del(qedn->cdev,
+						      conn_ctx->ep.p_doorbell,
+						      &conn_ctx->ep.db_data);
+		if (rc)
+			pr_warn("Doorbell recovery del returned error %u\n",
+				rc);
+
+		clear_bit(QEDN_CONN_RESRC_DB_ADD, &conn_ctx->resrc_state);
+	}
+
+	if (test_bit(QEDN_CONN_RESRC_ACQUIRE_CONN, &conn_ctx->resrc_state)) {
+		hash_del(&conn_ctx->hash_node);
+		rc = qed_ops->release_conn(qedn->cdev, conn_ctx->conn_handle);
+		if (rc)
+			pr_warn("Release_conn returned with an error %u\n",
+				rc);
+
+		clear_bit(QEDN_CONN_RESRC_ACQUIRE_CONN, &conn_ctx->resrc_state);
+	}
+
+	if (test_bit(QEDN_CONN_RESRC_CCCID_ITID_MAP, &conn_ctx->resrc_state)) {
+		dma_free_coherent(&qedn->pdev->dev,
+				  conn_ctx->sq_depth *
+				  sizeof(struct nvmetcp_host_cccid_itid_entry),
+				  conn_ctx->host_cccid_itid,
+				  conn_ctx->host_cccid_itid_phy_addr);
+		clear_bit(QEDN_CONN_RESRC_CCCID_ITID_MAP,
+			  &conn_ctx->resrc_state);
+	}
+
+	if (test_bit(QEDN_CONN_RESRC_TCP_PORT, &conn_ctx->resrc_state)) {
+		qedn_return_tcp_port(conn_ctx);
+		clear_bit(QEDN_CONN_RESRC_TCP_PORT,
+			  &conn_ctx->resrc_state);
+	}
+
+	if (conn_ctx->resrc_state)
+		pr_err("Conn resources state isn't 0 as expected 0x%lx\n",
+		       conn_ctx->resrc_state);
+
+	atomic_inc(&conn_ctx->destroy_conn_indicator);
+	qedn_set_con_state(conn_ctx, CONN_STATE_DESTROY_COMPLETE);
+	wake_up_interruptible(&conn_ctx->conn_waitq);
+}
+
+static int qedn_alloc_fw_sq(struct qedn_ctx *qedn,
+			    struct qedn_endpoint *ep)
+{
+	struct qed_chain_init_params params = {
+		.mode           = QED_CHAIN_MODE_PBL,
+		.intended_use   = QED_CHAIN_USE_TO_PRODUCE,
+		.cnt_type       = QED_CHAIN_CNT_TYPE_U16,
+		.num_elems      = QEDN_SQ_SIZE,
+		.elem_size      = sizeof(struct nvmetcp_wqe),
+	};
+	int rc;
+
+	rc = qed_ops->common->chain_alloc(qedn->cdev,
+					   &ep->fw_sq_chain,
+					   &params);
+	if (rc) {
+		pr_err("Failed to allocate SQ chain\n");
+
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int qedn_nvmetcp_offload_conn(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qed_nvmetcp_params_offload offld_prms = { 0 };
+	struct qedn_endpoint *qedn_ep = &conn_ctx->ep;
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	u8 ts_hdr_size = 0;
+	u32 hdr_size;
+	int rc, i;
+
+	ether_addr_copy(offld_prms.src.mac, qedn_ep->src_mac);
+	ether_addr_copy(offld_prms.dst.mac, qedn_ep->dst_mac);
+	offld_prms.vlan_id = qedn_ep->vlan_id;
+	offld_prms.ecn_en = QEDN_TCP_ECN_EN;
+	offld_prms.timestamp_en =  QEDN_TCP_TS_EN;
+	offld_prms.delayed_ack_en = QEDN_TCP_DA_EN;
+	offld_prms.tcp_keep_alive_en = QEDN_TCP_KA_EN;
+	offld_prms.ip_version = qedn_ep->ip_type;
+
+	offld_prms.src.ip[0] = ntohl(qedn_ep->src_addr[0]);
+	offld_prms.dst.ip[0] = ntohl(qedn_ep->dst_addr[0]);
+	if (qedn_ep->ip_type == TCP_IPV6) {
+		for (i = 1; i < 4; i++) {
+			offld_prms.src.ip[i] = ntohl(qedn_ep->src_addr[i]);
+			offld_prms.dst.ip[i] = ntohl(qedn_ep->dst_addr[i]);
+		}
+	}
+
+	offld_prms.ttl = QEDN_TCP_TTL;
+	offld_prms.tos_or_tc = QEDN_TCP_TOS;
+	offld_prms.dst.port = qedn_ep->dst_port;
+	offld_prms.src.port = qedn_ep->src_port;
+	offld_prms.nvmetcp_cccid_itid_table_addr =
+		conn_ctx->host_cccid_itid_phy_addr;
+	offld_prms.nvmetcp_cccid_max_range = conn_ctx->sq_depth;
+
+	/* Calculate MSS */
+	if (offld_prms.timestamp_en)
+		ts_hdr_size = QEDN_TCP_TS_OPTION_LEN;
+
+	hdr_size = qedn_ep->ip_type == TCP_IPV4 ?
+		   sizeof(struct iphdr) : sizeof(struct ipv6hdr);
+	hdr_size += sizeof(struct tcphdr) + ts_hdr_size;
+
+	offld_prms.mss = qedn->mtu - hdr_size;
+	offld_prms.rcv_wnd_scale = QEDN_TCP_RCV_WND_SCALE;
+	offld_prms.cwnd = QEDN_TCP_MAX_CWND * offld_prms.mss;
+	offld_prms.ka_max_probe_cnt = QEDN_TCP_KA_MAX_PROBE_COUNT;
+	offld_prms.ka_timeout = QEDN_TCP_KA_TIMEOUT;
+	offld_prms.ka_interval = QEDN_TCP_KA_INTERVAL;
+	offld_prms.max_rt_time = QEDN_TCP_MAX_RT_TIME;
+	offld_prms.sq_pbl_addr =
+		(u64)qed_chain_get_pbl_phys(&qedn_ep->fw_sq_chain);
+
+	rc = qed_ops->offload_conn(qedn->cdev,
+				   conn_ctx->conn_handle,
+				   &offld_prms);
+	if (rc)
+		pr_err("offload_conn returned with an error\n");
+
+	return rc;
+}
+
+static int qedn_fetch_tcp_port(struct qedn_conn_ctx *conn_ctx)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl;
+	struct qedn_ctrl *qctrl;
+	int rc = 0;
+
+	ctrl = conn_ctx->ctrl;
+	qctrl = (struct qedn_ctrl *)ctrl->private_data;
+	if (!qctrl)
+		return -ENODEV;
+
+	rc = qed_fetch_tcp_port(ctrl->conn_params.local_ip_addr,
+				&conn_ctx->sock, &conn_ctx->ep.src_port);
+
+	return rc;
+}
+
+static void qedn_decouple_conn(struct qedn_conn_ctx *conn_ctx)
+{
+	struct nvme_tcp_ofld_queue *queue;
+
+	queue = conn_ctx->queue;
+	queue->private_data = NULL;
+}
+
+void qedn_terminate_connection(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctrl *qctrl;
+
+	if (!conn_ctx)
+		return;
+
+	qctrl = (struct qedn_ctrl *)conn_ctx->ctrl->private_data;
+	if (!qctrl)
+		return;
+
+	if (test_and_set_bit(DESTROY_CONNECTION, &conn_ctx->agg_work_action))
+		return;
+
+	qedn_set_con_state(conn_ctx, CONN_STATE_DESTROY_CONNECTION);
+	queue_work(qctrl->sp_wq, &conn_ctx->sp_wq_entry);
+}
+
+/* Slowpath EQ Callback */
+int qedn_event_cb(void *context, u8 fw_event_code, void *event_ring_data)
+{
+	struct nvmetcp_connect_done_results *eqe_connect_done;
+	struct nvmetcp_eqe_data *eqe_data;
+	struct nvme_tcp_ofld_ctrl *ctrl;
+	struct qedn_conn_ctx *conn_ctx;
+	struct qedn_ctrl *qctrl;
+	struct qedn_ctx *qedn;
+	u16 icid;
+	int rc;
+
+	if (!context || !event_ring_data) {
+		pr_err("Recv event with ctx NULL\n");
+
+		return -EINVAL;
+	}
+
+	qedn = (struct qedn_ctx *)context;
+
+	if (fw_event_code != NVMETCP_EVENT_TYPE_ASYN_CONNECT_COMPLETE) {
+		eqe_data = (struct nvmetcp_eqe_data *)event_ring_data;
+		icid = le16_to_cpu(eqe_data->icid);
+		pr_err("EQE Type=0x%x icid=0x%x, conn_id=0x%x err-code=0x%x\n",
+		       fw_event_code, eqe_data->icid, eqe_data->conn_id,
+		       eqe_data->error_code);
+	} else {
+		eqe_connect_done =
+			(struct nvmetcp_connect_done_results *)event_ring_data;
+		icid = le16_to_cpu(eqe_connect_done->icid);
+	}
+
+	conn_ctx = qedn_get_conn_hash(qedn, icid);
+	if (!conn_ctx) {
+		pr_err("Connection with icid=0x%x doesn't exist in conn list\n",
+		       icid);
+
+		return -EINVAL;
+	}
+
+	ctrl = conn_ctx->ctrl;
+	qctrl = (struct qedn_ctrl *)ctrl->private_data;
+	if (!qctrl)
+		return -ENODEV;
+
+	switch (fw_event_code) {
+	case NVMETCP_EVENT_TYPE_ASYN_CONNECT_COMPLETE:
+		if (conn_ctx->state != CONN_STATE_WAIT_FOR_CONNECT_DONE) {
+			pr_err("CID=0x%x:ASYN_CONNECT_COMPL:Wrong state %u\n",
+			       conn_ctx->fw_cid, conn_ctx->state);
+		} else {
+			rc = qedn_set_con_state(conn_ctx,
+						CONN_STATE_OFFLOAD_COMPLETE);
+
+			if (rc)
+				return rc;
+
+			/* Placeholder - for ICReq flow */
+		}
+
+		break;
+	case NVMETCP_EVENT_TYPE_ASYN_TERMINATE_DONE:
+		if (conn_ctx->state != CONN_STATE_WAIT_FOR_DESTROY_DONE)
+			pr_err("CID=0x%x:ASYN_TERMINATE_DONE:Wrong state %u\n",
+			       conn_ctx->fw_cid, conn_ctx->state);
+		else
+			queue_work(qctrl->sp_wq, &conn_ctx->sp_wq_entry);
+
+		break;
+	default:
+		pr_err("CID=0x%x - Recv Unknown Event %u\n",
+		       conn_ctx->fw_cid, fw_event_code);
+		break;
+	}
+
+	return 0;
+}
+
+void qedn_prep_db_data(struct qedn_conn_ctx *conn_ctx)
+{
+	struct nvmetcp_db_data *db_data = &conn_ctx->ep.db_data;
+	u8 params = 0;
+
+	params |= DB_DEST_XCM << NVMETCP_DB_DATA_DEST_SHIFT;
+	params |= DB_AGG_CMD_SET << NVMETCP_DB_DATA_AGG_CMD_SHIFT;
+	params |= DQ_XCM_ISCSI_SQ_PROD_CMD << NVMETCP_DB_DATA_AGG_VAL_SEL_SHIFT;
+	params |= 1 << NVMETCP_DB_DATA_BYPASS_EN_SHIFT;
+
+	db_data->params = params;
+	db_data->agg_flags = 0;
+}
+
+static int qedn_prep_and_offload_queue(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	size_t dma_size;
+	int rc;
+
+	rc = qedn_alloc_fw_sq(qedn, &conn_ctx->ep);
+	if (rc) {
+		pr_err("Failed to allocate FW SQ\n");
+		goto rel_conn;
+	}
+
+	set_bit(QEDN_CONN_RESRC_FW_SQ, &conn_ctx->resrc_state);
+	rc = qed_ops->acquire_conn(qedn->cdev,
+				   &conn_ctx->conn_handle,
+				   &conn_ctx->fw_cid,
+				   &conn_ctx->ep.p_doorbell);
+	if (rc) {
+		pr_err("Couldn't acquire connection\n");
+		goto rel_conn;
+	}
+
+	hash_add(qedn->conn_ctx_hash, &conn_ctx->hash_node,
+		 conn_ctx->conn_handle);
+	set_bit(QEDN_CONN_RESRC_ACQUIRE_CONN, &conn_ctx->resrc_state);
+
+	/* Placeholder - Allocate task resources and initialize fields */
+
+	rc = qedn_fetch_tcp_port(conn_ctx);
+	if (rc)
+		goto rel_conn;
+
+	set_bit(QEDN_CONN_RESRC_TCP_PORT, &conn_ctx->resrc_state);
+	dma_size = conn_ctx->sq_depth *
+			   sizeof(struct nvmetcp_host_cccid_itid_entry);
+	conn_ctx->host_cccid_itid =
+			dma_alloc_coherent(&qedn->pdev->dev,
+					   dma_size,
+					   &conn_ctx->host_cccid_itid_phy_addr,
+					   GFP_ATOMIC);
+	if (!conn_ctx->host_cccid_itid) {
+		pr_err("CCCID-iTID Map allocation failed\n");
+		goto rel_conn;
+	}
+
+	memset(conn_ctx->host_cccid_itid, 0xFF, dma_size);
+	set_bit(QEDN_CONN_RESRC_CCCID_ITID_MAP, &conn_ctx->resrc_state);
+	rc = qedn_set_con_state(conn_ctx, CONN_STATE_WAIT_FOR_CONNECT_DONE);
+	if (rc)
+		goto rel_conn;
+
+	qedn_prep_db_data(conn_ctx);
+	rc = qed_ops->common->db_recovery_add(qedn->cdev,
+					      conn_ctx->ep.p_doorbell,
+					      &conn_ctx->ep.db_data,
+					      DB_REC_WIDTH_32B, DB_REC_KERNEL);
+	if (rc)
+		goto rel_conn;
+	set_bit(QEDN_CONN_RESRC_DB_ADD, &conn_ctx->resrc_state);
+
+	rc = qedn_nvmetcp_offload_conn(conn_ctx);
+	if (rc) {
+		pr_err("Offload error: CID=0x%x\n", conn_ctx->fw_cid);
+		goto rel_conn;
+	}
+
+	return 0;
+
+rel_conn:
+	pr_err("qedn create queue ended with ERROR\n");
+	qedn_release_conn_ctx(conn_ctx);
+
+	return -EINVAL;
+}
+
+void qedn_cleanp_fw(struct qedn_conn_ctx *conn_ctx)
+{
+	/* Placeholder - task cleanup */
+}
+
+void qedn_destroy_connection(struct qedn_conn_ctx *conn_ctx)
+{
+	struct qedn_ctx *qedn = conn_ctx->qedn;
+	int rc;
+
+	qedn_decouple_conn(conn_ctx);
+
+	if (qedn_set_con_state(conn_ctx, CONN_STATE_WAIT_FOR_DESTROY_DONE))
+		return;
+
+	rc = qed_ops->destroy_conn(qedn->cdev, conn_ctx->conn_handle,
+				   conn_ctx->abrt_flag);
+	if (rc)
+		pr_warn("destroy_conn failed - rc %u\n", rc);
+}
+
+void qedn_sp_wq_handler(struct work_struct *work)
+{
+	struct qedn_conn_ctx *conn_ctx;
+	struct qedn_ctx *qedn;
+	int rc;
+
+	conn_ctx = container_of(work, struct qedn_conn_ctx, sp_wq_entry);
+	qedn = conn_ctx->qedn;
+
+	if (conn_ctx->state == CONN_STATE_DESTROY_COMPLETE) {
+		pr_err("Connection already released!\n");
+
+		return;
+	}
+
+	if (conn_ctx->state == CONN_STATE_WAIT_FOR_DESTROY_DONE) {
+		qedn_release_conn_ctx(conn_ctx);
+
+		return;
+	}
+
+	qedn = conn_ctx->qedn;
+	if (test_bit(DESTROY_CONNECTION, &conn_ctx->agg_work_action)) {
+		qedn_destroy_connection(conn_ctx);
+
+		return;
+	}
+
+	if (test_bit(CREATE_CONNECTION, &conn_ctx->agg_work_action)) {
+		qedn_clr_sp_wa(conn_ctx, CREATE_CONNECTION);
+		rc = qedn_prep_and_offload_queue(conn_ctx);
+		if (rc) {
+			pr_err("Error in queue prepare & firmware offload\n");
+
+			return;
+		}
+	}
+}
+
+/* Clear connection aggregative slowpath work action */
+void qedn_clr_sp_wa(struct qedn_conn_ctx *conn_ctx, u32 bit)
+{
+	clear_bit(bit, &conn_ctx->agg_work_action);
+}
+
+/* Set connection aggregative slowpath work action */
+void qedn_set_sp_wa(struct qedn_conn_ctx *conn_ctx, u32 bit)
+{
+	set_bit(bit, &conn_ctx->agg_work_action);
+}
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index 6c0f36f7d9d1..bd5618f65c70 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -22,6 +22,15 @@ static struct pci_device_id qedn_pci_tbl[] = {
 	{0, 0},
 };
 
+static bool qedn_matches_qede(struct qedn_ctx *qedn, struct pci_dev *qede_pdev)
+{
+	struct pci_dev *qedn_pdev = qedn->pdev;
+
+	return (qede_pdev->bus->number == qedn_pdev->bus->number &&
+		PCI_SLOT(qede_pdev->devfn) == PCI_SLOT(qedn_pdev->devfn) &&
+		PCI_FUNC(qede_pdev->devfn) == qedn->dev_info.port_id);
+}
+
 static int
 qedn_find_dev(struct nvme_tcp_ofld_dev *dev,
 	      struct nvme_tcp_ofld_ctrl *ctrl)
@@ -29,7 +38,9 @@ qedn_find_dev(struct nvme_tcp_ofld_dev *dev,
 	struct nvme_tcp_ofld_ctrl_con_params *conn_params;
 	struct pci_dev *qede_pdev = NULL;
 	struct sockaddr remote_mac_addr;
+	struct qedn_ctrl *qctrl = NULL;
 	struct net_device *ndev = NULL;
+	struct qedn_ctx *qedn = NULL;
 	u16 vlan_id = 0;
 	int rc = 0;
 
@@ -65,11 +76,24 @@ qedn_find_dev(struct nvme_tcp_ofld_dev *dev,
 
 	qed_vlan_get_ndev(&ctrl->ndev, &vlan_id);
 
+	qctrl = (struct qedn_ctrl *)ctrl->private_data;
+	if (qctrl) {
+		qctrl->remote_mac_addr = remote_mac_addr;
+		qctrl->vlan_id = vlan_id;
+	}
+
 	/* route found through ndev - validate this is qede*/
 	qede_pdev = qed_validate_ndev(ctrl->ndev);
 	if (!qede_pdev)
 		return false;
 
+	qedn = container_of(dev, struct qedn_ctx, qedn_ofld_dev);
+	if (!qedn)
+		return false;
+
+	if (!qedn_matches_qede(qedn, qede_pdev))
+		return false;
+
 	return true;
 }
 
@@ -82,14 +106,73 @@ qedn_claim_dev(struct nvme_tcp_ofld_dev *dev,
 
 static int qedn_setup_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 {
-	/* Placeholder - qedn_setup_ctrl */
+	struct nvme_tcp_ofld_dev *dev = ctrl->dev;
+	struct qedn_ctrl *qctrl = NULL;
+	struct qedn_ctx *qedn = NULL;
+	bool new = true;
+	int rc = 0;
+
+	if (ctrl->private_data) {
+		qctrl = (struct qedn_ctrl *)ctrl->private_data;
+		new = false;
+	}
+
+	if (new) {
+		qctrl = kzalloc(sizeof(*qctrl), GFP_KERNEL);
+		if (!qctrl)
+			return -ENOMEM;
+
+		ctrl->private_data = (void *)qctrl;
+		set_bit(QEDN_CTRL_SET_TO_OFLD_CTRL, &qctrl->agg_state);
+
+		qctrl->sp_wq = alloc_workqueue(QEDN_SP_WORKQUEUE,
+					       WQ_MEM_RECLAIM,
+					       QEDN_SP_WORKQUEUE_MAX_ACTIVE);
+		if (!qctrl->sp_wq) {
+			rc = -ENODEV;
+			pr_err("Unable to create slowpath work queue!\n");
+			kfree(qctrl);
+
+			return rc;
+		}
+
+		set_bit(QEDN_STATE_SP_WORK_THREAD_SET, &qctrl->agg_state);
+	}
+
+	if (!qedn_find_dev(dev, ctrl)) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+	qedn = container_of(dev, struct qedn_ctx, qedn_ofld_dev);
+	qctrl->qedn = qedn;
+
+	/* Placeholder - setup LLH filter */
 
 	return 0;
+err_out:
+	flush_workqueue(qctrl->sp_wq);
+	kfree(qctrl);
+
+	return rc;
 }
 
 static int qedn_release_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 {
-	/* Placeholder - qedn_release_ctrl */
+	struct qedn_ctrl *qctrl;
+
+	qctrl = (struct qedn_ctrl *)ctrl->private_data;
+	if (!qctrl)
+		return -ENODEV;
+
+	if (test_and_clear_bit(QEDN_STATE_SP_WORK_THREAD_SET,
+			       &qctrl->agg_state))
+		flush_workqueue(qctrl->sp_wq);
+
+	if (test_and_clear_bit(QEDN_CTRL_SET_TO_OFLD_CTRL, &qctrl->agg_state)) {
+		kfree(qctrl);
+		ctrl->private_data = NULL;
+	}
 
 	return 0;
 }
@@ -97,19 +180,117 @@ static int qedn_release_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
 			     size_t queue_size)
 {
-	/* Placeholder - qedn_create_queue */
+	struct nvme_tcp_ofld_ctrl *ctrl = queue->ctrl;
+	struct nvme_ctrl *nctrl = &ctrl->nctrl;
+	struct qedn_conn_ctx *conn_ctx;
+	struct qedn_ctrl *qctrl;
+	struct qedn_ctx *qedn;
+	int rc;
+
+	qctrl = (struct qedn_ctrl *)ctrl->private_data;
+	if (!qctrl)
+		return -ENODEV;
+
+	qedn = qctrl->qedn;
+
+	/* Allocate qedn connection context */
+	conn_ctx = kzalloc(sizeof(*conn_ctx), GFP_KERNEL);
+	if (!conn_ctx)
+		return -ENOMEM;
+
+	queue->private_data = conn_ctx;
+	queue->hdr_digest = nctrl->opts->hdr_digest;
+	queue->data_digest = nctrl->opts->data_digest;
+	queue->tos = nctrl->opts->tos;
+
+	conn_ctx->qedn = qedn;
+	conn_ctx->queue = queue;
+	conn_ctx->ctrl = ctrl;
+	conn_ctx->sq_depth = queue_size;
+
+	init_waitqueue_head(&conn_ctx->conn_waitq);
+	atomic_set(&conn_ctx->est_conn_indicator, 0);
+	atomic_set(&conn_ctx->destroy_conn_indicator, 0);
+
+	spin_lock_init(&conn_ctx->conn_state_lock);
+
+	qedn_initialize_endpoint(&conn_ctx->ep, qedn->local_mac_addr, ctrl);
+
+	atomic_inc(&qctrl->host_num_active_conns);
+
+	qedn_set_sp_wa(conn_ctx, CREATE_CONNECTION);
+	qedn_set_con_state(conn_ctx, CONN_STATE_CREATE_CONNECTION);
+	INIT_WORK(&conn_ctx->sp_wq_entry, qedn_sp_wq_handler);
+	queue_work(qctrl->sp_wq, &conn_ctx->sp_wq_entry);
+
+	/* Wait for the connection establishment to complete - this includes the
+	 * FW TCP connection establishment and the NVMeTCP ICReq & ICResp
+	 */
+	rc = qedn_wait_for_conn_est(conn_ctx);
+	if (rc)
+		return -ENXIO;
 
 	return 0;
 }
 
 static void qedn_drain_queue(struct nvme_tcp_ofld_queue *queue)
 {
-	/* Placeholder - qedn_drain_queue */
+	struct qedn_conn_ctx *conn_ctx;
+
+	if (!queue) {
+		pr_err("ctrl has no queues\n");
+
+		return;
+	}
+
+	conn_ctx = (struct qedn_conn_ctx *)queue->private_data;
+	if (!conn_ctx)
+		return;
+
+	qedn_cleanp_fw(conn_ctx);
+}
+
+static inline void
+qedn_queue_wait_for_terminate_complete(struct qedn_conn_ctx *conn_ctx)
+{
+	/* Returns valid non-0 */
+	atomic_t *conn_dest_ind = &conn_ctx->destroy_conn_indicator;
+	u32 dest_timeout = msecs_to_jiffies(QEDN_RLS_CONS_TMO);
+	int wrc, state;
+
+	wrc = wait_event_interruptible_timeout(conn_ctx->conn_waitq,
+					       atomic_read(conn_dest_ind) > 0,
+					       dest_timeout);
+
+	atomic_set(conn_dest_ind, 0);
+
+	spin_lock_bh(&conn_ctx->conn_state_lock);
+	state = conn_ctx->state;
+	spin_unlock_bh(&conn_ctx->conn_state_lock);
+
+	if (!wrc  || state != CONN_STATE_DESTROY_COMPLETE)
+		pr_warn("Timed out waiting for clear-SQ on FW conns");
 }
 
 static void qedn_destroy_queue(struct nvme_tcp_ofld_queue *queue)
 {
-	/* Placeholder - qedn_destroy_queue */
+	struct qedn_conn_ctx *conn_ctx;
+
+	if (!queue) {
+		pr_err("ctrl has no queues\n");
+
+		return;
+	}
+
+	conn_ctx = (struct qedn_conn_ctx *)queue->private_data;
+	if (!conn_ctx)
+		return;
+
+	qedn_terminate_connection(conn_ctx);
+
+	qedn_queue_wait_for_terminate_complete(conn_ctx);
+
+	kfree(conn_ctx);
 }
 
 static int qedn_poll_queue(struct nvme_tcp_ofld_queue *queue)
@@ -150,6 +331,21 @@ static struct nvme_tcp_ofld_ops qedn_ofld_ops = {
 	.send_req = qedn_send_req,
 };
 
+struct qedn_conn_ctx *qedn_get_conn_hash(struct qedn_ctx *qedn, u16 icid)
+{
+	struct qedn_conn_ctx *conn = NULL;
+
+	hash_for_each_possible(qedn->conn_ctx_hash, conn, hash_node, icid) {
+		if (conn->conn_handle == icid)
+			break;
+	}
+
+	if (!conn || conn->conn_handle != icid)
+		return NULL;
+
+	return conn;
+}
+
 /* Fastpath IRQ handler */
 static irqreturn_t qedn_irq_handler(int irq, void *dev_id)
 {
@@ -250,7 +446,7 @@ static int qedn_setup_irq(struct qedn_ctx *qedn)
 
 static inline void qedn_init_pf_struct(struct qedn_ctx *qedn)
 {
-	/* Placeholder - Initialize qedn fields */
+	hash_init(qedn->conn_ctx_hash);
 }
 
 static inline void
@@ -591,7 +787,7 @@ static int __qedn_probe(struct pci_dev *pdev)
 	rc = qed_ops->start(qedn->cdev,
 			    NULL /* Placeholder for FW IO-path resources */,
 			    qedn,
-			    NULL /* Placeholder for FW Event callback */);
+			    qedn_event_cb);
 	if (rc) {
 		rc = -ENODEV;
 		pr_err("Cannot start NVMeTCP Function\n");
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
