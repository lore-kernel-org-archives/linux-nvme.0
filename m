Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CEAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Dec 2021 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t8Zt1JEEDRy6GcKIkZ2tEK7PRerF5d9wKfkDOWSLSjY=; b=GB3h5jB39h5nFBGZOuj+bI22hW
	AsQ/E4drfGGrSyM1/zK3LqsJ8OqqSi69p8fcpExiXhz6O9AaUNX/46KW6SpDkbL2HmJ5Gg6Zve3mP
	xd87/ICPJ0WY5eV0Uk6adgtEV3qmrLdF60mNwVI1+yh9CPeV3MObAhWWvoAOv2T/2XDbnRRdyTA91
	X0srfRK/oNisd3w88fH6N4FGWEtof97A022HJn5s0wrYRjWqbqDtrSSGHFCaRJt1KQ+0zY3vJC+zD
	uY7KxBI7btKoZf4eFnhnwSdCuAirHPLDiW9PHlVeePvpgRTKT9MXOSvEIrXNhdB+XcsLL4XLlraza
	4cacgKeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvNIK-00GzC6-3T; Thu, 09 Dec 2021 17:33:24 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvNHu-00Gz1C-AH
 for linux-nvme@lists.infradead.org; Thu, 09 Dec 2021 17:33:00 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9GZDKn006487; 
 Thu, 9 Dec 2021 17:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=t8Zt1JEEDRy6GcKIkZ2tEK7PRerF5d9wKfkDOWSLSjY=;
 b=fRTSmtCS3QHT9HOo3TO52eqzuDTkgQv1xrSz1rSUwBFs3f7RSWQ/yAfCg9BeyYrjxLNx
 054Xkb2MYL1RBFxSdcfaZZxSxW8zFCPJOZDij5/Cs0pemDvwbYlboEnvoYdfylK6HE5h
 D5Bp/9vsgzwFSclH1/5Wzck0ezja0ev/vb6FwmyyWQbfOwORdkJcE2nTgvkpK85OZ1Qy
 NMgwCMFKmmFO0M5xgUkT2NvrUikZeEKoAOI/kSZaOfxujrqmOiOqvC5XUMGLSOrgJq/Y
 rl6DblyFJKnmZJAeDlAfrstmMHh4biLvo3BT8mnZzNx8Sp6n7pWrR6/pDpCNOlDTdasv /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctua7kn8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 17:32:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9HBHk0136644;
 Thu, 9 Dec 2021 17:32:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 3cqwf2ghge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 17:32:46 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1B9HWibd019763;
 Thu, 9 Dec 2021 17:32:45 GMT
Received: from dhcp-10-159-149-161.vpn.oracle.com
 (dhcp-10-159-149-161.vpn.oracle.com [10.159.149.161])
 by userp3030.oracle.com with ESMTP id 3cqwf2gheg-2;
 Thu, 09 Dec 2021 17:32:45 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH 1/1] nvme: Add verbose error logging
Date: Thu,  9 Dec 2021 09:32:13 -0800
Message-Id: <20211209173213.14249-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211209173213.14249-1-alan.adamson@oracle.com>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ake3lf-6WQaicqRXPreGG3_drpaflg7i
X-Proofpoint-GUID: ake3lf-6WQaicqRXPreGG3_drpaflg7i
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211209_093258_409108_9552048A 
X-CRM114-Status: GOOD (  28.65  )
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

Enable more verbose reporting of NVMe errors. The kernel needs to be compiled
with the NVME_VERBOSE_ERRORS kernel config option enabled.

Logged error example:

nvme0n1: Read @ LBA 2304, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/Kconfig  |   8 ++
 drivers/nvme/host/Makefile |   1 +
 drivers/nvme/host/core.c   |   4 +
 drivers/nvme/host/errors.c | 176 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |   6 ++
 include/linux/nvme.h       |   1 +
 6 files changed, 196 insertions(+)
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
index dfaacd472e5d..24fc888e3792 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 nvme-core-y				:= core.o ioctl.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
+nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= errors.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b5de8f5435a..1e0fb4375b35 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -346,6 +346,8 @@ static inline void nvme_end_req(struct request *req)
 
 void nvme_complete_rq(struct request *req)
 {
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
@@ -354,6 +356,8 @@ void nvme_complete_rq(struct request *req)
 
 	switch (nvme_decide_disposition(req)) {
 	case COMPLETE:
+		if (unlikely(status != BLK_STS_OK))
+			nvme_error_log(req);
 		nvme_end_req(req);
 		return;
 	case RETRY:
diff --git a/drivers/nvme/host/errors.c b/drivers/nvme/host/errors.c
new file mode 100644
index 000000000000..4a60e52f55b0
--- /dev/null
+++ b/drivers/nvme/host/errors.c
@@ -0,0 +1,176 @@
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
+static const struct nvme_string_table nvme_errors[] = {
+	{ NVME_SC_SUCCESS,		"Success" },
+	{ NVME_SC_INVALID_OPCODE,	"Invalid Command Opcode" },
+	{ NVME_SC_INVALID_FIELD,	"Invalid Field in Command" },
+	{ NVME_SC_CMDID_CONFLICT,	"Command ID Conflict" },
+	{ NVME_SC_DATA_XFER_ERROR,	"Data Transfer Error" },
+	{ NVME_SC_POWER_LOSS,		"Commands Aborted due to Power Loss Notification" },
+	{ NVME_SC_INTERNAL,		"Internal Error" },
+	{ NVME_SC_ABORT_REQ,		"Command Abort Requested" },
+	{ NVME_SC_ABORT_QUEUE,		"Command Aborted due to SQ Deletion" },
+	{ NVME_SC_FUSED_FAIL,		"Command Aborted due to Failed Fused Command" },
+	{ NVME_SC_FUSED_MISSING,	"Command Aborted due to Missing Fused Command" },
+	{ NVME_SC_INVALID_NS,		"Invalid Namespace or Format" },
+	{ NVME_SC_CMD_SEQ_ERROR,	"Command Sequence Error" },
+	{ NVME_SC_SGL_INVALID_LAST,	"Invalid SGL Segment Descriptor" },
+	{ NVME_SC_SGL_INVALID_COUNT,	"Invalid Number of SGL Descriptors" },
+	{ NVME_SC_SGL_INVALID_DATA,	"Data SGL Length Invalid" },
+	{ NVME_SC_SGL_INVALID_METADATA,	"Metadata SGL Length Invalid" },
+	{ NVME_SC_SGL_INVALID_TYPE,	"SGL Descriptor Type Invalid" },
+	{ NVME_SC_CMB_INVALID_USE,	"Invalid Use of Controller Memory Buffer" },
+	{ NVME_SC_PRP_INVALID_OFFSET,	"PRP Offset Invalid" },
+	{ NVME_SC_ATOMIC_WU_EXCEEDED,	"Atomic Write Unit Exceeded" },
+	{ NVME_SC_OP_DENIED,		"Operation Denied" },
+	{ NVME_SC_SGL_INVALID_OFFSET,	"SGL Offset Invalid" },
+	{ NVME_SC_RESERVED,		"Reserved" },
+	{ NVME_SC_HOST_ID_INCONSIST,	"Host Identifier Inconsistent Format" },
+	{ NVME_SC_KA_TIMEOUT_EXPIRED,	"Keep Alive Timeout Expired" },
+	{ NVME_SC_KA_TIMEOUT_INVALID,	"Keep Alive Timeout Invalid" },
+	{ NVME_SC_ABORTED_PREEMPT_ABORT,	"Command Aborted due to Preempt and Abort" },
+	{ NVME_SC_SANITIZE_FAILED,	"Sanitize Failed" },
+	{ NVME_SC_SANITIZE_IN_PROGRESS,	"Sanitize In Progress" },
+	{ NVME_SC_SGL_INVALID_GRANULARITY,	"SGL Data Block Granularity Invalid" },
+	{ NVME_SC_CMD_NOT_SUP_CMB_QUEUE,	"Command Not Supported for Queue in CMB" },
+	{ NVME_SC_NS_WRITE_PROTECTED,	"Namespace is Write Protected" },
+	{ NVME_SC_CMD_INTERRUPTED,	"Command Interrupted" },
+	{ NVME_SC_TRANSIENT_TR_ERR,	"Transient Transport Error" },
+	{ NVME_SC_LBA_RANGE,		"LBA Out of Range" },
+	{ NVME_SC_CAP_EXCEEDED,		"Capacity Exceeded" },
+	{ NVME_SC_NS_NOT_READY,		"Namespace Not Ready" },
+	{ NVME_SC_RESERVATION_CONFLICT,	"Reservation Conflict" },
+	{ NVME_SC_FORMAT_IN_PROGRESS,	"Format In Progress" },
+	{ NVME_SC_CQ_INVALID,		"Completion Queue Invalid" },
+	{ NVME_SC_QID_INVALID,		"Invalid Queue Identifier" },
+	{ NVME_SC_QUEUE_SIZE,		"Invalid Queue Size" },
+	{ NVME_SC_ABORT_LIMIT,		"Abort Command Limit Exceeded" },
+	{ NVME_SC_ABORT_MISSING,	"Reserved" },
+	{ NVME_SC_ASYNC_LIMIT,		"Asynchronous Event Request Limit Exceeded" },
+	{ NVME_SC_FIRMWARE_SLOT,	"Invalid Firmware Slot" },
+	{ NVME_SC_FIRMWARE_IMAGE,	"Invalid Firmware Image" },
+	{ NVME_SC_INVALID_VECTOR,	"Invalid Interrupt Vector" },
+	{ NVME_SC_INVALID_LOG_PAGE,	"Invalid Log Page" },
+	{ NVME_SC_INVALID_FORMAT,	"Invalid Format" },
+	{ NVME_SC_FW_NEEDS_CONV_RESET,	"Firmware Activation Requires Conventional Reset" },
+	{ NVME_SC_INVALID_QUEUE,	"Invalid Queue Deletion" },
+	{ NVME_SC_FEATURE_NOT_SAVEABLE,	"Feature Identifier Not Saveable" },
+	{ NVME_SC_FEATURE_NOT_CHANGEABLE,	"Feature Not Changeable" },
+	{ NVME_SC_FEATURE_NOT_PER_NS,	"Feature Not Namespace Specific" },
+	{ NVME_SC_FW_NEEDS_SUBSYS_RESET, "Firmware Activation Requires NVM Subsystem Reset" },
+	{ NVME_SC_FW_NEEDS_RESET,	"Firmware Activation Requires Reset" },
+	{ NVME_SC_FW_NEEDS_MAX_TIME,	"Firmware Activation Requires Maximum Time Violation" },
+	{ NVME_SC_FW_ACTIVATE_PROHIBITED,	"Firmware Activation Prohibited" },
+	{ NVME_SC_OVERLAPPING_RANGE,	"Overlapping Range" },
+	{ NVME_SC_NS_INSUFFICIENT_CAP,	"Namespace Insufficient Capacity" },
+	{ NVME_SC_NS_ID_UNAVAILABLE,	"Namespace Identifier Unavailable" },
+	{ NVME_SC_NS_ALREADY_ATTACHED,	"Namespace Already Attached" },
+	{ NVME_SC_NS_IS_PRIVATE,	"Namespace Is Private" },
+	{ NVME_SC_NS_NOT_ATTACHED,	"Namespace Not Attached" },
+	{ NVME_SC_THIN_PROV_NOT_SUPP,	"Thin Provisioning Not Supported" },
+	{ NVME_SC_CTRL_LIST_INVALID,	"Controller List Invalid" },
+	{ NVME_SC_SELT_TEST_IN_PROGRESS,	"Device Self-test In Progress" },
+	{ NVME_SC_BP_WRITE_PROHIBITED,	"Boot Partition Write Prohibited" },
+	{ NVME_SC_CTRL_ID_INVALID,	"Invalid Controller Identifier" },
+	{ NVME_SC_SEC_CTRL_STATE_INVALID,	"Invalid Secondary Controller State" },
+	{ NVME_SC_CTRL_RES_NUM_INVALID,	"Invalid Number of Controller Resources" },
+	{ NVME_SC_RES_ID_INVALID,	"Invalid Resource Identifier" },
+	{ NVME_SC_PMR_SAN_PROHIBITED,	"Sanitize Prohibited" },
+	{ NVME_SC_ANA_GROUP_ID_INVALID,	"ANA Group Identifier Invalid" },
+	{ NVME_SC_ANA_ATTACH_FAILED,	"ANA Attach Failed" },
+	{ NVME_SC_BAD_ATTRIBUTES,	"Conflicting Attributes" },
+	{ NVME_SC_INVALID_PI,		"Invalid Protection Information" },
+	{ NVME_SC_READ_ONLY,		"Attempted Write to Read Only Range" },
+	{ NVME_SC_ONCS_NOT_SUPPORTED,	"ONCS Not Supported" },
+	{ NVME_SC_ZONE_BOUNDARY_ERROR,	"Zoned Boundary Error" },
+	{ NVME_SC_ZONE_FULL,		"Zone Is Full" },
+	{ NVME_SC_ZONE_READ_ONLY,	"Zone Is Read Only" },
+	{ NVME_SC_ZONE_OFFLINE,		"Zone Is Offline" },
+	{ NVME_SC_ZONE_INVALID_WRITE,	"Zone Invalid Write" },
+	{ NVME_SC_ZONE_TOO_MANY_ACTIVE,	"Too Many Active Zones" },
+	{ NVME_SC_ZONE_TOO_MANY_OPEN,	"Too Many Open Zones" },
+	{ NVME_SC_ZONE_INVALID_TRANSITION,	"Invalid Zone State Transition" },
+	{ NVME_SC_WRITE_FAULT,		"Write Fault" },
+	{ NVME_SC_READ_ERROR,		"Unrecovered Read Error" },
+	{ NVME_SC_GUARD_CHECK,		"End-to-end Guard Check Error" },
+	{ NVME_SC_APPTAG_CHECK,		"End-to-end Application Tag Check Error" },
+	{ NVME_SC_REFTAG_CHECK,		"End-to-end Reference Tag Check Error" },
+	{ NVME_SC_COMPARE_FAILED,	"Compare Failure" },
+	{ NVME_SC_ACCESS_DENIED,	"Access Denied" },
+	{ NVME_SC_UNWRITTEN_BLOCK,	"Deallocated or Unwritten Logical Block" },
+	{ NVME_SC_ANA_PERSISTENT_LOSS,	"Asymmetric Access Persistent Loss" },
+	{ NVME_SC_ANA_INACCESSIBLE,	"Asymmetric Access Inaccessible" },
+	{ NVME_SC_ANA_TRANSITION,	"Asymmetric Access Transition" },
+	{ NVME_SC_HOST_PATH_ERROR,	"Host Pathing Error" },
+	{ NVME_SC_HOST_ABORTED_CMD,	"Command Aborted By Host:" },
+};
+#define NVME_ERRORS_SIZE ARRAY_SIZE(nvme_errors)
+
+void nvme_error_log(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_request *nr = nvme_req(req);
+	const struct nvme_string_table *entry;
+	const unsigned char *op_str  = "Unknown";
+	const unsigned char *err_str = "Unknown";
+	unsigned int i;
+
+	if (!ns)
+		return;
+
+	for (i = 0, entry = nvme_ops ; i < NVME_OPS_SIZE ; i++)
+		if (entry[i].code == (req->cmd_flags & REQ_OP_MASK))
+			op_str = entry[i].string;
+
+	for (i = 0, entry = nvme_errors ; i < NVME_ERRORS_SIZE ; i++)
+		if (entry[i].code == (nr->status & 0x7ff))
+			err_str = entry[i].string;
+
+	pr_err("%s: %s @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
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
index b334af8aa264..b994804978c4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -922,4 +922,10 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+extern void nvme_error_log(struct request *req);
+#else
+static inline void nvme_error_log(struct request *req) {}
+#endif  /* CONFIG_NVME_VERBOSE_ERRORS */
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


