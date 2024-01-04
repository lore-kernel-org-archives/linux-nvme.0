Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E592C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F3/QaDbTWxIg6gJJNSV6lAUj8v7S5tCQUtvvMdTkG9Y=; b=giC1w9PbAlkpAkNhNTWI/35vqe
	daPxdptgi4Iv/V+2pYPwI+zocmqf3KO9UciQ6APMBDeyy+/Vsf9UWro1xRJx5DelxWsBfxMocTyEu
	Wjes2/Gg1q+FLBCxXwis2Rc6QCAX8HIFPPHIF2/RUKXZUfGdA+r8QvNZjEzfdNapThe1RZhxotFOA
	P+QbXhZNHiMEKU0OF/iDmGKDpNi+6bxQqVwxn4OT9vFIZ5L/JcRLh+RFSPZ37JQ6Ga7NrCBaE9peJ
	3Yqdu4SiXRzQ8BMNJcER/GS8zPAZ37okpiGM+y4bxe7dRQ5e7+0M5g4DpjJ5txXWY8OG+ihFQLjeX
	67PS471Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzh-00DMSl-1p;
	Thu, 04 Jan 2024 09:26:29 +0000
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com ([2a01:111:f400:fe5a::61a] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzd-00DMPF-2W
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTC2UDoQJPrDdTnyQvQ/Hh+JJU4cesmeuU+9VkfQ83YNcksMu0KtEn5kq9nYN66MEoW0sA5+WqLbQ+YSBD5nXCk41yunVY0jPnbo1WMRtbnuARYxvXrHCQd4NbNLXHxmu6rPf2XLAv7n7YG14Di6mQKxEbQlTcvBaljAbmClIV/+tqjhm9rxLCXM02eTY3CeTNbpV9toUkFJDZ+CD6vroWfIM2WRWSDx99xXKZlYyPJzEALvrErMuEFb6Bgi+W8QcUo6xIt0o34c6529RvGKpdD2qaEg1c4+1plD3C7SB0Azh1iQ3dLD20a636g9/LByGwllyqC31cLa5dpHQmQdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3/QaDbTWxIg6gJJNSV6lAUj8v7S5tCQUtvvMdTkG9Y=;
 b=eDFUvuUCAwWIsrROa3vuBw46JHmarv5KSmzS18Ws5wZZrlbj57pjDU+FU45xB9kRcXnhaNViwBpI5kyzYSTdvfhwedhfiqdpZfYK1D3JiivDIeplr6nB+FKryEQlKVZwzO/yhJrQjG6ZZ8P0L3+TX99AgBSX9kYACn2V04DbcmCw8f8wGyiGLEYLDg0xASHBwrZtTwD36uyWBLsXPiJWglO428nlNnDgqhCyO+8MWmpNxsypXPP39ENcd2PrmsxTOqvwqSou57VjNTNJrYUGLNxqC2gAFhr58upTyW1d6pOKZgMcbjEtKWvnYrJdZ3qPU0JMFXAASFCKQGKeQxkPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3/QaDbTWxIg6gJJNSV6lAUj8v7S5tCQUtvvMdTkG9Y=;
 b=C68/3zXcjK7E5j531xazD6aTnDb4bvCv0EUzi4445X8/HX9jxDra4E2wrPwai76QyzKBSfwwvFJx60IbJW62pLs7eaCTBsL8gHNeIEkGS3HemumP+R/cEhwNg0y1cb1xxQhXjgJpdem5uVawjnnrpqJ1r+QX8Cl8jHBEhGHFf8NjvVjfsgQ8nvUbXpjG4/QMmwxhJ/2EAmp2gyZOOZqdmD9QkAYDlPNnfxky+n59+Aaa0bProddseObzgHkiqZKRbpwxnPBprN0oBM/IDDsI1vw/dM6kABDIRfUCAyUWB4ak6OpXJnIpETHI00uR9QJKSLvElwhaHqunmTsGOf/ktQ==
Received: from BL0PR02CA0105.namprd02.prod.outlook.com (2603:10b6:208:51::46)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 09:26:18 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::c7) by BL0PR02CA0105.outlook.office365.com
 (2603:10b6:208:51::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 09:26:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:26:06 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:26:06 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:26:04 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 6/8] nvme-rdma: clamp queue size according to ctrl cap
Date: Thu, 4 Jan 2024 11:25:47 +0200
Message-ID: <20240104092549.25721-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c5f8be-9a2d-47cf-e78b-08dc0d07353d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stLNBv2IiJg20vzsC747AgvA0dxx2JbVPZUnm/ZfsqjKhCjZWTUTLrMEvNs6vgdkCKXYgjJyFG279Fz/AyYwqqpqnEO+fjONy/d8qvjkBC6t4ENHuI3Mvuj42vih147s9ICBwOhQoeZa3RBlALb4k0ugEMj1T0lt/BSNH0UltFawlVdoJYxZCnC5hbalRKDqaJUOvxHKaww6QD0DIS0O5jRPzFbfUiAYHxARdHHMgta6x4szv+0tPvK3gFW8Dt5I/Dma7UkIZL0sq6jApaAxbk0biHiLiuX9D/m5XNZdq+XalXUTOpNYOrV1tUXKKqjKJiyGO07X9Z/J77qZcyWbzBKasQPjfhmNjrQCrgOmbe34hMcdKWrnyw6PLX0LCVN3Dam6hvoAu7AJxpspRDsVQVvvqqhyL/Hb0WtsxSlDilpLqB8ETXpUTONCeBUvoi8Rp9j8DBOnSWc765aD4Rt8eMk7Omgkdy6bbg23mgPVOlXfQ7wpQGc2/atoE3I3cgWtzvLdzB/YbwHqS83pZasMY9Mt4qx5UEKwHlfUgdGfZSW+L2b6JlXeqmfs/v6RTv2qLrM6SAqZdu8/EtaYupVAOo03jKeaqNR5a/K7/RtcuvOuW2U5cOIoNo2J6D7yVooC8kTZ/DlexB/TY+DgbajsOV7Abb6WvU+g9CV15G2+H20t5ijkdLK+YXsnu4XiHjiG5dAy1l7ovDsx2jxsXYIW0E1IYwyKBTFokaYLlFvY/hZzJgeEba/aWH8ym4U5RG6S
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(36860700001)(41300700001)(82740400003)(7636003)(356005)(5660300002)(6666004)(4326008)(40460700003)(40480700001)(2616005)(426003)(336012)(26005)(2906002)(8676002)(70586007)(70206006)(54906003)(478600001)(110136005)(316002)(1076003)(47076005)(8936002)(86362001)(107886003)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:18.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c5f8be-9a2d-47cf-e78b-08dc0d07353d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012625_826274_BD08F80A 
X-CRM114-Status: GOOD (  12.15  )
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

If a controller is configured with metadata support, clamp the maximal
queue size to be 128 since there are more resources that are needed
for metadata operations. Otherwise, clamp it to 256.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bc90ec3c51b0..d81a7148fbc5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1029,11 +1029,20 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
 	}
 
-	if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
-		dev_warn(ctrl->ctrl.device,
-			"ctrl sqsize %u > max queue size %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
-		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
+	if (ctrl->ctrl.max_integrity_segments) {
+		if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_METADATA_QUEUE_SIZE) {
+			dev_warn(ctrl->ctrl.device,
+				"ctrl sqsize %u > max queue size %u, clamping down\n",
+				ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_METADATA_QUEUE_SIZE);
+			ctrl->ctrl.sqsize = NVME_RDMA_MAX_METADATA_QUEUE_SIZE - 1;
+		}
+	} else {
+		if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
+			dev_warn(ctrl->ctrl.device,
+				"ctrl sqsize %u > max queue size %u, clamping down\n",
+				ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
+			ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
+		}
 	}
 
 	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
-- 
2.18.1


