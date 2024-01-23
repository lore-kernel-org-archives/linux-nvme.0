Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0694C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W9kRkzoBPVeY/6PpMMMpCawwYb1qoH9Vysj36V7C/Cc=; b=CXKVSROT72pHNbJ52JOSwtQ8ub
	e4zWKzbwcKZbwudmRMbHnJIDcsaH3JrZylqA30zzaqoY6GPLcd4PCKLv4Lz/j9ZjfbOGzkM87N5Kb
	/tB+L7rABXxicaOFbBrYibpo9fyRtUAjXOtHeRM40XR6awGO5qTZmeEgjBoze3kmdDXHwoy7KwRY6
	94Ht0RTG3CL+5dIhoMIDP8oUvLo1VfpBh+5gzvfMjgeUoan8WUsb0al53v1VSZELWMw0gx91doclN
	MOQ31EYQIL8pIWDKwQRfQNOf+06x5n/x0diD2qgVu3wDMpR2htoM4Ncemhic9RZo4EL54h1i+/UAT
	clx6J0xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxg-00Gqwi-03;
	Tue, 23 Jan 2024 14:41:12 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxd-00Gqso-09
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:41:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdBK1Yuii1HVZ4eM//yoo0ZCKeXiKw8VF1eVAPBx5/DkIgODpNL0qEOGVEMVmeZHDozWCz9IpgliYt6O8F9pqT4lBZyGpBxSzVsbXxDHY8HEDs2Fg7b3IC1EL6BxEaeoVsWkozYZuZOpmpEcQEqqpmLA9nE4vNJ2S3PP339B97J7libyf399sYX+b6ClZKOO48miATSSRRCgTyLl62m8T/JwEnGpEBOWgLb1nnhDi21ArZ339p5uMqxbnvyjQ0X8Pp4+dVNkq7IGhLRI/K/BkNzt36u0MUt/KaUgUUXtQnMA9NH3f2P8g8GwjKS90szg0qQuYt9wQ969VtIJEX2b5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9kRkzoBPVeY/6PpMMMpCawwYb1qoH9Vysj36V7C/Cc=;
 b=GncOHfOD/pjf++RgfaH2SdTmkUtYD8iJ24qGAFumapbULeoOLQiwUUUH85zohVazVvsn8efozUIB7eveJ2VgRPBinXrkhEATtATkSUvA/6vMtreMayWXdzu9q8XZJp8qQv/9H4TZDcgr+kNAG+rs1CA+NSIwkDx7s09McqC5dF9FBXpZM8KRioX1fUGzLtGKQU24HzU284zfqcThx4/bgKV5YhvPpYsHK0PJ1gLbcAHT6Tk9ktkw0z2uaA+Yt1rFXJGvHMkEav0OlW4Uco7VWLCIC1x0mEE8qc8wEbYN0j/DKgsQ5bkGjYaIu11fRdal9gefq6y3BwE95uo2PXiA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9kRkzoBPVeY/6PpMMMpCawwYb1qoH9Vysj36V7C/Cc=;
 b=DPfjOjyehT7sarz0K/xIouRFlHqb+gymxp8o+wwlq23B726vqj3sn57neOJP2ia0TyysXlJT7k3zdfSlXUp5dR41hIBkhD5ujiPPC+P1VaT77F+S0rNlpV8sWPapaj+hCN6I7GDXc2/LK97xUSx/C+kK+jWN/aIrj5eXGncp9bWotTrzRJSDxQ45rLFWovQKOoBrRrbUE2umsB23TkphFKO3J22tp0ffbmgNTXFwNWkNx847R3e7lg9XMCSFHl4xBSlWIG4VKOoQtcZGBsVXGTRir4MO1bXrtAVoCDF99Ab3MB6NrgBu29a3wq+g4DZLp4XwlYcaZkTS0d3i+6lHsg==
Received: from DM6PR10CA0023.namprd10.prod.outlook.com (2603:10b6:5:60::36) by
 IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 14:41:02 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::df) by DM6PR10CA0023.outlook.office365.com
 (2603:10b6:5:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 14:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:41:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:50 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:48 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 6/8] nvme-rdma: clamp queue size according to ctrl cap
Date: Tue, 23 Jan 2024 16:40:30 +0200
Message-ID: <20240123144032.27801-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2243dda0-6a3d-402a-a15b-08dc1c215233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhYoss7Dq2eHKrKF/Oo5SeIoe6FBE5eD+ZRLQUQFitwXHW2yYjl5xVVI02ih+UrZeTwmFBxojM45RYsrEzSlXcy/EZXBv6wcJsTsDEjYmexZnmI5hhEUCdoH5/zewYN2ZCfp8fJddYMvOjTi4ASLnDileZGfe3b2W0SexvzLyoU9cVva0euV2bNZVFwvNx36NUK3GZCie08oFZnbseIPP4yROktOqlO4jxXyNnjhaCQ0tNGJc3sVszZ8rHzK0l823b4KIcA9/EiV0sqhQ2kCkksfAj9t3qoplWGqOopE0TNxVU47B+CovH1iyAt8tiiotcPzPxaEx1a/Z4nKxAWGhJn526UZfc0hDMpowG0jr7pWmxYkRKxgGUNkNkWNsRJovx5nqiQB+gU+R3+TjpONGhneIaxvvsqNTJHuyb3YA95ZzWuYOvYv+Ma8U7EvALsA2wjywI84djV6LYOy8+lrysbRJcY5bclplTwld7TOlSokL5J7R1zRZ5vDv3vq8e8ywZ/tp6vodgzVbWg8BnMFTUCZssegboYdocZg5rCFaCQjGctaa+j7mhQ0VPSuLbeV3g9NBrrEY9UKSnnjI6NA6ECWkXNxkaiOCL/5HzqdwS8tI6xyLf4yDhzyHYsDdnVvmhwt4VGkRLZ/JBZjAZhMeIPEbIWmDtIsw87q6b25zdcfjJcxHDzr433/IjyBUgmbwI3VKUmFvdNPP7V5+6m1aQEYm9rXCieUVvXOzWicb6/pGUqVEejaaNXlBvAMKxcW
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(2906002)(356005)(41300700001)(36860700001)(36756003)(86362001)(7636003)(82740400003)(110136005)(6666004)(316002)(70206006)(2616005)(54906003)(478600001)(70586007)(336012)(1076003)(4326008)(5660300002)(426003)(8936002)(47076005)(6636002)(8676002)(83380400001)(107886003)(26005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:41:01.7444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2243dda0-6a3d-402a-a15b-08dc1c215233
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064109_085908_E88D22BF 
X-CRM114-Status: GOOD (  11.32  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2e77c0f25f71..ef1cb9a0b90d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1005,6 +1005,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret;
 	bool changed;
+	u16 max_queue_size;
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, new);
 	if (ret)
@@ -1029,11 +1030,16 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
 	}
 
-	if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
+	if (ctrl->ctrl.max_integrity_segments)
+		max_queue_size = NVME_RDMA_MAX_METADATA_QUEUE_SIZE;
+	else
+		max_queue_size = NVME_RDMA_MAX_QUEUE_SIZE;
+
+	if (ctrl->ctrl.sqsize + 1 > max_queue_size) {
 		dev_warn(ctrl->ctrl.device,
-			"ctrl sqsize %u > max queue size %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
-		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
+			 "ctrl sqsize %u > max queue size %u, clamping down\n",
+			 ctrl->ctrl.sqsize + 1, max_queue_size);
+		ctrl->ctrl.sqsize = max_queue_size - 1;
 	}
 
 	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
-- 
2.18.1


