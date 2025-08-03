Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5328C87FD3
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Aug 2025 02:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDgxvXoLtWsTMxVXjlxzFNjWcd6HKUQuLlkocjqYA58=; b=2xb8go54GL2F+vvL8VJyVppwmO
	MVjneG4qlMcF0NYqswUdHdgFkhG8rO1VNJMA/7TEWMx3le076CJM4nJv53KyuC53kdxWIOuDdwggS
	Hj0l30kzOl4QeVJAqw3JDb2cfIZkdPeD+x6lufy1RniFeqIBgx7vGaYwmqUr/r5x7ufH2BxUySL9G
	ZqN4ESdtFR7e1pKvDCXf6q2bu7PkuX7LfGoddpXcB2JyccFb7itozhtWOUYwcfQHP+MKIdvZoHatW
	WK/IlALSaPiUTyVEiueShRgEUABhYtpBFZy0M8ugrBq2JRK3X7WroohNnmp9qniGIGzCFekI1eEDi
	ARPXFXHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiOmD-000000084Tw-41qB;
	Sun, 03 Aug 2025 02:48:45 +0000
Received: from mail-bn7nam10on20618.outbound.protection.outlook.com ([2a01:111:f403:2009::618] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiOmA-000000084ST-32yD
	for linux-nvme@lists.infradead.org;
	Sun, 03 Aug 2025 02:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxW80U8hmVzfLlbENo/o5tJpNAorVBjisJYXqZJv/zkxivh0gIKRL8zMF0SXnlhDz6/BXmnmoIZVImSPZOYNlWjLYedVz431zl3gWPGMKyUTHaN6jpUTu8nf9JAET4OjL7+IUuaZr2mhQOx7qJ83j7OMQaZdkwPPU6mdfrE5p8sAqj5otTdM4yIWLZER0NiXdDMkl0o8pI+AvUJfUAbN0mDX5EpwbkU0Gnsyiyl3lmnlFgETPzKHXJQ+WftfYOGiDm6Me8Jl6vPvTIJ7JalglK14WthLoRtBd1FvQllLi8/9uA2FOUOOD9sbkEkm/b2fbv9qU1cIVauZxNlx/a8btA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDgxvXoLtWsTMxVXjlxzFNjWcd6HKUQuLlkocjqYA58=;
 b=naFEWQuNHYZ0o/F3N2M9S9R9ZtdOJkzxY0O1lD6cg5htdC05hdp4rlvZjcYXLP9QIrJZFQxsMohlIZn/TsCnVJPUiJrW22VQ/wQW4or0KdzW3M8ShfP18mQPdfajMG0Ehtn+DbNVNZ8Jrkj60HEvaGOdrfXD80VrpG7zRnQXNZS4fD8AZm6oD9lIQMsVrZ8oN1/jSs+h19TTAwbEBvpj7fnXG1mQy7ZfTpl2rVwDDQCB72LrKI+1I1JNj4tuWhSZyQXRdBaQCoFPFAxPB52gyZgEi6QCy2sqD5xrQwl4YuNZfA2BNwoBdiMCtwoHdaWhIq64o6IMPltVSmU+VzfdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDgxvXoLtWsTMxVXjlxzFNjWcd6HKUQuLlkocjqYA58=;
 b=U7EA4+nbA4GN5plCLGBEUoeai8R0daBanwXr7BCwMJw0pKTjX4Vgd14gM4FvUbttS4cGJ19Hb/20IuYOSRqrlMAuDuKKOQmUdMqWZ9gu9RHM9My+gMZSxHJe51/4L++e4x+pohkqZhnmXcqA2c4VkiwZYA8AV+eIBi6o9Poh6Z0RGFFCs5oATdX7ZGJLP/OAuxLjEovF071k8YEPTB3UEfH7b8TI80mGZNKGPl5tTxCa0i9nv5ERjfH4BbUp2fn/sFv6CkYCovSDKAq/wIFWaix6Yd3FFwJdw6BGcSLvG1OIZ8am6i7cDzF5iLOv+PEA7EZaMFGQJFVez7PFWsyNzA==
Received: from CH2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610::19) by
 BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Sun, 3 Aug
 2025 02:48:31 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::86) by CH2PR05CA0006.outlook.office365.com
 (2603:10b6:610::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.10 via Frontend Transport; Sun,
 3 Aug 2025 02:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Sun, 3 Aug 2025 02:48:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 2 Aug
 2025 19:47:51 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 2 Aug
 2025 19:47:23 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
	<alex.williamson@redhat.com>, <cohuck@redhat.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
	<kevin.tian@intel.com>, <mjrosato@linux.ibm.com>, <mgurtovoy@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <kvm@vger.kernel.org>,
	<Konrad.wilk@oracle.com>, <martin.petersen@oracle.com>,
	<jmeneghi@redhat.com>, <arnd@arndb.de>, <schnelle@linux.ibm.com>,
	<bhelgaas@google.com>, <joao.m.martins@oracle.com>, Chaitanya Kulkarni
	<kch@nvidia.com>, Lei Rao <lei.rao@intel.com>
Subject: [RFC PATCH 1/4] vfio-nvme: add vfio-nvme lm driver infrastructure
Date: Sat, 2 Aug 2025 19:47:02 -0700
Message-ID: <20250803024705.10256-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20250803024705.10256-1-kch@nvidia.com>
References: <20250803024705.10256-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5cff2f-7531-4fa4-c7c9-08ddd2383b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QOjKiNWRLqlWUVmxpEA+rFDTK52DA3FU0z4hFDQqxTsSn5emYisM6llmVNr3?=
 =?us-ascii?Q?0+5vZSaCq8jj1+l8KUl+lIZJr3z0SS4GoUc6aJpdAiuAdvYliOYmud1bjCwO?=
 =?us-ascii?Q?Veb7jGbYFxrY0tCyhm5zCNmUJRpnl1vITHn+liD5f8xzm5sxpxYhDZ0wguyn?=
 =?us-ascii?Q?qd+JbRYXqDmcLcdxsZ60r5JFKaoWe9iBYX3L+csEtBCtCGH5n+E/KfYAzSCM?=
 =?us-ascii?Q?eEtprqd1t0Ens2kzHCqpdKLPtc3Lg6Oanu6ZQWU87QyGRNYtKfR5vPoy8z2g?=
 =?us-ascii?Q?JQaM2pdHBuzNkf4mODyfdF65vEw38UkfbPVX1R/iFOsjw9mGCAg3AInFkbOe?=
 =?us-ascii?Q?naOeFrd91gsuzrtDRoQOLKPUB4F1Rqzh0lldwzm/m9F/HzkNbQlMkbSs7IuZ?=
 =?us-ascii?Q?A84Ou/MXv0oVhtC1C7aICwEBtO4oQ8hGeTkebj4FODU2EEU5WYm+I4FAGoRd?=
 =?us-ascii?Q?lgRnvz5+yUmFEGjxYGFfeReqkxY1SxTeObV4fzhmX+QOY/Tly/iE57QGJ5za?=
 =?us-ascii?Q?oHcpq9pObdIUpLiU2ZqtCj4pTA+Nu5VaexBz4DffC/f1FUf3/4PXuJqlLIC/?=
 =?us-ascii?Q?j9XtT3+uQMDwhoQHxRH9eJfp28+YtvPUhmC/YaOP/Q/0QJ+Yq3yEbK7IJaep?=
 =?us-ascii?Q?7elXi1WN+htWOQbiAAvOJE3TL5nrGMSlAaGqLeD4ZZ07EFjmUXWrCUrMrFcM?=
 =?us-ascii?Q?gEFRvvzbMt7f/fmnbj5KrZAS+oDAjL81TlpI61KIUGcN741PEw3VbM9wXkMH?=
 =?us-ascii?Q?aOPS3zgRF6meGZ75vwRnNmRvL8C74CaLNDQYCyPCD3U35kmOaMhKKyiZrZf2?=
 =?us-ascii?Q?Z5hmyqTzJSaWkvotdXJSV2+IepRB8VGzPkVj0MZA9egWUMoviu4LxRTaxUFw?=
 =?us-ascii?Q?Movz0ZLXSxJtYC9yVKJCKaU3dGJ8f/K+9EyxR/hd72Aw94bZe40V+g7Sk2jD?=
 =?us-ascii?Q?acHDila2ZkOrtfmNNFXVj0f0Qj9Tj0LJj6Jek8hZ2wYyeN1Xxvgk3sEZRdLn?=
 =?us-ascii?Q?lsHUpk26ew6nNkVVBEU/02HpQtMFksYYBkm2wBuwXF2wLSVIeGf750MN5fd4?=
 =?us-ascii?Q?uJ+sb8AjGmaoNETHdfFPsvXE8CGC1r7qRh+b9sTvqzQ+S49kPBh7Oc2/EUrA?=
 =?us-ascii?Q?2/IQ9KiK+BMh8mYSuWS/FiGldvlEVSPJNVana0anOgw7U1OMZRBsZ7JwfyB8?=
 =?us-ascii?Q?bO6VjmYmBe1g+s8PnfQWZj7rbiPaSKEVVyi8kdoU88LImoS4YIyVw6f3LZtx?=
 =?us-ascii?Q?c6sdL6cVdHJSHix13PYkptOCnu7vm1M9aU02n/HJIuCbrIfBSCdvtOI50t7a?=
 =?us-ascii?Q?Z8wYZAPU6sTOXmh/lIZmC8W4mGNtmEXCx8tBQ1gXIdPIXYHnuJmsMAXhSn2D?=
 =?us-ascii?Q?UpKxNoxtJ2i6N0khhGqCefOhhZm1dKC6e6EvvDlksleIaHzfNCOnioLQTdF7?=
 =?us-ascii?Q?a3DdkYM3eZNfj8NbPOmQJY2EWc3vo30xZNb/o8QH23xySCJTXEQ5jdziUwsP?=
 =?us-ascii?Q?dt4qYte+DGToVYT2MPzYsNFhcT+piXwuV9dChl5uRGTJ/Xdw83r8XJ9Svw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 02:48:30.0768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5cff2f-7531-4fa4-c7c9-08ddd2383b3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250802_194842_843248_0C4FF4F8 
X-CRM114-Status: GOOD (  21.38  )
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

Add foundational infrastructure for vfio-nvme, enabling support for live
migration of NVMe devices via the VFIO framework. The following
components are included:

- Core driver skeleton for vfio-nvme support under drivers/vfio/pci/nvme/
- Definitions of basic data structures used in live migration
  (e.g., nvmevf_pci_core_device and nvmevf_migration_file)
- Implementation of helper routines for managing migration file state
- Integration of PCI driver callbacks and error handling logic
- Registration with vfio-pci-core through nvmevf_pci_ops
- Initial support for VFIO migration states and device open/close flows

Subsequent patches will build upon this base to implement actual live
migration commands and complete the vfio device state handling logic.

Signed-off-by: Lei Rao <lei.rao@intel.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/vfio/pci/Kconfig       |   2 +
 drivers/vfio/pci/Makefile      |   2 +
 drivers/vfio/pci/nvme/Kconfig  |  10 ++
 drivers/vfio/pci/nvme/Makefile |   3 +
 drivers/vfio/pci/nvme/nvme.c   | 196 +++++++++++++++++++++++++++++++++
 drivers/vfio/pci/nvme/nvme.h   |  36 ++++++
 6 files changed, 249 insertions(+)
 create mode 100644 drivers/vfio/pci/nvme/Kconfig
 create mode 100644 drivers/vfio/pci/nvme/Makefile
 create mode 100644 drivers/vfio/pci/nvme/nvme.c
 create mode 100644 drivers/vfio/pci/nvme/nvme.h

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 2b0172f54665..8f94429e7adc 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -67,4 +67,6 @@ source "drivers/vfio/pci/nvgrace-gpu/Kconfig"
 
 source "drivers/vfio/pci/qat/Kconfig"
 
+source "drivers/vfio/pci/nvme/Kconfig"
+
 endmenu
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index cf00c0a7e55c..be8c4b5ee0ba 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -10,6 +10,8 @@ obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
 
 obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
 
+obj-$(CONFIG_NVME_VFIO_PCI) += nvme/
+
 obj-$(CONFIG_HISI_ACC_VFIO_PCI) += hisilicon/
 
 obj-$(CONFIG_PDS_VFIO_PCI) += pds/
diff --git a/drivers/vfio/pci/nvme/Kconfig b/drivers/vfio/pci/nvme/Kconfig
new file mode 100644
index 000000000000..12e0eaba0de1
--- /dev/null
+++ b/drivers/vfio/pci/nvme/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NVME_VFIO_PCI
+	tristate "VFIO support for NVMe PCI devices"
+	depends on NVME_CORE
+	depends on VFIO_PCI_CORE
+	help
+	  This provides migration support for NVMe devices using the
+	  VFIO framework.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/pci/nvme/Makefile b/drivers/vfio/pci/nvme/Makefile
new file mode 100644
index 000000000000..2f4a0ad3d9cf
--- /dev/null
+++ b/drivers/vfio/pci/nvme/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_NVME_VFIO_PCI) += nvme-vfio-pci.o
+nvme-vfio-pci-y := nvme.o
diff --git a/drivers/vfio/pci/nvme/nvme.c b/drivers/vfio/pci/nvme/nvme.c
new file mode 100644
index 000000000000..08bee3274207
--- /dev/null
+++ b/drivers/vfio/pci/nvme/nvme.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, INTEL CORPORATION. All rights reserved
+ * Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved
+ */
+
+#include <linux/device.h>
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+#include <linux/anon_inodes.h>
+#include <linux/kernel.h>
+#include <linux/vfio_pci_core.h>
+
+#include "nvme.h"
+
+static void nvmevf_disable_fd(struct nvmevf_migration_file *migf)
+{
+	mutex_lock(&migf->lock);
+
+	/* release the device states buffer */
+	kvfree(migf->vf_data);
+	migf->vf_data = NULL;
+	migf->disabled = true;
+	migf->total_length = 0;
+	migf->filp->f_pos = 0;
+	mutex_unlock(&migf->lock);
+}
+
+static void nvmevf_disable_fds(struct nvmevf_pci_core_device *nvmevf_dev)
+{
+	if (nvmevf_dev->resuming_migf) {
+		nvmevf_disable_fd(nvmevf_dev->resuming_migf);
+		fput(nvmevf_dev->resuming_migf->filp);
+		nvmevf_dev->resuming_migf = NULL;
+	}
+
+	if (nvmevf_dev->saving_migf) {
+		nvmevf_disable_fd(nvmevf_dev->saving_migf);
+		fput(nvmevf_dev->saving_migf->filp);
+		nvmevf_dev->saving_migf = NULL;
+	}
+}
+
+static void nvmevf_state_mutex_unlock(struct nvmevf_pci_core_device *nvmevf_dev)
+{
+	lockdep_assert_held(&nvmevf_dev->state_mutex);
+again:
+	spin_lock(&nvmevf_dev->reset_lock);
+	if (nvmevf_dev->deferred_reset) {
+		nvmevf_dev->deferred_reset = false;
+		spin_unlock(&nvmevf_dev->reset_lock);
+		nvmevf_dev->mig_state = VFIO_DEVICE_STATE_RUNNING;
+		nvmevf_disable_fds(nvmevf_dev);
+		goto again;
+	}
+	mutex_unlock(&nvmevf_dev->state_mutex);
+	spin_unlock(&nvmevf_dev->reset_lock);
+}
+
+static struct nvmevf_pci_core_device *nvmevf_drvdata(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
+
+	return container_of(core_device, struct nvmevf_pci_core_device,
+			    core_device);
+}
+
+static int nvmevf_pci_open_device(struct vfio_device *core_vdev)
+{
+	struct nvmevf_pci_core_device *nvmevf_dev;
+	struct vfio_pci_core_device *vdev;
+	int ret;
+
+	nvmevf_dev = container_of(core_vdev, struct nvmevf_pci_core_device,
+			core_device.vdev);
+	vdev = &nvmevf_dev->core_device;
+
+	ret = vfio_pci_core_enable(vdev);
+	if (ret)
+		return ret;
+
+	if (nvmevf_dev->migrate_cap)
+		nvmevf_dev->mig_state = VFIO_DEVICE_STATE_RUNNING;
+	vfio_pci_core_finish_enable(vdev);
+	return 0;
+}
+
+static void nvmevf_pci_close_device(struct vfio_device *core_vdev)
+{
+	struct nvmevf_pci_core_device *nvmevf_dev;
+
+	nvmevf_dev = container_of(core_vdev, struct nvmevf_pci_core_device,
+			core_device.vdev);
+
+	if (nvmevf_dev->migrate_cap) {
+		mutex_lock(&nvmevf_dev->state_mutex);
+		nvmevf_disable_fds(nvmevf_dev);
+		nvmevf_state_mutex_unlock(nvmevf_dev);
+	}
+
+	vfio_pci_core_close_device(core_vdev);
+}
+
+static const struct vfio_device_ops nvmevf_pci_ops = {
+	.name = "nvme-vfio-pci",
+	.release = vfio_pci_core_release_dev,
+	.open_device = nvmevf_pci_open_device,
+	.close_device = nvmevf_pci_close_device,
+	.ioctl = vfio_pci_core_ioctl,
+	.device_feature = vfio_pci_core_ioctl_feature,
+	.read = vfio_pci_core_read,
+	.write = vfio_pci_core_write,
+	.mmap = vfio_pci_core_mmap,
+	.request = vfio_pci_core_request,
+	.match = vfio_pci_core_match,
+};
+
+static int nvmevf_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct nvmevf_pci_core_device *nvmevf_dev;
+	int ret;
+
+	nvmevf_dev = vfio_alloc_device(nvmevf_pci_core_device, core_device.vdev,
+				       &pdev->dev, &nvmevf_pci_ops);
+	if (IS_ERR(nvmevf_dev))
+		return PTR_ERR(nvmevf_dev);
+
+	dev_set_drvdata(&pdev->dev, &nvmevf_dev->core_device);
+	ret = vfio_pci_core_register_device(&nvmevf_dev->core_device);
+	if (ret)
+		goto out_put_dev;
+
+	return 0;
+
+out_put_dev:
+	vfio_put_device(&nvmevf_dev->core_device.vdev);
+	return ret;
+}
+
+static void nvmevf_pci_remove(struct pci_dev *pdev)
+{
+	struct nvmevf_pci_core_device *nvmevf_dev = nvmevf_drvdata(pdev);
+
+	vfio_pci_core_unregister_device(&nvmevf_dev->core_device);
+	vfio_put_device(&nvmevf_dev->core_device.vdev);
+}
+
+static void nvmevf_pci_aer_reset_done(struct pci_dev *pdev)
+{
+	struct nvmevf_pci_core_device *nvmevf_dev = nvmevf_drvdata(pdev);
+
+	if (!nvmevf_dev->migrate_cap)
+		return;
+
+	/*
+	 * As the higher VFIO layers are holding locks across reset and using
+	 * those same locks with the mm_lock we need to prevent ABBA deadlock
+	 * with the state_mutex and mm_lock.
+	 * In case the state_mutex was taken already we defer the cleanup work
+	 * to the unlock flow of the other running context.
+	 */
+	spin_lock(&nvmevf_dev->reset_lock);
+	nvmevf_dev->deferred_reset = true;
+	if (!mutex_trylock(&nvmevf_dev->state_mutex)) {
+		spin_unlock(&nvmevf_dev->reset_lock);
+		return;
+	}
+	spin_unlock(&nvmevf_dev->reset_lock);
+	nvmevf_state_mutex_unlock(nvmevf_dev);
+}
+
+static const struct pci_error_handlers nvmevf_err_handlers = {
+	.reset_done = nvmevf_pci_aer_reset_done,
+	.error_detected = vfio_pci_core_aer_err_detected,
+};
+
+static struct pci_driver nvmevf_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.probe = nvmevf_pci_probe,
+	.remove = nvmevf_pci_remove,
+	.err_handler = &nvmevf_err_handlers,
+	.driver_managed_dma = true,
+};
+
+module_pci_driver(nvmevf_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Chaitanya Kulkarni <kch@nvidia.com>");
+MODULE_DESCRIPTION("NVMe VFIO PCI - VFIO PCI driver with live migration support for NVMe");
diff --git a/drivers/vfio/pci/nvme/nvme.h b/drivers/vfio/pci/nvme/nvme.h
new file mode 100644
index 000000000000..ee602254679e
--- /dev/null
+++ b/drivers/vfio/pci/nvme/nvme.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, INTEL CORPORATION. All rights reserved
+ * Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved
+ */
+
+#ifndef NVME_VFIO_PCI_H
+#define NVME_VFIO_PCI_H
+
+#include <linux/kernel.h>
+#include <linux/vfio_pci_core.h>
+#include <linux/nvme.h>
+
+struct nvmevf_migration_file {
+	struct file *filp;
+	struct mutex lock;
+	bool disabled;
+	u8 *vf_data;
+	size_t total_length;
+};
+
+struct nvmevf_pci_core_device {
+	struct vfio_pci_core_device core_device;
+	int vf_id;
+	u8 migrate_cap:1;
+	u8 deferred_reset:1;
+	/* protect migration state */
+	struct mutex state_mutex;
+	enum vfio_device_mig_state mig_state;
+	/* protect the reset_done flow */
+	spinlock_t reset_lock;
+	struct nvmevf_migration_file *resuming_migf;
+	struct nvmevf_migration_file *saving_migf;
+};
+
+#endif /* NVME_VFIO_PCI_H */
-- 
2.40.0


