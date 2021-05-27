Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9915AC47089
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:17:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532A1613B4
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532A1613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2k7daeFvHLY1r+Llvuwqzwf0F2J+a4OlA0GdCAoO2a8=; b=2nFvPZhydtosNV
	EGLJeLK82oM1ZygIGynMPmRzziix5HDD7ZTEYwa8W/M9KnJkXozRQO8M7MonNKqlzHFEIPu7Rk2Ei
	drJ7GqIMAf7KbT/MFj5+pKd7Jv5tB/gRC4nvVKebRSNbja7xmhPgoAoYynEKm+7i00Od/8VHk4MpU
	5fMDMrxYL4TIaPy/EeLHJ/Aba/j0R4FlVOF3FCESkA2e/dZ08AW5Eh/uBB5B7CKdbJD62feNEfAEX
	FtbTtLHj6as4HoYKWYk/xwhgPRt/2fC0909ZujEhqckyFStef3t0qPcST5YSSiyLO4SVj/i4+Sayg
	Krz8vqBi8j9tEq9Bec6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmQAl-00AWPY-6O; Fri, 28 May 2021 00:16:19 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmPwP-00AQD6-Tt
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 00:01:32 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14S01Asx024935; Thu, 27 May 2021 17:01:25 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 38t9e7tufw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 27 May 2021 17:01:25 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 May 2021 17:01:23 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 May 2021 17:01:20 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>, "Arie
 Gershberg" <agershberg@marvell.com>
Subject: [RFC PATCH v6 16/27] qedn: Add qedn - Marvell's NVMeTCP HW offload
 vendor driver
Date: Fri, 28 May 2021 02:58:51 +0300
Message-ID: <20210527235902.2185-17-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210527235902.2185-1-smalin@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: R1YZISGDsIb5xSdhOzUxpDzYhYLJr0He
X-Proofpoint-ORIG-GUID: R1YZISGDsIb5xSdhOzUxpDzYhYLJr0He
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-27_13:2021-05-27,
 2021-05-27 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_170130_021690_DC36A495 
X-CRM114-Status: GOOD (  22.66  )
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

This patch will present the skeleton of the qedn driver.
The new driver will be added under "drivers/nvme/hw/qedn" and will be
enabled by the Kconfig "Marvell NVM Express over Fabrics TCP offload".

The internal implementation:
- qedn.h:
  Includes all common structs to be used by the qedn vendor driver.

- qedn_main.c
  Includes the qedn_init and qedn_cleanup implementation.
  As part of the qedn init, the driver will register as a pci device and
  will work with the Marvell fastlinQ NICs.
  As part of the probe, the driver will register to the nvme_tcp_offload
  (ULP).

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Arie Gershberg <agershberg@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 MAINTAINERS                      |  10 ++
 drivers/nvme/Kconfig             |   1 +
 drivers/nvme/Makefile            |   1 +
 drivers/nvme/hw/Kconfig          |   8 ++
 drivers/nvme/hw/Makefile         |   3 +
 drivers/nvme/hw/qedn/Makefile    |   5 +
 drivers/nvme/hw/qedn/qedn.h      |  19 +++
 drivers/nvme/hw/qedn/qedn_main.c | 200 +++++++++++++++++++++++++++++++
 8 files changed, 247 insertions(+)
 create mode 100644 drivers/nvme/hw/Kconfig
 create mode 100644 drivers/nvme/hw/Makefile
 create mode 100644 drivers/nvme/hw/qedn/Makefile
 create mode 100644 drivers/nvme/hw/qedn/qedn.h
 create mode 100644 drivers/nvme/hw/qedn/qedn_main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fbc349ab219..7a6d5963f6fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15012,6 +15012,16 @@ S:	Supported
 F:	drivers/infiniband/hw/qedr/
 F:	include/uapi/rdma/qedr-abi.h
 
+QLOGIC QL4xxx NVME-TCP-OFFLOAD DRIVER
+M:	Shai Malin <smalin@marvell.com>
+M:	Ariel Elior <aelior@marvell.com>
+L:	linux-nvme@lists.infradead.org
+S:	Supported
+W:	http://git.infradead.org/nvme.git
+T:	git://git.infradead.org/nvme.git
+F:	drivers/nvme/hw/qedn/
+F:	include/linux/qed/
+
 QLOGIC QLA1280 SCSI DRIVER
 M:	Michael Reed <mdr@sgi.com>
 L:	linux-scsi@vger.kernel.org
diff --git a/drivers/nvme/Kconfig b/drivers/nvme/Kconfig
index 87ae409a32b9..827c2c9f0ad1 100644
--- a/drivers/nvme/Kconfig
+++ b/drivers/nvme/Kconfig
@@ -3,5 +3,6 @@ menu "NVME Support"
 
 source "drivers/nvme/host/Kconfig"
 source "drivers/nvme/target/Kconfig"
+source "drivers/nvme/hw/Kconfig"
 
 endmenu
diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index fb42c44609a8..14c569040ef2 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -2,3 +2,4 @@
 
 obj-y		+= host/
 obj-y		+= target/
+obj-y		+= hw/
\ No newline at end of file
diff --git a/drivers/nvme/hw/Kconfig b/drivers/nvme/hw/Kconfig
new file mode 100644
index 000000000000..374f1f9dbd3d
--- /dev/null
+++ b/drivers/nvme/hw/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NVME_QEDN
+	tristate "Marvell NVM Express over Fabrics TCP offload"
+	depends on NVME_TCP_OFFLOAD
+	help
+	  This enables the Marvell NVMe TCP offload support (qedn).
+
+	  If unsure, say N.
diff --git a/drivers/nvme/hw/Makefile b/drivers/nvme/hw/Makefile
new file mode 100644
index 000000000000..2f38e0520795
--- /dev/null
+++ b/drivers/nvme/hw/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_NVME_QEDN)		+= qedn/
diff --git a/drivers/nvme/hw/qedn/Makefile b/drivers/nvme/hw/qedn/Makefile
new file mode 100644
index 000000000000..1422cd878680
--- /dev/null
+++ b/drivers/nvme/hw/qedn/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_NVME_QEDN) := qedn.o
+
+qedn-y := qedn_main.o
diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
new file mode 100644
index 000000000000..bcd0748a10fd
--- /dev/null
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2021 Marvell. All rights reserved.
+ */
+
+#ifndef _QEDN_H_
+#define _QEDN_H_
+
+/* Driver includes */
+#include "../../host/tcp-offload.h"
+
+#define QEDN_MODULE_NAME "qedn"
+
+struct qedn_ctx {
+	struct pci_dev *pdev;
+	struct nvme_tcp_ofld_dev qedn_ofld_dev;
+};
+
+#endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
new file mode 100644
index 000000000000..fbf27ab93872
--- /dev/null
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -0,0 +1,200 @@
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
+
+/* Driver includes */
+#include "qedn.h"
+
+#define CHIP_NUM_AHP_NVMETCP 0x8194
+
+static struct pci_device_id qedn_pci_tbl[] = {
+	{ PCI_VDEVICE(QLOGIC, CHIP_NUM_AHP_NVMETCP), 0 },
+	{0, 0},
+};
+
+static int
+qedn_claim_dev(struct nvme_tcp_ofld_dev *dev,
+	       struct nvme_tcp_ofld_ctrl_con_params *conn_params)
+{
+	/* Placeholder - qedn_claim_dev */
+
+	return 0;
+}
+
+static int qedn_setup_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
+{
+	/* Placeholder - qedn_setup_ctrl */
+
+	return 0;
+}
+
+static int qedn_release_ctrl(struct nvme_tcp_ofld_ctrl *ctrl)
+{
+	/* Placeholder - qedn_release_ctrl */
+
+	return 0;
+}
+
+static int qedn_create_queue(struct nvme_tcp_ofld_queue *queue, int qid,
+			     size_t queue_size)
+{
+	/* Placeholder - qedn_create_queue */
+
+	return 0;
+}
+
+static void qedn_drain_queue(struct nvme_tcp_ofld_queue *queue)
+{
+	/* Placeholder - qedn_drain_queue */
+}
+
+static void qedn_destroy_queue(struct nvme_tcp_ofld_queue *queue)
+{
+	/* Placeholder - qedn_destroy_queue */
+}
+
+static int qedn_poll_queue(struct nvme_tcp_ofld_queue *queue)
+{
+	/*
+	 * Poll queue support will be added as part of future
+	 * enhancements.
+	 */
+
+	return 0;
+}
+
+static int qedn_send_req(struct nvme_tcp_ofld_req *req)
+{
+	/* Placeholder - qedn_send_req */
+
+	return 0;
+}
+
+static struct nvme_tcp_ofld_ops qedn_ofld_ops = {
+	.name = "qedn",
+	.module = THIS_MODULE,
+	.required_opts = NVMF_OPT_TRADDR,
+	.allowed_opts = NVMF_OPT_TRSVCID | NVMF_OPT_NR_WRITE_QUEUES |
+			NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
+			NVMF_OPT_RECONNECT_DELAY,
+		/* These flags will be as part of future enhancements
+		 *	NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
+		 *	NVMF_OPT_NR_POLL_QUEUES | NVMF_OPT_TOS
+		 */
+	.claim_dev = qedn_claim_dev,
+	.setup_ctrl = qedn_setup_ctrl,
+	.release_ctrl = qedn_release_ctrl,
+	.create_queue = qedn_create_queue,
+	.drain_queue = qedn_drain_queue,
+	.destroy_queue = qedn_destroy_queue,
+	.poll_queue = qedn_poll_queue,
+	.send_req = qedn_send_req,
+};
+
+static void __qedn_remove(struct pci_dev *pdev)
+{
+	struct qedn_ctx *qedn = pci_get_drvdata(pdev);
+
+	pr_notice("Starting qedn_remove\n");
+	nvme_tcp_ofld_unregister_dev(&qedn->qedn_ofld_dev);
+	kfree(qedn);
+	pr_notice("Ending qedn_remove successfully\n");
+}
+
+static void qedn_remove(struct pci_dev *pdev)
+{
+	__qedn_remove(pdev);
+}
+
+static void qedn_shutdown(struct pci_dev *pdev)
+{
+	__qedn_remove(pdev);
+}
+
+static struct qedn_ctx *qedn_alloc_ctx(struct pci_dev *pdev)
+{
+	struct qedn_ctx *qedn = NULL;
+
+	qedn = kzalloc(sizeof(*qedn), GFP_KERNEL);
+	if (!qedn)
+		return NULL;
+
+	qedn->pdev = pdev;
+	pci_set_drvdata(pdev, qedn);
+
+	return qedn;
+}
+
+static int __qedn_probe(struct pci_dev *pdev)
+{
+	struct qedn_ctx *qedn;
+	int rc;
+
+	pr_notice("Starting qedn probe\n");
+
+	qedn = qedn_alloc_ctx(pdev);
+	if (!qedn)
+		return -ENODEV;
+
+	qedn->qedn_ofld_dev.ops = &qedn_ofld_ops;
+	INIT_LIST_HEAD(&qedn->qedn_ofld_dev.entry);
+	rc = nvme_tcp_ofld_register_dev(&qedn->qedn_ofld_dev);
+	if (rc)
+		goto release_qedn;
+
+	return 0;
+release_qedn:
+	kfree(qedn);
+
+	return rc;
+}
+
+static int qedn_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	return __qedn_probe(pdev);
+}
+
+static struct pci_driver qedn_pci_driver = {
+	.name     = QEDN_MODULE_NAME,
+	.id_table = qedn_pci_tbl,
+	.probe    = qedn_probe,
+	.remove   = qedn_remove,
+	.shutdown = qedn_shutdown,
+};
+
+static int __init qedn_init(void)
+{
+	int rc;
+
+	rc = pci_register_driver(&qedn_pci_driver);
+	if (rc) {
+		pr_err("Failed to register pci driver\n");
+
+		return -EINVAL;
+	}
+
+	pr_notice("driver loaded successfully\n");
+
+	return 0;
+}
+
+static void __exit qedn_cleanup(void)
+{
+	pci_unregister_driver(&qedn_pci_driver);
+	pr_notice("Unloading qedn ended\n");
+}
+
+module_init(qedn_init);
+module_exit(qedn_cleanup);
+
+MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: qede nvme-fabrics nvme-tcp-offload");
+MODULE_DESCRIPTION("Marvell 25/50/100G NVMe-TCP Offload Host Driver");
+MODULE_AUTHOR("Marvell");
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
