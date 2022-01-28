Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50480C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLHNPI8TFXY4Chts9skYFI3E0zL57wfZlAhRSppFm/4=; b=0MbmbNBIETv8Diq1uGYhoUccRq
	xdC5Kk6FWl//7RprUjdx4YO8uATbgBJJtpxO44KbPbqFHX5h16IIsUkIzlyTUkoGQQZGGtLmri7BA
	ObmeGu+urfUaaS4AU3kWqZ6suauZq2N09TNPMO+ALUpF1+o2GGH0lBxL+FBISoPiEO817+8Ouuzqg
	LfuJwfu5v9DmDzdlFQPTXmOWk3rwMN6c0V61UJo1dQcPOMDZrImSxFbHAcykRB9GdMdiC7j4E3XxM
	2YiyPY2Yf5onhOkfLkNqQGr3oi8vlb4ncHgDIg9BiejPLcJf2SheTptfKke0spb8z4dUMjv5L6eNB
	wUBhOSCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNS4-001DEs-9d; Fri, 28 Jan 2022 09:21:52 +0000
Received: from mail-bn7nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::606]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNR1-001Clm-AY
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGO3ma89S2TU8Qx5Z1ACjSNLiXmDvxhSnZJDBXHyZfnJI+k8DqsdEVkDpVmneA3BAwjdy4kKKwM9aBPuoyRbwyFPBi8rt+crX/GWJmb7U1nvOPCRaJkrhSGONC980ziJVpt24P9r/QtgOj92sAMSLa0/9odE6EmQ36cBXpsxZpcqBdy9wAizcLxg17fI3nyf6EfZGO9PQBBiNbt2F5j+00nn+S/p21mfJP7qySx7oYsFreQq4tA6D9gCZ6VTAFqqkjrL3GAkAh/yLImr6dKuS/LQSAqUFe8pjV/5SoEdyAh1unpbASB+7x6OlbhpCgF51EbFlez+XGTWxbtj7eGG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLHNPI8TFXY4Chts9skYFI3E0zL57wfZlAhRSppFm/4=;
 b=T8YD/8kZq7mxKg2lQ9adzuQXbkS0Nf9d8QqjfRqFvUpq20vBvseRRrcpY2+xoyMkvocmqr3BJXtJpl9haICADvZy9K5P10JFqmwyn6hS4tks2szGFZ3uysbJ5VIAXmrQMWejkiOVc319tW2eTuSix/k64Og+J+wkmvwrWEk6ryzHGYKxqVeNqE41R15gNtTgEEl3d1nCF/vMbsL1W8TAVnXz5ROE0vE33tdY56ZwhdttCVWQMfkfPoOAbyFlM7V7VBPsF0xnauafT/NdJkf4pOi3t2a1X/WS1oC4r5gYKr/eEwxjTcqlEt0Quh439R7L/xCCbmQHpYnoTlqSxLoL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLHNPI8TFXY4Chts9skYFI3E0zL57wfZlAhRSppFm/4=;
 b=CqhUGcG8d7aDrJjm7IhYmVt074ESTViKcMWjsK7ZNptq+6RXstvkwXJqrFK/5N90GTStXOdq0gX77IRjzZvAfr56TVbPnUcr8YoYNs/VbuQmDjZ2wYn8rL14U2sziwzS4prQJfmYU4lP+2At4nnsABo1H/qKUy7+3FMGFjiauBtjnjcmC20dD6XAmY6K/9zxKtAsZRugDLC1spPh/2PGei1AqSInD9NAkwZddFAGmPXI5jHUxqAUOlgUbgegMaNWsanjkY6kQZUcahE9QQTK69ZqCpjCLoUaseEXPZsLLasmBHaLCXjniMMkoI1ru4LEBzSkiuU+jxxF2/sipmqXyQ==
Received: from BN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:408:e4::6)
 by MW2PR12MB2476.namprd12.prod.outlook.com (2603:10b6:907:c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 09:20:44 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::a1) by BN0PR02CA0001.outlook.office365.com
 (2603:10b6:408:e4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 09:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:20:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:20:41 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:20:40 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 1/9] nvme-fc: add a helper to initialize connect_q
Date: Fri, 28 Jan 2022 01:20:07 -0800
Message-ID: <20220128092015.19289-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128092015.19289-1-chaitanyak@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d0d990e-93f2-4afb-6161-08d9e23f7590
X-MS-TrafficTypeDiagnostic: MW2PR12MB2476:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2476D72FC17A9229AFFEBD8BA3229@MW2PR12MB2476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2NYESoFgS0ul4JFSwsryURXLkZB7YwJPFy9guHoumFTjvrT7Ij3oyX29u145V3YCmeaFx2Ra+Mn3XYBb/RrApM2QENYkvVNoN+aUMYimJrMQHiD/3mORBiXmPQ/R6abAkOZ/Jzu1BvhxwPnqPmGj3f6QFYLyLXj7BJ0LQmjaWdPMgYiBj5Hla9vQkw/zGbcOmUjTohJrGmhoWiWR/HjXdOL+1OT76juK9e+f/dsHLEx0It6t6tPllqjHBS68YjEWuf0aJxGfyUf4e9Cq7BW6H7eC69G3Ohq9fQ46q8FxZqb4N9SmJ7yd1M6nGmJCW8XVVjv5gHe/79LUEVAFqbni0nixwziBC+cj3xBH/0PMWR1hHRs5gV76DtpmMI5aW7DKFxFMdckJLKiKX1GcGQAu8uHB4oBNR+Dvte84sXvbp6JZ51OIxcvlQ6HI2/qNiZr2JN/f+WCarZp30dzubPiaUSxQwkiXP7TgoulI5GZcfaO0NNegt6lvqjH1DzCCwOfiUPeF8ikHQ3/LW3M/BomiYYJlOc0H5M4r5vzcl7fu0Z1yiGUCl6ifAUhUXbpBcqLud0lYOhSVSSDY7gMhdrk0hPaqqyo3eYWa4V1T6hapiQNgAxDLtWrA0yr22jK4S1+9NpnHqmjLpb5XSXBvVuJOZDxbLjMFZh5xfYLh2ND7RCYWguYVFsPBWSr69sGIG//ZF/SHJkw94wTGCilg89yeeAszcYajDF3wvOqwjTY+0SVXx+3vGLBkXGKbtnyHdMlaAmEaH3im6oicBbm/qErc1lgUpSNLBz+O88fl4qTVLA=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(6666004)(6916009)(5660300002)(508600001)(82310400004)(81166007)(4326008)(426003)(356005)(70206006)(47076005)(186003)(107886003)(1076003)(8936002)(86362001)(2616005)(336012)(36860700001)(70586007)(54906003)(7696005)(36756003)(26005)(8676002)(316002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:20:43.1130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0d990e-93f2-4afb-6161-08d9e23f7590
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2476
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012047_417761_7613800E 
X-CRM114-Status: GOOD (  10.94  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Add and use helper to remove duplicate code for fabrics connect_q
initialization from all the transports.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fc.c   | 6 ++----
 drivers/nvme/host/nvme.h | 8 ++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 71b3108c22f0..23c896a138a3 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2916,11 +2916,9 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 
 	ctrl->ctrl.tagset = &ctrl->tag_set;
 
-	ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-	if (IS_ERR(ctrl->ctrl.connect_q)) {
-		ret = PTR_ERR(ctrl->ctrl.connect_q);
+	ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
+	if (ret)
 		goto out_free_tag_set;
-	}
 
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..f8658f984d64 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -894,6 +894,14 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 }
 #endif
 
+static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
+{
+	ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
+	if (IS_ERR(ctrl->connect_q))
+		return PTR_ERR(ctrl->connect_q);
+	return 0;
+}
+
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 {
 	return dev_to_disk(dev)->private_data;
-- 
2.29.0


