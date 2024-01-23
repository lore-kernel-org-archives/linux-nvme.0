Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB7BC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1KxF/1Ajz3//UXJluZHI2dSYpbuok/fyZmSSI5AMUGI=; b=QCFhJmWLwL00xdjyFIJoFwOA7J
	PmvCZ8HN/ouJhe5nqJw1x2FDGb1HwVSwO8zO3OpYtFe+JYVG49TnuJyZL2L6NzlqbPXqZW6JyfTg9
	QgtMSlyXwA7JeXg6wSk+j4P3D1aSoAblyTDL/XWxjv9PDqr4VPGyo9mNlsEtC89DH9jcgUzajRHn9
	fHTqUwq7W66zNvOa9VztpjMVsr4sFwjiTJlhMSR2cqNBjF9RzbwByZpa7P2cGstK3q7oOfDnu6iYf
	pvQbgFIMqqYpiZStghJSTGJ2gsbuj7hcBCc4Rx4G/9HSIMRKhf832j2bfTQdaQBfv0ASeK//Hqqun
	prYAD6Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxa-00GqsF-2E;
	Tue, 23 Jan 2024 14:41:06 +0000
Received: from mail-dm6nam10on20629.outbound.protection.outlook.com ([2a01:111:f400:7e88::629] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxW-00GqpC-30
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGLOYeOfeBTRgbxvOBlmhnnh2aiXwxqtBIUeLOJCdH1XRDiHwifcxZM7/vF3CvOeFLBz42XhgAwze0Z2M51zc0i3l9wlKB4ONkbxbKPwXfyaq1ODDGEFNK1lnBGqlPIY2cywmI9STZ2pLf7tObz02Z5ysvB13fLu6ZIwKwf9m4OChm/7jqJXLsBK4OaG+B/of4PawbyTq7yS69hZiRK8tYEwo7xGFFcbZOTH811iyIdrAb9K5tplI5X6oOM/S9XTreuBjVisYFBtzbH3ZLAto0ZqV0K/gg2mrUPoSqYRC3PGKEUW12l6r72kouLKUKuxWtPhAgtFbAyqLHQ+YJf3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KxF/1Ajz3//UXJluZHI2dSYpbuok/fyZmSSI5AMUGI=;
 b=D804RRz/JuUOTNERhcxAkyael3aVzpQuZ4EJ9fZXyo42b16KvJiEo4bLUfYqXJBW0l9VnxIympMElnmNP6A3fCuinVO0kh3fN9U+S5yRpDTtd4s5M2EfDJy9udV5sUYGx3owNgP3SC6MiR8TkDwO3Z8O7qV7LqvyIuZ1kuODFXleGq7ZzOCNvWYE6VNUXeyLiNdayrHh4Oz6LZ9GYFAIIeDMY8BUfnbdhZLE3A9iJbKMzUIPvZiviMb3TjyIV6bKDUJZig9KcRt1LnLIJr8HUhXGS6KndkbkoOcEzYyLK5oHPqRdkhPnlQr88IGNWGzFezSB8uFJms1UKyPUvRQppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KxF/1Ajz3//UXJluZHI2dSYpbuok/fyZmSSI5AMUGI=;
 b=cE71LF/4fa32mwD84DPpYbtcg8Heg3q3STXJLu1RQn6/CJLyRwuyZnOsNnkM12kYhrpjCNpT2uwUQqudan8TL19hbdZ3EB4oCPT7WGuAtQWagdfremlAx3o0LC32ZkIhbvZRa2609WQDAvkiDpmda96PLdVxG7Np04qTGO+kSQdld9f05NvCk8GfHLuYaiRZwbG6OQrrPPZ0xPsOnWqRunJ7yS7gdzz+o/NYUaL7YHCxyGqEKHjNkE2DRB5nsGMdVjbSEal9OZ+XeMOHICzMfodeNdSv9iQCNG6i0oZ1GMbr9SFnFBtufd8rj9DURqMDiCU5lFkCRYF0gTcElhzRag==
Received: from DM6PR10CA0013.namprd10.prod.outlook.com (2603:10b6:5:60::26) by
 CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 14:40:58 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::95) by DM6PR10CA0013.outlook.office365.com
 (2603:10b6:5:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 14:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:40:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:46 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:45 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:43 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 4/8] nvmet: set ctrl pi_support cap before initializing cap reg
Date: Tue, 23 Jan 2024 16:40:28 +0200
Message-ID: <20240123144032.27801-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: f28a0ccf-59c7-43b7-685a-08dc1c215054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYx0iMHjQGmD780Gh6CyqCgZuuN3KjkBSsgMrPizrsKE34yc1QoWSQ72dwjEkWmIftziIjgyQzQbhPqNroToXUeTucMP/bMt8KrutwdDMJ6bN5nvW6Z6c2UhnFV9XaT8+2Y6YsH0ZLVOQuL7mIYPsvO1m5lruMCZOEdY4Ju4WYvDfk/ISqF+5fz2ppGpglI3S5mrHsOhGSEkQdM9T9arpzMRyLPUUl3AATBGLGyijqlcHk5aNE+u2VcKkF+zcPOC+02BTPqyS3Nuzzw/FpbwmlAvJDPngEGzMchFM8gtsfRI9qFis0vGijabDEOJkJW+l+JKQ8lc12v+kqiJFVIG2Dwkjz4JoMQjmtRZwMU9Fm2k95XQTibnra9+8ZKCfw1Vio1HpQVVWyOlj8Vx2l5S6IlBk4MnAFa78UjaXk6mLUVaYR0jomXHiXuYN+cQrjAJABJcDBqlWWm6A0zm4xjV+aHE6Cz5CxPOuv0m10EXfQT2PptLmOlawZ6c4VIdgnSfCoehsy0UoZXL7sO7UakyZenLvvLQA7Gnw+h8j8Xr4UantqsNEyH+Gmt0apuD+HhKdW5Um6xEkhYKW65Ao5Dlda6et9W88Ys20kREVrrgWoph7pQZf1ETgXnGJgr3BUaKh5ZIpn1rEU9jha048zEeYNFa2ZRvPomQwV9vk2lNbdRgG3cO7pvEqxA926KThmMkc2cWnTNmRZnxfS8HyZ1AcMIaB4SrFl8fqWEmYn1jjyg=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(478600001)(86362001)(82740400003)(36756003)(356005)(7636003)(83380400001)(41300700001)(107886003)(2616005)(426003)(1076003)(26005)(6666004)(336012)(47076005)(36860700001)(316002)(6636002)(54906003)(4326008)(8676002)(8936002)(70586007)(70206006)(110136005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:40:58.5881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28a0ccf-59c7-43b7-685a-08dc1c215054
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064102_978729_019F5500 
X-CRM114-Status: GOOD (  10.88  )
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

This is a preparation for setting the maximal queue size of a controller
that supports PI.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c        | 1 +
 drivers/nvme/target/fabrics-cmd.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d26aa30f8702..ade5a7bd7f6d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1411,6 +1411,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
+	ctrl->pi_support = ctrl->port->pi_enable && ctrl->subsys->pi_support;
 	nvmet_init_cap(ctrl);
 	WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_CFG_OPTIONAL);
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 4d014c5d0b6a..08e9c6b6f551 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -252,8 +252,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	ctrl->pi_support = ctrl->port->pi_enable && ctrl->subsys->pi_support;
-
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
 	ret = nvmet_setup_auth(ctrl);
-- 
2.18.1


