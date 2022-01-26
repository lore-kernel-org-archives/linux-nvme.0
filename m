Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF04FC2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXjLsLPjX5HtuZn5lNhcSWwKoTCyEmw4RUfvnBOAmCU=; b=LlIJdqXyFmyBGZAxrOSJskco7I
	tJJUx2RsQ2JAQWuRz6o++DydnrEWEtup4oQ5VXVSljzjnNuJUAxsjYwKl5/SdZrazRgWq0NdcskM3
	7pbiTdshEhObaZWCmWTACf5rm6XdR8wmPQ6B7GcSCCkOtSPUIwzisYmw2AGzULcIGCwBm1J+2l5qu
	ZlH1A0smBFPzRdivrHFSoI4nQBr4UJ5sjP2pgi3AY0uP4BOcg9KJrzIkGVSo8s6/aygXqen2nKJWH
	caopM5oXnjNR4yovSdhaQxckZWAHKsx4ftkzdQqyVhtztcGFGW1+WGvdfNqCKvObvVF0pYlJlK0my
	2TE5c83A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCn7N-00DImQ-QI; Wed, 26 Jan 2022 18:34:05 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCn7A-00DIkl-87
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 18:33:54 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QINPI0006445; 
 Wed, 26 Jan 2022 18:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=EXjLsLPjX5HtuZn5lNhcSWwKoTCyEmw4RUfvnBOAmCU=;
 b=FGni5dGWNex2MG17639HZ9Q7PsAmMFXa7gyeMRQ1OX70ZNKA37kDFfxTg/aOUP89cZpt
 IAYPmptCtmpxaHUkNlv5J6xuvxPpsDk2aHhMCKpiXJayDGDq8JBc5+rKl2+zIHOcLnyk
 8Fc+vdWDcUnLftJp2RTieTz59vQeqIj6O61SoiLhDGrOF+47NgJwyjIdbl/YAv+QtXJL
 1oy7duXpXucm6W6QkLn+K0ROUfVs/XVrwviVoA+kn5RQiw+4b6bSstTytjhKrIAWvrLU
 9yO1aeIFRplKQLXgZo81WVd370B5LCxyGWcjrH9KPzKuT6D+97f/DIF5gA37ZMvyQtdn DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7ay41n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jan 2022 18:33:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QIRO0A147782;
 Wed, 26 Jan 2022 18:33:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 3dr7yj9b86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jan 2022 18:33:45 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20QIXi0j170622;
 Wed, 26 Jan 2022 18:33:45 GMT
Received: from dhcp-10-159-150-213.vpn.oracle.com
 (dhcp-10-159-150-213.vpn.oracle.com [10.159.150.213])
 by aserp3030.oracle.com with ESMTP id 3dr7yj9b6p-2;
 Wed, 26 Jan 2022 18:33:45 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V5 1/1] nvme: Add verbose error logging
Date: Wed, 26 Jan 2022 10:33:13 -0800
Message-Id: <20220126183313.85877-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220126183313.85877-1-alan.adamson@oracle.com>
References: <20220126183313.85877-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MJ7vDeaX8X8CqTuu7b-Xmyqkr1N9cp3g
X-Proofpoint-ORIG-GUID: MJ7vDeaX8X8CqTuu7b-Xmyqkr1N9cp3g
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_103352_348433_DC15F72F 
X-CRM114-Status: GOOD (  28.41  )
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

Verbose logging examples:
[  183.333734] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR

[  227.767945] nvme0: Activate Firmware(0x10), Invalid Field in Command (sct 0x0 / sc 0x2) DNR

Non-verbose logging examples:
[   41.280509] nvme0n1: I/O Cmd(0x2) @ LBA 0, 1 blocks, I/O Error (sct 0x2 / sc 0x81) DNR

[   77.249153] nvme0: Admin Cmd(0x10), I/O Error (sct 0x0 / sc 0x2) DNR

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/Kconfig  |   8 ++
 drivers/nvme/host/Makefile |   2 +-
 drivers/nvme/host/core.c   |   3 +
 drivers/nvme/host/errors.c | 229 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |   2 +
 include/linux/nvme.h       |   1 +
 6 files changed, 244 insertions(+), 1 deletion(-)
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
index 5e0bfda04bd7..ca5d36fcf4f8 100644
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
index 000000000000..a840ea61686e
--- /dev/null
+++ b/drivers/nvme/host/errors.c
@@ -0,0 +1,229 @@
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
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+static const char * const nvme_ops[] = {
+	[nvme_cmd_flush] = "Flush",
+	[nvme_cmd_write] = "Write",
+	[nvme_cmd_read] = "Read",
+	[nvme_cmd_write_uncor] = "Write Uncorrectable",
+	[nvme_cmd_compare] = "Compare",
+	[nvme_cmd_write_zeroes] = "Write Zeros",
+	[nvme_cmd_dsm] = "Deallocate (DSM)",
+	[nvme_cmd_verify] = "Verify",
+	[nvme_cmd_resv_register] = "Reservation Register",
+	[nvme_cmd_resv_report] = "Reservation Report",
+	[nvme_cmd_resv_acquire] = "Reservation Acquire",
+	[nvme_cmd_resv_release] = "Reservation Release",
+	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
+	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
+	[nvme_cmd_zone_append] = "Zone Management Append",
+};
+
+static const char * const nvme_admin_ops[] = {
+	[nvme_admin_delete_sq] = "Delete SQ",
+	[nvme_admin_create_sq] = "Create SQ",
+	[nvme_admin_get_log_page] = "Get Log Page",
+	[nvme_admin_delete_cq] = "Delete CQ",
+	[nvme_admin_create_cq] = "Create CQ",
+	[nvme_admin_identify] = "Identify",
+	[nvme_admin_abort_cmd] = "Abort Command",
+	[nvme_admin_set_features] = "Set Features",
+	[nvme_admin_get_features] = "Get Features",
+	[nvme_admin_async_event] = "Async Event",
+	[nvme_admin_ns_mgmt] = "Namespace Management",
+	[nvme_admin_activate_fw] = "Activate Firmware",
+	[nvme_admin_download_fw] = "Download Firmware",
+	[nvme_admin_dev_self_test] = "Device Self Test",
+	[nvme_admin_ns_attach] = "Namespace Attach",
+	[nvme_admin_keep_alive] = "Keep Alive",
+	[nvme_admin_directive_send] = "Directive Send",
+	[nvme_admin_directive_recv] = "Directive Receive",
+	[nvme_admin_virtual_mgmt] = "Virtual Management",
+	[nvme_admin_nvme_mi_send] = "NVMe Send MI",
+	[nvme_admin_nvme_mi_recv] = "NVMe Receive MI",
+	[nvme_admin_dbbuf] = "Doorbell Buffer Config",
+	[nvme_admin_format_nvm] = "Format NVM",
+	[nvme_admin_security_send] = "Security Send",
+	[nvme_admin_security_recv] = "Security Receive",
+	[nvme_admin_sanitize_nvm] = "Sanitize NVM",
+	[nvme_admin_get_lba_status] = "Get LBA Status",
+};
+
+static const char * const nvme_statuses[] = {
+	[NVME_SC_SUCCESS] = "Success",
+	[NVME_SC_INVALID_OPCODE] = "Invalid Command Opcode",
+	[NVME_SC_INVALID_FIELD] = "Invalid Field in Command",
+	[NVME_SC_CMDID_CONFLICT] = "Command ID Conflict",
+	[NVME_SC_DATA_XFER_ERROR] = "Data Transfer Error",
+	[NVME_SC_POWER_LOSS] = "Commands Aborted due to Power Loss Notification",
+	[NVME_SC_INTERNAL] = "Internal Error",
+	[NVME_SC_ABORT_REQ] = "Command Abort Requested",
+	[NVME_SC_ABORT_QUEUE] = "Command Aborted due to SQ Deletion",
+	[NVME_SC_FUSED_FAIL] = "Command Aborted due to Failed Fused Command",
+	[NVME_SC_FUSED_MISSING] = "Command Aborted due to Missing Fused Command",
+	[NVME_SC_INVALID_NS] = "Invalid Namespace or Format",
+	[NVME_SC_CMD_SEQ_ERROR] = "Command Sequence Error",
+	[NVME_SC_SGL_INVALID_LAST] = "Invalid SGL Segment Descriptor",
+	[NVME_SC_SGL_INVALID_COUNT] = "Invalid Number of SGL Descriptors",
+	[NVME_SC_SGL_INVALID_DATA] = "Data SGL Length Invalid",
+	[NVME_SC_SGL_INVALID_METADATA] = "Metadata SGL Length Invalid",
+	[NVME_SC_SGL_INVALID_TYPE] = "SGL Descriptor Type Invalid",
+	[NVME_SC_CMB_INVALID_USE] = "Invalid Use of Controller Memory Buffer",
+	[NVME_SC_PRP_INVALID_OFFSET] = "PRP Offset Invalid",
+	[NVME_SC_ATOMIC_WU_EXCEEDED] = "Atomic Write Unit Exceeded",
+	[NVME_SC_OP_DENIED] = "Operation Denied",
+	[NVME_SC_SGL_INVALID_OFFSET] = "SGL Offset Invalid",
+	[NVME_SC_RESERVED] = "Reserved",
+	[NVME_SC_HOST_ID_INCONSIST] = "Host Identifier Inconsistent Format",
+	[NVME_SC_KA_TIMEOUT_EXPIRED] = "Keep Alive Timeout Expired",
+	[NVME_SC_KA_TIMEOUT_INVALID] = "Keep Alive Timeout Invalid",
+	[NVME_SC_ABORTED_PREEMPT_ABORT] = "Command Aborted due to Preempt and Abort",
+	[NVME_SC_SANITIZE_FAILED] = "Sanitize Failed",
+	[NVME_SC_SANITIZE_IN_PROGRESS] = "Sanitize In Progress",
+	[NVME_SC_SGL_INVALID_GRANULARITY] = "SGL Data Block Granularity Invalid",
+	[NVME_SC_CMD_NOT_SUP_CMB_QUEUE] = "Command Not Supported for Queue in CMB",
+	[NVME_SC_NS_WRITE_PROTECTED] = "Namespace is Write Protected",
+	[NVME_SC_CMD_INTERRUPTED] = "Command Interrupted",
+	[NVME_SC_TRANSIENT_TR_ERR] = "Transient Transport Error",
+	[NVME_SC_INVALID_IO_CMD_SET] = "Invalid IO Command Set",
+	[NVME_SC_LBA_RANGE] = "LBA Out of Range",
+	[NVME_SC_CAP_EXCEEDED] = "Capacity Exceeded",
+	[NVME_SC_NS_NOT_READY] = "Namespace Not Ready",
+	[NVME_SC_RESERVATION_CONFLICT] = "Reservation Conflict",
+	[NVME_SC_FORMAT_IN_PROGRESS] = "Format In Progress",
+	[NVME_SC_CQ_INVALID] = "Completion Queue Invalid",
+	[NVME_SC_QID_INVALID] = "Invalid Queue Identifier",
+	[NVME_SC_QUEUE_SIZE] = "Invalid Queue Size",
+	[NVME_SC_ABORT_LIMIT] = "Abort Command Limit Exceeded",
+	[NVME_SC_ABORT_MISSING] = "Reserved", /* XXX */
+	[NVME_SC_ASYNC_LIMIT] = "Asynchronous Event Request Limit Exceeded",
+	[NVME_SC_FIRMWARE_SLOT] = "Invalid Firmware Slot",
+	[NVME_SC_FIRMWARE_IMAGE] = "Invalid Firmware Image",
+	[NVME_SC_INVALID_VECTOR] = "Invalid Interrupt Vector",
+	[NVME_SC_INVALID_LOG_PAGE] = "Invalid Log Page",
+	[NVME_SC_INVALID_FORMAT] = "Invalid Format",
+	[NVME_SC_FW_NEEDS_CONV_RESET] = "Firmware Activation Requires Conventional Reset",
+	[NVME_SC_INVALID_QUEUE] = "Invalid Queue Deletion",
+	[NVME_SC_FEATURE_NOT_SAVEABLE] = "Feature Identifier Not Saveable",
+	[NVME_SC_FEATURE_NOT_CHANGEABLE] = "Feature Not Changeable",
+	[NVME_SC_FEATURE_NOT_PER_NS] = "Feature Not Namespace Specific",
+	[NVME_SC_FW_NEEDS_SUBSYS_RESET] = "Firmware Activation Requires NVM Subsystem Reset",
+	[NVME_SC_FW_NEEDS_RESET] = "Firmware Activation Requires Reset",
+	[NVME_SC_FW_NEEDS_MAX_TIME] = "Firmware Activation Requires Maximum Time Violation",
+	[NVME_SC_FW_ACTIVATE_PROHIBITED] = "Firmware Activation Prohibited",
+	[NVME_SC_OVERLAPPING_RANGE] = "Overlapping Range",
+	[NVME_SC_NS_INSUFFICIENT_CAP] = "Namespace Insufficient Capacity",
+	[NVME_SC_NS_ID_UNAVAILABLE] = "Namespace Identifier Unavailable",
+	[NVME_SC_NS_ALREADY_ATTACHED] = "Namespace Already Attached",
+	[NVME_SC_NS_IS_PRIVATE] = "Namespace Is Private",
+	[NVME_SC_NS_NOT_ATTACHED] = "Namespace Not Attached",
+	[NVME_SC_THIN_PROV_NOT_SUPP] = "Thin Provisioning Not Supported",
+	[NVME_SC_CTRL_LIST_INVALID] = "Controller List Invalid",
+	[NVME_SC_SELT_TEST_IN_PROGRESS] = "Device Self-test In Progress",
+	[NVME_SC_BP_WRITE_PROHIBITED] = "Boot Partition Write Prohibited",
+	[NVME_SC_CTRL_ID_INVALID] = "Invalid Controller Identifier",
+	[NVME_SC_SEC_CTRL_STATE_INVALID] = "Invalid Secondary Controller State",
+	[NVME_SC_CTRL_RES_NUM_INVALID] = "Invalid Number of Controller Resources",
+	[NVME_SC_RES_ID_INVALID] = "Invalid Resource Identifier",
+	[NVME_SC_PMR_SAN_PROHIBITED] = "Sanitize Prohibited",
+	[NVME_SC_ANA_GROUP_ID_INVALID] = "ANA Group Identifier Invalid",
+	[NVME_SC_ANA_ATTACH_FAILED] = "ANA Attach Failed",
+	[NVME_SC_BAD_ATTRIBUTES] = "Conflicting Attributes",
+	[NVME_SC_INVALID_PI] = "Invalid Protection Information",
+	[NVME_SC_READ_ONLY] = "Attempted Write to Read Only Range",
+	[NVME_SC_ONCS_NOT_SUPPORTED] = "ONCS Not Supported",
+	[NVME_SC_ZONE_BOUNDARY_ERROR] = "Zoned Boundary Error",
+	[NVME_SC_ZONE_FULL] = "Zone Is Full",
+	[NVME_SC_ZONE_READ_ONLY] = "Zone Is Read Only",
+	[NVME_SC_ZONE_OFFLINE] = "Zone Is Offline",
+	[NVME_SC_ZONE_INVALID_WRITE] = "Zone Invalid Write",
+	[NVME_SC_ZONE_TOO_MANY_ACTIVE] = "Too Many Active Zones",
+	[NVME_SC_ZONE_TOO_MANY_OPEN] = "Too Many Open Zones",
+	[NVME_SC_ZONE_INVALID_TRANSITION] = "Invalid Zone State Transition",
+	[NVME_SC_WRITE_FAULT] = "Write Fault",
+	[NVME_SC_READ_ERROR] = "Unrecovered Read Error",
+	[NVME_SC_GUARD_CHECK] = "End-to-end Guard Check Error",
+	[NVME_SC_APPTAG_CHECK] = "End-to-end Application Tag Check Error",
+	[NVME_SC_REFTAG_CHECK] = "End-to-end Reference Tag Check Error",
+	[NVME_SC_COMPARE_FAILED] = "Compare Failure",
+	[NVME_SC_ACCESS_DENIED] = "Access Denied",
+	[NVME_SC_UNWRITTEN_BLOCK] = "Deallocated or Unwritten Logical Block",
+	[NVME_SC_ANA_PERSISTENT_LOSS] = "Asymmetric Access Persistent Loss",
+	[NVME_SC_ANA_INACCESSIBLE] = "Asymmetric Access Inaccessible",
+	[NVME_SC_ANA_TRANSITION] = "Asymmetric Access Transition",
+	[NVME_SC_HOST_PATH_ERROR] = "Host Pathing Error",
+};
+#endif /* CONFIG_NVME_VERBOSE_ERRORS */
+
+void nvme_error_log(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_request *nr = nvme_req(req);
+	const unsigned char *op_str  = "I/O Cmd";
+	const unsigned char *admin_op_str  = "Admin Cmd";
+	const unsigned char *err_str = NULL;
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+	if ((nr->status & 0x7ff) < ARRAY_SIZE(nvme_statuses) &&
+	    nvme_statuses[nr->status & 0x7ff] != NULL)
+		err_str = nvme_statuses[nr->status & 0x7ff];
+	else
+		err_str = "Unknown";
+#endif
+	if (err_str == NULL)
+		err_str =  "I/O Error";
+
+	if (ns) {
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+		if (nr->cmd->common.opcode < ARRAY_SIZE(nvme_ops) &&
+		    nvme_ops[nr->cmd->common.opcode] != NULL)
+			op_str = nvme_ops[nr->cmd->common.opcode];
+		else
+			op_str = "Unknown";
+#endif
+		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
+		       ns->disk ? ns->disk->disk_name : "?",
+		       op_str,
+		       nr->cmd->common.opcode,
+		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
+		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
+		       err_str,
+		       nr->status >> 8 & 7, /* Status Code Type */
+		       nr->status & 0xff,    /* Status Code */
+		       nr->status & NVME_SC_MORE ? "MORE " : "",
+		       nr->status & NVME_SC_DNR  ? "DNR "  : "");
+	} else {
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+		if (nr->cmd->common.opcode < ARRAY_SIZE(nvme_admin_ops) &&
+		    nvme_admin_ops[nr->cmd->common.opcode] != NULL)
+			admin_op_str = nvme_admin_ops[nr->cmd->common.opcode];
+		else
+			admin_op_str = "Unknown";
+#endif
+		pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s\n",
+		       dev_name(nr->ctrl->device),
+		       admin_op_str,
+		       nr->cmd->common.opcode,
+		       err_str,
+		       nr->status >> 8 & 7,	/* Status Code Type */
+		       nr->status & 0xff,	/* Status Code */
+		       nr->status & NVME_SC_MORE ? "MORE " : "",
+		       nr->status & NVME_SC_DNR  ? "DNR "  : "");
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_error_log);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..3216156b71b2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -930,4 +930,6 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
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


