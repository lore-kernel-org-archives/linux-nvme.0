Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B79ED74978
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E4lEq16ltHCG8Y8KiZXG0BCwJTGSWeadNvQrEpjGEZo=; b=BizjznJTGZV5DAvIG2SsYsxSCu
	4G5ueR5ejTcU15KYnGzlYm0bh98N49t/ML4ce7GaeT/q3NLcXnzrtQ1jzeIBU+bFGimoA5K1RH3Ha
	INRQ6midEgp16OMkZVZpE4yL3C74m3DKxjY3wjmBruhCDAorOWbOJvE6jp4/oJ7keRwZmhCaXnE+i
	tZemNuI2z7IctTe0PyQfmdeViWQHSb531yLLfKnhXTuGuBJZUPe6KGsg0ErSqt2fP+OpUTCr4nKcQ
	51sFvYQ8U20IS86xo9EJGYRxu2BZZFUZl/BFXha8rNU8XWxs2+mYAYPRvXuSldGGrch09DS+yGVBf
	ySrbtCdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62V8-0000000H1c0-3T0Y;
	Wed, 30 Oct 2024 06:48:18 +0000
Received: from mail-dm6nam12on20616.outbound.protection.outlook.com ([2a01:111:f403:2417::616] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62V6-0000000H1b3-0Z7W
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8kJ4EIap+Y5fTpOzo1uuI8G9trrlrwXD/fAFha5KO+PRphqHD+/ptydlPPWlOpXa9yJXaLe0UUFfFjFiX1DW7g5CVONPnPaReQ9A8CpugCSBtpmTowir94EnOP0NiAbK8vO/N+ZL2fp3LfAvTZHjkod/cEGv0E/O1v7XCQPFd1ohv+4ga9ktE8o1x5pcLZvpR+nGtp/NW+fkV3K4GXClYqZtLSDCconA+knW0AuzbI/RxV/RXP7VFPnnHd77zSat0M2ArhQaFfWyyBSl1OT7yWHYXrsgVU33xonIg+1vyMaGzN/YAIlRDtxDy/4FOgBMGl5gi6mg0uO7amK+frUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4lEq16ltHCG8Y8KiZXG0BCwJTGSWeadNvQrEpjGEZo=;
 b=oTuum0OEvdMCmHFIA9G/wW0Sy7w4fv/GB36l1dBlbmH9x8JWEgAgVpuWZzWN/AWhBLdP6Y/9SkcUuLVsZcpH05Z/24fvCn310nYK635c9hv+GGVyM9tF5dVC4TEPGJo9i+jAW3lZU7zmH15Pf5vpC0C+VRHzJubirmvVHnG53JpA6Mmiwe27J8OPbXbSm0vs0V9dE5TcUqZURFmdCrvZStwCAlaNacM4iIPl6r50FBuOD4mx1TMB7+Hk5scUvO2PrK4IKMiy2Kgkrg3G7elchOKxnhgKxNGufAe0b6xjcd9fkzfZC5LYNoPsdUYYkwoWjwOZmcdsza7Yz4uR3XmwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4lEq16ltHCG8Y8KiZXG0BCwJTGSWeadNvQrEpjGEZo=;
 b=VNLm6n3QY2MEis7nJBM01AYObDVD854tScHchosQTF067FHkmWKjzmTW78dRKTT/x9tqxSDT8JGPB7pQniOCOnn8FpgsHSBWtKfQWRGHnKmVArJP9zNkI2Gbq05b6Ad3VH9SO/RmtCZVt/3qpcCNQ9D8UuAksK+fiIU9CPnHOCkuqJ9SN8YNe4OByszh+A6NL9QDmVG+Z2f+u48mb+pX5K+o5n+DwinvH698rosIHvQYwBdXgWfshkKKVTpLf57XgSutMBniNsY35GnVkTLK33gk6drmo99HJ7hs1JtxTeHKCDr5pjF145PeRl7K8iB6Fp5on+hrSt4osQz02Rsveg==
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 06:48:07 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::5f) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 06:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.0 via Frontend Transport; Wed, 30 Oct 2024 06:48:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 23:47:54 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 23:47:53 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme-core: remove repeated wq flags
Date: Tue, 29 Oct 2024 23:47:37 -0700
Message-ID: <20241030064737.95291-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c649d07-643c-4235-2067-08dcf8aecffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ByX7TwHnC/OT01M6aW3oBHN4EiB/9XLyhFHb67jdQj9I+BbkbZt8AX2QTXeP?=
 =?us-ascii?Q?qZ3scpvXf2uSB3DGXNh71Hibda1Q54Rf03IubLvRuLFo+orEW4zmcP5qzDh3?=
 =?us-ascii?Q?xOmNyfhmNSn4MKJLtbhsIBSWvccD5fCEO1nNK61VYgEO+oTs7dGp53bSS9dL?=
 =?us-ascii?Q?KB2BNJGMZRNHpLT2dA2usMPnL8b7caQWIiAXhTWcDeeXDo7Yg6tvEXQ1xDkA?=
 =?us-ascii?Q?/IZQ3yVT2hG0+rNngqBuUDyTIQU8XFDeGsTayDAyYpUSCB2RBsjt/R108GKf?=
 =?us-ascii?Q?D/FomxTrGHYWpWDgJflqvw/WvR4o8pBOQmTWgyu/5Tkg8+HptQmm9VLTCHrp?=
 =?us-ascii?Q?xOc1vuTdXqAm86Wj90Et+t9ni0ui4RxY9fpPUYC/O82oRBThs0KFd7X68ze2?=
 =?us-ascii?Q?sYcywdlo4Xo7Y6L4u/+7OoQNcWvkZPataA+Ly/BS2ogRyVNmIsCxS7Z0gHOs?=
 =?us-ascii?Q?SmfuYQxeaCRrnRoKZZSLq+obxqHM0u+KuJotiyvbRXeb8c/RadV9lfxSQnNq?=
 =?us-ascii?Q?F5fAxHlIyNE8FDvqelgGAyriIUv9dJXdm2rXQBcbFKwH4VlUoxEgeFBWprIS?=
 =?us-ascii?Q?R1nVxw3pBFakQznjZmWnYD5WIPwpDmOyu/ik7D5nOD0QxL/LZephJ0u/sdsz?=
 =?us-ascii?Q?5MtuWMZ9P8xoLkgLUfht3s50uxiNk1QV+p8JKQIzwFOOGZRbrr4sPcRj+rc2?=
 =?us-ascii?Q?SheKihPMubzgL3zH52tmM0cPDZqwB43ld35ED67/zmzZZNetM62hLXga8cpl?=
 =?us-ascii?Q?fI1Xxed4kKa/oniX/AdYbXkWdTyVY8njJElKxjBr2+vCGR5d4yWWc5AayzcN?=
 =?us-ascii?Q?e3jlfa/EirRZW2N3YG1ycYbJc6ntOc3UXMwuSurOMpiCPh1gtC33OVOTiaiw?=
 =?us-ascii?Q?7WTtrWRoIC/oxhtNrjd3SG951X68Jxu3JzYCfxLCH9QZYKxyVuThbua6j71x?=
 =?us-ascii?Q?58A299SSBx84VLF/S2sguJE/rz+fmm0Zt8amwh9q7G36AUI/DkGnr9q9bKmT?=
 =?us-ascii?Q?CyWedwSq2/UD0O7T7fX42jYyPB57lkGROO8xweiHw2cN5NUNI5j2hEtwdSqh?=
 =?us-ascii?Q?hEDZ/amvaOUFhgp3owiohhy6zah+MXGsO+JDWlN2tupHG2RNdkbgwwqkryyB?=
 =?us-ascii?Q?tBR3q0J7XCq4UfpTJoE069e/vsedN02moV72pmCMpkCcmzyRNXsNyMD05G3Z?=
 =?us-ascii?Q?pgPRa1CGYeNiI++Eqs0dRf6YAuvVbhMa5qpoNfkLA98YX2I8aDYNpSJgi0da?=
 =?us-ascii?Q?snon1cz2PcD5SVTGhvRzRYSzHp5SQFJQctVLF3UTw+S3Bp8PH3cvSH+RuyQK?=
 =?us-ascii?Q?jQw7jcBg4Q1HWYSUZm5z9EusRISpVw+LLqiQ6L1/nKlfT1VMYNBhi53PH3Mq?=
 =?us-ascii?Q?TCZUw+Hz7W1KXn7vtC7WmhuRs63h3g+6K+qu2Wy4QyO2oumzzg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:48:07.5791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c649d07-643c-4235-2067-08dcf8aecffa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_234816_244720_80C2F173 
X-CRM114-Status: GOOD (  10.54  )
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

In nvme_core_init() nvme_wq, nvme_reset_wq, nvme_delete_wq share same
flags :- WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS.

Insated of repeating these flags in each call use the common variable.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..e9aac07f4c26 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5009,22 +5009,20 @@ static inline void _nvme_check_size(void)
 
 static int __init nvme_core_init(void)
 {
+	unsigned int wq_flags = WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS;
 	int result = -ENOMEM;
 
 	_nvme_check_size();
 
-	nvme_wq = alloc_workqueue("nvme-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	nvme_wq = alloc_workqueue("nvme-wq", wq_flags, 0);
 	if (!nvme_wq)
 		goto out;
 
-	nvme_reset_wq = alloc_workqueue("nvme-reset-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	nvme_reset_wq = alloc_workqueue("nvme-reset-wq", wq_flags, 0);
 	if (!nvme_reset_wq)
 		goto destroy_wq;
 
-	nvme_delete_wq = alloc_workqueue("nvme-delete-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	nvme_delete_wq = alloc_workqueue("nvme-delete-wq", wq_flags, 0);
 	if (!nvme_delete_wq)
 		goto destroy_reset_wq;
 
-- 
2.40.0


