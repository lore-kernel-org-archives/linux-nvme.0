Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D07CC47073
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q45oXec3T2mMXpr4aKFpFjyKA4E+otsttSwZS9ama0I=; b=0x9LYj5IKkW7HU7Xl8Ojo8PN9R
	kaXCCzQ3XjNH8DZ+fesTud+8jzW+BfllaeqraBhpr8vV/vIY2iPH6/awm3YsEWqiksEbA0XKuYCIG
	qB3X4pX0sXxXeWOQ9jMzZVAuaHznyjKhDPa3lul7mn45weLZSn+iSuk6F5x9BX7jU/rRpCu2BJIJY
	K8G4oAB4jPbFu1KR0V+EIG23qhmoFsTOOV/K+JwsDun9NqxjKIyzr1afYAUiOWWUhFloB5VQ7ddqq
	TP5ObGDoc6vvuP9g9FVDhIpXS6P5Ow9NnC1vKwGsDcwscZJQg/NMhV4wvpv8jYFanvICnx4RqIAxF
	q99c5vzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk58-003g7q-17;
	Sun, 31 Dec 2023 00:53:34 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk54-003g53-3B
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZVHprHBXz2gtTUin6fX8n8hi6GbXPZgO1fXm+MZePUO/0LGrbyY2G4EyXqAi7YjaaTqr0cgkozhi1dughUKk05t98udL2lyGxN6MqZ7gz6vhXPts1a5KSE9INlvzXujwv+cQrijC7eoh+OnFV9Lb6KCz0k6BkfN9Gz9c8D0Mv4ipTUjlXUa6WQH424ySEls7/byA0MXkb2XSjv4MCk6UMTc+z+Mbumy/DOUJkOgherxIsN4bk6jOjuotAz3GDYLhu3vcT7JG8wtKUOQKLrriMFWqOcIn3d37id+kYiH7DxDnPsWWAokZw72SfeWa843tTxULRp0nHZWfuaqRKOxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q45oXec3T2mMXpr4aKFpFjyKA4E+otsttSwZS9ama0I=;
 b=QMprqDVcMkzLcyiIhYneyzmrLaHgPf7xzMjiOsQJtLNxMj1RQxAd38nwN3JR8WdabMYlqBG1MJH4orwfO5twSssu0Vh28UKmpt7FYSpBppv+4NHTekTgPY6tFdnLxnUL7CMeWVkK8ygPMZDq+A0ScOg65e6LIIWHVBhj+ZaxhmPqxOv4pgsqE0eSvfqiIt+p/fk1LBHuPke1fzBB1+0vH1f7dwERMPBpuP0rv0bWRsZ+IPWidX+abUAFY77COj6CPUQyNi8Sz/iHKqxSwN4T3V3tS8rfg3BjMtDzqlsjnrRv4v71qFFNtFRGyknjJ1sOiaIife71PDB8Cfzu9o8Xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q45oXec3T2mMXpr4aKFpFjyKA4E+otsttSwZS9ama0I=;
 b=K/KEYeuzSCdS8X7dZqAa1jJl84HSioNz+RkkB36L58YhtTnvGJCCfN5Joz+7UO5lIYtQtYtTgCbd4IBwrxLzO64A8frTzyXLk9cn4B9Xjm+zo/9TSXCVxhGLxQG/QJfClp8O0h2k89E7/Q0QCabul6Wi/sW/VBJO8RaXrZ6hzpcHZ2SeK9y4OCTXHJP9nU/82KjRYbo55FwSTAAlid5aYh7v5vI9vZdTchOt2oXj0BHM56haE5jFsnpHpoJ1Uscq6lGyo1hzH2CC1xXYwT/lIuomqFYm0IaQqqFM0WYqW6Q0OsCtb2JRnmr4c4dYThyApGOwq6bZLr9X2gy0jq1NxQ==
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 00:53:24 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::93) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:14 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:53:12 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 08/10] nvme-rdma: clamp queue size according to ctrl cap
Date: Sun, 31 Dec 2023 02:52:47 +0200
Message-ID: <20231231005249.18294-9-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfd4e60-668e-4cf5-c3bf-08dc099ae476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ct5+vdM1pfwBHxfyIjF23a4P+sZB8eh8FmCVB0U5b8ip0KwgGsDaCOsfMio6rTE5E4Vfm8w7Z03YsgQWOmtj7OrO0BDVmg0ugLD61kCqvsFhOQctx5ggLRMRxOk4SaGBaj8WbhYbGYJ6YX9unsUoQDA9Jcyq/4lYfLv6mVODDUuYpYggfLkQYuo/tME6KxwDO61URMSQEhoO+PhvmAihdv2F8MI20fCBzwiWPGdtpMsQoMPlUuFgzlrpr32gTEHuIfwACHZVeOuMr3EAAZKUpH+0njlwxUc9DIdttZMTI3X6sGr+M23MhfGEFzI/bOxa+bzm4eq3E+bGezouuzpeI4r7slJH+Au6JC7ygPoD+1YVSbPLrqcbINXsxdZ0ptulkKtLqBOdRy0brDpW4QdBOi/ggi8AfWUT+Wg8Q9F2kKmRIdMsySyJDoHx9nmXOgXPchAn7xqYUUiP3D/10u5yT0fAYXeV18/5FhtEusQ9FR0zeqomG9XCI0FYihtAqWoCdFxdVT5+Xr5tp7ubCGDOI0rY3Ic2VAi4UcbM8LMB/L0S5ta5e46d1FO0r4H8NCvaAIV2WLGfa9M+m09ioCWL8aN9WrSNSu5OjPtu93V2uT6OlUN+SYxpeiKbr7R5hfgKScXFd7DOroqBPsm0oaJyzRO301dKHRP48UJwwl5I91Ib+B96KNzsBWNPgmQ5DR8iqIvgsr+w8hh8NhWEju4PnA05ePd/fBgNckJgsfj/PiFH24eMQc27xLAl0R/9I/YZ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(336012)(426003)(2616005)(107886003)(83380400001)(1076003)(26005)(86362001)(36756003)(7636003)(356005)(82740400003)(4326008)(5660300002)(47076005)(6666004)(36860700001)(54906003)(8936002)(8676002)(70206006)(70586007)(316002)(110136005)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:24.0807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfd4e60-668e-4cf5-c3bf-08dc099ae476
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165331_026315_1E9DB255 
X-CRM114-Status: GOOD (  10.77  )
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
index 7c99c87688dd..a0ff406c10a9 100644
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


