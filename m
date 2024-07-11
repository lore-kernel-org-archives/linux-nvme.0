Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08DCC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PqucNGdTuzWQm6TBLTFB9AYpi7tMMvaQ2N/e6wkgEso=; b=wtJlt5+LuxNSWuBiJh82fGWZg8
	+ufltMcv3SxH9zrtZiB+1sM7qwL3Qf6zX4yIVGJOQlkeG6sDROdZlUYHEeRftxRDh3l9FNJn2Hv00
	pUrL/mbQwdy31oNXTBU8TGpVQayKALNjN5QO2Dx78TtcsL8L+oarKLROxEOId7cx2kdakPLRgdkai
	TxmZqOw9Dw5aXBkkVwgU1tk/cnrmVc8pBMkPg20q2LlLaZmouJ2J48otArTfUMMvASgTilYPsi0tY
	3rK4P0E4IKr59Ztnnzr4snVi+XY8CQdjyXzyvMAtsOUehDyyj/y8zknJwce6KkyApYxS6+0+tHaQP
	Q0KFyvlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRsB0-0000000DoSi-1yuN;
	Thu, 11 Jul 2024 11:41:30 +0000
Received: from mail-mw2nam10on2062f.outbound.protection.outlook.com ([2a01:111:f403:2412::62f] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRsAt-0000000DoR6-3BP4
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 11:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWhFyZnw5QdXvP6AORxqSfz9EsEszsqWPfF4YMIbBLQkTjxTHBeJGURGwOvnfXkwVmOqBMdB5H1gaYQUclWVQ81/YUYsS5M3F2fKfk6Wmzze07DqvjtMecvR5JhKGSdKCepdx9ue3MS5+ApqWgoNcJO71YxRxsx2gYzV6YcVxtYwyqdMcPlNICTnDM/nBsl6rYh7TjseNwGRL+JA22C+eZbT0Xsfdm17zEm7rz7IFBN8kucgBA2dkHLbLDA7MyqLOgFeOQZFc5LjsT2FUlGX4xU6EGSEZ44nDLPZDqVbMz4mjfXU9h96ccAalJDt4lGq+iBGR53Yno+LBINh8WEj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqucNGdTuzWQm6TBLTFB9AYpi7tMMvaQ2N/e6wkgEso=;
 b=cdLF+2saxT9ehwSwVHaJEFVytwZWbmRrmz00Q6afzv9J8ocpp4qpzpoLGdVaH5rNrrrOApDgW5x5LHobYN+YEoMkpuPppvq9eHLau/a6DbQyuWWk2xszMy4wb1A18qIKPnS04DYgS0rtaW1rXTLvS7XxcsHUAXF/+n3IWtfnOZ2ZrhRPv5k009kiBCruKlcah6P5Qdygqi7KbjOY9LC2onxiaIVADER4Ev35+/BbPxY2pMF7dtV0xjqRfhLJxtUyCMA6gpQJe44E1djqZR4JNSk9Sz4CNHJIdBy0Hn0gsp0/e0of6hUdgo1OvtJL6OSRBNp+m6ai2lQ6nfsvVqF9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqucNGdTuzWQm6TBLTFB9AYpi7tMMvaQ2N/e6wkgEso=;
 b=Ilryt9mL+TuhuPT6ThpAgzH7z26rKLmRnr/bgHu86lgfrJXBBurWeW6hUFSrkTMZS9jxP69yQHdF0zSufmHl/leCogV5iOhTvSb1ZddiZgO/x9k7svnP82Pd7kESRhOiBoy4g+frJ8VtcaJ6+nHKHhuibH2krv61xuJqTGaHS57Y778klx78sYONuaSD0U1ZaiWUjX2S3CIuBcMOo87dTaYBXFtsFDLES0JQYbWxxqgYTgGs4wB/6Y/Y8RdzW+e76q2ciJsoKJBgeSPunmPH2dzP9M/pEuiyFogU6gEdXX0fd7SPc3toV1ZciiNOmdXII78ZL/n8RSfKsuharn/raA==
Received: from SJ0PR13CA0084.namprd13.prod.outlook.com (2603:10b6:a03:2c4::29)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 11:41:12 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::1f) by SJ0PR13CA0084.outlook.office365.com
 (2603:10b6:a03:2c4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22 via Frontend
 Transport; Thu, 11 Jul 2024 11:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 11:41:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 04:41:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 04:41:02 -0700
Received: from rsws50.mtr.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Jul 2024 04:41:00 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Linux-nvme
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	"Christoph Hellwig" <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH] nvme: remove redundant bdev local variable
Date: Thu, 11 Jul 2024 14:40:53 +0300
Message-ID: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e509b1-a9b6-476f-6efa-08dca19e5d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L5usPJmlWA5D0cJbUW5z+h/yytRHU8lqLICd4E5WZHDCMZ7giL5AftClC5gt?=
 =?us-ascii?Q?NFPNkKkyJG8f8+tVvPPb/gd5sl5QUDG5EkneDmmyDAhvfz8hYoZta6ObqrOD?=
 =?us-ascii?Q?UHFIqPANtYOG71cncwdND010tsI99lyYm8h78suaGaZbZE+QVmHBZ97v15l0?=
 =?us-ascii?Q?o8jjYv0AjC06NyusZDTKvlgCmdNKeQwBMMSyehovPpSDkRQghDZ0iFtqpEDw?=
 =?us-ascii?Q?DzgfL/ZBE67RZyLaGxpL/Ir6dKGKZrEmOr7VngJRmBXmTSfOE6RAXRz1xMFr?=
 =?us-ascii?Q?RruelvXEbwOf8EFqPzzxZCCM7nUVBAKgJRsMmB7QPn6fhvuCZzURp5fIlOTS?=
 =?us-ascii?Q?CFAi5Jrv1b/OEfIQz1xsKXZ6w5M1edBxDqdDJdi8c4pAB8QIQV0Aa5CBiDUw?=
 =?us-ascii?Q?J+rMl8X0tSByvaUg+qA7DXGKHy+5ZcYpgIYZhEWRkK6l8atVF+wIxeUagUFB?=
 =?us-ascii?Q?QnQuD01/nxLvacXGF2p0Cx9qvPy+4UiPW6xnp16zwv9+o4oGz5uzWrZ780L6?=
 =?us-ascii?Q?dM9Dr90ok4eZibB3VtRVrM4HJ3r9sRJEaPXuX4qWPFt12HTVwivtRUpfNozr?=
 =?us-ascii?Q?z4s2FXcPEYWu9ev10OFDOWSuSTKcY7J7LNmNA8vm2gxh3LSTKCivOcC8O91o?=
 =?us-ascii?Q?/DIEU/0pH1VIKx5ZBSzQxx7leI//DfWdhxHjqSg/VapvfRI9qwleKt8S3ueC?=
 =?us-ascii?Q?kO8oswakqmqZw/GwCZVpBggFE+MwvNp84f02tto7SPS2siaesdwW//XmUzcu?=
 =?us-ascii?Q?YRmcZmbd97nZYWkOMHkxIl43niAN2PJbEOyegcYtwwdpseUbJqM4VBZ8g+d6?=
 =?us-ascii?Q?JpkcjejpJBbGF/aflc9J3ELrJDsXtv0KgNhwHN2Yxqk64BjVnheZKUwB1VTN?=
 =?us-ascii?Q?10hIkeJEDWAEyaKAM0uoglEV6TYLZK0C2gYvy7luI95J5SaTCoK8WeOToAPj?=
 =?us-ascii?Q?cXFVHS/O+i9M+v+pMAzDSK2GsAvuhNF159bOnyi31Rvxw57kgizHVlWP1dNH?=
 =?us-ascii?Q?eT56TvVskZecXJgYiRUWcoIJUuuj9mtnK8ottNC1Hw6EUvMBwoIK66XAk+wT?=
 =?us-ascii?Q?iJWaRTkMOKOkZMRjtxPYHjKy7/d0+BzEKCDXnV1pPPIA1ndfuiE7pcKBFLeR?=
 =?us-ascii?Q?ipiRm8H9dyrxK59+j8CBrEEY0aN3oFpe8zpzjUDxiMTWrzoqAoUa6DL43Dop?=
 =?us-ascii?Q?jCq9yr66okDw+leYoxgWw9PQrYdSdILRpy70a15m9yKxOeEkcI7ThtlZeE9E?=
 =?us-ascii?Q?1Wb3Nn4Ngz1j2lnuotvFSRsDTMWxvUxWGkI7p4dusVFMOunvs1etBk3UW2yt?=
 =?us-ascii?Q?GbRM+b3NL66pvINJXr6WYJvbyeH3etPMKLonQ7PNwGMLFbXWF0kvD5kMgzei?=
 =?us-ascii?Q?N4s8VHdvNOYA0nZP/I5W6knWChBT9ckAqKYc4FhFWcwKWY7+7BEmNVCYl2ma?=
 =?us-ascii?Q?Tb2R9NP9I9GDMuvsv0kbzdGLcWTj223z?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:41:12.0349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e509b1-a9b6-476f-6efa-08dca19e5d50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_044123_833596_BCBCB76A 
X-CRM114-Status: GOOD (  10.13  )
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

Use disk directly instead of getting it from bdev->bd_disk.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
---
 drivers/nvme/host/sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 3c55f7edd181..ba05faaac562 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -233,13 +233,12 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 {
 	struct nvme_ns_head *head = dev_to_ns_head(dev);
 	struct gendisk *disk = dev_to_disk(dev);
-	struct block_device *bdev = disk->part0;
 	int ret;
 
-	if (nvme_disk_is_ns_head(bdev->bd_disk))
+	if (nvme_disk_is_ns_head(disk))
 		ret = ns_head_update_nuse(head);
 	else
-		ret = ns_update_nuse(bdev->bd_disk->private_data);
+		ret = ns_update_nuse(disk->private_data);
 	if (ret)
 		return ret;
 
-- 
2.18.2


