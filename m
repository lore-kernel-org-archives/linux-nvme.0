Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8617C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 08:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7BJck8QBcwPKReUVWDCpgZ0WqRxZlLpF56W6k7jEHPI=; b=DqPcm+wEFa2hODLJEOOR4Ub25J
	+0Z0OeV+JMO65IcCOxiVwqKMGRfqZBbeezkR02E+ZPBG9hfsM0i+Ey2o1yNAPdCCYlzY4Ve2ac8bq
	p7CpNZtdLQ62IaqCPRLa5wZ6S6k0jGIUaD87uulFIEWFdzHjTypAHIWzD89cyMMVCWDx5lCi4aP5f
	ZF+2DeX8kw/419YRg+TyOkbROHGJdam7snvyuAkEKRjhb3wJtnpnkBJserBZa1dDxK5C/FrlscaC4
	AxkiUgCKtJqGAJ1N3PuVAnIFpVLGw/5CqDQHugwGP0uvDb+DbPvK7AKh4FeCGZ5lyTXDXvag/hoWc
	gl2WVb6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFXE6-000GNt-P9; Thu, 03 Feb 2022 08:12:22 +0000
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com
 ([40.107.236.67] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFXE3-000GMm-Dr
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 08:12:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsOrDETOKIO1uYE9Q0dvnw+7iDk+HTLzDwmFAKNTnKvl87F3ryjkZnpmLUsbCko+f1lT+24YFooAP4XgXN4eX/KcIKHA6fJ7G1sjN9Q4CedNiIaVFZ/MpDtc/6nhtbPX3nEeg+Bae0X8Kp9fP9BJ2jPyRhpGn02bCsmJOwBFbr4RepwMyP9MqpsmqvN1bV73PgnUc9nLfnXhN1mQpiaKk9VSp4WTGqoG9cRi1f4JdcQwl5iZulJvYf/ja+6cDxwDQNSLH4l9Gddjx9Yx+Iq0wGM7oXQCe7BZhb2JW1uppRex7JFGLZPCVwNt/ih2SabKQJb0qzJoD1V9U/6NJUNfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BJck8QBcwPKReUVWDCpgZ0WqRxZlLpF56W6k7jEHPI=;
 b=EglD/mQg1lCnsdI0219VaKR8nco8/vSnfTncbGZ8TbP5haYRM4al9bLlbXzx1/bmhGPkfCCNx014KSK+/14gFrgspAW0xXH7aGnfXNYitBF89HsTYg9lC8de8oIFWVQHiqUkBKmLTnWsrdds3lnmUj/yOQ2TugpoCVpk6COeVFh/MPXuDwBbJtka4IRyqpJBtA2AnJIOg0dfwmdTjDpR5mHvBTQYMIUX0dKEp2FucTCEISXWnC9sF/XML2tVuywU+iscnIu7wY54rWbUcee8Ropv2qNDG+quHAZOTBKlamgc1Ec0qxFJTAdzxs87Qjg95iFnCzFv7LERcO2AIpkEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BJck8QBcwPKReUVWDCpgZ0WqRxZlLpF56W6k7jEHPI=;
 b=j+FEWcqjd4UzFsztiDANV0iurhOxLRhqoM5TL84kgo2+vQYtOKw6VD++iIz+782zg6A2A13ipgyyIoJ4xhA+U4frdEVaOU8r5Oq83kYvzfupe+B+Euf2m295Avilw74NtmCVZHx9zauXI2k12VsJGhW0pNPLChJ2bGlO+Hj1KMwmVKqWOlYCGTAtlmbnSBMKfzLVxW19/lWuo2Cs68wlm/UeN2n7KDMaooX7/XpUlDRnEvt0J0yBlE/RsixjrsRYqMzRd5nKToJHbx+y/NUyk80Zap0nnnVh2eiIfTvOklOIxDRbV0uSsQtV4jM9nLi5MaNpXfE3BTgzSr+tRaQI6w==
Received: from CO2PR18CA0061.namprd18.prod.outlook.com (2603:10b6:104:2::29)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 08:12:17 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::cc) by CO2PR18CA0061.outlook.office365.com
 (2603:10b6:104:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Thu, 3 Feb 2022 08:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 08:12:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 3 Feb 2022 08:12:16 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 00:12:15 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Alan
 Adamson" <alan.adamson@oracle.com>, Himanshu Madhani
 <himanshu.madhani@oracle.com>
Subject: [PATCH V7 1/1] nvme-core: Add verbose error logging
Date: Thu, 3 Feb 2022 00:11:53 -0800
Message-ID: <20220203081153.162956-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220203081153.162956-1-chaitanyak@nvidia.com>
References: <20220203081153.162956-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b942f60-5c40-42a7-76c4-08d9e6ece45b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4536:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB45364F68F8814CC401956F2DA3289@MN2PR12MB4536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnpiB43IajKllS5E52Xcxmg73wDuxPaysIYhgA6Xv/UKVjTjK/yO21J6uTJAENNBoU9SdbXDJPGWWBKPBIjJpNOHbFfI8O8Ii+4nRsf696iidvd6Hwq7k0wj5uMre1g86lgER8S+0G/HBTo+P+MJL8Xld/8JCcoMJ4eyx9W5A5lKjPw8hsdL/S23uWB7PHgniSrm7wAP5Tk+/aHp/pckgQxSBpwHebH9TYQAthfoUTA87s7ELYuybX2Qjk6K0cPQ/o9qZ7Gc3eIAo5eNx4VGmfQGKnik/Z9RDTenH4K6jJ483Y0CSimGFOQt0fBGmm/UVivBVKFKbrRUqfcSk5Pov+O+iiktN3eMmu8TrNdLmoVUtYPuSl/98gQOYtwWQBv6rgiVjG8YtMAUBzjk+lGy0IB2t2lBjq2Xz6kRjfl9ga7pDGS15an+U9wWlUq3SsoL9vbS5wTLvcKY4MF0XxGAU4vdFefU5e8/gpbdYLGZ+kuG80ZTZM5OBT8Cn/PU4d/Cc1NkKepkO5E0Lxr0AoW4Nwd8SiEgruXGegEgov8BXdT/Z6ZxYkDBQ0x3Q9Cj2LbF0hefiNVtEML2MuICCHBZw9Al6iY9CyDQpKAA3kkEUHl18jci+KbN36eqc7RtSMw0pDOmoSkj2fA6DBiRqu6gn0pdFWC7U+sIx3HWZr/T4PGOiVW+by3tr2Vdp5psk+IesSUgycYI/Y3ex2Pcciy5NBOVhYu0W1Olpf9YtvGIWDw=
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(2906002)(30864003)(40460700003)(5660300002)(86362001)(6666004)(186003)(26005)(16526019)(1076003)(47076005)(83380400001)(336012)(426003)(70206006)(70586007)(8936002)(8676002)(4326008)(82310400004)(508600001)(81166007)(356005)(36860700001)(7696005)(54906003)(6916009)(316002)(36756003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 08:12:16.6099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b942f60-5c40-42a7-76c4-08d9e6ece45b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_001219_609953_A7E0B27A 
X-CRM114-Status: GOOD (  14.96  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

From: Alan Adamson <alan.adamson@oracle.com>

Improves logging of NVMe errors.  If NVME_VERBOSE_ERRORS is configured,
a verbose description of the error is logged, otherwise only status
codes/bits is logged.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
[kch]: fix several nits, cosmetics, and trim down code.
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/Kconfig     |   8 ++
 drivers/nvme/host/Makefile    |   2 +-
 drivers/nvme/host/constants.c | 185 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      |  34 +++++++
 drivers/nvme/host/nvme.h      |  19 ++++
 include/linux/nvme.h          |   1 +
 6 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/constants.c

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
index dfaacd472e5d..476c5c988496 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 
-nvme-core-y				:= core.o ioctl.o
+nvme-core-y				:= core.o ioctl.o constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
new file mode 100644
index 000000000000..7d49eb34b348
--- /dev/null
+++ b/drivers/nvme/host/constants.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVM Express device driver verbose errors
+ * Copyright (c) 2022, Oracle and/or its affiliates
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
+	[nvme_cmd_dsm] = "Dataset Management",
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
+
+const unsigned char *nvme_get_error_status_str(u16 status)
+{
+	status &= 0x7ff;
+	if (status < ARRAY_SIZE(nvme_statuses) && nvme_statuses[status])
+		return nvme_statuses[status & 0x7ff];
+	return "Unknown";
+}
+
+const unsigned char *nvme_get_opcode_str(u8 opcode)
+{
+	if (opcode < ARRAY_SIZE(nvme_ops) && nvme_ops[opcode])
+		return nvme_ops[opcode];
+	return "Unknown";
+}
+
+const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
+{
+	if (opcode < ARRAY_SIZE(nvme_admin_ops) && nvme_admin_ops[opcode])
+		return nvme_admin_ops[opcode];
+	return "Unknown";
+}
+#endif /* CONFIG_NVME_VERBOSE_ERRORS */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37eca20006e0..2054e8855f74 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -299,6 +299,37 @@ static void nvme_retry_req(struct request *req)
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
+static void nvme_log_error(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_request *nr = nvme_req(req);
+
+	if (ns) {
+		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
+		       ns->disk ? ns->disk->disk_name : "?",
+		       nvme_get_opcode_str(nr->cmd->common.opcode),
+		       nr->cmd->common.opcode,
+		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
+		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
+		       nvme_get_error_status_str(nr->status),
+		       nr->status >> 8 & 7,	/* Status Code Type */
+		       nr->status & 0xff,	/* Status Code */
+		       nr->status & NVME_SC_MORE ? "MORE " : "",
+		       nr->status & NVME_SC_DNR  ? "DNR "  : "");
+		return;
+	}
+
+	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s\n",
+			   dev_name(nr->ctrl->device),
+			   nvme_get_admin_opcode_str(nr->cmd->common.opcode),
+			   nr->cmd->common.opcode,
+			   nvme_get_error_status_str(nr->status),
+			   nr->status >> 8 & 7,	/* Status Code Type */
+			   nr->status & 0xff,	/* Status Code */
+			   nr->status & NVME_SC_MORE ? "MORE " : "",
+			   nr->status & NVME_SC_DNR  ? "DNR "  : "");
+}
+
 enum nvme_disposition {
 	COMPLETE,
 	RETRY,
@@ -354,6 +385,9 @@ void nvme_complete_rq(struct request *req)
 
 	switch (nvme_decide_disposition(req)) {
 	case COMPLETE:
+		if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
+			nvme_log_error(req);
+
 		nvme_end_req(req);
 		return;
 	case RETRY:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..5b50ba4eb309 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -930,4 +930,23 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+const unsigned char *nvme_get_error_status_str(u16 status);
+const unsigned char *nvme_get_opcode_str(u8 opcode);
+const unsigned char *nvme_get_admin_opcode_str(u8 opcode);
+#else /* CONFIG_NVME_VERBOSE_ERRORS */
+static inline const unsigned char *nvme_get_error_status_str(u16 status)
+{
+	return "I/O Error";
+}
+static inline const unsigned char *nvme_get_opcode_str(u8 opcode)
+{
+	return "I/O Cmd";
+}
+static inline const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
+{
+	return "Admin Cmd";
+}
+#endif /* CONFIG_NVME_VERBOSE_ERRORS */
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
2.29.0


