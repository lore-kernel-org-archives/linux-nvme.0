Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A30C63797
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Jan 2023 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dzmWb4a5QOcLh0pMBj1iGgqX6U/wqNtKIZUD06MwM7k=; b=BU8+CFzSXTEt2ZOOOJ+jJBWDC4
	cHdxIm1zF58FgUXkTEzCN2YD9dbc+bJN3oHK5w7gPk+FtZs20OkuNs39cc2P4zcoveqDcl/ljpgH8
	XaXEhsnUHJPTvgtbn8jed7uGK63m0UaigROhdAyQlDpAHbV3J+f5BM16M0nyjVBoqNkowWzCqrIf6
	QmdgyrQI4aauZLARMPDS38t+nE664uzW088KjqAh4nrmHGWj0Rux1qvlsUudKPagRMZYIrhhL25Je
	oocoHs6VIVuCud70dGudIwzss84g0UVdNvDaMVIdFjEGojZtd0pkI9vopGqGR1Fo9EjV/9YeuF3J5
	GIztcwrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzru-0079uT-J8; Sun, 15 Jan 2023 10:04:02 +0000
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzrp-0079sv-25
	for linux-nvme@lists.infradead.org; Sun, 15 Jan 2023 10:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ/FHa/5ORucjhbEgvlS1RDiJLqW2hsJA0S+kHDXOf1hVRSMMDXWMBOxKh1WYvGwHz5n0z7SxS7vJ+2N3+nCImv2q32hy1ZHarCxHx+Xd5VwED3qd6J4vDyCZImkUSW33AP1ZR7q+YM907YvB7M8xI+al018DcBdj1GVwgn76ECjwBp0GQRvvLmpmY+Aay5Bvazh+uGMRt9XF01Ntu2I/LKJi/wC84xBv8vjz0RKQ80Tw6RStiqN0M4jrLXKF6fGoMNh0c1HUOrhk7dfsElHHf0z3fauHouNgxlBR9VN88MsOT0NVrHXw+BQl5WKSED9BuC822bzr9pU4WRz9wEOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzmWb4a5QOcLh0pMBj1iGgqX6U/wqNtKIZUD06MwM7k=;
 b=dFOvaT9NbGn0+jaFeY++zExgL75vzWB8VFmE+KEhCA+c2LC5imww3i4Yo8mtMIO1ZQLihd8zCrFj8swZsuHdGFJNe4Mwn8dWn+SRS6chw7CYO0ROwiLsD2MJp47sn1cL/BztJtETGfhS2hIorh8+wYIVEUP2qq/YYJqBs6pXNgS6sAnIvX/tHy3JTEhi4cQVAUm1pcrZYzcKHh7dDKM7xPSV6X69IEZNPMOYgCb64hr1RRpd9mH5wK/YCfx7y7q9foc9zTdhO34okSIAwk5ATxJ9BGAHmBtAHgFzOi9M64WNJ1LBhZE7Ua1/N0HTSat+Kv+BcGejfNWBdB2jB9kkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzmWb4a5QOcLh0pMBj1iGgqX6U/wqNtKIZUD06MwM7k=;
 b=arc079CXAbTL1NvUUx5+jfGvtWJ/w3at2B8GmeJtFwB1G172Rh7hO9/lvYwcz/W2reaSb9NDEtrWBD/XyM2UF26qwbvr4csgCXtZAnWadG97r07V1kV7d4A/xUCzhAges+/ukxMt84TXZWOaRR3HnUfdSXMWr+JZ4P08zGWMbEYUzmt3v/17X9l4lqOSeFvuw1mGsJzgwwcnNeeGtuvk66Uda35ohE+z/zV5u4T7h2HnV4ecvazppFpRhLYBOcYTta4f2UvStZoRC4hfZKqDqym60e77537D2HMmR0oiiQmSq1IgQ8aurUOh9EmhGGUiYwpCPZCEUC0D65Vu8OhsDQ==
Received: from MW4PR03CA0132.namprd03.prod.outlook.com (2603:10b6:303:8c::17)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Sun, 15 Jan
 2023 10:03:51 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::d2) by MW4PR03CA0132.outlook.office365.com
 (2603:10b6:303:8c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 10:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 10:03:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 02:03:47 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 02:03:46 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 02:03:44 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@infradead.org>,
	<kbusch@kernel.org>, <sagi@grimberg.me>
CC: <israelr@nvidia.com>, <chaitanyak@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] nvme-rdma: implement existing_ctrl operation
Date: Sun, 15 Jan 2023 12:03:40 +0200
Message-ID: <20230115100341.40347-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230115100341.40347-1-mgurtovoy@nvidia.com>
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e81124-3c4c-478a-32aa-08daf6dfcdbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Wj7pFwsJ5WXnfZsMelaPyz2NQ8SWQKRVQ4flZSWTjVoRHfwNLyX37klFZrKWXuKEnSVNaLRm4d1rhwmtTSZXpzQHy4Jg9j4dJjF5FLCdTequ74bAe3zX/1w1D7y1Z4Gc67lbkiproS5dA1oN0A24pEMXE0yNX9ppfrn4aqQbbwgExMSL+9kX5qViCscW86b+KaRjcOHIA32cTAy9ZA0SOmdpJIxUC+hOB4a1w3v2XtBsK5NcIt5S68xtYjQOM2VcafhU6os/PienpoOsx0E3s7khEQij23OkDnb7nuQuHRMoo1t5Y8aVwWKqpZ1Nf5fXEhdL/QngkBjYjYwe48gCW/Afa5si9qJmFiUIwvnI54B6Et8YbhqBmnGkL4n0kIEwq54qwRKqWcaavi42S3kbhn+Yi1iBkeFCrfrRbFVdrXVlRxE9bMx4stKsnG9W6zLVnNidpVGarZL3rb+DB5zRM+6U6GTpMG3Q5c5W6ykliCudiP4oVgrs1oocdpf71y65jquQfP4qQ14AzVGeUecuWBVHGETOZ0K8BXlIqtcPCOCwLtEs4zxlJOzBxSBpjqmdsATl+HvLp5mHxZoysguV5XmM0GbOgHt7IUc0BVX7ybS+zKRiA3ee2BJ/7Y+CM8Z5R3taK2J2fdjHSM4ZkOBoX86k+wk4Qjbv+xBMA51C/prw1VtYxirmW5Ar/DciYysOlJuFIiGkXgdQaLGcegBdZw==
X-Forefront-Antispam-Report: 	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(1076003)(54906003)(2616005)(186003)(4326008)(8676002)(26005)(336012)(316002)(70586007)(70206006)(110136005)(478600001)(426003)(47076005)(41300700001)(8936002)(5660300002)(6666004)(107886003)(83380400001)(2906002)(36860700001)(356005)(7636003)(82740400003)(86362001)(40480700001)(36756003)(40460700003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:03:51.5146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e81124-3c4c-478a-32aa-08daf6dfcdbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_020357_122896_045B7EC4 
X-CRM114-Status: GOOD (  10.22  )
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

The logic of checking matching connections moved to the core layer.
Implement the needed optional operation and remove the common logic.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbad26b82b56..79412e4bfe3e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2326,11 +2326,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		}
 	}
 
-	if (!opts->duplicate_connect && nvme_rdma_existing_controller(opts)) {
-		ret = -EALREADY;
-		goto out_free_ctrl;
-	}
-
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
@@ -2390,6 +2385,7 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS,
 	.create_ctrl	= nvme_rdma_create_ctrl,
+	.existing_ctrl	= nvme_rdma_existing_controller,
 };
 
 static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
-- 
2.18.1


