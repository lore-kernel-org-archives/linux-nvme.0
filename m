Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43D6C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cqScHW/s86gW8AwQqfqLkCFAGO3GKMFi0Busy1Bjhpg=; b=mkrQtX69qbhSC2vUd78Q9qXkNC
	Q9JVaESUhi6PCIGO11pCj5kmzgBoBxQXxXRZHM/tY/XNZl2P/IRMiPJNDwGnhYaMrDhGSXus0/SXV
	UN9RMrp8wvf+tK9UihfQ8Jt2XVAE6KBf183++1fDa8tlgQH7EJe8YBgJ4f9X5iR9RmCCPseWY4bXr
	oFSeT6YEjRLdwRR8Kl/8DuTuE5NU5ZOkXEjFfO4gcCLKwBJZy2Jub69RAshN2K94bOOOrtLAL3Wt2
	gDH38WoBpqbuxUxbah2kwXbHuPk+gJ1eJyUnO26dvFvTYPFVPYGISkTeKLQZQnvFVgnn/lO5R8CHm
	mm6MDffQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzc-00DMOu-0L;
	Thu, 04 Jan 2024 09:26:24 +0000
Received: from mail-dm6nam10on2060e.outbound.protection.outlook.com ([2a01:111:f400:7e88::60e] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzZ-00DMMB-28
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTFKIXanwrr/MxFAqk8FEDDO/cypg3J5qLeL/QDpTy8X8eJuQvxv4Ybi/lAUr+gbn2ZZ4kdZrAhtDcBkDQ3V/T3bWrdBLjOCyOq+NhLG1SOaadTlXYoS+5zXmPQ/YfwGeIH13dAXO4yyRqtfQZ/WETnOLG09wx8NyRWwRLyhLG/3m3XSkkZjP7TKMBJv6/LCraIcGGUOqytalFMS4RkQbphzMUfiq2bjr+f1j/r/h2Q6IrM4/WAwXwO4V4WuC9X4kSfWYgb7n9PL7gc4A7kVbPEMrARBLJkOUa91fAGLnxnM7MIIRKPTHN4Tv607m0u7XfKC42xR55j+YbIchc5Clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqScHW/s86gW8AwQqfqLkCFAGO3GKMFi0Busy1Bjhpg=;
 b=OEzXbnJO2cS+czw4b7I3ECjdZOGTITx1knN/WVEY1KHtH1dOEoZUGrG3UI/45/VgepvaqP0KweHDT2rPCjghJq+aFmaA6qFxqYnWraL75PK/v7WBfdeSbIPDC67iCNKta7mCUC83TxRyGEngv2psH198u8Tc/4M3n1dxgvRGesSqhc42jbTZVIVWk0KROB7b+8JEifup6CZKmdXoAUHaqwiS2+glUgjR1/orALBaOTA4d6Zm6tAs06zALGN8yhE6TQM1fwoIHhsVDXAxnlGggKFX2+dPin1DBGOmUhCncGSKyv7QhCdTyhdju/fymrLBndX1QzNh9PCtR/FLcne9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqScHW/s86gW8AwQqfqLkCFAGO3GKMFi0Busy1Bjhpg=;
 b=aptXFzA1gXGy9hGE+NMBXYeO4obVnTU8VcWPIZ2J3QhnUEjqRxO6tNM8mOITxv0f/tNLLCN73PQhzAmJZ8tqJBZQW1yKS9tAkmvQyeDC5MdbtW0m4Z+TfA8VSDW815uctJdRfBndU4vqw3UOLOQBVelEf1DekKxkHg9vu3J6/8vK0y3HbW4BPyrToaJA70ZV5Pp4W/4Q08w2gTw+RHjRzhj8K9BIIzFTClP5Ff8BIT+h42LBYHHJ7PEWZvdP7fCSBovKVhmaofZfeDE4tC6hbh8mXRH9h7Az/wdzq55B/kImHz2YWRX0vZYTEfxCbG65umNuyogDBhB00zY+niSmxA==
Received: from MW2PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:302:1::26)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 09:26:15 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::4d) by MW2PR2101CA0013.outlook.office365.com
 (2603:10b6:302:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.1 via Frontend Transport; Thu, 4 Jan 2024 09:26:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:26:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:26:01 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:25:59 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 4/8] nvmet: set ctrl pi_support cap before initializing cap reg
Date: Thu, 4 Jan 2024 11:25:45 +0200
Message-ID: <20240104092549.25721-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|BL1PR12MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8f2c3f-d89e-4d0f-dcac-08dc0d073304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPNWJ298BmfsvIKgOY8Nc5RL6j7gwm6SPn+1oX2S48N8JxT//3/lM5r72lfzMiu/px4P7+b9o+LYgM8nVubSZsf7KHrBxcRTm1tN0gdlyX6NIjvRSWwGVXl1eYshO01ni9p7HRv9biz2Dtv6k7lioSFQWBv3yBqcNZCWHtSLm2SgbYgcyt1kT4pjvJU7ICrBu2e0peO/tDn70sk+Ly/hmWRrVskeRHRjcOGSXH0w9RmSv07FH0Pr8thqcu8YrqE4q5fceyhQ8X7yqC03WXhQsc0IT8BBwlsMiB/HA6rPB0Eh/xsszu84zc2BM8kWxIy5bDjNv0bio+75nA1o5TdTE46aDRbCw4QY5OwS6aB9XkLSvdTbJSE34vFhKMFVf2FYzPFoTQ3/GZZDTQEn7FnkyJx+jHETKL6ldbNl3hYgInLWjEmiwjQ8KEp7m6yOwxBGq3kDfvcU1yS7E82ja0jaB4fGsme3RDIv8yI7i9nwyQC2QjFMwcg2/cSb0aKlnb1/pZnVIIqc+H3lhhFx389tSD5H1GMaQlnwuIYUETP0tP0rndcF/njzccBqaaJUa+5rrb+zQC1HZQpZp9RWAF470eXF+WZ5Nq2kOiBb4LVVShl/o8xyGCUFgZqSVHTXN0KdqNoYI4oEKshwJZKTg9Advw8rrjkshfyzMIDxSvZNK25SPaalY6UqcoMWB0i/XDiP0dHbhQYtBgVHmgg2AJ/FerD8WZxcLM/nDZuoMmArgYQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(316002)(110136005)(54906003)(8676002)(8936002)(86362001)(336012)(426003)(1076003)(2616005)(26005)(107886003)(6666004)(478600001)(36860700001)(83380400001)(41300700001)(36756003)(82740400003)(356005)(47076005)(7636003)(70586007)(70206006)(40460700003)(40480700001)(5660300002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:15.0719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8f2c3f-d89e-4d0f-dcac-08dc0d073304
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012621_700934_2E73266C 
X-CRM114-Status: GOOD (  11.18  )
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


