Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A21C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Dec 2021 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JmWG/kKELZrYbXUtcYsXrO9NOmT/APnWeg+h80cbXsU=; b=Yxi+5buRSumEpfSBSFYIH13mzC
	bO+uikxXZm4Z0gQBs6iU1lbaBPUd8hhcfws+GReyzdIKSA7aBqICy/UV0n/KC96Xpy5hwhEnh7QHk
	QNwje/b3XDBnWBp8Bwd8HbTDn90bf1+bDo1NqGV8boab4fLBabJJdG2CfBqjVs/yZi1Nj7ZJ4+CaZ
	Y3ozg1P/M6tCNtgpcIchL2qrUWSVY+PpCuI+/KR3fmvtW8ZsSbsfCEfwx4KuH8QNeeKJ08Uz88etF
	PZZ8M5tHQVeKbGPuZuYHmqW+fOrSei69jOsu+6JXLsW5ETDD01W99uUV1WjsuGD4Hkqg0F6IKTp4r
	kRA950Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n0W6V-00DVcP-Nh; Thu, 23 Dec 2021 21:58:27 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0W6H-00DVbA-Eo
 for linux-nvme@lists.infradead.org; Thu, 23 Dec 2021 21:58:15 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNJSlIG023723; 
 Thu, 23 Dec 2021 21:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=JmWG/kKELZrYbXUtcYsXrO9NOmT/APnWeg+h80cbXsU=;
 b=er2kzlbrD2dhRb/mKbMEla3s5O8HSkphAPNlCbD1BhxRbLGD7xI/32KQtXl4t0yNCwR/
 ZoPqX2BZvKnO2rN2lxh7UjgJFUEAEb5aaN/qnCRIIlKOPfQ/oDoHsGPn9rG7YhXjhFzh
 SJJtrrwH6G/hAIBLiJyTj8me37sIBHvDOZGNJxomlXZ53lpd31x/MpTzDFtySflgYKug
 LWFs1gr476qHKkJzCoySQhH6znV9/n0Fmsblv4C46oQl8RYZPr8b9imgfYexi5ab+mec
 cdGxiD/bN4Ih8iQDSGJsozCxSRAyYO4vfEpVRvI6LCHlyil3Ii4WAWnhZn5FeuPGB/+8 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d46qn44cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 21:58:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNLp5Aa040173;
 Thu, 23 Dec 2021 21:57:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 3d15pghv3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 21:57:59 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BNLvwo6052101;
 Thu, 23 Dec 2021 21:57:59 GMT
Received: from dhcp-10-65-149-175.vpn.oracle.com
 (dhcp-10-65-149-175.vpn.oracle.com [10.65.149.175])
 by aserp3030.oracle.com with ESMTP id 3d15pghv23-2;
 Thu, 23 Dec 2021 21:57:59 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V2 1/1] nvme: Add verbose error logging
Date: Thu, 23 Dec 2021 13:57:26 -0800
Message-Id: <20211223215726.71096-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211223215726.71096-1-alan.adamson@oracle.com>
References: <20211223215726.71096-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WZ8jL8tPIBvJCyGJDcyOB84WgXBjaWms
X-Proofpoint-GUID: WZ8jL8tPIBvJCyGJDcyOB84WgXBjaWms
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211223_135813_662430_D8852881 
X-CRM114-Status: GOOD (  30.14  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Improves logging of NVMe errors.  If NVME_VERBOSE_ERRORS is configured,
a verbose description of the error is logged, otherwise only status codes/bits
is logged.

Verbose logging example:
nvme0n1: Read @ LBA 2304, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR

Non-verbose logging example:
nvme0n1: Read @ LBA 2304, 1 blocks, NVME Error (sct 0x2 / sc 0x81) DNR

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/Kconfig  |   8 ++
 drivers/nvme/host/Makefile |   2 +-
 drivers/nvme/host/core.c   |   3 +
 drivers/nvme/host/errors.c | 202 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |   2 +
 include/linux/nvme.h       |   1 +
 6 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/errors.c

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index dc0450ca23a3..d6d056963c06 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -24,6 +24,14 @@ config NVME_MULTIPATH
 	   /dev/nvmeXnY device will show up for each NVMe namespace,
 	   even if it is accessible through multiple controllers.
 
+config NVME_VERBOSE_ERRORS
+	bool "NVMe verbose error reporting"
+	depends on NVME_CORE
+	help
+	   This option enables verbose reporting for NVMe errors. The
+	   error translation table will grow the kernel image size by
+	   about 4 KB.
+
 config NVME_HWMON
 	bool "NVMe hardware monitoring"
 	depends on (NVME_CORE=y && HWMON=y) || (NVME_CORE=m && HWMON)
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index dfaacd472e5d..ea3d702feb51 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 
-nvme-core-y				:= core.o ioctl.o
+nvme-core-y				:= core.o ioctl.o errors.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1af8a4513708..fda029a55436 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -354,6 +354,9 @@ void nvme_complete_rq(struct request *req)
 
 	switch (nvme_decide_disposition(req)) {
 	case COMPLETE:
+		if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
+			nvme_error_log(req);
+
 		nvme_end_req(req);
 		return;
 	case RETRY:
diff --git a/drivers/nvme/host/errors.c b/drivers/nvme/host/errors.c
new file mode 100644
index 000000000000..3183b2e728d4
--- /dev/null
+++ b/drivers/nvme/host/errors.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVM Express device driver verbose errors
+ * Copyright (c) 2021, Oracle and/or its affiliates
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/blkdev.h>
+#include "nvme.h"
+
+struct nvme_string_table {
+	unsigned int code;
+	const unsigned char *string;
+};
+
+static const struct nvme_string_table nvme_ops[] = {
+	{ REQ_OP_READ,			"Read" },
+	{ REQ_OP_WRITE,			"Write" },
+	{ REQ_OP_FLUSH,			"Flush" },
+	{ REQ_OP_DISCARD,		"Deallocate (DSM)" },
+	{ REQ_OP_WRITE_ZEROES,		"Write Zeroes" },
+	{ REQ_OP_ZONE_RESET_ALL,	"Zone Reset All" },
+	{ REQ_OP_ZONE_RESET,		"Zone Reset" },
+	{ REQ_OP_ZONE_OPEN,		"Zone Open" },
+	{ REQ_OP_ZONE_CLOSE,		"Zone Close" },
+	{ REQ_OP_ZONE_FINISH,		"Zone Finish" },
+	{ REQ_OP_ZONE_APPEND,		"Zone Append" },
+};
+#define NVME_OPS_SIZE ARRAY_SIZE(nvme_ops)
+
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+#define TEN_NULLS	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
+
+static const char * const nvme_errors[] = {
+	"Success",
+	"Invalid Command Opcode",
+	"Invalid Field in Command",
+	"Command ID Conflict",
+	"Data Transfer Error",
+	"Commands Aborted due to Power Loss Notification",
+	"Internal Error",
+	"Command Abort Requested",
+	"Command Aborted due to SQ Deletion",
+	"Command Aborted due to Failed Fused Command",
+	"Command Aborted due to Missing Fused Command",
+	"Invalid Namespace or Format",
+	"Command Sequence Error",
+	"Invalid SGL Segment Descriptor",
+	"Invalid Number of SGL Descriptors",
+	"Data SGL Length Invalid",
+	"Metadata SGL Length Invalid",
+	"SGL Descriptor Type Invalid",
+	"Invalid Use of Controller Memory Buffer",
+	"PRP Offset Invalid",
+	"Atomic Write Unit Exceeded",
+	"Operation Denied",
+	"SGL Offset Invalid",
+	"Reserved",
+	"Host Identifier Inconsistent Format",
+	"Keep Alive Timeout Expired",
+	"Keep Alive Timeout Invalid",
+	"Command Aborted due to Preempt and Abort",
+	"Sanitize Failed",
+	"Sanitize In Progress",
+	"SGL Data Block Granularity Invalid",
+	"Command Not Supported for Queue in CMB",
+	"Namespace is Write Protected",
+	"Command Interrupted",
+	"Transient Transport Error",
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	"Invalid IO Command Set",
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS, TEN_NULLS, TEN_NULLS,
+	NULL, NULL, NULL,
+	"LBA Out of Range",
+	"Capacity Exceeded",
+	"Namespace Not Ready",
+	"Reservation Conflict",
+	"Format In Progress",
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS, TEN_NULLS, TEN_NULLS,
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, NULL, NULL, NULL,
+	"Completion Queue Invalid",
+	"Invalid Queue Identifier",
+	"Invalid Queue Size",
+	"Abort Command Limit Exceeded",
+	"Reserved",
+	"Asynchronous Event Request Limit Exceeded",
+	"Invalid Firmware Slot",
+	"Invalid Firmware Image",
+	"Invalid Interrupt Vector",
+	"Invalid Log Page",
+	"Invalid Format",
+	"Firmware Activation Requires Conventional Reset",
+	"Invalid Queue Deletion",
+	"Feature Identifier Not Saveable",
+	"Feature Not Changeable",
+	"Feature Not Namespace Specific",
+	"Firmware Activation Requires NVM Subsystem Reset",
+	"Firmware Activation Requires Reset",
+	"Firmware Activation Requires Maximum Time Violation",
+	"Firmware Activation Prohibited",
+	"Overlapping Range",
+	"Namespace Insufficient Capacity",
+	"Namespace Identifier Unavailable",
+	NULL,
+	"Namespace Already Attached",
+	"Namespace Is Private",
+	"Namespace Not Attached",
+	"Thin Provisioning Not Supported",
+	"Controller List Invalid",
+	"Device Self-test In Progress",
+	"Boot Partition Write Prohibited",
+	"Invalid Controller Identifier",
+	"Invalid Secondary Controller State",
+	"Invalid Number of Controller Resources",
+	"Invalid Resource Identifier",
+	"Sanitize Prohibited",
+	"ANA Group Identifier Invalid",
+	"ANA Attach Failed",
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
+	TEN_NULLS, TEN_NULLS, TEN_NULLS,
+	"Conflicting Attributes",
+	"Invalid Protection Information",
+	"Attempted Write to Read Only Range",
+	"ONCS Not Supported",
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, NULL, NULL,
+	"Zoned Boundary Error",
+	"Zone Is Full",
+	"Zone Is Read Only",
+	"Zone Is Offline",
+	"Zone Invalid Write",
+	"Too Many Active Zones",
+	"Too Many Open Zones",
+	"Invalid Zone State Transition",
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
+	TEN_NULLS, NULL, NULL,
+	"Write Fault",
+	"Unrecovered Read Error",
+	"End-to-end Guard Check Error",
+	"End-to-end Application Tag Check Error",
+	"End-to-end Reference Tag Check Error",
+	"Compare Failure",
+	"Access Denied",
+	"Deallocated or Unwritten Logical Block",
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
+	NULL,
+	"Asymmetric Access Persistent Loss",
+	"Asymmetric Access Inaccessible",
+	"Asymmetric Access Transition",
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,  TEN_NULLS,
+	TEN_NULLS, TEN_NULLS, TEN_NULLS, TEN_NULLS,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	"Host Pathing Error",
+};
+#define NVME_ERRORS_SIZE ARRAY_SIZE(nvme_errors)
+#endif /* CONFIG_NVME_VERBOSE_ERRORS */
+
+void nvme_error_log(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_request *nr = nvme_req(req);
+	const struct nvme_string_table *entry;
+	const unsigned char *op_str  = "Unknown";
+	const unsigned char *err_str = NULL;
+	unsigned int i;
+
+	if (!ns)
+		return;
+
+	for (i = 0, entry = nvme_ops ; i < NVME_OPS_SIZE ; i++)
+		if (entry[i].code == (req->cmd_flags & REQ_OP_MASK))
+			op_str = entry[i].string;
+
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+	if ((nr->status & 0x7ff) <= NVME_ERRORS_SIZE)
+		err_str = nvme_errors[nr->status & 0x7ff];
+#endif
+	if (err_str == NULL)
+		err_str =  "NVME Error";
+
+	pr_err_ratelimited("%s: %s @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
+	       req->rq_disk ? req->rq_disk->disk_name : "?",
+	       op_str,
+	       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
+	       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
+	       err_str,
+	       nr->status >> 8 & 7, /* Status Code Type */
+	       nr->status & 0xff,    /* Status Code */
+	       nr->status & NVME_SC_MORE ? "MORE " : "",
+	       nr->status & NVME_SC_DNR  ? "DNR "  : "");
+}
+EXPORT_SYMBOL_GPL(nvme_error_log);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b095ee01364..7edd67b92a6b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -922,4 +922,6 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+extern void nvme_error_log(struct request *req);
+
 #endif /* _NVME_H */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 855dd9b3e84b..1f946e5bf7c1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1636,6 +1636,7 @@ enum {
 	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
 	NVME_SC_CRD			= 0x1800,
+	NVME_SC_MORE			= 0x2000,
 	NVME_SC_DNR			= 0x4000,
 };
 
-- 
2.27.0


