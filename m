Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C07C47079
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HE8pQdBo+t7agtg8Wi9UnoMnIC7Uz4lqmTHEOtgFPHM=; b=4cyTmux/qRO5W6H5YMG2VoBjpM
	DXSP7g2GorIt+xj3nl1TkmncFAixV3eV9pKjajWA/wikmACOJ9z5/1KMQ2QceLF/2akfKhmyfHC5G
	tkA8DdHJJUT9L2jp3BctEb6BUeJfhEfV04R46JbEZvwD85rE8XpU6AK9HP36knLE6C7TT57UQYkAA
	uhOcjTZhi2/h0UwVEGg7EsZlCy9dnHrDNsE8cM+NvEOyvP7Pv4bpHNiczf6NNrJeceKQWhufTOT+S
	+93nc7rG4IscQFYUGUztNSQx4rqBemSdNZ4SQjroiCZIlDP73qMydV2XgLrAIYXICT1ls5YinalUK
	UF8P6hwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk53-003g4Y-1w;
	Sun, 31 Dec 2023 00:53:29 +0000
Received: from mail-dm6nam10on20601.outbound.protection.outlook.com ([2a01:111:f400:7e88::601] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk51-003g2K-15
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH48G5Ajg8sqCealD7TfP1rAzTSGXlnwOaK2utmsc5hlzrViUQM3K4mfxU5wMVL62tGPjTpeor2bgrFcTKqKuPtsVUSO55H7+VDf61GcckUljRxyexdIYRlv6904mLH9Xv5ojuDC5kV3IX7CXDO8QAmQqFUaIb2tp5l4mrAdDt0oiEvuAnOx7UXAgqMOX+wZd4Tgh9HydBeByy5smJhvxmLNn9n6m06cjIvZ20Q/wkVAnJFQq3QIrIhyQyiKx340vEXC4E4GyUXWGN5YzeMgjZiUGvkqu5exs/WyftEk54D1y6phcpm+r0V/pXk9rfE+qCJUSqJ2vsl5quAf+M9pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE8pQdBo+t7agtg8Wi9UnoMnIC7Uz4lqmTHEOtgFPHM=;
 b=DMShwyRudtL2havTSK/10Xt1BZVRgDYvl2LhdSiWkYis6Xr7YEyWS+scQ+e6p64pcRpG4yFuAb1a7zJYDb8hQ05g/FcrKkQ7uNCaBE8PPG6d8WUcXoyRwl45AS98huEFtxOLQrs+eTwumOtYcMl2y7MXBeNBhNjpKiZTPgaa0NUMinbHuOBhC6rUyMG3u5VLyUhiU5XUx44n+eZv1lrPPU8MMWpXuc8JiWBESM55hfVi4GfjGO1fYwy87JRXzYXotfyV7DHXPWhNE5QkaHHJTrc+qY27XHcRhy3Y2d20KXGprBx0uz9RCYrk9yuGHMH2yYY0c7YCCoNPGJY1vbH4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE8pQdBo+t7agtg8Wi9UnoMnIC7Uz4lqmTHEOtgFPHM=;
 b=Ee/CKeg38w5q4MtEtMHJt4ObBl+Nwk1kWM3KBU1sI6I2mIkMr3P7Cu8yceU1qorcBqFKJh0UNmlUnEmoOk9mcyLwLULFuJDm/Eg2KF0/cFgd4mO/BOH0sDb4GAfWv9Z2ruAh/hHo6cPQdqp1SJTp3cq7/6frsDTH+58ryt098TBNBxJ2oNgXQVjglavdzRsbuYUJfy55j+5NOmLGDQVfcJACrgYOifjiqgwQ9dkcEkz5oWOkIUYo1+fHToldFFSmnDxMJv6/EsskILbUvUBNH44Dy/PyOiMhJy564ow1ASzPnrj+AqFH+CBQLB4w6gGQ51I8vT18RezHo+4MkYcZhA==
Received: from DS7PR05CA0028.namprd05.prod.outlook.com (2603:10b6:5:3b9::33)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sun, 31 Dec
 2023 00:53:17 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8b) by DS7PR05CA0028.outlook.office365.com
 (2603:10b6:5:3b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:09 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:08 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:53:06 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 06/10] nvmet: set ctrl pi_support cap before initializing cap reg
Date: Sun, 31 Dec 2023 02:52:45 +0200
Message-ID: <20231231005249.18294-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a20a8c-e2f0-410b-6a35-08dc099ae08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRlBE7Nxa1L9fQ6Uwy58S0KtaWEAKhCnjR3+2dJj9mJSZfTwE42Z+haUDR5UuepAPJRAXnWxHSvjJnKcie7N/T0v53K7EQb3KNGWugGUaACGuqxhJ9KWZsVG1TwYCRr3sr0oGRxZjNxU+2d41Ntl/VMPzf4kIWMGE6Qp371srG/NuGF8Uh/2J6GPHAk5+OwGGid0rSCLACYYN23PSXElVioTv4SPIVPt0EpmMoaok9g3/C6k0xqq48upE89UWmtOCoWE3PjUA9/5V6B+mkZyieYnt6H2bGbeVoEydNUblyNOzx3lbLJqM1p2iIZzLtvZVy1MzVnX4petMXI7QDEcWPa5lk1f3qcVlTmKVazj+IztKfyrkWSP2NwLPQFJAOATs+HF5lxGhL0ivFgJQkp8xug9MSroGpuAhV7CavV+FizP19e9ZyAAAhBM9rLe9I7KYnzou3GllHX6G6/1sEPg1o6wLs5IcbkquKsByq8OYWDRaH6sjKNdcX+dQBtkXhFv4Mxr5a0Guam4bzOyespe5tmNU+naqehC4kgYXjAASDJsTf1owMmr4hQDZIcuet6ufJlyveWv98Z4thtI8GIyTLekE8D5SoXokCuGAPoWwcaRbzWFufm6I5838/PPk+dCccXcs524wzhroskl6+PFAIhXwhUfcvdL2sFM8Di83s1hfYe4I8k79mhrUzGr6/3UJxo810Zxv1E+z9sUbtQ+LMVD3dtDeVvQHR3PfkjbEibdP2nS5D18xR1IIOM1sOwG
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(26005)(426003)(2616005)(41300700001)(1076003)(107886003)(82740400003)(7636003)(356005)(316002)(478600001)(36860700001)(110136005)(8676002)(2906002)(54906003)(8936002)(4326008)(5660300002)(70206006)(70586007)(47076005)(336012)(6666004)(86362001)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:17.5183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a20a8c-e2f0-410b-6a35-08dc099ae08d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165327_377101_3E146AC5 
X-CRM114-Status: UNSURE (   9.54  )
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

This is a preperation for setting the maximal queue size of a controller
that supports PI.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c        | 1 +
 drivers/nvme/target/fabrics-cmd.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 128156145d29..f08997f58101 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1411,6 +1411,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
+	ctrl->pi_support = ctrl->port->pi_enable && ctrl->subsys->pi_support;
 	nvmet_init_cap(ctrl);
 	WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_CFG_OPTIONAL);
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840a1c0e..6f898aac1ad4 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -251,8 +251,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	ctrl->pi_support = ctrl->port->pi_enable && ctrl->subsys->pi_support;
-
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
 	ret = nvmet_setup_auth(ctrl);
-- 
2.18.1


