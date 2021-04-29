Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083C9C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:14:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4337E6143E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4337E6143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h5hRwbdZIk9LPsZg1kDqGTHZq9+zA6aKfREARn8EOWw=; b=MUSsVGSy+EwfUl490mx02MeOq
	InUWLerk9LNWuvMMLPV0q1OdV394zkdsn5dypr3LTVRTR9kDGPHPowqyD63UbdIfbE3CnJAEVrzbM
	W0XYIpTK/ofGJ4U2f/akmBRY9/E5tvPbCypL7WFeHAT1Pxx4vqkiGb1ARG9ujkgflg3AuCHoqDzmd
	Fj+C/BBpSNYiUhNqcQPm0EVYV8ghjS5O4YDm4SR8PxFUEhgNPz8GZgh8vYsbZ86qkfH+0Sp4hVfGU
	SlBmy6g01yi9l/Zq/nyFmrwQ53sCEgZ8pT1lnNHYJECYxy8j4nTiyMjOOv1vmwGUZghPtSaDNGYl2
	wKaDkKlBQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcC6q-006G0C-Ch; Thu, 29 Apr 2021 19:14:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC3I-006FNh-EL
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 19:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7+S2Y8fahSBNJLVhKDwE/WtEValXwc0P0Rzj2FhPiLU=; b=szKwN1n0BhmAvXDBT9RcdbKzzf
 f0tBrvmvYnFhs/ZilWTjUVkPhgKdyAvLWFMsq/Ku9lCAFtMGjF/ohqfMESfwTqd2EZ57Cry9+BoDN
 IN2IK3LU+Uo985hHU68IfsVMc5HWJ4dthqALsU+Che+gyQC5h7+fd9qoY3gwdfMCGOZxUcewj5pUT
 /FKlr7lrQSj3V7IcbE4/Tl3Gxv8MqseloHQwXaU24woNNcOqgtEwb23h/zk/KhOn/c0ArHIqdtq+o
 iW8q5tNdtUXrKQncgP0tp0AJO72IjLCg8X9kAclnTXDjbuqcqsIdbF4fk1pa8UqKeuhJrp1uQU1X6
 8y1z/zCQ==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC3E-000scw-Q8
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 19:10:19 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13TJ4xdZ027122; Thu, 29 Apr 2021 12:10:12 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 387rpnamp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 29 Apr 2021 12:10:12 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 29 Apr 2021 12:10:10 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 29 Apr 2021 12:10:07 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: =?UTF-8?q?David=20S=20=2E=20Miller=20davem=20=40=20davemloft=20=2E=20net=20=C2=A0--cc=3DJakub=20Kicinski?=
 <kuba@kernel.org>,
 <smalin@marvell.com>, <aelior@marvell.com>, <mkalderon@marvell.com>,
 <okulkarni@marvell.com>, <pkushwaha@marvell.com>,
 <malin1024@gmail.com>, Dean Balandin <dbalandin@marvell.com>
Subject: [RFC PATCH v4 08/27] nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP
 HW offload ULP
Date: Thu, 29 Apr 2021 22:09:07 +0300
Message-ID: <20210429190926.5086-9-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210429190926.5086-1-smalin@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: l6C0XR-D_8W1b6_psvwVU17547RIxvea
X-Proofpoint-ORIG-GUID: l6C0XR-D_8W1b6_psvwVU17547RIxvea
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-29_10:2021-04-28,
 2021-04-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_121016_996333_BC59E06F 
X-CRM114-Status: GOOD (  30.41  )
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
---
 drivers/nvme/host/Kconfig       |  16 +++
 drivers/nvme/host/Makefile      |   3 +
 drivers/nvme/host/tcp-offload.c | 126 +++++++++++++++++++
 drivers/nvme/host/tcp-offload.h | 206 ++++++++++++++++++++++++++++++++
 4 files changed, 351 insertions(+)
 create mode 100644 drivers/nvme/host/tcp-offload.c
 create mode 100644 drivers/nvme/host/tcp-offload.h

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
index d7f6a87687b8..0e7ef044cf29 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
 obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
+obj-$(CONFIG_NVME_TCP_OFFLOAD)	+= nvme-tcp-offload.o
 
 nvme-core-y				:= core.o
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
index 000000000000..9fd270240eaa
--- /dev/null
+++ b/drivers/nvme/host/tcp-offload.h
@@ -0,0 +1,206 @@
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
+	struct pci_dev *qede_pdev;
+	struct net_device *ndev;
+	struct nvme_tcp_ofld_ops *ops;
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
+	u32 queue_type_mapping[HCTX_MAX_TYPES];
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
