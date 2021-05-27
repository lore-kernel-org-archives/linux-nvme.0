Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DBAC4707F
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:18:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0622C613B4
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0622C613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=enHKLNVc0OI++SY3VvEB5+NcamlGGpQrUybLsV/uyEI=; b=B3yZ+8ljTHjJs/
	jUhWlZYP22BXPuQxSIKZOL6zi2H2cJK6viY0SNIWS4Bd39ERuUePIsNMb2612kp3s76G5Y1q9gZs6
	zooL37eFJkZBiYmuUGqGS//qO6wHw7DpAbKTIU8em6bDKwfkiji/e5jYLdk95yO4Ck3imfe3PTkWm
	GGXXWTz0wAVMG/G+N3CLfKNTch04JK4W4dMAWiejOvH0kLCbBICrkGHRcep/aWVHQxiXSJezVgS0S
	mU5TuXkJI1zvr4jOuqkbaBxaJO13fmHl9PSLxuCKUvZL+xKgIcXuGxzzxCxd0OSW2Z8FOOlDEO6UB
	/D9rOddQOZcwwDIuXKBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmQCu-00AX74-38; Fri, 28 May 2021 00:18:32 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmPwW-00AQGh-KG
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 00:01:38 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14S017qT024877; Thu, 27 May 2021 17:01:29 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 38t9e7tug9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 27 May 2021 17:01:29 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 May 2021 17:01:28 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 May 2021 17:01:24 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>, "Dean
 Balandin" <dbalandin@marvell.com>
Subject: [RFC PATCH v6 17/27] qedn: Add qedn probe
Date: Fri, 28 May 2021 02:58:52 +0300
Message-ID: <20210527235902.2185-18-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210527235902.2185-1-smalin@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: MVJs2a_OrLegswuEHm72BtyAAARyQRfh
X-Proofpoint-ORIG-GUID: MVJs2a_OrLegswuEHm72BtyAAARyQRfh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-27_13:2021-05-27,
 2021-05-27 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_170136_795284_E4131350 
X-CRM114-Status: GOOD (  19.53  )
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

This patch introduces the functionality of loading and unloading
physical function.
qedn_probe() loads the offload device PF(physical function), and
initialize the HW and the FW with the PF parameters using the
HW ops->qed_nvmetcp_ops, which are similar to other "qed_*_ops" which
are used by the qede, qedr, qedf and qedi device drivers.
qedn_remove() unloads the offload device PF, re-initialize the HW and
the FW with the PF parameters.

The struct qedn_ctx is per PF container for PF-specific attributes and
resources.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Dean Balandin <dbalandin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/hw/Kconfig          |   1 +
 drivers/nvme/hw/qedn/qedn.h      |  26 ++++++
 drivers/nvme/hw/qedn/qedn_main.c | 155 ++++++++++++++++++++++++++++++-
 3 files changed, 177 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/hw/Kconfig b/drivers/nvme/hw/Kconfig
index 374f1f9dbd3d..91b1bd6f07d8 100644
--- a/drivers/nvme/hw/Kconfig
+++ b/drivers/nvme/hw/Kconfig
@@ -2,6 +2,7 @@
 config NVME_QEDN
 	tristate "Marvell NVM Express over Fabrics TCP offload"
 	depends on NVME_TCP_OFFLOAD
+	select QED_NVMETCP
 	help
 	  This enables the Marvell NVMe TCP offload support (qedn).
 
diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index bcd0748a10fd..931efc3afbaa 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -6,14 +6,40 @@
 #ifndef _QEDN_H_
 #define _QEDN_H_
 
+#include <linux/qed/qed_if.h>
+#include <linux/qed/qed_nvmetcp_if.h>
+
 /* Driver includes */
 #include "../../host/tcp-offload.h"
 
 #define QEDN_MODULE_NAME "qedn"
 
+#define QEDN_MAX_TASKS_PER_PF (16 * 1024)
+#define QEDN_MAX_CONNS_PER_PF (4 * 1024)
+#define QEDN_FW_CQ_SIZE (4 * 1024)
+#define QEDN_PROTO_CQ_PROD_IDX	0
+#define QEDN_NVMETCP_NUM_FW_CONN_QUEUE_PAGES 2
+
+enum qedn_state {
+	QEDN_STATE_CORE_PROBED = 0,
+	QEDN_STATE_CORE_OPEN,
+	QEDN_STATE_MFW_STATE,
+	QEDN_STATE_REGISTERED_OFFLOAD_DEV,
+	QEDN_STATE_MODULE_REMOVE_ONGOING,
+};
+
 struct qedn_ctx {
 	struct pci_dev *pdev;
+	struct qed_dev *cdev;
+	struct qed_dev_nvmetcp_info dev_info;
 	struct nvme_tcp_ofld_dev qedn_ofld_dev;
+	struct qed_pf_params pf_params;
+
+	/* Accessed with atomic bit ops, used with enum qedn_state */
+	unsigned long state;
+
+	/* Fast path queues */
+	u8 num_fw_cqs;
 };
 
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index fbf27ab93872..1888c72805cb 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -14,6 +14,9 @@
 
 #define CHIP_NUM_AHP_NVMETCP 0x8194
 
+const struct qed_nvmetcp_ops *qed_ops;
+
+/* Global context instance */
 static struct pci_device_id qedn_pci_tbl[] = {
 	{ PCI_VDEVICE(QLOGIC, CHIP_NUM_AHP_NVMETCP), 0 },
 	{0, 0},
@@ -98,12 +101,109 @@ static struct nvme_tcp_ofld_ops qedn_ofld_ops = {
 	.send_req = qedn_send_req,
 };
 
+static inline void qedn_init_pf_struct(struct qedn_ctx *qedn)
+{
+	/* Placeholder - Initialize qedn fields */
+}
+
+static inline void
+qedn_init_core_probe_params(struct qed_probe_params *probe_params)
+{
+	memset(probe_params, 0, sizeof(*probe_params));
+	probe_params->protocol = QED_PROTOCOL_NVMETCP;
+	probe_params->is_vf = false;
+	probe_params->recov_in_prog = 0;
+}
+
+static inline int qedn_core_probe(struct qedn_ctx *qedn)
+{
+	struct qed_probe_params probe_params;
+	int rc = 0;
+
+	qedn_init_core_probe_params(&probe_params);
+	pr_info("Starting QED probe\n");
+	qedn->cdev = qed_ops->common->probe(qedn->pdev, &probe_params);
+	if (!qedn->cdev) {
+		rc = -ENODEV;
+		pr_err("QED probe failed\n");
+	}
+
+	return rc;
+}
+
+static int qedn_set_nvmetcp_pf_param(struct qedn_ctx *qedn)
+{
+	u32 fw_conn_queue_pages = QEDN_NVMETCP_NUM_FW_CONN_QUEUE_PAGES;
+	struct qed_nvmetcp_pf_params *pf_params;
+
+	pf_params = &qedn->pf_params.nvmetcp_pf_params;
+	memset(pf_params, 0, sizeof(*pf_params));
+	qedn->num_fw_cqs = min_t(u8, qedn->dev_info.num_cqs, num_online_cpus());
+
+	pf_params->num_cons = QEDN_MAX_CONNS_PER_PF;
+	pf_params->num_tasks = QEDN_MAX_TASKS_PER_PF;
+
+	/* Placeholder - Initialize function level queues */
+
+	/* Placeholder - Initialize TCP params */
+
+	/* Queues */
+	pf_params->num_sq_pages_in_ring = fw_conn_queue_pages;
+	pf_params->num_r2tq_pages_in_ring = fw_conn_queue_pages;
+	pf_params->num_uhq_pages_in_ring = fw_conn_queue_pages;
+	pf_params->num_queues = qedn->num_fw_cqs;
+	pf_params->cq_num_entries = QEDN_FW_CQ_SIZE;
+
+	/* the CQ SB pi */
+	pf_params->gl_rq_pi = QEDN_PROTO_CQ_PROD_IDX;
+
+	return 0;
+}
+
+static inline int qedn_slowpath_start(struct qedn_ctx *qedn)
+{
+	struct qed_slowpath_params sp_params = {};
+	int rc = 0;
+
+	/* Start the Slowpath-process */
+	sp_params.int_mode = QED_INT_MODE_MSIX;
+	strscpy(sp_params.name, "qedn NVMeTCP", QED_DRV_VER_STR_SIZE);
+	rc = qed_ops->common->slowpath_start(qedn->cdev, &sp_params);
+	if (rc)
+		pr_err("Cannot start slowpath\n");
+
+	return rc;
+}
+
 static void __qedn_remove(struct pci_dev *pdev)
 {
 	struct qedn_ctx *qedn = pci_get_drvdata(pdev);
+	int rc;
+
+	pr_notice("Starting qedn_remove: abs PF id=%u\n",
+		  qedn->dev_info.common.abs_pf_id);
+
+	if (test_and_set_bit(QEDN_STATE_MODULE_REMOVE_ONGOING, &qedn->state)) {
+		pr_err("Remove already ongoing\n");
+
+		return;
+	}
+
+	if (test_and_clear_bit(QEDN_STATE_REGISTERED_OFFLOAD_DEV, &qedn->state))
+		nvme_tcp_ofld_unregister_dev(&qedn->qedn_ofld_dev);
+
+	if (test_and_clear_bit(QEDN_STATE_MFW_STATE, &qedn->state)) {
+		rc = qed_ops->common->update_drv_state(qedn->cdev, false);
+		if (rc)
+			pr_err("Failed to send drv state to MFW\n");
+	}
+
+	if (test_and_clear_bit(QEDN_STATE_CORE_OPEN, &qedn->state))
+		qed_ops->common->slowpath_stop(qedn->cdev);
+
+	if (test_and_clear_bit(QEDN_STATE_CORE_PROBED, &qedn->state))
+		qed_ops->common->remove(qedn->cdev);
 
-	pr_notice("Starting qedn_remove\n");
-	nvme_tcp_ofld_unregister_dev(&qedn->qedn_ofld_dev);
 	kfree(qedn);
 	pr_notice("Ending qedn_remove successfully\n");
 }
@@ -143,15 +243,52 @@ static int __qedn_probe(struct pci_dev *pdev)
 	if (!qedn)
 		return -ENODEV;
 
+	qedn_init_pf_struct(qedn);
+
+	/* QED probe */
+	rc = qedn_core_probe(qedn);
+	if (rc)
+		goto exit_probe_and_release_mem;
+
+	set_bit(QEDN_STATE_CORE_PROBED, &qedn->state);
+
+	rc = qed_ops->fill_dev_info(qedn->cdev, &qedn->dev_info);
+	if (rc) {
+		pr_err("fill_dev_info failed\n");
+		goto exit_probe_and_release_mem;
+	}
+
+	rc = qedn_set_nvmetcp_pf_param(qedn);
+	if (rc)
+		goto exit_probe_and_release_mem;
+
+	qed_ops->common->update_pf_params(qedn->cdev, &qedn->pf_params);
+	rc = qedn_slowpath_start(qedn);
+	if (rc)
+		goto exit_probe_and_release_mem;
+
+	set_bit(QEDN_STATE_CORE_OPEN, &qedn->state);
+
+	rc = qed_ops->common->update_drv_state(qedn->cdev, true);
+	if (rc) {
+		pr_err("Failed to send drv state to MFW\n");
+		goto exit_probe_and_release_mem;
+	}
+
+	set_bit(QEDN_STATE_MFW_STATE, &qedn->state);
+
 	qedn->qedn_ofld_dev.ops = &qedn_ofld_ops;
 	INIT_LIST_HEAD(&qedn->qedn_ofld_dev.entry);
 	rc = nvme_tcp_ofld_register_dev(&qedn->qedn_ofld_dev);
 	if (rc)
-		goto release_qedn;
+		goto exit_probe_and_release_mem;
+
+	set_bit(QEDN_STATE_REGISTERED_OFFLOAD_DEV, &qedn->state);
 
 	return 0;
-release_qedn:
-	kfree(qedn);
+exit_probe_and_release_mem:
+	__qedn_remove(pdev);
+	pr_err("probe ended with error\n");
 
 	return rc;
 }
@@ -173,6 +310,13 @@ static int __init qedn_init(void)
 {
 	int rc;
 
+	qed_ops = qed_get_nvmetcp_ops();
+	if (!qed_ops) {
+		pr_err("Failed to get QED NVMeTCP ops\n");
+
+		return -EINVAL;
+	}
+
 	rc = pci_register_driver(&qedn_pci_driver);
 	if (rc) {
 		pr_err("Failed to register pci driver\n");
@@ -188,6 +332,7 @@ static int __init qedn_init(void)
 static void __exit qedn_cleanup(void)
 {
 	pci_unregister_driver(&qedn_pci_driver);
+	qed_put_nvmetcp_ops();
 	pr_notice("Unloading qedn ended\n");
 }
 
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
