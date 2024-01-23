Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB9AC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qh87pNAa4UEmC1G5Vx3c+dcljPhmkpfneVv7XLbnF18=; b=UzGfZ2t0/Eeu6sJYYWGBnt0A8q
	GSyiFvBBwu/8i84c69PgMMvjvWY9wVivvMWKWDACdHdC4NVJi9kWi4vXgfVcdJkOQJrJKXYiGRXe1
	CluMcReonaYMNRS1G+7Shy/NAMCPJK7+bp9E8hj5yZNjZ/fMHUoq/BJtUTCAgDK6hMXAIC08Ck7+4
	+SJ9xuDy0Mq2INlP7x93b4PvUTChxLP971ut+Op2rbCEyTSIfDXOu85JNQMYY/Hkk2HAipfwa7d9h
	M4AJ4BpKSC14Neoef22ioUxaFo5IHUYjgHf00i3AiGiagPRhWEb7zEs/I3ddN9ZOjuyFblfrHG3fi
	wzIWwkAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxZ-00Gqrp-30;
	Tue, 23 Jan 2024 14:41:05 +0000
Received: from mail-co1nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2416::601] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxW-00Gqpc-0d
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ak2jGzIj0sspuIM1ORT+rL58vjuIQNRV3El6PB0/CD3KYAw1OyQ4+LxH1ZDJ1b8snztiAnaQC6kCdeYZGrul8/K/7EqgwP6veEMY2IsK9yCzqwawlS3mmVlZ7/t+0cvuy1skNCScleXzfhhAqLawxH047rZCnWeRoDm6PMEn4zcNb0xT0ymKYcIHV6xus1X3U21QNKmVfhoYSvgQzzdnfrrDQD88ERRsvQaTeSNQbsrcMxSgHmgAC7yBmFIpNxz8oQjSIDNx6O8lesIqfFP6YoEeqGuUdli0OZwfXd48c1eLQdxIyK9kqaO9Fab1QsBqRctEUFAWIUgAV8SgT+/M1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh87pNAa4UEmC1G5Vx3c+dcljPhmkpfneVv7XLbnF18=;
 b=X/Up0HW6FJteDu+UZ8KHvZjm3vTobVzt1cBpQTrRlBukgZgT0Y/eEH66dE8RjC4om3QtXTz3vpprZiHgzxT3DOSFZJrFM+fKJQydWvCt2VfcyhpCwGoARDfaUvn9bH0neBhMYMhG0oxLJgnlrPlyOMfkJ6WkhBhkWCVfD0xebVwsaTbcEkX4o/uUuJNEMVm8MMCQCrMpC/7gVAJ/XtQZFqGa7Wq+rHMYdqx0uLA43s5GnL29lqH2xsMMpe6MAyrfmTJu1wsT77PMV4KEyUZGBRVeQ3SHua1Ciyd4ntvyxkkWHThYWemnYOhgojE0OobSZm+/bGu9AsPLjY452+axDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh87pNAa4UEmC1G5Vx3c+dcljPhmkpfneVv7XLbnF18=;
 b=svks7XH4Sdm6oB1qMC51tejYipQRNYUvCKRzLaxEEXgEwwkJW8jphxgXI6p1HPLxitJSrRd6frti0KFTTDAYSXJyFm/T0zuYOu3zrNtulok2f8oon14t42MWcg6Bxy7oPfzYVZFCi+N4jB7/T6jL2+vx1rVWNuDeweUuL7mE2p21PeoGYI0xrlCUtyioBz9IRqB43saDl0jPepXJQvWoFUuA6k4vulWos6QaxyQ8bxmTU5ylRiZ691INSJDYby0HBdzjqUg/hrWrYlFtQuzcHV9hGg+mPf3xC6+k/CBjYyE0qSj+8K5w0o7RNU1+E141820I1WuCKwFg8HGifacykQ==
Received: from CYXPR02CA0071.namprd02.prod.outlook.com (2603:10b6:930:cd::26)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 14:40:56 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::2) by CYXPR02CA0071.outlook.office365.com
 (2603:10b6:930:cd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 14:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:40:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:40 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:40 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:38 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 2/8] nvmet: compare mqes and sqsize only for IO SQ
Date: Tue, 23 Jan 2024 16:40:26 +0200
Message-ID: <20240123144032.27801-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d085564-4b0f-4c45-cbf8-08dc1c214dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoxIGo/WxfQFUknHjhEVEJUZ1ncGXGRD41JlxyYr9+DA0XVJx9Qskky3BHnOTHiKPSdMOOykRsBe9VCFEQRNkm/hXHe+19wM1XviSpr9CxaX3TkUDU5frpzZbGx7VfK8A6XIkELYibDnm8J9U8OlFD+KNwXoRDB1L4ajANqZKBi14prUNvs1oRLfpK9smNGPnRo1ECxB0X5L7wKAxpn4SF+Jx0n2FRUhgkrMZbCpeido4raPUorkLEaTUYy32iOkHk/zTFa1dJC3qQsJI7gBSvt17xGZybTiYR4m1ACJKSHB7dFZVhSuro9xWEzfv+ZpsjEKjeKc/hX7lRwJWcKRbX9P3ZzetZTMmT/n4IXncg6pEQ/RXN1gDhb2eFEXEu1gQsAt1+1C0PQtfZ0xrSvfZPgmsR7uGRMNkfuJ0Yg6ITvEuXr7JnQ6ZW+2tcj5ic+xG5c9PNLiXtyAhPo/NLYOIBa4fbhyMxzhW+ueWIQOMKs1eJ+ZPCi3553QAtD4o+2d9PJovldiOUUp+kkB2nFQ5T4Fg3SXOTl7LDwq1IhqL8MZ2l0sb02lGBtoP4pFpbmkcpbDsxq3spahg/uUluPYMZU8gy9Oo6hY8xMelSIDH++rpMooM6sAExHIjIpzxdrtiEJI7pTtbwlfYSakV5RH2FZSRWFLyvoL1ld2E+OwIuEuvo0IhdEWN+4/ge/u27NyPCG4RF7vylci/QvK7X8YmMTQpeA1RoY+mTqvJ//0A0maPlB+IuSaGIEcROCU0xbp
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(26005)(36860700001)(426003)(336012)(41300700001)(8676002)(6666004)(36756003)(107886003)(2616005)(70206006)(6636002)(5660300002)(54906003)(110136005)(316002)(356005)(70586007)(8936002)(4326008)(82740400003)(478600001)(7636003)(2906002)(86362001)(1076003)(40460700003)(40480700001)(83380400001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:40:54.4069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d085564-4b0f-4c45-cbf8-08dc1c214dd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064102_233680_D91C16D6 
X-CRM114-Status: GOOD (  11.88  )
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

According to the NVMe Spec:
"
MQES: This field indicates the maximum individual queue size that the
controller supports. For NVMe over PCIe implementations, this value
applies to the I/O Submission Queues and I/O Completion Queues that the
host creates. For NVMe over Fabrics implementations, this value applies
to only the I/O Submission Queues that the host creates.
"

Align the target code to compare mqes and sqsize as mentioned in the
NVMe Spec.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840a1c0e..4d014c5d0b6a 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -157,7 +157,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 
-	if (sqsize > mqes) {
+	/* for fabrics, this value applies to only the I/O Submission Queues */
+	if (qid && sqsize > mqes) {
 		pr_warn("sqsize %u is larger than MQES supported %u cntlid %d\n",
 				sqsize, mqes, ctrl->cntlid);
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
-- 
2.18.1


