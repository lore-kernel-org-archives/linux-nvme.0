Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8BC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:15:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12766135B
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12766135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aiXJIvaNleAcA95ExSrkjCOYSMQgd5YeQUZ54aYI93Y=; b=EDSO4yXvvPuhvZAO1D2JfkhM7
	W6MaoJQi8GEw/T0S/mgmLWpn4Af86WCi2kvZPgPoPPpXRuf4GHQUdKU3TMLOFSb6AZk/kFz73l7G2
	v3CKsyyJuQmWnenRr2zuDkTA/mLj1vLwixBSz5Otuv9pZSS/27k7zC0oMyWly/034V1SubFj5h/OV
	yldB5r9f4T1Ha7eS6ChsiPpEzYvrjokP8NRrpDw8Avf+lRtDq6LeReoEzw/OrZnABOf7q/Rpvh5wG
	2bJPDcH+vZcEyqu+x990cJNSTfniS6SSd6ZSDvomFd2paKvQ9YCM95PqjLhAaQ6g5uxPV/+U+zOc/
	Zmnml2tpw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljKAi-003j7N-6f; Wed, 19 May 2021 11:15:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKA8-003j2B-3o
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 11:14:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4CU0BuPOHBHFCOvt0XHKHVIsVqseOvKbfFCKmK4fWCU=; b=rBBHNaIh34rHAg24h+PG2tryAi
 7dgCT1Y7HoYvrPrWQa0L0fYO66BVeSJhYOtNYs7TWG4M6jbUSgkVtOfgJk03+RRgsYjGCpF7dmhKB
 tyIvMDWZizO0awjW/iTxDdqj1LMLEHqWVHzJqj/3Xz8tJ9p2PUIbE/KFFVI/Vo22N184lWKipwyel
 q0M0l2kCqjpnqZ96VJLrVDi67XN/BTNIMCd2we9VbfRE4CQEWCPsjjcd2SKXLuqB2vfvtdL2Gl0a6
 BisTvT5P9gcAD0OmXDA6BND7fEVb3v+eRamN9Rbh69Bjzb+LLCvut510pN8uP4+g0ot1rRWDMM2o4
 t8leER5g==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKA4-00FOMR-Eq
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 11:14:50 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14JBAXVN007727; Wed, 19 May 2021 04:14:34 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38mqcwhy2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 19 May 2021 04:14:33 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 19 May 2021 04:14:31 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 19 May 2021 04:14:28 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>, "Dean
 Balandin" <dbalandin@marvell.com>
Subject: [RFC PATCH v5 01/27] nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP
 HW offload ULP
Date: Wed, 19 May 2021 14:13:14 +0300
Message-ID: <20210519111340.20613-2-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210519111340.20613-1-smalin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: NKjU2_oH8STtHo3gGtvIieHsFPrXrvKs
X-Proofpoint-ORIG-GUID: NKjU2_oH8STtHo3gGtvIieHsFPrXrvKs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-19_04:2021-05-19,
 2021-05-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_041448_670288_753B35FA 
X-CRM114-Status: GOOD (  32.05  )
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

This patch will present the structure for the NVMeTCP offload common
layer driver. This module is added under "drivers/nvme/host/" and future
offload drivers which will register to it will be placed under
"drivers/nvme/hw".
This new driver will be enabled by the Kconfig "NVM Express over Fabrics
TCP offload commmon layer".
In order to support the new transport type, for host mode, no change is
needed.

Each new vendor-specific offload driver will register to this ULP during
its probe function, by filling out the nvme_tcp_ofld_dev->ops and
nvme_tcp_ofld_dev->private_data and calling nvme_tcp_ofld_register_dev
with the initialized struct.

The internal implementation:
- tcp-offload.h:
  Includes all common structs and ops to be used and shared by offload
  drivers.

- tcp-offload.c:
  Includes the init function which registers as a NVMf transport just
  like any other transport.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Dean Balandin <dbalandin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 MAINTAINERS                     |   8 ++
 drivers/nvme/host/Kconfig       |  16 +++
 drivers/nvme/host/Makefile      |   3 +
 drivers/nvme/host/tcp-offload.c | 126 +++++++++++++++++++
 drivers/nvme/host/tcp-offload.h | 212 ++++++++++++++++++++++++++++++++
 5 files changed, 365 insertions(+)
 create mode 100644 drivers/nvme/host/tcp-offload.c
 create mode 100644 drivers/nvme/host/tcp-offload.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..49a4a73ea1c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13092,6 +13092,14 @@ F:	drivers/nvme/host/
 F:	include/linux/nvme.h
 F:	include/uapi/linux/nvme_ioctl.h
 
+NVM EXPRESS TCP OFFLOAD TRANSPORT DRIVERS
+M:	Shai Malin <smalin@marvell.com>
+M:	Ariel Elior <aelior@marvell.com>
+L:	linux-nvme@lists.infradead.org
+S:	Supported
+F:	drivers/nvme/host/tcp-offload.c
+F:	drivers/nvme/host/tcp-offload.h
+
 NVM EXPRESS FC TRANSPORT DRIVERS
 M:	James Smart <james.smart@broadcom.com>
 L:	linux-nvme@lists.infradead.org
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index a44d49d63968..6e869e94e67f 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -84,3 +84,19 @@ config NVME_TCP
 	  from https://github.com/linux-nvme/nvme-cli.
 
 	  If unsure, say N.
+
+config NVME_TCP_OFFLOAD
+	tristate "NVM Express over Fabrics TCP offload common layer"
+	default m
+	depends on INET
+	depends on BLK_DEV_NVME
+	select NVME_FABRICS
+	help
+	  This provides support for the NVMe over Fabrics protocol using
+	  the TCP offload transport. This allows you to use remote block devices
+	  exported using the NVMe protocol set.
+
+	  To configure a NVMe over Fabrics controller use the nvme-cli tool
+	  from https://github.com/linux-nvme/nvme-cli.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index cbc509784b2e..3c3fdf83ce38 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
 obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
+obj-$(CONFIG_NVME_TCP_OFFLOAD)	+= nvme-tcp-offload.o
 
 nvme-core-y				:= core.o ioctl.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
@@ -26,3 +27,5 @@ nvme-rdma-y				+= rdma.o
 nvme-fc-y				+= fc.o
 
 nvme-tcp-y				+= tcp.o
+
+nvme-tcp-offload-y		+= tcp-offload.o
diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
new file mode 100644
index 000000000000..711232eba339
--- /dev/null
+++ b/drivers/nvme/host/tcp-offload.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Marvell. All rights reserved.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+/* Kernel includes */
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+/* Driver includes */
+#include "tcp-offload.h"
+
+static LIST_HEAD(nvme_tcp_ofld_devices);
+static DECLARE_RWSEM(nvme_tcp_ofld_devices_rwsem);
+
+/**
+ * nvme_tcp_ofld_register_dev() - NVMeTCP Offload Library registration
+ * function.
+ * @dev:	NVMeTCP offload device instance to be registered to the
+ *		common tcp offload instance.
+ *
+ * API function that registers the type of vendor specific driver
+ * being implemented to the common NVMe over TCP offload library. Part of
+ * the overall init sequence of starting up an offload driver.
+ */
+int nvme_tcp_ofld_register_dev(struct nvme_tcp_ofld_dev *dev)
+{
+	struct nvme_tcp_ofld_ops *ops = dev->ops;
+
+	if (!ops->claim_dev ||
+	    !ops->setup_ctrl ||
+	    !ops->release_ctrl ||
+	    !ops->create_queue ||
+	    !ops->drain_queue ||
+	    !ops->destroy_queue ||
+	    !ops->poll_queue ||
+	    !ops->init_req ||
+	    !ops->send_req ||
+	    !ops->commit_rqs)
+		return -EINVAL;
+
+	down_write(&nvme_tcp_ofld_devices_rwsem);
+	list_add_tail(&dev->entry, &nvme_tcp_ofld_devices);
+	up_write(&nvme_tcp_ofld_devices_rwsem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_tcp_ofld_register_dev);
+
+/**
+ * nvme_tcp_ofld_unregister_dev() - NVMeTCP Offload Library unregistration
+ * function.
+ * @dev:	NVMeTCP offload device instance to be unregistered from the
+ *		common tcp offload instance.
+ *
+ * API function that unregisters the type of vendor specific driver being
+ * implemented from the common NVMe over TCP offload library.
+ * Part of the overall exit sequence of unloading the implemented driver.
+ */
+void nvme_tcp_ofld_unregister_dev(struct nvme_tcp_ofld_dev *dev)
+{
+	down_write(&nvme_tcp_ofld_devices_rwsem);
+	list_del(&dev->entry);
+	up_write(&nvme_tcp_ofld_devices_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_tcp_ofld_unregister_dev);
+
+/**
+ * nvme_tcp_ofld_report_queue_err() - NVMeTCP Offload report error event
+ * callback function. Pointed to by nvme_tcp_ofld_queue->report_err.
+ * @queue:	NVMeTCP offload queue instance on which the error has occurred.
+ *
+ * API function that allows the vendor specific offload driver to reports errors
+ * to the common offload layer, to invoke error recovery.
+ */
+int nvme_tcp_ofld_report_queue_err(struct nvme_tcp_ofld_queue *queue)
+{
+	/* Placeholder - invoke error recovery flow */
+
+	return 0;
+}
+
+/**
+ * nvme_tcp_ofld_req_done() - NVMeTCP Offload request done callback
+ * function. Pointed to by nvme_tcp_ofld_req->done.
+ * Handles both NVME_TCP_F_DATA_SUCCESS flag and NVMe CQ.
+ * @req:	NVMeTCP offload request to complete.
+ * @result:     The nvme_result.
+ * @status:     The completion status.
+ *
+ * API function that allows the vendor specific offload driver to report request
+ * completions to the common offload layer.
+ */
+void nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
+			    union nvme_result *result,
+			    __le16 status)
+{
+	/* Placeholder - complete request with/without error */
+}
+
+static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
+	.name		= "tcp_offload",
+	.module		= THIS_MODULE,
+	.required_opts	= NVMF_OPT_TRADDR,
+	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_NR_WRITE_QUEUES  |
+			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
+			  NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_HDR_DIGEST |
+			  NVMF_OPT_DATA_DIGEST | NVMF_OPT_NR_POLL_QUEUES |
+			  NVMF_OPT_TOS,
+};
+
+static int __init nvme_tcp_ofld_init_module(void)
+{
+	nvmf_register_transport(&nvme_tcp_ofld_transport);
+
+	return 0;
+}
+
+static void __exit nvme_tcp_ofld_cleanup_module(void)
+{
+	nvmf_unregister_transport(&nvme_tcp_ofld_transport);
+}
+
+module_init(nvme_tcp_ofld_init_module);
+module_exit(nvme_tcp_ofld_cleanup_module);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
new file mode 100644
index 000000000000..949132ce2ed4
--- /dev/null
+++ b/drivers/nvme/host/tcp-offload.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2021 Marvell. All rights reserved.
+ */
+
+/* Linux includes */
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/types.h>
+#include <linux/nvme-tcp.h>
+
+/* Driver includes */
+#include "nvme.h"
+#include "fabrics.h"
+
+/* Forward declarations */
+struct nvme_tcp_ofld_ops;
+
+/* Representation of a vendor-specific device. This is the struct used to
+ * register to the offload layer by the vendor-specific driver during its probe
+ * function.
+ * Allocated by vendor-specific driver.
+ */
+struct nvme_tcp_ofld_dev {
+	struct list_head entry;
+	struct net_device *ndev;
+	struct nvme_tcp_ofld_ops *ops;
+
+	/* Vendor specific driver context */
+	void *private_data;
+	int num_hw_vectors;
+};
+
+/* Per IO struct holding the nvme_request and command
+ * Allocated by blk-mq.
+ */
+struct nvme_tcp_ofld_req {
+	struct nvme_request req;
+	struct nvme_command nvme_cmd;
+	struct list_head queue_entry;
+	struct nvme_tcp_ofld_queue *queue;
+	struct request *rq;
+
+	/* Vendor specific driver context */
+	void *private_data;
+
+	bool async;
+	bool last;
+
+	void (*done)(struct nvme_tcp_ofld_req *req,
+		     union nvme_result *result,
+		     __le16 status);
+};
+
+enum nvme_tcp_ofld_queue_flags {
+	NVME_TCP_OFLD_Q_ALLOCATED = 0,
+	NVME_TCP_OFLD_Q_LIVE = 1,
+};
+
+/* Allocated by nvme_tcp_ofld */
+struct nvme_tcp_ofld_queue {
+	/* Offload device associated to this queue */
+	struct nvme_tcp_ofld_dev *dev;
+	struct nvme_tcp_ofld_ctrl *ctrl;
+	unsigned long flags;
+	size_t cmnd_capsule_len;
+
+	u8 hdr_digest;
+	u8 data_digest;
+	u8 tos;
+
+	/* Vendor specific driver context */
+	void *private_data;
+
+	/* Error callback function */
+	int (*report_err)(struct nvme_tcp_ofld_queue *queue);
+};
+
+/* Connectivity (routing) params used for establishing a connection */
+struct nvme_tcp_ofld_ctrl_con_params {
+	/* Input params */
+	struct sockaddr_storage remote_ip_addr;
+
+	/* If NVMF_OPT_HOST_TRADDR is provided it will be set in local_ip_addr
+	 * in nvme_tcp_ofld_create_ctrl().
+	 * If NVMF_OPT_HOST_TRADDR is not provided the local_ip_addr will be
+	 * initialized by claim_dev().
+	 */
+	struct sockaddr_storage local_ip_addr;
+
+	/* Output params */
+	struct sockaddr	remote_mac_addr;
+	struct sockaddr	local_mac_addr;
+	u16 vlan_id;
+};
+
+/* Allocated by nvme_tcp_ofld */
+struct nvme_tcp_ofld_ctrl {
+	struct nvme_ctrl nctrl;
+	struct list_head list;
+	struct nvme_tcp_ofld_dev *dev;
+
+	/* admin and IO queues */
+	struct blk_mq_tag_set tag_set;
+	struct blk_mq_tag_set admin_tag_set;
+	struct nvme_tcp_ofld_queue *queues;
+
+	struct work_struct err_work;
+	struct delayed_work connect_work;
+
+	/*
+	 * Each entry in the array indicates the number of queues of
+	 * corresponding type.
+	 */
+	u32 io_queues[HCTX_MAX_TYPES];
+
+	/* Connectivity params */
+	struct nvme_tcp_ofld_ctrl_con_params conn_params;
+
+	/* Vendor specific driver context */
+	void *private_data;
+};
+
+struct nvme_tcp_ofld_ops {
+	const char *name;
+	struct module *module;
+
+	/* For vendor-specific driver to report what opts it supports */
+	int required_opts; /* bitmap using enum nvmf_parsing_opts */
+	int allowed_opts; /* bitmap using enum nvmf_parsing_opts */
+
+	/* For vendor-specific max num of segments and IO sizes */
+	u32 max_hw_sectors;
+	u32 max_segments;
+
+	/**
+	 * claim_dev: Return True if addr is reachable via offload device.
+	 * @dev: The offload device to check.
+	 * @conn_params: ptr to routing params to be filled by the lower
+	 *               driver. Input+Output argument.
+	 */
+	int (*claim_dev)(struct nvme_tcp_ofld_dev *dev,
+			 struct nvme_tcp_ofld_ctrl_con_params *conn_params);
+
+	/**
+	 * setup_ctrl: Setup device specific controller structures.
+	 * @ctrl: The offload ctrl.
+	 * @new: is new setup.
+	 */
+	int (*setup_ctrl)(struct nvme_tcp_ofld_ctrl *ctrl, bool new);
+
+	/**
+	 * release_ctrl: Release/Free device specific controller structures.
+	 * @ctrl: The offload ctrl.
+	 */
+	int (*release_ctrl)(struct nvme_tcp_ofld_ctrl *ctrl);
+
+	/**
+	 * create_queue: Create offload queue and establish TCP + NVMeTCP
+	 * (icreq+icresp) connection. Return true on successful connection.
+	 * Based on nvme_tcp_alloc_queue.
+	 * @queue: The queue itself - used as input and output.
+	 * @qid: The queue ID associated with the requested queue.
+	 * @q_size: The queue depth.
+	 */
+	int (*create_queue)(struct nvme_tcp_ofld_queue *queue, int qid,
+			    size_t q_size);
+
+	/**
+	 * drain_queue: Drain a given queue - Returning from this function
+	 * ensures that no additional completions will arrive on this queue.
+	 * @queue: The queue to drain.
+	 */
+	void (*drain_queue)(struct nvme_tcp_ofld_queue *queue);
+
+	/**
+	 * destroy_queue: Close the TCP + NVMeTCP connection of a given queue
+	 * and make sure its no longer active (no completions will arrive on the
+	 * queue).
+	 * @queue: The queue to destroy.
+	 */
+	void (*destroy_queue)(struct nvme_tcp_ofld_queue *queue);
+
+	/**
+	 * poll_queue: Poll a given queue for completions.
+	 * @queue: The queue to poll.
+	 */
+	int (*poll_queue)(struct nvme_tcp_ofld_queue *queue);
+
+	/**
+	 * init_req: Initialize vendor-specific params for a new request.
+	 * @req: Ptr to request to be initialized. Input+Output argument.
+	 */
+	int (*init_req)(struct nvme_tcp_ofld_req *req);
+
+	/**
+	 * send_req: Dispatch a request. Returns the execution status.
+	 * @req: Ptr to request to be sent.
+	 */
+	int (*send_req)(struct nvme_tcp_ofld_req *req);
+
+	/**
+	 * commit_rqs: Serves the purpose of kicking the hardware in case of
+	 * errors, otherwise it would have been kicked by the last request.
+	 * @queue: The queue to drain.
+	 */
+	void (*commit_rqs)(struct nvme_tcp_ofld_queue *queue);
+};
+
+/* Exported functions for lower vendor specific offload drivers */
+int nvme_tcp_ofld_register_dev(struct nvme_tcp_ofld_dev *dev);
+void nvme_tcp_ofld_unregister_dev(struct nvme_tcp_ofld_dev *dev);
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
