Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1602AC47073
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+8yk/RXAzgeOxs0HZ2QPcv3BE3iRRiMlXzsH2N+N1Co=; b=cY1iv6gKfBoO1TPNiFtFlNOfwW
	8+f+K7tSZLrfJhRam+nRfMlc1RMr9rLRiI4zQubdcnvmtw1IIjiMQ+H6Afs6yLT95vcrdTIrZtn8B
	D8W4NZJQyd9/OCDrvan9n24AocLvzfpZdovkK1UWRxEqXf2XsV+5JCKWfqjY9V+C5bjJZp7Vn7e9/
	GregSzsznADSHMqa7NF9FnZHGVU513BYYSj8N1d81NzYsaiLW66RR6ND8hXSBBYqSUnom/P4B9wao
	zU5J4Mw75OJaZvJ6Xwj+4HSBmWNAM//c/NHdG/A0lafABN+WYLHqjaMy9WTtLiWsCx6sjUhgQXqL+
	vQKRxP6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4v-003g0v-0F;
	Sun, 31 Dec 2023 00:53:21 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4r-003fyw-27
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W915WxLf4ho42oG7T5BZh84ehuyl4fHcc8yqUqszInW1klc/RgsYBkmOEqEbh5DEsgzhkgp4pJ1q5eUpzYF3do5c1HMT4bLiifz9Ajrl0J2JRa5qKvXBWzs5FtwCe/i+WDEunDQE/iAcPrjAekag77TtTrbZxXAMjRusj6qqqS0layVbFSPRHZIHkR5kXDiKhYEwiBIOtvT19TUl1fCcyi70tlgdvEKNDsejVILek2B2K2LY76dN7/xTIyquN8lOZt4qnlevKdg88gPHmQj/x2EYqJ0lmrOZUpgzpXssDrWA3Xp3g/XJn5Mq4eYMREKqPsCZLduFTPjVZETuvN5H2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8yk/RXAzgeOxs0HZ2QPcv3BE3iRRiMlXzsH2N+N1Co=;
 b=nFDHQPRJoPDTFnsfE8qQbR5Uy6xPHWdoTK1h11PRt6FRwFd0vX0Qid9Ubs7pWtXDnmz5Gf2F+gSLMlzT8WQT3uJ9vqVKEzzap0MlMD/JLUDjbpikc6DSzmTJXzybxVdGbi2SUfAphHXVU3HTHrbGzhThGnU77O8OIOcZssUfudyC7bVENoYpMLHDbELbAED7NDQb681gb0eQ+k7mH+XGROEAWCHu7yYz1sq8MQ7HVqzaVemXE7W+YYbm8plm3dxNGVvKyUVCobbewk6dLUcKTFf+kaEAvCOUKkJMv+NKcv60TaXl2QYyI44Ueexu/S/UArGO9hZuirT84cxzPLkkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8yk/RXAzgeOxs0HZ2QPcv3BE3iRRiMlXzsH2N+N1Co=;
 b=aDU1QGEpORjLQ6vXc7y45GfQuZTg500awTl7e6vMHxP0kANAYB8XyHRHLtvZTuuA8ydtC4eKOsF45sphY7stdvx6rwAClyVc1nuV6NNeK+FUwg9/0Hc+n8XEAEFIweQRTgT0bWihzRwDz8Mf+kQe96BjA9nj9vl4NujHd7VPp7ZMZ6J8qjpkOxPVJxOlNXW7KWHrs63b9k6aWbyu9gWXpMmgzFK+yLFBl1uM5epvAcL2bKCpG1dTo40pIGrSYpR9RP0yIbKujbmCGpZK8/j8mVWA8qTPJlwhtRx+gDvbC4jRo1gpXjo1AHC8wgNdbCBxzVjkEH0wQHCOb2TF0Kpt8g==
Received: from SN7PR18CA0030.namprd18.prod.outlook.com (2603:10b6:806:f3::7)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sun, 31 Dec
 2023 00:53:10 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::e) by SN7PR18CA0030.outlook.office365.com
 (2603:10b6:806:f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:52:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:52:52 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:52:49 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 00/10] Introduce new max-queue-size configuration
Date: Sun, 31 Dec 2023 02:52:39 +0200
Message-ID: <20231231005249.18294-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 36076248-4e99-4d19-38f7-08dc099adbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acbjcF9RQcr5iNUr0OIvI/lWYZlX2LSvA61MwG5mhV3f6pIOizN1AXRUsfzPDQ+qAj693aw2uM620Wnd+jwj87q5UzOWBWUU5Cout/1vDyzVDCEgn9w/BO7fXyd6eHV+GBgDKWlDtyR22xuanRS7QkfeSEsxqijEGYiMl6e4kzuAi+4P916yrvRrGv+/Hwt5tJxTsWmgjAY6fQpyhrRb9mFFDVmFXXfyiPSQMcax/hHdXZVpqQM9fj3eQEzj9SWlnR47hEnE/M9qZ+iYzRG1TFCMGiabJqvmX8MWAYl1ak9ysAC7mRFKEILtwEZMOfCmDMD546r78CGgKeEoD5mB6UbbiXE1ghKTU6Ro5mJgb+xP/wQ+Puqn82SA/stf2sVtULlaEn3tUHVPHx9wdtFK4T6Zzuiq71F+bYTTD+EVtYgGz/J8XRUXOqFQJMAFiz9nbmVHEtwjXWS4Vk9n3PQnr+KSsG/8dkzUrWJH9Xu3tQxdo9pOEk5J/wK0l21pA1wOW5vFjUqw9FMaooDX4mvfyLcG4ZVF7j8ZpD3xGPL3brPejrDsNcd3R98nyQCNLmtUhMPrZCBHan3ufJzDDcnOvbv48pl2Oo/C42ItlpR0FLif3A2jhCglmpfr4YSWC0sXYsPw2l8IVnhkC8sAASrve/pw6TyeIgEymLJrBkvdhlEisXSCZM2Iqs3ISGguF64eHxAXrFXWfk5nDfYokeM+S58qQ1JfjkrqcneQfSxenpI2JllTr7SICaAm/fOIsXAB
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(47076005)(86362001)(41300700001)(7636003)(36756003)(82740400003)(6666004)(356005)(316002)(8676002)(54906003)(70206006)(70586007)(336012)(426003)(5660300002)(478600001)(83380400001)(110136005)(8936002)(4326008)(2616005)(26005)(1076003)(107886003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:09.8714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36076248-4e99-4d19-38f7-08dc099adbfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165317_703286_937EA67B 
X-CRM114-Status: GOOD (  10.12  )
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

Hi Christoph/Sagi/Keith,
This patch series is mainly for adding a functionality for a user
to configure the maximal queue size for fabrics via port configfs. Using
this interface a user will be able to better control the system and HW
resouces.

Also, I've increased the maximal queue depth for RDMA controllers to be
256 after request from Guixin Liu. This new value will be valid only for
controllers that don't support PI.

While developing this feature I've made some minor cleanups to the header
files.

Max Gurtovoy (10):
  nvme: remove unused definition
  nvme-rdma: move NVME_RDMA_IP_PORT from common file
  nvme-fabrics: move queue size definitions to common header
  nvmet: remove NVMET_QUEUE_SIZE definition
  nvmet: set maxcmd to be per controller
  nvmet: set ctrl pi_support cap before initializing cap reg
  nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
  nvme-rdma: clamp queue size according to ctrl cap
  nvmet: introduce new max queue size configuration entry
  nvmet-rdma: set max_queue_size for RDMA transport

 drivers/nvme/host/fabrics.h       |  3 ---
 drivers/nvme/host/rdma.c          | 19 ++++++++++++++-----
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/configfs.c    | 28 ++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 17 +++++++++++++++--
 drivers/nvme/target/discovery.c   |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  2 --
 drivers/nvme/target/nvmet.h       |  4 ++--
 drivers/nvme/target/passthru.c    |  2 +-
 drivers/nvme/target/rdma.c        | 10 ++++++++++
 include/linux/nvme-rdma.h         |  6 +++++-
 include/linux/nvme.h              |  7 ++++---
 12 files changed, 81 insertions(+), 21 deletions(-)

-- 
2.18.1


