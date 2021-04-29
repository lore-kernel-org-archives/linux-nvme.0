Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE76C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:29:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E2261459
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E2261459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=swRABDmv2t/7npopdTTlIUyoImDztkpudMZw6zt7FiA=; b=msjpx+9ybjBt0gXJ7Xfo8N1Pr
	Mz8Vz3eitsy4Evki7w9vME9hmYcmjrrI4Gu0NdDFICMhqXYycK2AvghKhzB7LzfEDfjXhz24FnZSj
	xZY7vR1dChKTIcnYNXahO44zGzFhqrkEcxyk7WX6LmCIF9rwEUcvAp+rJUbVTqB025aDgJVu/9Q7n
	fepvEMeopv6ApZY25KU8mEi6qfSvN/+dNhDjVmO7ty+cId4GYHkyZsNnwHVmgnqRsZgbRGJr8mCLL
	dCCBBh5eIxGsF+oO2HHIsqEvNI4Dstm5bXxbZvsq7l3n5hWI9dyV2ih/zgxAy0mcbCgyDWPul8ntN
	ZQXy35vZw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcCLU-006IBc-4B; Thu, 29 Apr 2021 19:29:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC3t-006FVq-54
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 19:10:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8U4H/+xM6DbgKHZfLVIF5yRMgVhc2ROQ4HQ5RH1V5lc=; b=1oHSMa9dFegExQtbYXpxoSXEzt
 UevHzsZpQB2zytWImL5GgGcQqs5g7ZznPgrFYbuDeyNsElYB8c3EwPIx749SYzrZbjdxjtjAA2F3m
 Emk0ljped6tzIJ5AzvBMQWxHGaz1NrgUEVYdzfTMsAFNW59OEfJQsLGfi9m4ipY21A3q4Qlr6ARxP
 kX0S+Pygss6giYHd0JqmQJ5IHumz1pfcY/p4en0zfaqDZkEOH4wt9SDp35SN8VajS8moNUz+q96cz
 qHF+NpqZ/DKIgoxDaLYRN2ldg7VC/J+rp4rRArnz9OU4ApK4ltflCVrpx82Yv8oMwSh/Pa6bpvbQm
 ZYLATbPQ==;
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC3q-000sfX-2W
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 19:10:55 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13TJ6QMA019652; Thu, 29 Apr 2021 12:10:50 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 387erumw45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 29 Apr 2021 12:10:50 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 29 Apr 2021 12:10:49 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 29 Apr 2021 12:10:45 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: =?UTF-8?q?David=20S=20=2E=20Miller=20davem=20=40=20davemloft=20=2E=20net=20=C2=A0--cc=3DJakub=20Kicinski?=
 <kuba@kernel.org>,
 <smalin@marvell.com>, <aelior@marvell.com>, <mkalderon@marvell.com>,
 <okulkarni@marvell.com>, <pkushwaha@marvell.com>,
 <malin1024@gmail.com>, Dean Balandin <dbalandin@marvell.com>
Subject: [RFC PATCH v4 17/27] qedn: Add qedn probe
Date: Thu, 29 Apr 2021 22:09:16 +0300
Message-ID: <20210429190926.5086-18-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210429190926.5086-1-smalin@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: g1PNubqQ7GSJ8LU2bhX4l93vhmq6_n98
X-Proofpoint-ORIG-GUID: g1PNubqQ7GSJ8LU2bhX4l93vhmq6_n98
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-29_10:2021-04-28,
 2021-04-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_121054_147426_91C4D260 
X-CRM114-Status: GOOD (  21.11  )
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
---
 drivers/nvme/hw/Kconfig          |   1 +
 drivers/nvme/hw/qedn/qedn.h      |  49 ++++++++
 drivers/nvme/hw/qedn/qedn_main.c | 191 ++++++++++++++++++++++++++++++-
 3 files changed, 236 insertions(+), 5 deletions(-)

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
index bcd0748a10fd..c1ac17eabcb7 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -6,14 +6,63 @@
 #ifndef _QEDN_H_
 #define _QEDN_H_
 
+#include <linux/qed/qed_if.h>
+#include <linux/qed/qed_nvmetcp_if.h>
+
 /* Driver includes */
 #include "../../host/tcp-offload.h"
 
+#define QEDN_MAJOR_VERSION		8
+#define QEDN_MINOR_VERSION		62
+#define QEDN_REVISION_VERSION		10
+#define QEDN_ENGINEERING_VERSION	0
+#define DRV_MODULE_VERSION __stringify(QEDE_MAJOR_VERSION) "."	\
+		__stringify(QEDE_MINOR_VERSION) "."		\
+		__stringify(QEDE_REVISION_VERSION) "."		\
+		__stringify(QEDE_ENGINEERING_VERSION)
+
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
+	QEDN_STATE_GL_PF_LIST_ADDED,
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
+	/* Global PF list entry */
+	struct list_head gl_pf_entry;
+
+	/* Accessed with atomic bit ops, used with enum qedn_state */
+	unsigned long state;
+
+	/* Fast path queues */
+	u8 num_fw_cqs;
+};
+
+struct qedn_global {
+	struct list_head qedn_pf_list;
+
+	/* Host mode */
+	struct list_head ctrl_list;
+
+	/* Mutex for accessing the global struct */
+	struct mutex glb_mutex;
 };
 
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index 31d6d86d6eb7..e3e8e3676b79 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -14,6 +14,10 @@
 
 #define CHIP_NUM_AHP_NVMETCP 0x8194
 
+const struct qed_nvmetcp_ops *qed_ops;
+
+/* Global context instance */
+struct qedn_global qedn_glb;
 static struct pci_device_id qedn_pci_tbl[] = {
 	{ PCI_VDEVICE(QLOGIC, CHIP_NUM_AHP_NVMETCP), 0 },
 	{0, 0},
@@ -99,12 +103,132 @@ static struct nvme_tcp_ofld_ops qedn_ofld_ops = {
 	.commit_rqs = qedn_commit_rqs,
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
+static void qedn_add_pf_to_gl_list(struct qedn_ctx *qedn)
+{
+	mutex_lock(&qedn_glb.glb_mutex);
+	list_add_tail(&qedn->gl_pf_entry, &qedn_glb.qedn_pf_list);
+	mutex_unlock(&qedn_glb.glb_mutex);
+}
+
+static void qedn_remove_pf_from_gl_list(struct qedn_ctx *qedn)
+{
+	mutex_lock(&qedn_glb.glb_mutex);
+	list_del_init(&qedn->gl_pf_entry);
+	mutex_unlock(&qedn_glb.glb_mutex);
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
+	sp_params.drv_major = QEDN_MAJOR_VERSION;
+	sp_params.drv_minor = QEDN_MINOR_VERSION;
+	sp_params.drv_rev = QEDN_REVISION_VERSION;
+	sp_params.drv_eng = QEDN_ENGINEERING_VERSION;
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
+	pr_notice("qedn remove started: abs PF id=%u\n",
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
+	if (test_and_clear_bit(QEDN_STATE_GL_PF_LIST_ADDED, &qedn->state))
+		qedn_remove_pf_from_gl_list(qedn);
+	else
+		pr_err("Failed to remove from global PF list\n");
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
@@ -144,15 +268,55 @@ static int __qedn_probe(struct pci_dev *pdev)
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
+	qedn_add_pf_to_gl_list(qedn);
+	set_bit(QEDN_STATE_GL_PF_LIST_ADDED, &qedn->state);
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
@@ -170,10 +334,26 @@ static struct pci_driver qedn_pci_driver = {
 	.shutdown = qedn_shutdown,
 };
 
+static inline void qedn_init_global_contxt(void)
+{
+	INIT_LIST_HEAD(&qedn_glb.qedn_pf_list);
+	INIT_LIST_HEAD(&qedn_glb.ctrl_list);
+	mutex_init(&qedn_glb.glb_mutex);
+}
+
 static int __init qedn_init(void)
 {
 	int rc;
 
+	qedn_init_global_contxt();
+
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
@@ -189,6 +369,7 @@ static int __init qedn_init(void)
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
