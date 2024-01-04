Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2509C47077
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R6bj3ajbcqh57GDhFt5yUa0H+uStiKIzQRSKX8Sn2tg=; b=A9/Io4564NxWv3BI6cNk/DCbV/
	ljuDHn96OUTdP6YaSnlfjeOJGNWkVIS6JNmIeDyP4gdNOPtMmxcHY/ArGZ2ZFOvfpCjTHnhxly5dZ
	B5LtIfmU/jC6tlRAuOigM09JgxQW0oBc9ZvmihH3Na0vU4jeiBN1dK+EzP978lN+O2FC/pkRTMlDo
	bKDTy2vJjduvrv+cnctZtYBeGbe249RjtD8AmT+aqhGzdxgXRIZst2rjMh7N4etiCfw4BfQyMMmaH
	kQYVF20EcGsX+LFl1gU25FA3qouAtTzdKy55bwMgZZTsp/9HpWEtIqsfSFIpdKw0jMoe4rMe9ynCD
	dYGgNa6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzV-00DML8-0H;
	Thu, 04 Jan 2024 09:26:17 +0000
Received: from mail-sn1nam02on2061e.outbound.protection.outlook.com ([2a01:111:f400:7ea9::61e] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzS-00DMK1-0K
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEpAFKxu7+nl0IM9k6IpcOKfFQw/10j3RtEeKhCj5rEnIYxlYi70Eb2exQlFi5jBZT4CenitipsTVasNS9ofz7nDI6jTNVIg1ZQ/9moeHMiL9WlaYPV6nV/GmSF6ZLjfw8aOjlCttWNvYbB5Cd5IrN8OQAztZ8FXWqXObIYb7N7VjqsDw7lZqtmp6JTg8nKMTs9dcEWrVV80+VzV603b8WKTRlxGNLNoxJkIFD985icJCx9q+up6ItW3aBy9FKBeM2qFvnS//co0Qq4Y3RBb/Z3Y3JODpGIZtjVre8NSucZDRLOgd76kdkiTg2urIy58EgML4CNDU27UjMT0yFDGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6bj3ajbcqh57GDhFt5yUa0H+uStiKIzQRSKX8Sn2tg=;
 b=PNjBKQDh+6XGhW6rxdBBV0UoHKfakqJNRaShrfa/Ujp9KZtyKaENA+WQOLJsAL42vSqr7qWpzzL4kx43+1Z7y9kOQpA6WrkE1brHPcRZgyO9q7DLK5GQ5v7m+JbSusCF0IDy64LlU6WmUML8oCw1o7L5QTeUEbSr3kLMcAopWmhaS7X/cDTYLLe52oG05TLA6VYqnv9lDxEz1ew+bis715ZDVLadeke0rmET4Sk8XSC0AyqEQ9bBgQt44ed+if7PNOCpg+kedl77oRJNo49WjAo/edCNPi6az7s1RqUW9LeMjBq6hd6Nq3LdjlZNgvz14XkuR2IAz6MAhzZOUWKBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6bj3ajbcqh57GDhFt5yUa0H+uStiKIzQRSKX8Sn2tg=;
 b=eO7f+1p/RKPQ1thl38NIpWrhkKLVIQy5cQDXidi3V+UsSIFDq1k3oNtaBbSD6zF17EthXYkBVNRQjWrnLCcJEaZ9iM0dRhvrjgfJlTf2zqq1StH0hJMKW3JXKGu+Unb24Z5w8eblSgAFexBUo2ly0HV+r4xUOiOGm74FX0V8UbfUIgxYmzSY2Yi38hVuSCJbKbfKEGNxPFgxGJoqOBEdaN6nT6uNbEEZT0wNRC8cE9Xvwk8XKFSht4yl3UJfsrO8U8fyNLRBPewFlDUt182CXeM4PxL9kgEggqGOvNlU47m1iRx2zhPgPm18f6XNygwhAVs8A3Zz/K3TJnvCspqjog==
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 09:26:07 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::ea) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.1 via Frontend Transport; Thu, 4 Jan 2024 09:26:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:25:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:25:51 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:25:49 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v2 0/8] Introduce new max-queue-size configuration
Date: Thu, 4 Jan 2024 11:25:41 +0200
Message-ID: <20240104092549.25721-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: cccdc5bb-5815-4ad3-7bf6-08dc0d072e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5Vgk9UnVuicR2vv4YWr5QrEMbxOMcuGyTnrLB6LwXxIi3xPlMtCH7SnpxPRJYCYjyqozas/otF5rWtV8xW72q/FOMyTI/H/YY+CEpVHQBaw4F3/1Ar3y4wM/IBkX8L8puzIIG53S1uoAk/9GAxQ08GMyrAnJEsRMNRkRTvf6DemPoQFb/iAkujZhViLu/JhQoFdtWBNpnCNabLLaXAcMAuAxO0zg8Ggyhuz3FtNpU31IqBisXeWw1s+KCYnAHlEooDsJrNcYDk8I62FizeHpMbgncJY7j3XiK5/OFDLM7UWrHpUyi6PeNqr9ce4IxUitbVu7QCdWbMfhsJXoTiI9l2yVQ0JtkIoAHCm/uqL2Dl6lpSELJjElFUReGxpP/AD+o2zQv6VRhG6EufVRybmbDabMkCv04/lWyxMft83sIB1TMR0Vc+4ADR7u98HfAeaCv9131dS+OUA3W1rL/vpxMov+6SZdYg4uPP6RdvrglE02PSe8B5jXsqi/8VL6Z4HqmVLHhuRbSV8fJoxeWK1uPCmoCYOkMYK85PisMJj3TTGxK1KIdQ+r++XFBAIqklx9XqAAvm+nSesnCnjfCxRJNY9rk36fFux/mu7SpCPJ9IDK9h4SdVNKAbV4w1X7uLMKxC5ozuPV+7dLym+tl5SDKaiQb1LcReFRikx0uVNxsZtrCT8svS51jCfpl34S2ZP3WEtuwlITuQEmOvJmWKhBS3ZaLorSkgRR7UMWF1QjQ3OjPwHNDCnuGfW+M+4UYMG
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(40480700001)(40460700003)(5660300002)(2906002)(8676002)(316002)(4326008)(70206006)(54906003)(70586007)(6666004)(110136005)(36756003)(47076005)(2616005)(7636003)(356005)(478600001)(86362001)(8936002)(82740400003)(36860700001)(426003)(26005)(1076003)(336012)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:06.9691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cccdc5bb-5815-4ad3-7bf6-08dc0d072e30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012614_142215_770AC7CD 
X-CRM114-Status: GOOD (  10.72  )
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

 drivers/nvme/host/rdma.c          | 19 ++++++++++++++-----
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
 11 files changed, 82 insertions(+), 18 deletions(-)

-- 
2.18.1


