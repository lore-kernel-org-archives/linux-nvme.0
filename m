Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E186BC11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:58:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B188961DF1
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B188961DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=moVwXZdGp72NAWWcf7IJFeIyfjewrvhKAhhakmQ/TTs=; b=AJHP8+EvR16W0d
	g3Bth48zCPeLR5CSWx7zLTAQoym7oSo8pKvc4PJCF04e637acIRag2lcZnD4sfjE/wyRm8Cer013k
	J7kriKl40rqQGJHEFfytSPi20FbAq3YDzR9XJji1ZCvCJhWz9XR284s3hcwfzGaP2N82tVAvRKDKB
	X0AbHwNZCjR/jaNXps1kANvIkoKhEWaa0cmvc/yLgzJ805uIeebdO2tuzq9pm+InGZlWI4ohuyVJn
	9cEz1hgPpsKnJSscyEcAShY5k59UkUJHzUba5wYby8AhQZ5isl4CqpyFe8jSij5VGXGrJ7tvIYoFs
	amRfq4GlYyTAFUwd3k4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyDJx-00AuzD-Rm; Tue, 29 Jun 2021 12:58:33 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyDAk-00AsOe-5b
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 12:49:03 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15TCjMra014062; Tue, 29 Jun 2021 05:48:55 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 39f964dupk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 29 Jun 2021 05:48:55 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 29 Jun 2021 05:48:53 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Tue, 29 Jun 2021 05:48:50 -0700
From: Prabhakar Kushwaha <pkushwaha@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
 <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH v4 14/20] qedn: Add support of configuring HW filter block
Date: Tue, 29 Jun 2021 15:47:37 +0300
Message-ID: <20210629124743.6898-15-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210629124743.6898-1-pkushwaha@marvell.com>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 4hXYivYFM4156x52kWxZ1NBQ1tforgy1
X-Proofpoint-GUID: 4hXYivYFM4156x52kWxZ1NBQ1tforgy1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-29_06:2021-06-28,
 2021-06-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_054902_379809_226928E7 
X-CRM114-Status: GOOD (  19.51  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/hw/qedn/qedn.h      |  15 ++++
 drivers/nvme/hw/qedn/qedn_main.c | 113 ++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index 38ab4ff88999..9e16297fa323 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -29,6 +29,11 @@
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
@@ -68,6 +73,7 @@
 enum qedn_state {
 	QEDN_STATE_CORE_PROBED = 0,
 	QEDN_STATE_CORE_OPEN,
+	QEDN_STATE_LLH_PORT_FILTER_SET,
 	QEDN_STATE_MFW_STATE,
 	QEDN_STATE_NVMETCP_OPEN,
 	QEDN_STATE_IRQ_SET,
@@ -99,6 +105,8 @@ struct qedn_ctx {
 	/* Accessed with atomic bit ops, used with enum qedn_state */
 	unsigned long state;
 
+	u8 num_llh_filters;
+	struct list_head llh_filter_list;
 	u8 local_mac_addr[ETH_ALEN];
 	u16 mtu;
 
@@ -165,6 +173,12 @@ enum qedn_conn_state {
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
@@ -249,5 +263,6 @@ int qedn_set_con_state(struct qedn_conn_ctx *conn_ctx,
 		       enum qedn_conn_state new_state);
 void qedn_terminate_connection(struct qedn_conn_ctx *conn_ctx);
 void qedn_cleanp_fw(struct qedn_conn_ctx *conn_ctx);
+__be16 qedn_get_in_port(struct sockaddr_storage *sa);
 
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index bd5618f65c70..3cadec6d6f5d 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -22,6 +22,86 @@ static struct pci_device_id qedn_pci_tbl[] = {
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
+	list_for_each_entry_safe(llh_filter, llh_tmp, &qedn->llh_filter_list,
+				 entry) {
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
+			pr_err("LLH port config failed. port:%u; rc:%u\n",
+			       tcp_port, rc);
+
+			return NULL;
+		}
+
+		llh_filter = kzalloc(sizeof(*llh_filter), GFP_KERNEL);
+		if (!llh_filter) {
+			qed_ops->remove_src_tcp_port_filter(qedn->cdev,
+							    tcp_port);
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
+void qedn_dec_llh_filter(struct qedn_ctx *qedn,
+			 struct qedn_llh_filter *llh_filter)
+{
+	if (!llh_filter)
+		return;
+
+	llh_filter->ref_cnt--;
+	if (!llh_filter->ref_cnt) {
+		list_del(&llh_filter->entry);
+
+		/* Remove LLH protocol port filter */
+		qed_ops->remove_src_tcp_port_filter(qedn->cdev,
+						    llh_filter->port);
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
@@ -107,8 +187,10 @@ qedn_claim_dev(struct nvme_tcp_ofld_dev *dev,
 static int qedn_setup_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 {
 	struct nvme_tcp_ofld_dev *dev = ctrl->dev;
+	struct qedn_llh_filter *llh_filter = NULL;
 	struct qedn_ctrl *qctrl = NULL;
 	struct qedn_ctx *qedn = NULL;
+	__be16 remote_port;
 	bool new = true;
 	int rc = 0;
 
@@ -147,7 +229,22 @@ static int qedn_setup_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 	qedn = container_of(dev, struct qedn_ctx, qedn_ofld_dev);
 	qctrl->qedn = qedn;
 
-	/* Placeholder - setup LLH filter */
+	if (qedn->num_llh_filters == 0) {
+		qedn->mtu = ctrl->ndev->mtu;
+		memcpy(qedn->local_mac_addr, ctrl->ndev->dev_addr, ETH_ALEN);
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
 err_out:
@@ -165,6 +262,12 @@ static int qedn_release_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
 	if (!qctrl)
 		return -ENODEV;
 
+	if (test_and_clear_bit(LLH_FILTER, &qctrl->agg_state) &&
+	    qctrl->llh_filter) {
+		qedn_dec_llh_filter(qctrl->qedn, qctrl->llh_filter);
+		qctrl->llh_filter = NULL;
+	}
+
 	if (test_and_clear_bit(QEDN_STATE_SP_WORK_THREAD_SET,
 			       &qctrl->agg_state))
 		flush_workqueue(qctrl->sp_wq);
@@ -446,6 +549,8 @@ static int qedn_setup_irq(struct qedn_ctx *qedn)
 
 static inline void qedn_init_pf_struct(struct qedn_ctx *qedn)
 {
+	INIT_LIST_HEAD(&qedn->llh_filter_list);
+	qedn->num_llh_filters = 0;
 	hash_init(qedn->conn_ctx_hash);
 }
 
@@ -688,6 +793,12 @@ static void __qedn_remove(struct pci_dev *pdev)
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
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
