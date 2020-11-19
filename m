Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D43C63697
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA2022256
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L3ivuAZg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KtCi0GV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA2022256
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ioVhtH3m2wC2TBGSg5XBxMjQWASRSuRvD6KvQ8VyLPQ=; b=L3ivuAZg0VH7vxraS7r0MdzqM
	zymvgrD575FwWV814fJj9+Xbeck8CbWkiqGy1/Fl3OHPEkVec1MAAneBdtjOyCl5N/EmRJGyh3T1i
	kH+GQgUDhyxutAj8/M6uQtyEquo+0shH9/178SHn+2cg4k6kaEKrpMcMcRSzJiJil2tWqWtM8HB5R
	OoIBH9j8w4pfThfix7+Cu1KSRPx3jfkH0PbVNA8lDTCUwQv1Jmr2OOtdZkCSwX6Y326F8S86ob5ci
	bKRGLXGiuHTTjA1kJPhN1h4/w/Lf//+ml9Ip4EEwPoVZB1DGXuvZ4f5UO5WJxvfxzDIEYs1/qbp11
	DU84UPPIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfkp0-0004Go-0t; Thu, 19 Nov 2020 14:22:02 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfkoq-0004DZ-1P
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 14:21:54 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AJEK92I008097; Thu, 19 Nov 2020 06:21:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=9UAp4g/kw01zx4W/FkI7t3SLFIWFaK3zlfaAPLBo+l0=;
 b=KtCi0GV6GrRtppDqplcXS6/c6bUeWKRflp0+XlzWLUJYknUDSQJM27v1GG1yxVzKeD4v
 wwbT0c8vPjAENOBzwWyQAm2QowXU0L9yc93qy/hkGHt+tfdgDfnxr3xFRuw/nZTCSEk4
 2qUKe1GAr6id47WXG2uRcHLP9QspZmfdFHWz4yRJIZks+K9COOfJubPwiwQeYNolRUfO
 D20Zpa1hm+HAwKzDAFhLV8uVo61UlzOgX117iVYzGY+XKBacukUvaXn0CK5BndYUR21j
 4LyJsc8Er42XUpN0zX7IqbcPwaSzSc47YQFPXyIN0J4J9N5g75pIcv7kIcUKtFXRJCMi Ow== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 34w7ncurfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2020 06:21:39 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 19 Nov 2020 06:21:38 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 19 Nov 2020 06:21:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 06:21:37 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 2B0473F703F;
 Thu, 19 Nov 2020 06:21:33 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [PATCH 1/7] nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW
 offload ULP
Date: Thu, 19 Nov 2020 16:21:01 +0200
Message-ID: <20201119142107.17429-2-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201119142107.17429-1-smalin@marvell.com>
References: <20201119142107.17429-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-19_09:2020-11-19,
 2020-11-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_092152_195148_C2923AE2 
X-CRM114-Status: GOOD (  36.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: smalin@marvell.com, aelior@marvell.com, agershberg@marvell.com,
 mkalderon@marvell.com, nassa@marvell.com, dbalandin@marvell.com,
 malin1024@gmail.com
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

Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Dean Balandin <dbalandin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
---
 drivers/nvme/host/Kconfig       |  16 +++
 drivers/nvme/host/Makefile      |   3 +
 drivers/nvme/host/tcp-offload.c | 121 ++++++++++++++++++++++
 drivers/nvme/host/tcp-offload.h | 173 ++++++++++++++++++++++++++++++++
 include/linux/nvme.h            |   1 +
 5 files changed, 314 insertions(+)
 create mode 100644 drivers/nvme/host/tcp-offload.c
 create mode 100644 drivers/nvme/host/tcp-offload.h

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 3ed9786b88d8..c05057e8a7a4 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -83,3 +83,19 @@ config NVME_TCP
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
index 000000000000..dfb25da7a564
--- /dev/null
+++ b/drivers/nvme/host/tcp-offload.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright 2020 Marvell. All rights reserved.
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
+	    !ops->create_queue ||
+	    !ops->drain_queue ||
+	    !ops->destroy_queue ||
+	    !ops->init_req ||
+	    !ops->map_sg ||
+	    !ops->send_req)
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
+void nvme_tcp_ofld_report_queue_err(struct nvme_tcp_ofld_queue *queue)
+{
+	/* Placeholder - invoke error recovery flow */
+}
+
+/**
+ * nvme_tcp_ofld_req_done() - NVMeTCP Offload request done callback
+ * function. Pointed to by nvme_tcp_ofld_req->done.
+ * @req:	NVMeTCP offload request to complete.
+ * @result:     The nvme_result.
+ * @status:     The completion status.
+ *
+ * API function that allows the vendor specific offload driver to report request
+ * completions to the common offload layer.
+ */
+void
+nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
+		       union nvme_result *result,
+		       __le16 status)
+{
+	/* Placeholder - complete request with/without error */
+}
+
+static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
+	.name		= "tcp_offload",
+	.module		= THIS_MODULE,
+	.required_opts	= NVMF_OPT_TRADDR,
+	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_DISABLE_SQFLOW |
+			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_HOST_TRADDR |
+			  NVMF_OPT_CTRL_LOSS_TMO | NVMF_OPT_RECONNECT_DELAY |
+			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
+			  NVMF_OPT_NR_POLL_QUEUES | NVMF_OPT_TOS,
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
index 000000000000..ed340b33d366
--- /dev/null
+++ b/drivers/nvme/host/tcp-offload.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright 2020 Marvell. All rights reserved.
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
+	struct nvme_tcp_ofld_ops *ops;
+};
+
+/* Per IO struct holding the nvme_request and command
+ * Allocated by blk-mq.
+ */
+struct nvme_tcp_ofld_req {
+	struct nvme_request req;
+	struct nvme_command nvme_cmd;
+	struct nvme_tcp_ofld_queue *queue;
+
+	/* Vendor specific driver context */
+	void *private_data;
+
+	void (*done)(struct nvme_tcp_ofld_req *req,
+		     union nvme_result *result,
+		     __le16 status);
+};
+
+/* Allocated by nvme_tcp_ofld */
+struct nvme_tcp_ofld_queue {
+	/* Offload device associated to this queue */
+	struct nvme_tcp_ofld_dev *dev;
+	struct nvme_tcp_ofld_ctrl *ctrl;
+
+	/* Vendor specific driver context */
+	void *private_data;
+
+	/* Error callback function */
+	void (*report_err)(struct nvme_tcp_ofld_queue *queue);
+};
+
+/* Connectivity (routing) params used for establishing a connection */
+struct nvme_tcp_ofld_ctrl_con_params {
+	/* Input params */
+	struct sockaddr_storage remote_ip_addr;
+
+	/*
+	 * Can be input or output, depending if host traddr was passed.
+	 * Vendor-specific driver should determine if it should use the passed
+	 * addr or fill it on its own.
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
+	struct nvme_tcp_ofld_dev *dev;
+
+	/* admin and IO queues */
+	struct blk_mq_tag_set tag_set;
+	struct blk_mq_tag_set admin_tag_set;
+	struct nvme_tcp_ofld_queue *queues;
+
+	/*
+	 * Each entry in the array indicates the number of queues of
+	 * corresponding type.
+	 */
+	u32 queue_type_mapping[HCTX_MAX_TYPES];
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
+	/**
+	 * claim_dev: Return True if addr is reachable via offload device.
+	 * @dev: The offload device to check.
+	 * @conn_params: ptr to routing params to be filled by the lower
+	 *               driver. Input+Output argument.
+	 */
+	bool (*claim_dev)(struct nvme_tcp_ofld_dev *dev,
+			  struct nvme_tcp_ofld_ctrl_con_params *conn_params);
+
+	/**
+	 * create_queue: Create offload queue and establish TCP + NVMeTCP
+	 * (icreq+icresp) connection. Return true on successful connection.
+	 * Based on nvme_tcp_alloc_queue.
+	 * @queue: The queue itself.
+	 * @qid: The queue ID associated with the requested queue.
+	 * @q_size: The queue depth.
+	 */
+	bool (*create_queue)(struct nvme_tcp_ofld_queue *queue, int qid,
+			     size_t q_size);
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
+	void (*poll_queue)(struct nvme_tcp_ofld_queue *queue);
+
+	/**
+	 * init_req: Initialize vendor-specific params for a new request.
+	 * @req: Ptr to request to be initialized. Input+Output argument.
+	 */
+	void (*init_req)(struct nvme_tcp_ofld_req *req);
+
+	/**
+	 * send_req: Dispatch a request. Returns the execution status.
+	 * @req: Ptr to request to be sent.
+	 */
+	blk_status_t (*send_req)(struct nvme_tcp_ofld_req *req);
+
+	/**
+	 * map_sg: Map a scatter/gather list to DMA addresses Returns the
+	 * number of SGs entries mapped successfully.
+	 * @dev: The device for which the DMA addresses are to be created.
+	 * @req: The request corresponding to the SGs, to allow vendor-specific
+	 *       driver to initialize additional params if it needs to.
+	 */
+	int (*map_sg)(struct nvme_tcp_ofld_dev *dev,
+		      struct nvme_tcp_ofld_req *req);
+};
+
+/* Exported functions for lower vendor specific offload drivers */
+int nvme_tcp_ofld_register_dev(struct nvme_tcp_ofld_dev *dev);
+void nvme_tcp_ofld_unregister_dev(struct nvme_tcp_ofld_dev *dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d92535997687..2c4c21f39a2f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -47,6 +47,7 @@ enum {
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
 	NVMF_TRTYPE_TCP		= 3,	/* TCP/IP */
+	NVMF_TRTYPE_TCP_OFFLOAD = 4,	/* TCP/IP offload */
 	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
 	NVMF_TRTYPE_MAX,
 };
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
