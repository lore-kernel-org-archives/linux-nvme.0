Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7511FC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:39:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE75061453
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE75061453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z+DJb05D0473pYGiPcIyj42A5c1zG1RcY+hbXaM5EVI=; b=rVjv08fSf8lWAlvBlCR6bobHo
	PgKGdDEkfbv7lc3VZFsfUAPnDZPXfjHRppLBc+tGWgjASPKUQ6D+872DuLGhGRiPQq82BzsYmPbsP
	lyREymiR0i8lygD7aAD/UKkfOiQ1yqMww9IdaPnHPv87yzi+SFtTgVmEYJ/FQLxSz5TVelBU4bJZm
	C/IlWrIEW+nKemP9xL1Y12TzoYsrQEenRoNZaPhzyKQnH3W2jP1fmpx371yJAOw5yXzg1zZrAdDz0
	FhGxpM72YnOztEGLjtYcFfqSLobsacfRdkco7cDtMZ7OdmlPgtZSwQERRCKMXrV3fjW540vbxiRBn
	Yoy1jXAyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcCVY-006JQS-Ez; Thu, 29 Apr 2021 19:39:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC4B-006FZ5-4M
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 19:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ufzT4VJpUQRbdktJnZ1ySwueDxxd0lRQ7IPnjFmSwmE=; b=emgki1q9Qzakv3+SCrDN303fts
 uvzkMIebEzQbTh9FOi9SNy+JKGEONbg4eO/SbbzqJelqJ+HELSl4Vuz52ED0/P32P48BDFVBujk+b
 +/YQSKBpJpwJqpBZGuXzvrvtQ3Nz8gsQaQh5pklWj/QjHvQXNu4RUQXm5gYxMY3laaOxek/R945vy
 ksm8WnvABcogCaRoP1Fx7JwDK0fR8Shxmq3bdjf+6CypNgiBfEyeOYWzqra0CMirqBRhGBW27TX4L
 8VlgncHzotxFZ2/Bl+YivkpG+p50zddYaLRRvOjNRy6j5zcIXgeDAqNa/fZuk/DhjgHd7htbYFUPG
 7+YsPvBw==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC48-000sgo-80
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 19:11:13 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13TJ5GSs027367; Thu, 29 Apr 2021 12:11:08 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 387rpnamun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 29 Apr 2021 12:11:07 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 29 Apr 2021 12:11:05 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 29 Apr 2021 12:11:02 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: =?UTF-8?q?David=20S=20=2E=20Miller=20davem=20=40=20davemloft=20=2E=20net=20=C2=A0--cc=3DJakub=20Kicinski?=
 <kuba@kernel.org>,
 <smalin@marvell.com>, <aelior@marvell.com>, <mkalderon@marvell.com>,
 <okulkarni@marvell.com>, <pkushwaha@marvell.com>, <malin1024@gmail.com>
Subject: [RFC PATCH v4 21/27] qedn: Add support of configuring HW filter block
Date: Thu, 29 Apr 2021 22:09:20 +0300
Message-ID: <20210429190926.5086-22-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210429190926.5086-1-smalin@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: aWCghXMYH5zgEdsFCznSHCwNYNo4v0lq
X-Proofpoint-ORIG-GUID: aWCghXMYH5zgEdsFCznSHCwNYNo4v0lq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-29_10:2021-04-28,
 2021-04-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_121112_428592_11D941F5 
X-CRM114-Status: GOOD (  19.21  )
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

HW filter can be configured to filter TCP packets based on either
source or target TCP port. QEDN leverage this feature to route
NVMeTCP traffic.

This patch configures HW filter block based on source port for all
receiving packets to deliver correct QEDN PF.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/hw/qedn/qedn.h      |  15 +++++
 drivers/nvme/hw/qedn/qedn_main.c | 108 ++++++++++++++++++++++++++++++-
 2 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index ed0d43163da2..c15cac37ec1e 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -38,6 +38,11 @@
 #define QEDN_IRQ_NAME_LEN 24
 #define QEDN_IRQ_NO_FLAGS 0
 
+/* HW defines */
+
+/* QEDN_MAX_LLH_PORTS will be extended in future */
+#define QEDN_MAX_LLH_PORTS 16
+
 /* Destroy connection defines */
 #define QEDN_NON_ABORTIVE_TERMINATION 0
 #define QEDN_ABORTIVE_TERMINATION 1
@@ -78,6 +83,7 @@ enum qedn_state {
 	QEDN_STATE_CORE_PROBED = 0,
 	QEDN_STATE_CORE_OPEN,
 	QEDN_STATE_GL_PF_LIST_ADDED,
+	QEDN_STATE_LLH_PORT_FILTER_SET,
 	QEDN_STATE_MFW_STATE,
 	QEDN_STATE_NVMETCP_OPEN,
 	QEDN_STATE_IRQ_SET,
@@ -112,6 +118,8 @@ struct qedn_ctx {
 	/* Accessed with atomic bit ops, used with enum qedn_state */
 	unsigned long state;
 
+	u8 num_llh_filters;
+	struct list_head llh_filter_list;
 	u8 local_mac_addr[ETH_ALEN];
 	u16 mtu;
 
@@ -177,6 +185,12 @@ enum qedn_conn_state {
 	CONN_STATE_DESTROY_COMPLETE
 };
 
+struct qedn_llh_filter {
+	struct list_head entry;
+	u16 port;
+	u16 ref_cnt;
+};
+
 struct qedn_ctrl {
 	struct list_head glb_entry;
 	struct list_head pf_entry;
@@ -265,5 +279,6 @@ int qedn_initialize_endpoint(struct qedn_endpoint *ep, u8 *local_mac_addr,
 int qedn_wait_for_conn_est(struct qedn_conn_ctx *conn_ctx);
 int qedn_set_con_state(struct qedn_conn_ctx *conn_ctx, enum qedn_conn_state new_state);
 void qedn_terminate_connection(struct qedn_conn_ctx *conn_ctx, int abrt_flag);
+__be16 qedn_get_in_port(struct sockaddr_storage *sa);
 
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index 70beb84b9793..8b5714e7e2bb 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -23,6 +23,81 @@ static struct pci_device_id qedn_pci_tbl[] = {
 	{0, 0},
 };
 
+__be16 qedn_get_in_port(struct sockaddr_storage *sa)
+{
+	return sa->ss_family == AF_INET
+		? ((struct sockaddr_in *)sa)->sin_port
+		: ((struct sockaddr_in6 *)sa)->sin6_port;
+}
+
+struct qedn_llh_filter *qedn_add_llh_filter(struct qedn_ctx *qedn, u16 tcp_port)
+{
+	struct qedn_llh_filter *llh_filter = NULL;
+	struct qedn_llh_filter *llh_tmp = NULL;
+	bool new_filter = 1;
+	int rc = 0;
+
+	/* Check if LLH filter already defined */
+	list_for_each_entry_safe(llh_filter, llh_tmp, &qedn->llh_filter_list, entry) {
+		if (llh_filter->port == tcp_port) {
+			new_filter = 0;
+			llh_filter->ref_cnt++;
+			break;
+		}
+	}
+
+	if (new_filter) {
+		if (qedn->num_llh_filters >= QEDN_MAX_LLH_PORTS) {
+			pr_err("PF reached the max target ports limit %u. %u\n",
+			       qedn->dev_info.common.abs_pf_id,
+			       qedn->num_llh_filters);
+
+			return NULL;
+		}
+
+		rc = qed_ops->add_src_tcp_port_filter(qedn->cdev, tcp_port);
+		if (rc) {
+			pr_err("LLH port configuration failed. port:%u; rc:%u\n", tcp_port, rc);
+
+			return NULL;
+		}
+
+		llh_filter = kzalloc(sizeof(*llh_filter), GFP_KERNEL);
+		if (!llh_filter) {
+			qed_ops->remove_src_tcp_port_filter(qedn->cdev, tcp_port);
+
+			return NULL;
+		}
+
+		llh_filter->port = tcp_port;
+		llh_filter->ref_cnt = 1;
+		++qedn->num_llh_filters;
+		list_add_tail(&llh_filter->entry, &qedn->llh_filter_list);
+		set_bit(QEDN_STATE_LLH_PORT_FILTER_SET, &qedn->state);
+	}
+
+	return llh_filter;
+}
+
+void qedn_dec_llh_filter(struct qedn_ctx *qedn, struct qedn_llh_filter *llh_filter)
+{
+	if (!llh_filter)
+		return;
+
+	llh_filter->ref_cnt--;
+	if (!llh_filter->ref_cnt) {
+		list_del(&llh_filter->entry);
+
+		/* Remove LLH protocol port filter */
+		qed_ops->remove_src_tcp_port_filter(qedn->cdev, llh_filter->port);
+
+		--qedn->num_llh_filters;
+		kfree(llh_filter);
+		if (!qedn->num_llh_filters)
+			clear_bit(QEDN_STATE_LLH_PORT_FILTER_SET, &qedn->state);
+	}
+}
+
 static bool qedn_matches_qede(struct qedn_ctx *qedn, struct pci_dev *qede_pdev)
 {
 	struct pci_dev *qedn_pdev = qedn->pdev;
@@ -105,8 +180,10 @@ qedn_claim_dev(struct nvme_tcp_ofld_dev *dev,
 static int qedn_setup_ctrl(struct nvme_tcp_ofld_ctrl *ctrl, bool new)
 {
 	struct nvme_tcp_ofld_dev *dev = ctrl->dev;
+	struct qedn_llh_filter *llh_filter = NULL;
 	struct qedn_ctrl *qctrl = NULL;
 	struct qedn_ctx *qedn = NULL;
+	__be16 remote_port;
 	int rc = 0;
 
 	if (new) {
@@ -140,7 +217,22 @@ static int qedn_setup_ctrl(struct nvme_tcp_ofld_ctrl *ctrl, bool new)
 
 	qctrl->qedn = qedn;
 
-	/* Placeholder - setup LLH filter */
+	if (qedn->num_llh_filters == 0) {
+		qedn->mtu = dev->ndev->mtu;
+		memcpy(qedn->local_mac_addr, dev->ndev->dev_addr, ETH_ALEN);
+	}
+
+	remote_port = qedn_get_in_port(&ctrl->conn_params.remote_ip_addr);
+	if (new) {
+		llh_filter = qedn_add_llh_filter(qedn, ntohs(remote_port));
+		if (!llh_filter) {
+			rc = -EFAULT;
+			goto err_out;
+		}
+
+		qctrl->llh_filter = llh_filter;
+		set_bit(LLH_FILTER, &qctrl->agg_state);
+	}
 
 	return 0;
 
@@ -155,6 +247,12 @@ static int qedn_release_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 {
 	struct qedn_ctrl *qctrl = (struct qedn_ctrl *)ctrl->private_data;
 
+	if (test_and_clear_bit(LLH_FILTER, &qctrl->agg_state) &&
+	    qctrl->llh_filter) {
+		qedn_dec_llh_filter(qctrl->qedn, qctrl->llh_filter);
+		qctrl->llh_filter = NULL;
+	}
+
 	if (test_and_clear_bit(QEDN_STATE_SP_WORK_THREAD_SET, &qctrl->agg_state))
 		flush_workqueue(qctrl->sp_wq);
 
@@ -435,6 +533,8 @@ static int qedn_setup_irq(struct qedn_ctx *qedn)
 
 static inline void qedn_init_pf_struct(struct qedn_ctx *qedn)
 {
+	INIT_LIST_HEAD(&qedn->llh_filter_list);
+	qedn->num_llh_filters = 0;
 	hash_init(qedn->conn_ctx_hash);
 }
 
@@ -694,6 +794,12 @@ static void __qedn_remove(struct pci_dev *pdev)
 		return;
 	}
 
+	if (test_and_clear_bit(QEDN_STATE_LLH_PORT_FILTER_SET, &qedn->state)) {
+		pr_err("LLH port configuration removal. %d filters still set\n",
+		       qedn->num_llh_filters);
+		qed_ops->clear_all_filters(qedn->cdev);
+	}
+
 	if (test_and_clear_bit(QEDN_STATE_REGISTERED_OFFLOAD_DEV, &qedn->state))
 		nvme_tcp_ofld_unregister_dev(&qedn->qedn_ofld_dev);
 
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
