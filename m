Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAF9C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0TFfM5/+0QRab5RISvgaDxhu1vHFYAF/IkP5obZlVpg=; b=n/rjXPYf1z9YAtjXO8qBPv2gCW
	/siRm/wJ7JfPQt9Jsu5rxrVFm1wt+AaOT77uBRGgtXED+lGxS1dDmlWO7dbVgWJU+PK1qVkl+H7bM
	XKAzWHkEeY+43DGlCXadHNSF2+iJpsnFmFhi/8B9oFU2+3KwJkeNQJjxw5TWo8tUMCRiuml+AZJgx
	IdHWfEpLUkyOfnrA/QGtA9NqSmETLVd0paqAORVGd7ZTzZ5HnGMoA5oS15Z+C8LAgZV4o7kVCdau3
	wD850q9Rfez2gmrg3WHhSgk6EMDyUStNooa8tpoLspba7zOsb+ZBt4aBMV7aWJI5t+1BHq1mycoOr
	hacYpP6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxQ-00Gqn8-0E;
	Tue, 23 Jan 2024 14:40:56 +0000
Received: from mail-co1nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2416::601] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxM-00Gqm7-2L
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:40:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXTtdPKxBt6/ths/ykLQIK0OgAUoSRYHggCuzYWJespklI2E4xCsLpqt0H5t5dxnuU1YuckNGrWiiQb6bSNuvayR/h85cc8uVp2V2JHAb4RgCZsU54EITFT1cuE77tN+daDaVz2jA1B/Z8DJSSToW2RGvMK5d/1fvrI50vfeMz0yDnCZsQyLPy663xgUSyi17Wxk0xAbGyCKztbg/A7LAlDkAi+rC4405sGdjd/d2nBGBnABweSJtZjvf9z9c8NtwwC+RnyfShCWA2r2XV6SGFNCYKR7RoWYNPZ5yNzgdEc1VbFKhafD8noEdX+X/Y/lrqqL+2p5/xxl085SckYdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TFfM5/+0QRab5RISvgaDxhu1vHFYAF/IkP5obZlVpg=;
 b=XvWzOshOK9TLsvWCtLS+TzkKN/GfXuHWjPLxKICh+98fC2ZwPOFTLYp5cJhleoLmxwMF/qzaslbpGpbibo058pzD4L+XYJDQtsX+irP0GuWfORls3a+27dgqmH2iz8yv3WfwI103TNHwxsluJBCB/0qJD7Zc5LpBcfFERwaAuKcI8svDQP7ht8fj9KhAx27N/ZcxffjrYgkuyIgNAb91/H/jeLjKmpoO1zqyG77MjjUE8w9z3jRZ5a6Y4vnfTlWI36UbA8Rv8RzZkYkauKR4H8oDdw9PBMjMWcS0PBsTTtXxMI6ZmptFbdSHk6DY6EkfKRexJbZA1c5CZb5rJb+vwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TFfM5/+0QRab5RISvgaDxhu1vHFYAF/IkP5obZlVpg=;
 b=H5kLbpDRsdQLY8e+s9Zyz/GitF/lnL7Xr8QwSGiK7+zQWeyZotzPAYu39GnBzV51P+Ph3IRA30ldzx23t6Ms0Xgmuhr29Y3+Lef3zkp8ayhOSxc4o4s/HmG38pZaVbP3/qB1rlDB5AnKyaXcs1Y1pTbUo8F33oS/oN67mcisUx3hkViSVWVpG9V21hYgH0SkXv+P3ZbrJePJwqor6IUcDEqSvq+Ip/Ula2EVDkfMWe+Ruis4Bxkt3tXqEo1rT1d3lGnWiYPRfoIP0pSQ0I2s+MXCwSMqKKetkx7B2vcrZ/Sn3XwijMB1Wdr/C6Taeh4pLL2w2orBlFdScAG3foqzrQ==
Received: from MN2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:208:1b4::33)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 14:40:47 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::32) by MN2PR15CA0020.outlook.office365.com
 (2603:10b6:208:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Tue, 23 Jan 2024 14:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:40:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:35 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:35 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:33 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v3 0/8] Introduce new max-queue-size configuration
Date: Tue, 23 Jan 2024 16:40:24 +0200
Message-ID: <20240123144032.27801-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 3953df9e-fa28-4cba-adf5-08dc1c214914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xa2X8WCEBpzctc7zKdzkDjvZmAdfHbMe43KnqtPhO7mW3RjYUWOI49o0nspjez2HNlKCws988keig4pnRDE7tvYAU3812s/262gL/P2w9JW9uglkZbuqkjYE7xtwlZQb/eLpjuB7ObkSbjDbL/8zCmuj59YHv2COL6x4eRBcayZQkvo1nFMduHsGRi4ER4v22efcYvUW+0j1X2axLVN/1xXHavXC1UjdSyUldIob3x6u4rbY6JxXlrlHmp9D3DP6vXE6TOTvYac6RDtyyQgbsM1TvXJnY71ojHW+DRNYzjF/Z4Fh2dIE8URdwMDSJi3l0A5vJmRNNAXhcJOz2QukEfQw74LS6TskRo8e+1rjGqLbn7xI2wNhkLlMnC752OXk5SS0+bJdcM4oZcrWTGT6kYDb4QXN1XpacEGOxhW4eYjd44BdnZYOgCeMz4hgM/FQq274rKT02RrlWF/y0JoUBVeWYGdaFd54/Ryu17TBYt1IHxcHR7ieoL/q308dQBgh0JFhKU0Qz3ahXPNgk46Aq35229hgOqICpmLm/mbQ7tgGCF6toNBMRflPTTwUATCiqHuMUtd+GbRPvNrAMPa/kLM326TKFXpPjSPtW2m+TTl07+D0FIXrA0POI8KIJcydvmDKgqaOVkHno2pJDP5nuToeRP6M9mkk+zAfZoCK8+Qlz3BcUJ2orLuQXFrxW7RKTFyEOXoSJfQcUwWSDlx7yueAMvub1q1/cqwiraehW6Iz8MCLivno1iBX3NHf/9Tv
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(107886003)(6666004)(336012)(26005)(1076003)(2616005)(426003)(356005)(86362001)(7636003)(36756003)(82740400003)(41300700001)(47076005)(83380400001)(4326008)(36860700001)(5660300002)(110136005)(2906002)(8936002)(8676002)(6636002)(54906003)(478600001)(70586007)(70206006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:40:46.3327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3953df9e-fa28-4cba-adf5-08dc1c214914
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064052_806610_4EED7A71 
X-CRM114-Status: UNSURE (   9.90  )
X-CRM114-Notice: Please train this message.
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
This patch series is mainly for adding an interface for a user to
configure the maximal queue size for fabrics via port configfs. Using
this interface a user will be able to better control the system and HW
resources.

Also, I've increased the maximal queue depth for RDMA controllers to be
256 after request from Guixin Liu. This new value will be valid only for
controllers that don't support PI.

While developing this feature I've made some minor cleanups as well.

Changes from v2:
 - collected Reviewed-by signatures (Sagi and Christoph)
 - added local variable to simplify code in patch 6/8 (Christoph)

Changes from v1:
 - collected Reviewed-by signatures (Sagi and Guixin Liu)
 - removed the patches that unify fabric host and target max/min/default
   queue size definitions (Sagi)
 - align MQES and SQ size according to the NVMe Spec (patch 2/8)

Max Gurtovoy (8):
  nvme-rdma: move NVME_RDMA_IP_PORT from common file
  nvmet: compare mqes and sqsize only for IO SQ
  nvmet: set maxcmd to be per controller
  nvmet: set ctrl pi_support cap before initializing cap reg
  nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
  nvme-rdma: clamp queue size according to ctrl cap
  nvmet: introduce new max queue size configuration entry
  nvmet-rdma: set max_queue_size for RDMA transport

 drivers/nvme/host/rdma.c          | 14 ++++++++++----
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/configfs.c    | 28 ++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 18 ++++++++++++++++--
 drivers/nvme/target/discovery.c   |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  5 ++---
 drivers/nvme/target/nvmet.h       |  6 ++++--
 drivers/nvme/target/passthru.c    |  2 +-
 drivers/nvme/target/rdma.c        | 10 ++++++++++
 include/linux/nvme-rdma.h         |  6 +++++-
 include/linux/nvme.h              |  2 --
 11 files changed, 78 insertions(+), 17 deletions(-)

-- 
2.18.1


