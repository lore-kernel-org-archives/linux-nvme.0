Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4355CC46CD2
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t0Un6T/2VAttotSZOOysmV6mq7h+qiDn7xDyHVTXfHo=; b=vzNPxuyj6H+yWzaPgYhbzU07It
	0phv1Y6Af2BYadSS61FQe3a85V7YOFIq2JOmvEqRPlqOoPmtUdQhQMslgE6C1/0UrC7VwduVXQZwu
	KMl+qvXtp8y9cy5OuADmTUPwNciWbUIeluIgZghxUelQAC8pfKwkJEY07fQFxq8dlXH5pC+xL9FNp
	Pnqdpk/V6LkXdbBG/x7IuJrgHndPhtUX3kuQ130XmgB24Cpd5ygXvNesPgOU0jdpunsN/UtYTwPim
	2k0aTVsfqtTnqwccCJe4FwOQHhEFtC1HoVbNS+JfXbdbYws4xVspY+Ixh7mtqjeN1tJCNtOZCgHI3
	hUCqhnCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4u-003g0c-1E;
	Sun, 31 Dec 2023 00:53:20 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4r-003fyv-1o
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2Lm1Qg9KDCmTyVBS91qZs87bhtyfz1BsLsLadnrOM27cinAKbJtY2KnaJztuOQpyj4JG4tWu4+BYjSlt1+o4krSt+mGDAO3BvNPJt4SoAaJWca5ThBm6l8kLGngZNy8oxUC2jl/8lOwiczO1/CZVOy7ounuCnagv+5brBezoWPHx8xiPBKrUlZKCWlfeNrJluplV5GvN5BtSpMf2hazq0L/Vh8I5X5wdWRdi5ek4Q0k5hM5s8JLEcMZmAFh9XLLlzJjbGUrHVsUVpzGw6E+viYnbnHJ1arf2XZk1xh1L9zeVmkdI+PNcpeip5RZu3S18JR6ETD0dzZr+iF6LBNpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0Un6T/2VAttotSZOOysmV6mq7h+qiDn7xDyHVTXfHo=;
 b=TiNHk7bumrdkZsYhMQjl2wpwRxBTycQvYp5CwmVV1pU5/6fP8dYNg6PtMFr72xa3ANL9zIc6w6EgCUC/Pnem3JmU7o3Zpq+SIgYHu8c8lT6q042+m/9yJxeM0l11FZNJGfuGpn/8bESGPKnQDttqPSTtU3UMhrMfoiCN6NqV9wBScl5AUivd3S5UquNf9IblENYBg104IRlCS5lrjUv8wzyg9S+ESrMIfvtDO29vYyL9J6y0D4XBbu0yg0p9+wD0gWsFV0CjxZixH8TerdmOneDogorZF2Yb6j8ZTLrNXHDP24NIlMEGyjL7kMdg0i8dOnnXr8gtNqLXq5izXhYrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0Un6T/2VAttotSZOOysmV6mq7h+qiDn7xDyHVTXfHo=;
 b=JooCoTchP6l1W0m3CpdrEy4IyHlDuSJT+49mRbJeKTWJ7UfZwBt6KxxMzQbKJxS1BiuKD9Scjp8cXuCdhNbeKdkHpDIfNA4V+peTbx4P4WaAa5anW5rhHq1s3Mosw/pDE6PJG/0et0bN9FncRMULB5IJjspuZ2G7OISxZpNV29XyRkAyMGlYLQbDwBRDAepi0q8Ug7dmqigFN1iGeMSzj50U4CCPGLA8TJFnJjbsx2E1BBwjErBjkSYrlNJM8PSDQCdAYl7iqlCHvJ5mKsSoI8q33GSJ0xpEhji0QIha+t70XDFCQd8t/z98EgTFm4WKX0jrUOHhgo7DKTwLlJlayQ==
Received: from SN7PR18CA0018.namprd18.prod.outlook.com (2603:10b6:806:f3::10)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 00:53:10 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::83) by SN7PR18CA0018.outlook.office365.com
 (2603:10b6:806:f3::10) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:52:58 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:52:57 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:52:55 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 02/10] nvme-rdma: move NVME_RDMA_IP_PORT from common file
Date: Sun, 31 Dec 2023 02:52:41 +0200
Message-ID: <20231231005249.18294-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1843be-843b-4ce6-2149-08dc099adc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gx8yMOD7uXKQodQjU5eo4tDAlLNx6eAbc0oAwoqjl+Y7Qnmnd6dHj1L8yrsomTZiTDqNNANIjKyGSz1wUP+xpNHVZbhpwkQdtdxa3uyx8p0lLsCtZosLYrt7yViAtUbIWKuGKkbFdxs/cNp/VOO9li8XSef51k0ZVk9B3CQ2Ukp3AcxlPDIU8tQXWRnoJh6qijDAczYj6mMmsmrHMIk9mNnLrsZc2lFuau2gbYw2FwhrBggcpuEQasQ3Cj7RIz7UENgrtZ3jMhkjtL2La3wAvWq1Rt/QEUXeiX5deYs7+/8/ODHDt839kEmDPsmd2Tghy/OMdVDMUEQ9Al9/syhXJ0IST0jJRWMWq2BnIdHdBwTw2r7MWmhrdHb029Gn41Ze3bdiiIjeOlrWlZquPozdEJZ3yc9u5HKB98YPxYEoK8nw9hzMvlBkWFhkgmtzAJjYnvDjJ+YqOoyzhpx9NjZf5MH+D5XMQMK55qW3P+YxJTqDlvKJiJydlMOGQtJBv9emw4XlgS5jiDsQ35B2EeVdZaEYFm+NbAOx8SPJCMKAOPTtEjZ+FR6WsOA4AelSOqLn9ODYhjOsesNVAqUfOqs1xclJNWsKsx9+jZCvvU1kIxr/bewUo0CS1U+PnsnEltip0WgqSpbufa1uv+ArqiO5va50qHCHi28aG94xBe8+PAtJQwu4XmGS6h+siM1VcIw7MJ4N/vMASV53bwUF+GO2X9B3oNhvEAXYZelSDcOYwpVNQlQmN06j0am2dmZLyP+0
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(40460700003)(6666004)(70586007)(70206006)(86362001)(426003)(336012)(7636003)(356005)(83380400001)(1076003)(26005)(107886003)(2616005)(41300700001)(47076005)(2906002)(4744005)(5660300002)(4326008)(478600001)(82740400003)(36860700001)(110136005)(54906003)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:10.3558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1843be-843b-4ce6-2149-08dc099adc46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165317_600241_F77AB3B9 
X-CRM114-Status: UNSURE (   8.94  )
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

The correct place for this definition is the nvme rdma header file and
not the common nvme header file.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/nvme-rdma.h | 2 ++
 include/linux/nvme.h      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 4dd7e6fe92fb..146dd2223a5f 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_NVME_RDMA_H
 #define _LINUX_NVME_RDMA_H
 
+#define NVME_RDMA_IP_PORT		4420
+
 #define NVME_RDMA_MAX_QUEUE_SIZE	128
 
 enum nvme_rdma_cm_fmt {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 462c21e0e417..ee28acdb8d43 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -23,8 +23,6 @@
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
-#define NVME_RDMA_IP_PORT	4420
-
 #define NVME_NSID_ALL		0xffffffff
 
 enum nvme_subsys_type {
-- 
2.18.1


